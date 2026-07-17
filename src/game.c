#include <string.h>

enum {
#define BALANCE(name, value) name = value,
#include "../content/balance.def"
#undef BALANCE
};

Game g;
static uint8_t held_keys[256], pressed_keys[256];
static int deck_total(void);
#ifdef DEV_LOG
static bool dev_cheated;
static void telemetry_transition(Mode before,Mode after){
    if(before==after)return;
    const char *event=after==ON_AIR?"on_air":after==BREAK?"break":after==EDIT?"edit":after==OPEN_CHANNEL?"open":after==RESULT?"result":"state";
    int tx=0,rx=0;for(int i=0;i<g.deck.hand_n;i++)if(CARD_DEF[g.deck.hand[i]].type==CARRIER){if(g.carrier_rx[i])rx++;else tx++;}
    wchar_t path[MAX_PATH];DWORD n=GetModuleFileNameW(NULL,path,MAX_PATH);while(n&&path[n-1]!=L'\\')n--;lstrcpyW(path+n,L"playtest.csv");
    FILE *file=NULL;if(_wfopen_s(&file,path,L"a+"))return;fseek(file,0,SEEK_END);
    if(ftell(file)==0)fputs("seed,tick,event,turn,intent,deck,tx,rx,cued,hp,live,archived,mimicked,trend,result,cheated\n",file);
    fprintf(file,"%u,%d,%s,%u,%u,%d,%d,%d,%u,%u,%d,%d,%d,%u,%u,%d\n",g.seed,g.anim_ticks,event,g.turn,g.intent,deck_total(),tx,rx,g.queue_n,g.hp,g.echo_live,g.echo_archived,g.echo_mimicked,g.trend_card,g.result_reason,dev_cheated?1:0);fclose(file);
}
#endif

const CardDef CARD_DEF[CARD_COUNT] = {
    {L"2400 모뎀", L"2400", CARRIER, 0, CARD_BAUD_2400, 0},
    {L"14K 고속 회선", L"14K", CARRIER, COST_14K, CARD_BAUD_14K, 0},
    {L"다중 분기", L"분기", PROGRAM, COST_MULTI, 0, 0},
    {L"임시 저장", L"저장", PROGRAM, COST_CACHE, 0, 0},
    {L"방화벽 프레임", L"방벽", PROGRAM, COST_FIREWALL, 0, 0},
    {L"반복 녹화", L"반복", PROGRAM, COST_MACRO, 0, 0},
    {L"미리 읽기", L"예독", PROGRAM, COST_PREFETCH, 0, 0},
    {L"신호 표식", L"표식", PROGRAM, COST_MARKER, 0, 0},
    {L"회선 폭주", L"폭주", PROGRAM, COST_SURGE, 0, 0},
    {L"무결성 검사", L"검사", PROGRAM, COST_CHECKSUM, 0, 0},
    {L"채팅 기록", L"채팅", ARCHIVE, COST_CHAT, 0, ECHO_CHAT},
    {L"음성 기록", L"음성", ARCHIVE, COST_VOICE, 0, ECHO_VOICE},
    {L"불량 잡음", L"잡음", NOISE, 0, 0, 0}
};

static uint32_t rng(uint32_t *state) {
    uint32_t x = *state ? *state : 0x6d2b79f5u;
    x ^= x << 13; x ^= x >> 17; x ^= x << 5;
    return *state = x;
}

static float clampf(float v, float lo, float hi) { return v < lo ? lo : v > hi ? hi : v; }
static float dist2(float x, float y) { return x*x + y*y; }
static void normalize(float *x, float *y) {
    float d = sqrtf(*x * *x + *y * *y);
    if (d > 0.001f) { *x /= d; *y /= d; }
}

int deck_count(CardId id) {
    int n = 0;
    for (int i=0;i<g.deck.draw_n;i++) n += g.deck.draw[i] == id;
    for (int i=0;i<g.deck.discard_n;i++) n += g.deck.discard[i] == id;
    for (int i=0;i<g.deck.hand_n;i++) n += g.deck.hand[i] == id;
    if (g.cached_card == id + 1) n++;
    return n;
}

static int deck_total(void) { return g.deck.draw_n + g.deck.discard_n + g.deck.hand_n + (g.cached_card != 0); }

static bool remove_from(CardId *cards,uint8_t *count,CardId id) {
    for(int i=0;i<*count;i++)if(cards[i]==id){memmove(&cards[i],&cards[i+1],(size_t)(*count-i-1)*sizeof(*cards));(*count)--;return true;}
    return false;
}

static bool deck_remove_one(CardId id) {
    if(remove_from(g.deck.draw,&g.deck.draw_n,id)||remove_from(g.deck.discard,&g.deck.discard_n,id))return true;
    if(g.cached_card==id+1){g.cached_card=0;return true;}
    for(int i=0;i<g.deck.hand_n;i++)if(g.deck.hand[i]==id){int tail=g.deck.hand_n-i-1;memmove(&g.deck.hand[i],&g.deck.hand[i+1],(size_t)tail*sizeof(CardId));memmove(&g.selected[i],&g.selected[i+1],(size_t)tail);memmove(&g.carrier_rx[i],&g.carrier_rx[i+1],(size_t)tail);g.deck.hand_n--;return true;}return false;
}

static void shuffle(void) {
    for (int i=g.deck.draw_n-1;i>0;i--) {
        int j = (int)(rng(&g.deck_rng) % (uint32_t)(i+1));
        CardId t=g.deck.draw[i]; g.deck.draw[i]=g.deck.draw[j]; g.deck.draw[j]=t;
    }
}

static CardId draw_one(void) {
    if (!g.deck.draw_n) {
        memcpy(g.deck.draw, g.deck.discard, g.deck.discard_n);
        g.deck.draw_n = g.deck.discard_n;
        g.deck.discard_n = 0;
        shuffle();
        g.message_ticks = 45;
    }
    assert(g.deck.draw_n);
    return g.deck.draw[--g.deck.draw_n];
}

static CardId note_card_return(CardId id){if(g.new_card==id+1)g.new_ticks=90;return id;}

static void draw_hand(void) {
    g.deck.hand_n = 0;
    g.cached_ready_slot=0;
    if (g.cached_card) {
        g.deck.hand[g.deck.hand_n++] = note_card_return((CardId)(g.cached_card - 1));
        g.cached_card = 0;g.cached_ready_slot=1;
    }
    while (g.deck.hand_n < HAND_SIZE && (g.deck.draw_n || g.deck.discard_n))
        g.deck.hand[g.deck.hand_n++] = note_card_return(draw_one());
}

static void recount_echo(void) {
    g.echo_total=g.echo_live=g.echo_archived=g.echo_mimicked=0;
    for (int i=0;i<64;i++) if (g.ring[i].state) {
        g.echo_total++;
        if (g.ring[i].state==ECHO_LIVE) g.echo_live++;
        else if (g.ring[i].state==ECHO_ARCHIVED) g.echo_archived++;
        else g.echo_mimicked++;
    }
}

static void start_next_threshold(void);

static void add_echo(uint8_t state, int amount, uint8_t origin) {
    int before=g.echo_total;
    for (int n=0;n<amount;n++) {
        if(g.mode!=OPEN_CHANNEL&&g.echo_total+n>=16)break;
        for (int i=0;i<64;i++) if (!g.ring[i].state) {
            g.ring[i].state=state; g.ring[i].origin=origin; break;
        }
    }
    recount_echo();
    if(g.echo_total>before&&!g.threshold_ticks)start_next_threshold();
}

static int nearest_enemy(float x, float y) {
    int best=-1; float bd=1e30f;
    for (int i=0;i<MAX_ENEMIES;i++) if (g.enemies[i].active) {
        float d=dist2(g.enemies[i].x-x,g.enemies[i].y-y);
        if (d<bd) { bd=d; best=i; }
    }
    return best;
}

static void bullet(float x,float y,float dx,float dy,int damage,uint8_t hostile,int hits) {
    normalize(&dx,&dy);
    for (int i=0;i<MAX_BULLETS;i++) if (!g.bullets[i].active) {
        Bullet *b=&g.bullets[i];
        b->active=1;b->x=x;b->y=y;b->vx=dx*(hostile?46.0f:150.0f)/TICK_HZ;
        b->vy=dy*(hostile?46.0f:150.0f)/TICK_HZ;b->damage=(int16_t)damage;
        b->life=hostile?300:90;b->hostile=(uint8_t)hostile;b->hits=(uint8_t)hits;return;
    }
}

static bool spawn_enemy(uint8_t type, float x, float y) {
    static const int hp[] = {4,8,10,14,4};
    for (int i=0;i<MAX_ENEMIES;i++) if (!g.enemies[i].active) {
        Enemy *e=&g.enemies[i]; memset(e,0,sizeof(*e));
        e->active=1;e->type=type;e->x=x;e->y=y;e->hp=(int16_t)hp[type];e->fire=60;return true;
    }
    return false;
}

static void spawn_edge(uint8_t type, int side) {
    float x=4,y=(float)(24+rng(&g.encounter_rng)%176);
    if(side==1)x=316; else if(side==2){x=(float)(8+rng(&g.encounter_rng)%304);y=20;}
    else if(side==3){x=(float)(8+rng(&g.encounter_rng)%304);y=204;}
    spawn_enemy(type,x,y);
}

static void damage_enemy(int i,int damage) {
    if (!g.enemies[i].active) return;
    if(g.enemies[i].marked)damage=(damage*3+1)/2;
    g.enemies[i].hp -= (int16_t)damage;
    if (g.enemies[i].hp<=0) {
        if(g.enemies[i].type==SPON_GIFT&&g.sync<3)g.sync++;
        if(g.enemies[i].type==BUF_WORM&&g.stolen_card){g.deck.discard[g.deck.discard_n++]=(CardId)(g.stolen_card-1);g.stolen_card=0;add_echo(ECHO_LIVE,1,0);}
        g.enemies[i].active=0; g.flash_ticks=g.low_fx?0:2;
    }
}

static void area_damage(float x,float y,float radius,int damage) {
    float r2=radius*radius;
    for(int i=0;i<MAX_ENEMIES;i++) if(g.enemies[i].active&&dist2(g.enemies[i].x-x,g.enemies[i].y-y)<=r2)
        damage_enemy(i,damage);
}

static void fire_carriers(void) {
    int target=nearest_enemy(g.px,g.py); if(target<0)return;
    float dx=g.enemies[target].x-g.px,dy=g.enemies[target].y-g.py;
    if(g.mode==OPEN_CHANNEL) {
        for(int n=0;n<deck_count(CARD_2400);n++) bullet(g.px,g.py,dx,dy,DAMAGE_2400,false,1);
        for(int n=0;n<deck_count(CARD_14K);n++) bullet(g.px,g.py,dx,dy,DAMAGE_14K,false,2);
    } else {
        for(int i=0;i<g.deck.hand_n;i++) if(CARD_DEF[g.deck.hand[i]].type==CARRIER&&!g.carrier_rx[i])
            bullet(g.px,g.py,dx,dy,g.deck.hand[i]==CARD_14K?DAMAGE_14K:DAMAGE_2400,false,g.deck.hand[i]==CARD_14K?2:1);
    }
}

static void mark_nearest(int count) {
    for(int n=0;n<count;n++){int best=-1;float bd=1e30f;for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active&&!g.enemies[i].marked){float d=dist2(g.enemies[i].x-g.px,g.enemies[i].y-g.py);if(d<bd){bd=d;best=i;}}if(best<0)break;g.enemies[best].marked=MARKER_TICKS;}
}

static void surge(int scale) {
    bool used[MAX_ENEMIES]={0};int hit=0,damage=(DAMAGE_SURGE*scale+50)/100;
    for(int i=0;i<MAX_ENEMIES&&hit<4;i++)if(g.enemies[i].active&&g.enemies[i].marked){used[i]=true;damage_enemy(i,damage);hit++;}
    while(hit<3){int best=-1;float bd=1e30f;for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active&&!used[i]){float d=dist2(g.enemies[i].x-g.px,g.enemies[i].y-g.py);if(d<bd){bd=d;best=i;}}if(best<0)break;used[best]=true;damage_enemy(best,damage);hit++;}
}

static void checksum(void) {
    if(deck_remove_one(CARD_NOISE))return;
    for(int i=0;i<64;i++)if(g.ring[i].origin==0&&g.ring[i].state==ECHO_MIMICKED){g.ring[i].state=ECHO_LIVE;recount_echo();return;}
}

static void program_effect(CardId id,bool mirrored,int scale) {
    switch(id) {
    case CARD_FIREWALL:
        if (mirrored) {
            for(int i=0;i<3;i++) bullet(160.0f,(float)(32+i*64),g.px-160.0f,g.py-(float)(32+i*64),1,true,1);
        } else {g.firewall_ticks=FIREWALL_TICKS*scale/100;g.firewall_open_dir=fabsf(g.last_dx)>fabsf(g.last_dy)?(g.last_dx>=0?0:2):(g.last_dy>=0?1:3);}
        break;
    case CARD_MACRO: if(g.last_program<CARD_COUNT&&g.last_program!=CARD_MACRO)program_effect((CardId)g.last_program,mirrored,70);break;
    case CARD_MARKER: if(mirrored)for(int i=0;i<3;i++)spawn_edge(MOD_MASK,i);else mark_nearest(5);break;
    case CARD_SURGE:
        if(mirrored)for(int i=0;i<3;i++)bullet((float)(40+i*120),20.0f,g.px-(40.0f+i*120.0f),g.py-20.0f,1,true,1);else{surge(scale);g.surge_ticks=180;}
        break;
    case CARD_CHECKSUM:
        if(mirrored){for(int i=0;i<64;i++)if(g.ring[i].state==ECHO_LIVE){g.ring[i].state=ECHO_MIMICKED;recount_echo();break;}}else checksum();
        break;
    case CARD_CACHE:
        if (mirrored) area_damage(g.px,g.py,20,6);
        break;
    case CARD_MULTI:
        if (mirrored) for(int i=0;i<4;i++) spawn_edge(BOT_CHAT,i);
        break;
    default: break;
    }
}

static void execute_program_scaled(CardId id,bool mirrored,int scale) {
    if(!mirrored&&g.sync>=2)scale=scale*110/100;
    if(!mirrored){g.program_uses[id]++;g.program_recent[(g.turn-1)%6][id]++;g.cards_fired[id]++;g.program_fired=true;g.effect_card=id;g.effect_ticks=24;}
    program_effect(id,mirrored,scale);
    if(!mirrored)g.last_program=id;
}
static void execute_program(CardId id,bool mirrored){execute_program_scaled(id,mirrored,100);}

static void choose_trend(void) {
    int best=-1,uses=-1;
    for(int id=CARD_MULTI;id<=CARD_CHECKSUM;id++){int score=g.program_uses[id];for(int t=0;t<6;t++)score+=g.program_recent[t][id];if(score>uses){uses=score;best=id;}}
    g.trend_card=(uint8_t)(best<0?CARD_FIREWALL:best);
}

static void start_next_threshold(void){
    static const int level[]={16,32,48,64};
    for(int i=0;i<4;i++)if(g.echo_total>=level[i]&&!(g.threshold_seen&(1u<<i))){
        g.threshold_seen|=(uint8_t)(1u<<i);g.ring_threshold=(uint8_t)(i+1);g.threshold_ticks=120;
        if(i==0)for(int b=0;b<MAX_BULLETS;b+=2)if(g.bullets[b].hostile)g.bullets[b].active=0;
        if(i==2)choose_trend();
        return;
    }
}

static void compile_finale(void){
    int chat=deck_count(CARD_CHAT),voice=deck_count(CARD_VOICE);
    int tags[4]={deck_count(CARD_MULTI)+deck_count(CARD_CACHE),deck_count(CARD_MARKER)+deck_count(CARD_SURGE),deck_count(CARD_FIREWALL)+deck_count(CARD_CHECKSUM),deck_count(CARD_MACRO)+deck_count(CARD_PREFETCH)};
    g.final_form=chat>voice?FORM_CHATSTORM:voice>chat?FORM_RESONANCE:FORM_OPEN_ECHO;g.final_modifier=0;
    for(int i=1;i<4;i++)if(tags[i]>tags[g.final_modifier])g.final_modifier=(uint8_t)i;
}

static uint8_t choose_ending(void){
    int lo=g.echo_live,hi=g.echo_live;if(g.echo_archived<lo)lo=g.echo_archived;if(g.echo_mimicked<lo)lo=g.echo_mimicked;if(g.echo_archived>hi)hi=g.echo_archived;if(g.echo_mimicked>hi)hi=g.echo_mimicked;
    if(lo>=12&&hi-lo<=8&&g.contract_used&&g.seek_path_used&&(deck_count(CARD_CHAT)+deck_count(CARD_VOICE)))return END_UNRESOLVED_ECHO;
    if(g.echo_mimicked>=24)return END_PERFECT_AUDIENCE;if(g.echo_archived>=24)return END_LAST_ARCHIVE;return END_OPEN_CHANNEL;
}

static void finish_open_success(void){
    g.won=true;g.ending=choose_ending();g.result_reason=RESULT_TWO_WAY;g.victory_ticks=VICTORY_TICKS;
    memset(g.enemies,0,sizeof(g.enemies));memset(g.bullets,0,sizeof(g.bullets));
}

static void apply_off_air(void){
    for(int h=0;h<g.deck.hand_n;h++)if(!g.selected[h]){
        CardId id=g.deck.hand[h];
        if(id==CARD_MACRO){int e=nearest_enemy(g.px,g.py);if(e>=0)bullet(g.px,g.py,g.enemies[e].x-g.px,g.enemies[e].y-g.py,DAMAGE_2400/2,false,1);}
        else if(id==CARD_MARKER)mark_nearest(1);
        else if(id==CARD_SURGE)for(int e=0;e<MAX_ENEMIES;e++)if(g.enemies[e].active&&g.enemies[e].marked){g.enemies[e].marked=0;damage_enemy(e,DAMAGE_SURGE/2);break;}
    }
}

static bool restore_echo(uint8_t from){
    for(int i=0;i<64;i++)if(g.ring[i].origin==0&&g.ring[i].state==from){g.ring[i].state=ECHO_LIVE;recount_echo();return true;}
    return false;
}

static bool kingdom_valid(const CardId *cards) {
    int engine=0,payload=0,safe=0;
    for(int i=0;i<5;i++){CardId id=cards[i];engine+=id==CARD_MULTI||id==CARD_CACHE||id==CARD_PREFETCH;payload+=id==CARD_MACRO||id==CARD_MARKER||id==CARD_SURGE||id==CARD_FIREWALL;safe+=id==CARD_FIREWALL||id==CARD_CHECKSUM;}
    return engine>=1&&payload>=2&&safe>=1;
}

static void generate_kingdom(void) {
    CardId pool[]={CARD_MULTI,CARD_CACHE,CARD_FIREWALL,CARD_MACRO,CARD_PREFETCH,CARD_MARKER,CARD_SURGE,CARD_CHECKSUM};
    do{for(int i=7;i>0;i--){int j=(int)(rng(&g.reward_rng)%(uint32_t)(i+1));CardId t=pool[i];pool[i]=pool[j];pool[j]=t;}memcpy(g.kingdom,pool,5);}while(!kingdom_valid(g.kingdom));
}

static void begin_open(void);

static void begin_edit(void) {
    g.mode=EDIT;g.cursor=0;g.cue=CUE_START;g.queue_n=g.queue_at=0;g.seek_used=false;
    g.cache_mode=g.prefetch_mode=false;memset(g.program_recent[(g.turn-1)%6],0,CARD_COUNT);
    memset(g.selected,0,sizeof(g.selected));memset(g.carrier_rx,0,sizeof(g.carrier_rx));
    g.intent=g.intent_deck[g.turn-1];
    draw_hand();
    if(g.intent==MUTE)for(int i=0;i<g.deck.hand_n;i++)if(CARD_DEF[g.deck.hand[i]].type==PROGRAM){g.selected[i]=3;break;}
    if(g.contract_boost){g.cue++;g.contract_boost=0;add_echo(ECHO_MIMICKED,2,1);}
}

static void cleanup(void) {
    g.defrag_mode=g.trade_mode=false;
    for(int i=0;i<g.deck.hand_n;i++) if(g.deck.discard_n<MAX_DECK)g.deck.discard[g.deck.discard_n++]=g.deck.hand[i];
    g.deck.hand_n=0;g.turn++;
    if(g.turn>12) { /* forced finale */
        begin_open();return;
    }
    begin_edit();
}

static void begin_air(void) {
    g.mode=ON_AIR;g.phase_ticks=ON_AIR_TICKS;g.carrier_ticks=1;g.turn_hit=false;g.program_fired=false;
    memset(g.enemies,0,sizeof(g.enemies));memset(g.bullets,0,sizeof(g.bullets));
    int count=3+g.turn/2;
    uint8_t type=g.intent==GIFT_DROP?SPON_GIFT:g.intent==MUTE?MOD_MASK:g.intent==COMMENT_WALL?POP_AD:g.intent==MIRROR?POP_AD:BOT_CHAT;
    for(int i=0;i<count;i++)spawn_edge(type,g.intent==BOT_RAID?1:(int)(rng(&g.encounter_rng)&3));
    if(g.turn==2)spawn_edge(BUF_WORM,0);
    if(g.turn==7){
        if(deck_remove_one(CARD_VOICE))g.stolen_card=CARD_VOICE+1;else if(deck_remove_one(CARD_CHAT))g.stolen_card=CARD_CHAT+1;
        if(g.stolen_card)spawn_edge(BUF_WORM,3);
    }
    if(g.intent==TREND){choose_trend();g.stolen_program=g.trend_card+1;g.mirror_ticks=120;}
    apply_off_air();
}

static void end_air(void) {
    if(g.stolen_card){add_echo(ECHO_ARCHIVED,1,0);g.stolen_card=0;}
    if(!g.turn_hit&&g.sync<3)g.sync++; else if(g.turn_hit&&g.sync)g.sync--;
    g.mode=BREAK;g.shop_cursor=0;g.baud=0;
    for(int i=0;i<g.deck.hand_n;i++) if(CARD_DEF[g.deck.hand[i]].type==CARRIER&&g.carrier_rx[i])g.baud+=CARD_DEF[g.deck.hand[i]].baud;
    choose_trend();
}

static void begin_open(void) {
    g.mode=OPEN_CHANNEL;g.open_ticks=OPEN_TICKS;g.open_card_ticks=1;g.protocol_ticks=0;g.mirror_ticks=MIRROR_TICKS;g.seek_ticks=1;g.open_sequence_at=0;
    choose_trend();compile_finale();g.carrier_ticks=1;memset(g.enemies,0,sizeof(g.enemies));memset(g.bullets,0,sizeof(g.bullets));
}

static void damage_player(void) {
    if(g.invuln_ticks||g.firewall_ticks)return;
    g.hp--;g.invuln_ticks=HIT_INVULN_TICKS;g.turn_hit=true;g.shake_ticks=g.low_fx?0:5;
    if(g.mode==OPEN_CHANNEL&&!g.echo_convert_ticks){for(int i=0;i<64;i++)if(g.ring[i].state==ECHO_LIVE){g.ring[i].state=ECHO_MIMICKED;g.echo_convert_ticks=ECHO_CONVERT_TICKS;break;}}
    recount_echo();
    if(!g.hp){g.won=false;g.result_reason=RESULT_STREAM_LOST;g.mode=RESULT;}
}

static void update_enemies(void) {
    static const float speed[]={22,10,0,10,18};
    for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active){Enemy *e=&g.enemies[i];
        float dx=g.px-e->x,dy=g.py-e->y;normalize(&dx,&dy);
        e->x=clampf(e->x+dx*speed[e->type]/TICK_HZ,3,317);
        e->y=clampf(e->y+dy*speed[e->type]/TICK_HZ,ARENA_TOP+3,ARENA_BOTTOM-3);
        if(e->type==POP_AD||e->type==MOD_MASK){if(e->fire)--e->fire;else{bullet(e->x,e->y,dx,dy,1,e->type==MOD_MASK?2:1,1);e->fire=120;}}
        if(e->marked)e->marked--;
        if(dist2(e->x-g.px,e->y-g.py)<25){if(e->type==BUF_WORM){g.carrier_ticks+=ENEMY_ATTACH_TICKS;g.phase_ticks-=ENEMY_ATTACH_TICKS;e->active=0;}else if(e->type==BOT_CHAT){g.carrier_ticks+=ENEMY_ATTACH_TICKS;g.queue_delay_ticks+=ENEMY_ATTACH_TICKS;e->active=0;}else if(e->type==SPON_GIFT){e->active=0;add_echo(ECHO_MIMICKED,1,1);if(g.hp<HP_START)g.hp++;}else damage_player();}
    }
    /* ponytail: O(n²) is cheaper and sufficient below the documented 384-enemy spatial-hash threshold. */
    for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active)for(int j=i+1;j<MAX_ENEMIES;j++)if(g.enemies[j].active){float dx=g.enemies[j].x-g.enemies[i].x,dy=g.enemies[j].y-g.enemies[i].y,d2=dx*dx+dy*dy;if(d2>0.01f&&d2<64.0f){float d=sqrtf(d2),push=(8.0f-d)*0.01875f;dx=dx/d*push;dy=dy/d*push;g.enemies[i].x-=dx;g.enemies[i].y-=dy;g.enemies[j].x+=dx;g.enemies[j].y+=dy;}}
}

static void insert_noise(void){if(deck_count(CARD_NOISE)<5&&deck_total()<MAX_DECK)g.deck.discard[g.deck.discard_n++]=CARD_NOISE;}

static void update_bullets(void) {
    for(int i=0;i<MAX_BULLETS;i++)if(g.bullets[i].active){Bullet *b=&g.bullets[i];b->x+=b->vx;b->y+=b->vy;
        if(--b->life<=0||b->x<0||b->x>=SCREEN_W||b->y<ARENA_TOP||b->y>=ARENA_BOTTOM){b->active=0;continue;}
        if(b->hostile){if(g.firewall_ticks&&dist2(b->x-g.px,b->y-g.py)<400){float dx=b->x-g.px,dy=b->y-g.py;bool opening=(g.firewall_open_dir==0&&dx>fabsf(dy))||(g.firewall_open_dir==1&&dy>fabsf(dx))||(g.firewall_open_dir==2&&-dx>fabsf(dy))||(g.firewall_open_dir==3&&-dy>fabsf(dx));if(!opening){b->active=0;continue;}}
            if(dist2(b->x-g.px,b->y-g.py)<16){uint8_t effect=b->hostile;b->active=0;if(effect==2)insert_noise();else damage_player();}}
        else for(int e=0;e<MAX_ENEMIES;e++)if(g.enemies[e].active&&dist2(b->x-g.enemies[e].x,b->y-g.enemies[e].y)<25){damage_enemy(e,b->damage);if(!--b->hits)b->active=0;break;}
    }
}

static void move_player(void) {
    float dx=(float)((held_keys[VK_RIGHT]||held_keys['D'])-(held_keys[VK_LEFT]||held_keys['A']));
    float dy=(float)((held_keys[VK_DOWN]||held_keys['S'])-(held_keys[VK_UP]||held_keys['W']));
    if(dx||dy){normalize(&dx,&dy);g.last_dx=dx;g.last_dy=dy;g.px=clampf(g.px+dx*PLAYER_SPEED/TICK_HZ,4,316);g.py=clampf(g.py+dy*PLAYER_SPEED/TICK_HZ,ARENA_TOP+4,ARENA_BOTTOM-4);}
}

static void update_air(void) {
    move_player();
    if(--g.carrier_ticks<=0){fire_carriers();g.carrier_ticks=CARRIER_TICKS;}
    if(g.auto_fire_ticks)g.auto_fire_ticks--;if(g.queue_delay_ticks)g.queue_delay_ticks--;
    if(!g.queue_delay_ticks&&(pressed_keys[VK_SPACE]||(held_keys[VK_SPACE]&&!g.auto_fire_ticks))&&g.queue_at<g.queue_n){int at=g.queue_at++;CardId id=g.queue[at];execute_program_scaled(id,false,g.queue_scale[at]);g.auto_fire_ticks=10;if(g.intent==MIRROR&&g.queue_at==1)execute_program(id,true);if(g.intent==CLIP_THEFT&&g.queue_at==1){g.stolen_program=id+1;g.mirror_ticks=90;}}
    if(g.stolen_program&&--g.mirror_ticks<=0){execute_program((CardId)(g.stolen_program-1),true);g.stolen_program=0;}
    if(g.surge_ticks){g.surge_ticks--;if(g.surge_ticks%30==0)surge(100);}
    update_enemies();update_bullets();
    if(--g.phase_ticks<=0)end_air();
}

static int open_sequence_size(void) {
    return deck_count(CARD_2400)+deck_count(CARD_14K)+deck_count(CARD_CHAT)+deck_count(CARD_VOICE);
}

static void open_archive_tick(void) {
    CardId ids[MAX_DECK];int n=0;
    for(int id=CARD_2400;id<=CARD_14K;id++)for(int k=0;k<deck_count((CardId)id);k++)ids[n++]=(CardId)id;
    for(int id=CARD_CHAT;id<=CARD_VOICE;id++)for(int k=0;k<deck_count((CardId)id);k++)ids[n++]=(CardId)id;
    if(!n)return;
    CardId id=ids[g.open_sequence_at++%n];
    if(CARD_DEF[id].type!=ARCHIVE)return;
    add_echo(ECHO_LIVE,CARD_DEF[id].echo,0);
    if(id==CARD_CHAT)area_damage(g.px,g.py,34,DAMAGE_CHAT);else area_damage(g.px,g.py,70,DAMAGE_VOICE);
}

static void update_open(void) {
    if(g.won){if(--g.victory_ticks<=0)g.mode=RESULT;return;}
    move_player();
    if(--g.carrier_ticks<=0){fire_carriers();g.carrier_ticks=CARRIER_TICKS;}
    if(--g.open_card_ticks<=0){
        open_archive_tick();
        if(g.echo_total>=64){finish_open_success();return;}
        int n=open_sequence_size(),pos=n?g.open_sequence_at%n:0;
        g.open_card_ticks=OC_CARD_TICKS+(n&&(pos==0||pos%HAND_SIZE==0)?HAND_SWAP_TICKS:0);
    }
    if(g.protocol_ticks>0)g.protocol_ticks--;
    if(g.protocol_replay_ticks>0&&!--g.protocol_replay_ticks){if(g.final_form==FORM_RESONANCE)area_damage(g.px,g.py,86,25);else for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active)damage_enemy(i,13);}
    if((pressed_keys[VK_SPACE]||held_keys[VK_SPACE])&&!g.protocol_ticks){
        int repeats=g.final_modifier==MOD_REPEAT?2:1;for(int pass=0;pass<repeats;pass++){
            if(g.final_form==FORM_RESONANCE)area_damage(g.px,g.py,86,36);else if(g.final_form==FORM_CHATSTORM)for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active)damage_enemy(i,18);else{area_damage(g.px,g.py,70,24);for(int j=0;j<MAX_ENEMIES;j++)if(g.enemies[j].active)damage_enemy(j,8);}
        }
        if(g.final_modifier==MOD_NETWORK)for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active)damage_enemy(i,8);
        if(g.final_modifier==MOD_SAFE){for(int i=0;i<MAX_BULLETS;i++)if(g.bullets[i].hostile)g.bullets[i].active=0;g.firewall_ticks=FIREWALL_TICKS;restore_echo(ECHO_MIMICKED);}
        if(g.final_modifier==MOD_REPLAY){g.protocol_replay_ticks=PROTOCOL_REPLAY_TICKS;restore_echo(ECHO_ARCHIVED);}
        g.protocol_ticks=g.sync==3?PROTOCOL_TICKS*3/4:PROTOCOL_TICKS;
    }
    if(--g.mirror_ticks<=0){execute_program((CardId)g.trend_card,true);g.mirror_ticks=MIRROR_TICKS;}
    if(g.echo_total>=48&&g.seek_interventions<3&&--g.seek_ticks<=0){for(int i=0;i<64;i++)if(g.ring[i].state==ECHO_LIVE){g.ring[i].state=ECHO_ARCHIVED;g.seek_interventions++;g.seek_ticks=SEEK_CABLE_TICKS;recount_echo();break;}}
    g.spawn_budget+=0.08f;
    while(g.spawn_budget>=1.0f){spawn_edge(BOT_CHAT,(int)(rng(&g.encounter_rng)&3));g.spawn_budget-=1.0f;}
    update_enemies();update_bullets();
    if(g.echo_total>=64)finish_open_success();
    else if(--g.open_ticks<=0){g.won=false;g.result_reason=RESULT_OFFLINE;g.mode=RESULT;}
}

static void edit_activate(void) {
    if(g.cursor>=g.deck.hand_n)return;
    CardId id=g.deck.hand[g.cursor];const CardDef *c=&CARD_DEF[id];
    if(c->type==CARRIER){g.carrier_rx[g.cursor]^=1;return;}
    if(c->type!=PROGRAM||g.selected[g.cursor]||!g.cue)return;
    g.selected[g.cursor]=1;g.cue--;g.cards_cued[id]++;
    if(id==CARD_MULTI){g.cue+=2;g.program_uses[id]++;g.program_recent[(g.turn-1)%6][id]++;}
    else if(id==CARD_CACHE){
        int target=-1;for(int i=0;i<g.deck.hand_n;i++)if(i!=g.cursor&&!g.selected[i]&&CARD_DEF[g.deck.hand[i]].type==PROGRAM){target=i;break;}
        if(target<0||!(g.deck.draw_n||g.deck.discard_n)){g.selected[g.cursor]=0;g.cue++;g.cards_cued[id]--;return;}
        g.cache_mode=true;g.cache_slot=g.cursor;g.cursor=(uint8_t)target;
    } else if(id==CARD_PREFETCH){
        g.prefetch_mode=true;g.prefetch_cursor=0;g.prefetch_n=0;g.prefetch_slot=g.cursor;
        while(g.prefetch_n<3&&(g.deck.draw_n||g.deck.discard_n))g.prefetch_cards[g.prefetch_n++]=draw_one();
        if(!g.prefetch_n)g.prefetch_mode=false;
        g.program_uses[id]++;g.program_recent[(g.turn-1)%6][id]++;
    } else if(id==CARD_MARKER){
        if(g.queue_n<QUEUE_SIZE){g.queue_scale[g.queue_n]=g.cached_ready_slot==g.cursor+1?150:100;g.queue[g.queue_n++]=id;}
        if(g.deck.draw_n||g.deck.discard_n){g.deck.discard[g.deck.discard_n++]=id;g.deck.hand[g.cursor]=note_card_return(draw_one());g.selected[g.cursor]=0;}
    } else if(g.queue_n<QUEUE_SIZE){g.queue_scale[g.queue_n]=g.cached_ready_slot==g.cursor+1?150:100;g.queue[g.queue_n++]=id;}
}

static void resolve_cache(void){
    if(!g.cache_mode||g.cursor==g.cache_slot||g.selected[g.cursor]||CARD_DEF[g.deck.hand[g.cursor]].type!=PROGRAM)return;
    g.cached_card=(uint8_t)(g.deck.hand[g.cursor]+1);g.deck.hand[g.cursor]=note_card_return(draw_one());g.program_uses[CARD_CACHE]++;g.program_recent[(g.turn-1)%6][CARD_CACHE]++;g.seek_path_used=true;g.cursor=g.cache_slot;g.cache_mode=false;
}

static void resolve_prefetch(void) {
    if(!g.prefetch_mode||!g.prefetch_n)return;
    for(int i=g.prefetch_n-1;i>=0;i--)if(i!=g.prefetch_cursor)g.deck.draw[g.deck.draw_n++]=g.prefetch_cards[i];
    g.deck.discard[g.deck.discard_n++]=CARD_PREFETCH;g.deck.hand[g.prefetch_slot]=note_card_return(g.prefetch_cards[g.prefetch_cursor]);g.selected[g.prefetch_slot]=0;g.cursor=g.prefetch_slot;g.prefetch_mode=false;
}

static void seek_card(void) {
    if(g.seek_used||g.cursor>=g.deck.hand_n||deck_total()<HAND_SIZE)return;
    CardId old=g.deck.hand[g.cursor];
    memmove(&g.deck.draw[1],&g.deck.draw[0],g.deck.draw_n*sizeof(CardId));g.deck.draw[0]=old;g.deck.draw_n++;
    g.deck.hand[g.cursor]=note_card_return(draw_one());g.seek_used=true;
}

static CardId shop_card(int slot) {
    if(slot==0)return CARD_14K;if(slot==1)return CARD_CHAT;if(slot==2)return CARD_VOICE;
    return g.kingdom[slot-3];
}

static void defrag_move(int direction) {
    for(int tries=0;tries<CARD_COUNT;tries++){g.shop_cursor=(uint8_t)((g.shop_cursor+CARD_COUNT+direction)%CARD_COUNT);if(deck_count(g.shop_cursor))return;}
}

static void buy(void) {
    if(g.shop_cursor==8){g.defrag_mode=true;g.shop_cursor=0;if(!deck_count(0))defrag_move(1);return;}
    if(g.shop_cursor==9){if(g.turn<5)return;g.contract_boost=1;g.contract_used=true;cleanup();return;}
    if(g.shop_cursor==10){if(g.turn<7)return;g.trade_mode=true;g.shop_cursor=0;if(!deck_count(0))defrag_move(1);return;}
    CardId id=shop_card(g.shop_cursor);if(g.baud<CARD_DEF[id].cost)return;
    if(deck_total()<MAX_DECK){g.deck.discard[g.deck.discard_n++]=id;g.new_card=id+1;g.new_ticks=0;g.cards_bought[id]++;}cleanup();
}

void game_start(uint32_t seed) {
    bool muted=g.muted,low_fx=g.low_fx,today=g.today,save_corrupt=g.save_corrupt;
    memset(&g,0,sizeof(g));g.running=true;g.muted=muted;g.low_fx=low_fx;g.seed=seed;g.deck_rng=seed^0x12345678u;g.encounter_rng=seed^0x9e3779b9u;g.reward_rng=seed^0xa5a5a5a5u;
    g.today=today;g.save_corrupt=save_corrupt;
#ifdef DEV_LOG
    dev_cheated=false;
#endif
    g.hp=HP_START;g.turn=1;g.px=160;g.py=112;g.last_dx=1;g.trend_card=CARD_FIREWALL;g.last_program=255;
    uint8_t intents[12]={BOT_RAID,GIFT_DROP,BOT_RAID,COMMENT_WALL,MUTE,GIFT_DROP,COMMENT_WALL,MUTE,BOT_RAID,MIRROR,CLIP_THEFT,TREND};
    memcpy(g.intent_deck,intents,sizeof(intents));generate_kingdom();
    CardId rest[]={CARD_2400,CARD_2400,CARD_2400,CARD_2400,CARD_CHAT};
    for(int i=0;i<5;i++)g.deck.draw[g.deck.draw_n++]=rest[i];
    CardId fixed[]={CARD_MULTI,CARD_CHAT,CARD_FIREWALL,CARD_2400,CARD_2400};
    for(int i=0;i<5;i++)g.deck.draw[g.deck.draw_n++]=fixed[i];
    begin_edit();
}

const wchar_t *intent_name(uint8_t intent) {
    static const wchar_t *names[]={L"봇 습격 > 동쪽",L"음소거 / 칸 봉인",L"선물 투하 / 위험",L"댓글 장벽",L"거울 / 첫 편성",L"영상 탈취 / 재생",L"유행 / 학습 완료"};
    return names[intent%INTENT_COUNT];
}

const wchar_t *ending_name(uint8_t ending){static const wchar_t *names[]={L"열린 채널",L"마지막 보관",L"완벽한 관객",L"미해결 메아리"};return names[ending%4];}
const wchar_t *final_form_name(uint8_t form){static const wchar_t *names[]={L"채팅 폭풍",L"공명",L"열린 메아리"};return names[form%3];}
const wchar_t *final_modifier_name(uint8_t modifier){static const wchar_t *names[]={L"반복",L"회선",L"안전",L"재생"};return names[modifier%4];}

void game_press(int key){if(key>=0&&key<256)pressed_keys[key]=1;}
void game_hold(int key,bool down){if(key>=0&&key<256)held_keys[key]=(uint8_t)down;}

void game_tick(void) {
#ifdef DEV_LOG
    Mode before_mode=g.mode;
#endif
    if(pressed_keys['M'])g.muted=!g.muted;
    if(pressed_keys[VK_F1])g.low_fx=!g.low_fx;
    if(pressed_keys[VK_ESCAPE]&&g.mode!=TITLE&&!(g.mode==BREAK&&(g.defrag_mode||g.trade_mode))){g.paused=!g.paused;memset(pressed_keys,0,sizeof(pressed_keys));return;}
    if(g.paused){memset(pressed_keys,0,sizeof(pressed_keys));return;}
    g.anim_ticks++;if(g.invuln_ticks)g.invuln_ticks--;if(g.echo_convert_ticks)g.echo_convert_ticks--;if(g.firewall_ticks)g.firewall_ticks--;if(g.effect_ticks)g.effect_ticks--;if(g.flash_ticks)g.flash_ticks--;if(g.shake_ticks)g.shake_ticks--;if(g.threshold_ticks&&!--g.threshold_ticks)start_next_threshold();if(g.new_ticks&&!--g.new_ticks)g.new_card=0;if(g.message_ticks)g.message_ticks--;
#ifdef DEV_LOG
    if(pressed_keys[VK_F6]||pressed_keys[VK_F7]||pressed_keys[VK_F8]||pressed_keys[VK_F9])dev_cheated=true;
    if(pressed_keys[VK_F9]&&g.mode!=TITLE&&g.mode!=RESULT)begin_open();
    if(pressed_keys[VK_F8]&&g.mode==EDIT){CardId p1[]={CARD_PREFETCH,CARD_MARKER,CARD_SURGE,CARD_MACRO,CARD_CHECKSUM};memcpy(g.deck.hand,p1,sizeof(p1));g.deck.hand_n=5;g.cursor=0;g.cue=3;memset(g.selected,0,sizeof(g.selected));}
    if(pressed_keys[VK_F7]&&g.mode==EDIT){g.mode=BREAK;g.baud=9;g.shop_cursor=0;}
    if(pressed_keys[VK_F6]&&g.mode==OPEN_CHANNEL)add_echo(ECHO_LIVE,32,0);
#endif
    if(g.mode==TITLE){if(pressed_keys[VK_RETURN])game_start(0x14401997u);}
    else if(g.mode==EDIT){
        if(g.cache_mode){if(pressed_keys[VK_LEFT]||pressed_keys['A'])do{g.cursor=(uint8_t)((g.cursor+g.deck.hand_n-1)%g.deck.hand_n);}while(g.cursor==g.cache_slot||g.selected[g.cursor]||CARD_DEF[g.deck.hand[g.cursor]].type!=PROGRAM);if(pressed_keys[VK_RIGHT]||pressed_keys['D'])do{g.cursor=(uint8_t)((g.cursor+1)%g.deck.hand_n);}while(g.cursor==g.cache_slot||g.selected[g.cursor]||CARD_DEF[g.deck.hand[g.cursor]].type!=PROGRAM);if(pressed_keys[VK_RETURN])resolve_cache();}
        else if(g.prefetch_mode){if(pressed_keys[VK_LEFT]||pressed_keys['A'])g.prefetch_cursor=(uint8_t)((g.prefetch_cursor+g.prefetch_n-1)%g.prefetch_n);if(pressed_keys[VK_RIGHT]||pressed_keys['D'])g.prefetch_cursor=(uint8_t)((g.prefetch_cursor+1)%g.prefetch_n);if(pressed_keys[VK_RETURN])resolve_prefetch();}
        else{if(pressed_keys[VK_LEFT]||pressed_keys['A'])g.cursor=(uint8_t)((g.cursor+g.deck.hand_n-1)%g.deck.hand_n);if(pressed_keys[VK_RIGHT]||pressed_keys['D'])g.cursor=(uint8_t)((g.cursor+1)%g.deck.hand_n);if(pressed_keys[VK_RETURN])edit_activate();if(pressed_keys[VK_SPACE])seek_card();if(pressed_keys[VK_TAB])begin_air();}
    } else if(g.mode==ON_AIR)update_air();
    else if(g.mode==BREAK){
        if(g.defrag_mode||g.trade_mode){if(pressed_keys[VK_LEFT]||pressed_keys['A'])defrag_move(-1);if(pressed_keys[VK_RIGHT]||pressed_keys['D'])defrag_move(1);if(pressed_keys[VK_RETURN]&&deck_total()>5){CardId removed=g.shop_cursor;if(deck_remove_one(removed)){if(g.trade_mode){add_echo(ECHO_ARCHIVED,2,0);g.seek_path_used=true;}else if(removed==CARD_NOISE)for(int i=0;i<64;i++)if(g.ring[i].origin==0&&g.ring[i].state!=ECHO_LIVE){g.ring[i].state=ECHO_LIVE;recount_echo();break;}cleanup();}}if(pressed_keys[VK_ESCAPE]){g.defrag_mode=g.trade_mode=false;g.shop_cursor=8;}}
        else{if(pressed_keys[VK_LEFT]||pressed_keys['A'])g.shop_cursor=(uint8_t)((g.shop_cursor+10)%11);if(pressed_keys[VK_RIGHT]||pressed_keys['D'])g.shop_cursor=(uint8_t)((g.shop_cursor+1)%11);if(pressed_keys[VK_RETURN])buy();if(pressed_keys[VK_TAB])cleanup();if(pressed_keys['O']&&g.turn>=8)begin_open();}
    } else if(g.mode==OPEN_CHANNEL)update_open();
    else if(g.mode==RESULT){if(pressed_keys[VK_RETURN])game_start(g.seed);else if(pressed_keys[VK_RIGHT]||pressed_keys['D'])game_start(g.today?g.seed:g.seed+0x9e3779b9u);}
#ifdef DEV_LOG
    telemetry_transition(before_mode,g.mode);
#endif
    memset(pressed_keys,0,sizeof(pressed_keys));
}

#ifdef SELF_TEST
#ifndef SIM_SEEDS
#define SIM_SEEDS 30
#endif
static void test_movement(void) {
    game_start(1);g.mode=ON_AIR;g.phase_ticks=1000;float x=g.px;
    game_hold(VK_RIGHT,true);for(int i=0;i<60;i++)game_tick();game_hold(VK_RIGHT,false);assert(fabsf(g.px-x-54.0f)<0.01f);
}
static void test_ring(void){game_start(2);add_echo(ECHO_LIVE,3,0);add_echo(ECHO_MIMICKED,2,1);assert(g.echo_total==5&&g.echo_live==3&&g.echo_mimicked==2);}
static void test_finale_model(void){game_start(3);assert(deck_count(CARD_2400)==6&&deck_count(CARD_CHAT)==2);int cycle=OC_CARD_TICKS*8+HAND_SWAP_TICKS*((8+4)/5);assert((OPEN_TICKS/cycle)*2==26);g.deck.discard[g.deck.discard_n++]=CARD_VOICE;cycle=OC_CARD_TICKS*9+HAND_SWAP_TICKS*((9+4)/5);assert((OPEN_TICKS/cycle)*5==60);}
static void test_turn_flow(void){game_start(4);assert(g.mode==EDIT);game_press(VK_TAB);game_tick();assert(g.mode==ON_AIR);g.phase_ticks=1;game_tick();assert(g.mode==BREAK);game_press(VK_TAB);game_tick();assert(g.mode==EDIT&&g.turn==2);}
static void test_controls(void){
    game_start(41);game_press('M');game_tick();assert(g.muted);game_press(VK_F1);game_tick();assert(g.low_fx);game_start(42);assert(g.muted&&g.low_fx);
    int ticks=g.phase_ticks;game_press(VK_ESCAPE);game_tick();assert(g.paused);game_tick();assert(g.phase_ticks==ticks);game_press(VK_ESCAPE);game_tick();assert(!g.paused);
    g.mode=RESULT;uint32_t seed=g.seed;game_press(VK_RIGHT);game_tick();assert(g.seed==seed+0x9e3779b9u&&g.mode==EDIT);
    g.deck.hand[0]=CARD_FIREWALL;g.deck.hand[1]=CARD_CHECKSUM;g.deck.hand_n=2;g.cue=2;g.cursor=0;edit_activate();g.cursor=1;edit_activate();begin_air();game_hold(VK_SPACE,true);for(int i=0;i<12;i++)game_tick();game_hold(VK_SPACE,false);assert(g.queue_at==2);
}
static void test_rule_feedback(void){
    game_start(43);g.mode=OPEN_CHANNEL;add_echo(ECHO_LIVE,2,0);damage_player();int mimicked=g.echo_mimicked;g.invuln_ticks=0;damage_player();assert(g.echo_mimicked==mimicked&&g.echo_convert_ticks>0);
    game_start(44);g.hp=4;memset(g.enemies,0,sizeof(g.enemies));spawn_enemy(SPON_GIFT,g.px,g.py);update_enemies();assert(g.echo_mimicked==1&&g.hp==5&&!g.enemies[0].active);
    game_start(45);g.sync=0;memset(g.enemies,0,sizeof(g.enemies));spawn_enemy(SPON_GIFT,40,40);damage_enemy(0,99);assert(g.sync==1&&g.echo_mimicked==0);
    game_start(46);g.mode=BREAK;g.defrag_mode=true;g.deck.draw_n=5;g.deck.discard_n=g.deck.hand_n=0;g.shop_cursor=CARD_2400;game_press(VK_RETURN);game_tick();assert(deck_total()==5&&g.mode==BREAK);
    g.deck.draw[g.deck.draw_n++]=CARD_NOISE;g.shop_cursor=CARD_NOISE;g.ring[0].origin=0;g.ring[0].state=ECHO_MIMICKED;recount_echo();game_press(VK_RETURN);game_tick();assert(deck_count(CARD_NOISE)==0&&g.echo_live==1);
    game_start(47);g.new_card=CARD_FIREWALL+1;g.deck.draw_n=1;g.deck.draw[0]=CARD_FIREWALL;assert(note_card_return(draw_one())==CARD_FIREWALL&&g.new_ticks==90);
}
static void test_cache_no_duplicate(void){game_start(5);g.deck.hand[0]=CARD_CACHE;g.deck.hand[1]=CARD_FIREWALL;g.deck.hand_n=2;g.cursor=0;int before=deck_total();edit_activate();assert(g.cache_mode);g.cursor=1;resolve_cache();assert(g.cached_card==CARD_FIREWALL+1&&deck_total()==before);cleanup();assert(deck_total()==before);game_start(5);g.cached_card=CARD_FIREWALL+1;g.deck.hand_n=0;draw_hand();g.cursor=0;edit_activate();assert(g.queue_n==1&&g.queue_scale[0]==150);}
static int simulate_open_echo(void){for(int tick=0;tick<OPEN_TICKS;tick++)if(--g.open_card_ticks<=0){open_archive_tick();int n=open_sequence_size(),pos=n?g.open_sequence_at%n:0;g.open_card_ticks=OC_CARD_TICKS+(n&&(pos==0||pos%HAND_SIZE==0)?HAND_SWAP_TICKS:0);}return g.echo_total;}
static void test_open_scheduler(void){game_start(6);begin_open();assert(simulate_open_echo()==26);game_start(6);g.deck.discard[g.deck.discard_n++]=CARD_VOICE;begin_open();assert(simulate_open_echo()==60);}
static void test_p1_cards(void){
    game_start(7);g.deck.hand[0]=CARD_PREFETCH;g.cursor=0;int total=deck_total();edit_activate();assert(g.prefetch_mode&&g.prefetch_n==3);resolve_prefetch();assert(!g.prefetch_mode&&deck_total()==total);
    game_start(8);g.deck.hand[0]=CARD_MARKER;g.cursor=0;total=deck_total();edit_activate();assert(g.queue_n==1&&g.queue[0]==CARD_MARKER&&deck_total()==total);
    memset(g.enemies,0,sizeof(g.enemies));spawn_enemy(BOT_CHAT,40.0f,40.0f);spawn_enemy(BOT_CHAT,80.0f,40.0f);execute_program(CARD_MARKER,false);assert(g.enemies[0].marked&&g.enemies[1].marked);int hp=g.enemies[0].hp;execute_program(CARD_SURGE,false);assert(g.enemies[0].hp<hp||!g.enemies[0].active);
    g.deck.discard[g.deck.discard_n++]=CARD_NOISE;int noise=deck_count(CARD_NOISE);execute_program(CARD_CHECKSUM,false);assert(deck_count(CARD_NOISE)==noise-1);
    g.last_program=CARD_FIREWALL;g.firewall_ticks=0;execute_program(CARD_MACRO,false);assert(g.firewall_ticks==FIREWALL_TICKS*70/100);
}
static void test_p1_content(void){for(uint32_t seed=1;seed<=100;seed++){game_start(seed);assert(kingdom_valid(g.kingdom));}game_start(9);int counts[INTENT_COUNT]={0};for(int i=0;i<12;i++)counts[g.intent_deck[i]]++;assert(counts[BOT_RAID]==3&&counts[MUTE]==2&&counts[GIFT_DROP]==2&&counts[COMMENT_WALL]==2&&counts[MIRROR]==1&&counts[CLIP_THEFT]==1&&counts[TREND]==1);}
static void test_seek_intervention(void){
    game_start(10);g.turn=7;g.intent=COMMENT_WALL;int archives=deck_count(CARD_CHAT)+deck_count(CARD_VOICE);begin_air();assert(g.stolen_card&&deck_count(CARD_CHAT)+deck_count(CARD_VOICE)==archives-1);int worm=-1;for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active&&g.enemies[i].type==BUF_WORM){worm=i;break;}assert(worm>=0);damage_enemy(worm,99);assert(!g.stolen_card&&g.echo_live==1&&deck_count(CARD_CHAT)+deck_count(CARD_VOICE)==archives);
    game_start(11);g.turn=7;g.intent=COMMENT_WALL;begin_air();assert(g.stolen_card);end_air();assert(!g.stolen_card&&g.echo_archived==1);
    game_start(12);g.intent=COMMENT_WALL;begin_air();int walls=0;for(int i=0;i<MAX_ENEMIES;i++)walls+=g.enemies[i].active&&g.enemies[i].type==POP_AD;assert(walls>0);
}

static void test_finale_effects(void){
    game_start(13);g.deck.draw_n=g.deck.discard_n=g.deck.hand_n=0;g.deck.draw[g.deck.draw_n++]=CARD_CHAT;g.deck.draw[g.deck.draw_n++]=CARD_CHAT;g.deck.draw[g.deck.draw_n++]=CARD_MARKER;g.deck.draw[g.deck.draw_n++]=CARD_SURGE;compile_finale();assert(g.final_form==FORM_CHATSTORM&&g.final_modifier==MOD_NETWORK);
    memset(g.ring,0,sizeof(g.ring));for(int i=0;i<24;i++)g.ring[i].state=ECHO_ARCHIVED;recount_echo();assert(choose_ending()==END_LAST_ARCHIVE);for(int i=24;i<48;i++)g.ring[i].state=ECHO_MIMICKED;recount_echo();assert(choose_ending()==END_PERFECT_AUDIENCE);
    memset(g.ring,0,sizeof(g.ring));for(int i=0;i<16;i++)g.ring[i].state=ECHO_LIVE;for(int i=16;i<32;i++)g.ring[i].state=ECHO_ARCHIVED;for(int i=32;i<48;i++)g.ring[i].state=ECHO_MIMICKED;recount_echo();g.contract_used=g.seek_path_used=true;assert(choose_ending()==END_UNRESOLVED_ECHO);
    memset(g.program_uses,0,sizeof(g.program_uses));memset(g.program_recent,0,sizeof(g.program_recent));g.program_uses[CARD_FIREWALL]=1;g.program_recent[0][CARD_SURGE]=2;choose_trend();assert(g.trend_card==CARD_SURGE);
    game_start(14);g.mode=OPEN_CHANNEL;add_echo(ECHO_LIVE,16,0);assert(g.ring_threshold==1&&g.threshold_ticks);int timer=g.threshold_ticks;game_tick();assert(g.threshold_ticks==timer-1);
    game_start(15);g.firewall_ticks=FIREWALL_TICKS;g.firewall_open_dir=0;bullet(g.px-10,g.py,1,0,1,1,1);update_bullets();assert(!g.bullets[0].active);bullet(g.px+10,g.py,1,0,1,1,1);update_bullets();assert(g.bullets[0].active);
    game_start(16);int hp=g.hp,noise=deck_count(CARD_NOISE);bullet(g.px,g.py,1,0,1,2,1);update_bullets();assert(g.hp==hp&&deck_count(CARD_NOISE)==noise+1);
    game_start(17);g.mode=ON_AIR;memset(g.enemies,0,sizeof(g.enemies));spawn_enemy(BOT_CHAT,g.px,g.py);update_enemies();assert(g.queue_delay_ticks==ENEMY_ATTACH_TICKS&&!g.enemies[0].active);
    game_start(18);g.deck.hand[0]=CARD_MARKER;g.deck.hand_n=1;g.intent=BOT_RAID;begin_air();int marked=0;for(int i=0;i<MAX_ENEMIES;i++)marked+=g.enemies[i].marked!=0;assert(marked==1);
    game_start(19);g.mode=OPEN_CHANNEL;for(int i=0;i<48;i++)g.ring[i].state=ECHO_LIVE;recount_echo();g.seek_ticks=1;update_open();assert(g.echo_archived==1&&g.seek_interventions==1);
    g.ring[0].state=ECHO_MIMICKED;recount_echo();assert(restore_echo(ECHO_MIMICKED)&&g.ring[0].state==ECHO_LIVE);g.ring[1].state=ECHO_ARCHIVED;recount_echo();assert(restore_echo(ECHO_ARCHIVED)&&g.ring[1].state==ECHO_LIVE);
}

static bool sim_available(CardId id){if(id==CARD_14K||id==CARD_CHAT||id==CARD_VOICE)return true;for(int i=0;i<5;i++)if(g.kingdom[i]==id)return true;return false;}
static int program_count(void){int n=0;for(int id=CARD_MULTI;id<=CARD_CHECKSUM;id++)n+=deck_count((CardId)id);return n;}
static CardId sim_pick(int policy,int baud){
    static const CardId priority[7][5]={
        {CARD_14K,CARD_CHAT,CARD_VOICE,CARD_CHECKSUM,CARD_MULTI},
        {CARD_MULTI,CARD_CACHE,CARD_PREFETCH,CARD_14K,CARD_CHAT},
        {CARD_VOICE,CARD_CHAT,CARD_14K,CARD_PREFETCH,CARD_FIREWALL},
        {CARD_CHECKSUM,CARD_FIREWALL,CARD_14K,CARD_CHAT,CARD_VOICE},
        {CARD_MARKER,CARD_SURGE,CARD_MULTI,CARD_MACRO,CARD_CACHE},
        {CARD_CHAT,CARD_14K,CARD_VOICE,CARD_MULTI,CARD_CACHE},
        {CARD_CACHE,CARD_CHAT,CARD_VOICE,CARD_14K,CARD_CHECKSUM}
    };
    if(policy==0&&deck_count(CARD_14K)>=2){if(CARD_DEF[CARD_VOICE].cost<=baud)return CARD_VOICE;if(CARD_DEF[CARD_CHAT].cost<=baud)return CARD_CHAT;}
    if(policy==1&&program_count()>=5){if(CARD_DEF[CARD_VOICE].cost<=baud)return CARD_VOICE;if(CARD_DEF[CARD_CHAT].cost<=baud)return CARD_CHAT;}
    if(policy==3&&deck_count(CARD_CHECKSUM)+deck_count(CARD_FIREWALL)>=3){if(CARD_DEF[CARD_VOICE].cost<=baud)return CARD_VOICE;if(CARD_DEF[CARD_CHAT].cost<=baud)return CARD_CHAT;}
    if(policy==4&&program_count()>=5){if(CARD_DEF[CARD_VOICE].cost<=baud)return CARD_VOICE;if(CARD_DEF[CARD_CHAT].cost<=baud)return CARD_CHAT;}
    for(int i=0;i<5;i++){CardId id=priority[policy][i];if(sim_available(id)&&CARD_DEF[id].cost<=baud)return id;}return CARD_COUNT;
}
static bool sim_air(int policy,int turn,uint32_t seed){
    int carriers=0,tx_goal=(policy==2||policy==5||policy==6)?0:policy==3?2:1;
    if((policy==1||policy==4)&&program_count()>=3)tx_goal=0;
    for(int i=0;i<g.deck.hand_n;i++)if(CARD_DEF[g.deck.hand[i]].type==CARRIER)g.carrier_rx[i]=(uint8_t)(carriers++>=tx_goal);
    begin_air();game_hold(VK_SPACE,true);
    for(int tick=0;tick<ON_AIR_TICKS+1&&g.mode==ON_AIR;tick++){
        /* ponytail: the balance bot is invulnerable; it measures deck throughput while still executing real combat effects. */
        g.invuln_ticks=2;
        game_hold('W',false);game_hold('A',false);game_hold('S',false);game_hold('D',false);
        int direction=(tick/60+turn+(int)(seed&3))&3;game_hold(direction==0?'D':direction==1?'S':direction==2?'A':'W',true);game_tick();
    }
    game_hold(VK_SPACE,false);game_hold('W',false);game_hold('A',false);game_hold('S',false);game_hold('D',false);
    return g.mode==BREAK;
}
static int sim_run_policy(int policy,uint32_t seed,int *terminal){
    game_start(seed);
    for(int turn=1;turn<=12;turn++){
        int programs=0;for(int i=0;i<g.deck.hand_n;i++)programs+=CARD_DEF[g.deck.hand[i]].type==PROGRAM;
        for(int i=0;i<g.deck.hand_n&&g.cue;i++)if(CARD_DEF[g.deck.hand[i]].type==PROGRAM&&!g.selected[i]){g.cursor=(uint8_t)i;edit_activate();if(g.cache_mode)resolve_cache();if(g.prefetch_mode)resolve_prefetch();}
        *terminal+=programs>g.queue_n?programs-g.queue_n:0;if(!sim_air(policy,turn,seed))return g.echo_total;
        if(policy==5&&turn>=5&&(turn&1)){g.contract_boost=1;cleanup();continue;}
        if(policy==6&&turn>=7&&turn%3==1){if(deck_total()>5)deck_remove_one(CARD_2400);add_echo(ECHO_ARCHIVED,2,0);cleanup();continue;}
        CardId buy_id=sim_pick(policy,g.baud);if(buy_id<CARD_COUNT&&deck_total()<MAX_DECK){g.deck.discard[g.deck.discard_n++]=buy_id;g.cards_bought[buy_id]++;}
        cleanup();
    }
    assert(g.mode==OPEN_CHANNEL);return simulate_open_echo();
}
static void test_strategy_sim(void){
    static const char *name[]={"BIG_BAUD","LOOP_ENGINE","ECHO_RUSH","CLEAN_SIGNAL","CACHE_COMBO","PERFECT_SHOW","THREE_WAY"};int total_wins=0,max_wins=0,positive=0;
    for(int policy=0;policy<7;policy++){int wins=0,echoes=0,terminal=0;for(uint32_t seed=1;seed<=SIM_SEEDS;seed++){int echo=sim_run_policy(policy,seed,&terminal);echoes+=echo;wins+=echo>=64;}printf("SIM %-12s win %d/%d echo %d terminal %d\n",name[policy],wins,SIM_SEEDS,echoes/SIM_SEEDS,terminal);assert(echoes>=0&&echoes<=64*SIM_SEEDS);positive+=wins>0;total_wins+=wins;if(wins>max_wins)max_wins=wins;}
    assert(positive>=5&&max_wins*10<=total_wins*4);
}
int main(void){setvbuf(stdout,NULL,_IONBF,0);test_movement();test_ring();test_finale_model();test_turn_flow();test_controls();test_rule_feedback();test_cache_no_duplicate();test_open_scheduler();test_p1_cards();test_p1_content();test_seek_intervention();test_finale_effects();test_strategy_sim();puts("V2 P1 selftest: PASS");return 0;}
#endif
