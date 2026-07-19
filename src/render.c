enum {
    COL_BG=0x0009070f,COL_PANEL=0x0021182a,COL_INK=0x00f2ebdd,COL_DIM=0x0085808d,
    COL_CYAN=0x004edbc9,COL_AMBER=0x00e7aa4b,COL_MAGENTA=0x00ef4f9e,COL_RED=0x00e65b5b,
    COL_BLUE=0x006aaae8,COL_BLACK=0
};

static uint32_t *pixels;
static HDC back_dc;
static HBITMAP back_bitmap;

static void clear(uint32_t c){for(int i=0;i<SCREEN_W*SCREEN_H;i++)pixels[i]=c;}
static void rect(int x,int y,int w,int h,uint32_t c){
    int x0=x<0?0:x,y0=y<0?0:y,x1=x+w>SCREEN_W?SCREEN_W:x+w,y1=y+h>SCREEN_H?SCREEN_H:y+h;
    for(int yy=y0;yy<y1;yy++)for(int xx=x0;xx<x1;xx++)pixels[yy*SCREEN_W+xx]=c;
}
static void frame(int x,int y,int w,int h,uint32_t c){rect(x,y,w,1,c);rect(x,y+h-1,w,1,c);rect(x,y,1,h,c);rect(x+w-1,y,1,h,c);}
static void line(int x0,int y0,int x1,int y1,uint32_t c){
    int dx=abs(x1-x0),sx=x0<x1?1:-1,dy=-abs(y1-y0),sy=y0<y1?1:-1,e=dx+dy;
    for(;;){if(x0>=0&&x0<SCREEN_W&&y0>=0&&y0<SCREEN_H)pixels[y0*SCREEN_W+x0]=c;if(x0==x1&&y0==y1)break;int e2=e*2;if(e2>=dy){e+=dy;x0+=sx;}if(e2<=dx){e+=dx;y0+=sy;}}
}
static const uint8_t FONT[][7]={
    {14,17,17,31,17,17,17},{30,17,17,30,17,17,30},{15,16,16,16,16,16,15},{30,17,17,17,17,17,30},{31,16,16,30,16,16,31},{31,16,16,30,16,16,16},{15,16,16,23,17,17,15},{17,17,17,31,17,17,17},{31,4,4,4,4,4,31},{7,2,2,2,2,18,12},{17,18,20,24,20,18,17},{16,16,16,16,16,16,31},{17,27,21,21,17,17,17},{17,25,21,19,17,17,17},{14,17,17,17,17,17,14},{30,17,17,30,16,16,16},{14,17,17,17,21,18,13},{30,17,17,30,20,18,17},{15,16,16,14,1,1,30},{31,4,4,4,4,4,4},{17,17,17,17,17,17,14},{17,17,17,17,17,10,4},{17,17,17,21,21,27,17},{17,17,10,4,10,17,17},{17,17,10,4,4,4,4},{31,1,2,4,8,16,31},
    {14,17,19,21,25,17,14},{4,12,4,4,4,4,14},{14,17,1,2,4,8,31},{30,1,1,14,1,1,30},{2,6,10,18,31,2,2},{31,16,16,30,1,1,30},{14,16,16,30,17,17,14},{31,1,2,4,8,8,8},{14,17,17,14,17,17,14},{14,17,17,15,1,1,14}
};
typedef struct { uint16_t ch,row[12]; } KoGlyph;
#include "generated/font_ko.inc"
#include "generated/art.inc"
static const uint32_t ART_PALETTE[16]={0x0009070f,0x00120e1a,0x0021182a,0x0032253b,0x00f2ebdd,0x0085808d,0x00176c69,0x004edbc9,0x0076501f,0x00e7aa4b,0x006c204a,0x00ef4f9e,0x00e65b5b,0x006aaae8,0x00b8a6d9,0};
static void art_blit(int x,int y,const uint8_t *data,int stride,int sx,int sy,int w,int h){for(int yy=0;yy<h;yy++)for(int xx=0;xx<w;xx++){int at=(sy+yy)*stride+sx+xx;uint8_t byte=data[at>>1],c=(uint8_t)((at&1)?byte&15:byte>>4);if(c!=15&&x+xx>=0&&x+xx<SCREEN_W&&y+yy>=0&&y+yy<SCREEN_H)pixels[(y+yy)*SCREEN_W+x+xx]=ART_PALETTE[c];}}
static uint8_t glyph_row(wchar_t ch,int row){
    if(ch>=L'a'&&ch<=L'z')ch-=32;if(ch>=L'A'&&ch<=L'Z')return FONT[ch-L'A'][row];if(ch>=L'0'&&ch<=L'9')return FONT[26+ch-L'0'][row];
    switch(ch){case L'/':return (uint8_t)(1<<(row<5?row:4));case L'-':return row==3?31:0;case L'_':return row==6?31:0;case L'.':return row==6?4:0;case L':':return row==2||row==5?4:0;case L'+':return row==3?14:(row==2||row==4?4:0);case L'>':return row==2?8:row==3?4:row==4?2:0;case L'?':return (uint8_t[]){14,17,1,2,4,0,4}[row];case L'!':return row<5?4:(row==6?4:0);case L'=':return row==2||row==4?31:0;case L'(':return row==0||row==6?2:4;case L')':return row==0||row==6?8:4;default:return 0;}
}
static int draw_glyph(int x,int y,uint32_t c,wchar_t ch,int scale){
    if(ch>=0xac00&&ch<=0xd7a3){for(size_t i=0;i<KO_FONT_COUNT;i++)if(KO_FONT[i].ch==(uint16_t)ch){for(int row=0;row<12;row++)for(int col=0;col<12;col++)if(KO_FONT[i].row[row]&(1u<<(11-col)))rect(x+col*scale,y+row*scale,scale,scale,c);break;}return 13*scale;}
    for(int row=0;row<7;row++){uint8_t bits=glyph_row(ch,row);for(int col=0;col<5;col++)if(bits&(16>>col))rect(x+col*scale,y+row*scale,scale,scale,c);}return 6*scale;
}
static void text_scaled(int x,int y,uint32_t c,const wchar_t *s,int scale){for(;*s;s++)x+=draw_glyph(x,y,c,*s,scale);}
static void text_at(int x,int y,uint32_t c,const wchar_t *s){text_scaled(x,y,c,s,1);}
static void number_at(int x,int y,uint32_t c,const wchar_t *fmt,int n){wchar_t b[48];wsprintfW(b,fmt,n);text_at(x,y,c,b);}

static uint32_t echo_color(int state){return state==ECHO_LIVE?COL_CYAN:state==ECHO_ARCHIVED?COL_AMBER:state==ECHO_MIMICKED?COL_MAGENTA:COL_DIM;}

static void draw_ring(int cx,int cy,int radius,bool detailed){
    int cells=detailed?64:16;
    for(int i=0;i<cells;i++){
        int first=i*(64/cells),state=0;
        for(int k=0;k<64/cells;k++)if(g.ring[first+k].state){state=g.ring[first+k].state;break;}
        double a=(double)i*6.283185307179586/cells-1.5707963267948966;
        int x=cx+(int)(cos(a)*radius),y=cy+(int)(sin(a)*radius);
        uint32_t c=state?echo_color(state):COL_DIM;
        if(state==ECHO_MIMICKED){rect(x-2,y-2,5,5,c);rect(x-1,y-1,3,3,COL_BG);}
        else if(state==ECHO_ARCHIVED){rect(x-2,y-1,2,2,c);rect(x+1,y-1,2,2,c);}
        else rect(x-1,y-1,3,3,c);
    }
}

static void draw_echo(int x,int y){
    int pose=g.mode==OPEN_CHANNEL?5:g.invuln_ticks?4:g.effect_ticks?3:g.mode==EDIT?(g.cursor<2?2:g.cursor>2?3:6):(g.anim_ticks/12)&1;
    art_blit(x-12,y-12,ART_ECHO,240,pose*24,0,24,24);
    if(g.invuln_ticks&&(g.invuln_ticks/3&1))frame(x-10,y-10,20,27,COL_RED);
}

static void draw_noa(int x,int y){
    int stage=g.echo_total>=48?2:g.echo_total>=32?1:0;art_blit(x-24,y-32,ART_NOA,144,stage*48,0,48,64);
}
static void draw_seek_cable(void){art_blit(2,121,ART_SEEK_SHELL,64,((g.anim_ticks/16)&1)*16,0,16,16);line(16,134,47,120,COL_AMBER);}

static void draw_enemy(const Enemy *e){int x=(int)e->x,y=(int)e->y;
    int pose=(g.anim_ticks/14+((int)e->x>>4))&1;art_blit(x-8,y-8,ART_ENEMY,160,e->type*32+pose*16,0,16,16);
}

static void draw_icon(int x,int y,CardId id,uint32_t c){
    (void)c;art_blit(x,y,ART_CARD,240,id*16,0,16,16);
}

static const wchar_t *card_hint(CardId id){
    static const wchar_t *hints[]={
        L"송신 공격 / 수신 전송+1",L"강한 송신 / 수신 전송+2",L"이번 구절 편성 +2",
        L"다음 구절 150% 보관",L"이동 방향 한 면이 열린 방벽",L"직전 프로그램 70% 반복",
        L"다음 3장 중 하나 선택",L"가까운 적 5개 표식",L"표식 적 우선 연쇄 피해",
        L"잡음 제거 / 모방 복구",L"연쇄 급증 / 이번 구절 신호+1",
        L"편성 유지 / 손패 순환(프로그램 탐색)",
        L"지금 부담 / 최종 응답+1",L"지금 부담 / 최종 응답+3",
        L"덱 방해 / 검사나 정리로 제거"
    };
    return hints[id<CARD_COUNT?id:CARD_NOISE];
}

static void draw_card(int x,int y,int w,int h,CardId id,bool focus,int slot){
    const CardDef *c=&CARD_DEF[id];uint32_t ac=c->type==CARRIER?COL_CYAN:c->type==ARCHIVE?COL_DIM:c->type==NOISE?COL_RED:COL_INK;
    if(focus)rect(x+3,y+3,w-1,h,COL_BLACK);rect(x,y,w,h,COL_PANEL);frame(x,y,w,h,focus?COL_INK:ac);
    rect(x+4,y+2,w-8,2,ac);rect(x,y,2,2,COL_BG);rect(x+w-2,y,2,2,COL_BG);rect(x,y+h-2,2,2,COL_BG);rect(x+w-2,y+h-2,2,2,COL_BG);
    if(focus)frame(x+2,y+2,w-4,h-4,ac);if(c->type==PROGRAM)rect(x-1,y+9,3,9,focus?COL_INK:COL_DIM);else if(c->type==ARCHIVE)rect(x+w-13,y-2,10,3,COL_DIM);
    draw_icon(x+w/2-8,y+6,id,ac);rect(x+3,y+24,w-6,1,focus?ac:COL_DIM);text_at(x+4,y+29,focus?COL_INK:COL_DIM,c->short_name);
    rect(x+2,y+h-17,w-4,15,COL_BG);
    if(c->type==CARRIER){bool rx=g.carrier_rx[slot]!=0;text_at(x+4,y+h-13,rx?COL_BLUE:COL_CYAN,rx?L"수신v":L"송신^");int px=x+w-9,py=y+h-10;if(rx){line(px-3,py-3,px,py, COL_BLUE);line(px+3,py-3,px,py,COL_BLUE);rect(px-1,py+1,3,2,COL_BLUE);}else{line(px-3,py+2,px,py-1,COL_CYAN);line(px+3,py+2,px,py-1,COL_CYAN);rect(px-1,py-4,3,2,COL_CYAN);}}
    else if(g.selected[slot])text_at(x+4,y+h-13,g.selected[slot]==2?COL_AMBER:g.selected[slot]==3?COL_MAGENTA:COL_CYAN,g.selected[slot]==2?L"저장":g.selected[slot]==3?L"봉인":L"편성");
    else text_at(x+4,y+h-13,COL_DIM,c->type==ARCHIVE?L"기록":c->type==NOISE?L"잡음":L"기능");
}

enum { COL_TRACK=0x00171322 };
static void draw_header(void){
    rect(0,0,SCREEN_W,16,COL_PANEL);number_at(4,2,COL_INK,L"체력%d",g.hp);number_at(54,2,COL_CYAN,L"동조%d",g.sync);
    int tx=SCREEN_W-70,ew=tx-8-118;
    number_at(118,2,COL_INK,L"메아리%d/64",g.echo_total);number_at(tx,2,COL_DIM,L"구절%d/12",g.turn>12?12:g.turn);
    /* HP = discrete life pips (Miller: small counts read faster as units than as a bar). */
    for(int i=0;i<HP_START;i++)rect(4+i*10,13,7,2,i<g.hp?(g.hp<3?COL_RED:COL_INK):COL_TRACK);
    /* SYNC 0..3 as three filling pips = the arrangement gauge, not a static bar. */
    for(int i=0;i<3;i++)rect(54+i*17,13,15,2,i<g.sync?COL_CYAN:COL_TRACK);
    /* ECHO = stacked composition gauge toward 64. Live/archived/mimicked widths make the
       ending-deciding colour mix readable every frame (goal-gradient + docs 10 s8). */
    rect(118,13,ew,2,COL_TRACK);
    int wl=ew*g.echo_live/64,wa=ew*g.echo_archived/64,wm=ew*g.echo_mimicked/64,cx=118;
    rect(cx,13,wl,2,COL_CYAN);cx+=wl;rect(cx,13,wa,2,COL_AMBER);cx+=wa;rect(cx,13,wm,2,COL_MAGENTA);
    /* TURN = elapsed fraction of the 12-verse run. */
    rect(tx,13,66,2,COL_TRACK);rect(tx,13,66*(g.turn>12?12:g.turn)/12,2,COL_DIM);
}

static void draw_background(void){clear(COL_BG);for(int y=24;y<ARENA_BOTTOM;y+=16)for(int x=(y&16)?8:0;x<SCREEN_W;x+=16)rect(x,y,1,1,COL_DIM);frame(2,18,SCREEN_W-4,188,COL_PANEL);}

static void draw_world(void){
    int previous=-1;for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active&&g.enemies[i].marked){if(previous>=0)line((int)g.enemies[previous].x,(int)g.enemies[previous].y,(int)g.enemies[i].x,(int)g.enemies[i].y,COL_CYAN);previous=i;frame((int)g.enemies[i].x-6,(int)g.enemies[i].y-6,12,12,COL_CYAN);}
    for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active)draw_enemy(&g.enemies[i]);
    /* Elite telegraph — a pulsing amber/red ring + crown pip marks the priority treasure target. */
    for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active&&g.enemies[i].elite){int x=(int)g.enemies[i].x,y=(int)g.enemies[i].y;uint32_t ec=(g.anim_ticks/6&1)?COL_AMBER:COL_RED;frame(x-9,y-9,18,18,ec);rect(x-2,y-11,4,2,ec);}
    for(int i=0;i<MAX_BULLETS;i++)if(g.bullets[i].active){Bullet *b=&g.bullets[i];rect((int)b->x-1,(int)b->y-1,3,3,b->hostile?COL_RED:COL_CYAN);if(b->hostile)rect((int)b->x,(int)b->y,1,1,COL_INK);}
    /* Signal shards — VS-style pickups that fund the shop; brighter cores are worth more. */
    for(int i=0;i<MAX_PICKUPS;i++)if(g.pickups[i].active){int x=(int)g.pickups[i].x,y=(int)g.pickups[i].y;rect(x-1,y-1,3,3,COL_BG);rect(x-1,y-1,2,2,g.pickups[i].worth>1?COL_MAGENTA:COL_AMBER);rect(x,y,1,1,COL_INK);}
    if(g.firewall_ticks){int x=(int)g.px,y=(int)g.py;frame(x-19,y-17,38,34,COL_CYAN);if(g.firewall_open_dir==0)rect(x+18,y-4,1,8,COL_BG);else if(g.firewall_open_dir==1)rect(x-4,y+16,8,1,COL_BG);else if(g.firewall_open_dir==2)rect(x-19,y-4,1,8,COL_BG);else rect(x-4,y-17,8,1,COL_BG);}
    if(g.effect_ticks&&g.effect_card==CARD_MACRO)frame((int)g.px-13,(int)g.py-13,26,30,COL_DIM);
    if(g.effect_ticks&&g.effect_card==CARD_CHECKSUM)line(8,ARENA_TOP+(24-g.effect_ticks)*8,SCREEN_W-8,ARENA_TOP+(24-g.effect_ticks)*8,COL_CYAN);
    if(g.turn==7||g.echo_archived)draw_seek_cable();
    draw_echo((int)g.px,(int)g.py);draw_ring((int)g.px,(int)g.py,22,false);
}

/* Combat-identity readout: which survivor stats the deck's PROGRAM tag schools currently grant.
   Closes the loop between the Dominion buy decision and the moment-to-moment ON AIR combat. */
static void draw_combat_build(int x,int y){
    static const uint8_t sch[4]={MOD_NETWORK,MOD_REPEAT,MOD_REPLAY,MOD_SAFE};
    static const wchar_t *nm[4]={L"확산",L"다발",L"연사",L"내성"};
    text_at(x,y,COL_DIM,L"전투:");x+=34;bool any=false;
    for(int i=0;i<4;i++){int t=combat_tier(sch[i]);if(!t)continue;any=true;
        text_at(x,y,COL_CYAN,nm[i]);x+=28;
        for(int k=0;k<t;k++){rect(x,y+1,3,5,COL_CYAN);x+=5;}
        x+=7;}
    if(!any)text_at(x,y,COL_DIM,L"기본 전송");
}

static void draw_edit(void){
    draw_background();rect(0,16,SCREEN_W,142,0x00171322);draw_world();draw_header();
    text_at(4,18,COL_MAGENTA,L"다음:");text_at(48,18,COL_INK,intent_name(g.intent));
    /* Threat telegraph — which enemy is coming and how many. Makes the intent deck (the
       one-screen level design, docs 10 s5) legible without a wall of text. */
    {uint8_t nt=g.intent==GIFT_DROP?SPON_GIFT:g.intent==MUTE?MOD_MASK:g.intent==COMMENT_WALL||g.intent==MIRROR?POP_AD:BOT_CHAT;
     art_blit(150,16,ART_ENEMY,160,nt*32,0,16,16);number_at(168,18,COL_DIM,L"x%d",3+g.turn/2);}
    if(g.turn==1){
        text_at(4,34,COL_BLUE,g.cards_cued[CARD_MULTI]?L"1. 방벽도 편성 -> 전투에서 공백":L"1. 분기 편성 -> 선택 +2");
        text_at(4,50,COL_DIM,g.cards_cued[CARD_MULTI]?L"확인:방벽 편성 / 탭:전투":L"송신1 / 수신1 추천 적용");
    }
    else if(g.turn==2){text_at(4,34,COL_BLUE,L"2. 확인: 송신 공격 / 수신 구매");text_at(4,50,COL_DIM,L"다음 의도에 맞춰 모뎀을 바꾸세요");}
    else if(g.turn==3){text_at(4,34,COL_BLUE,L"3. 탭 전투 / WASD 이동 / 공백 발동");}
    else if(g.turn>=5){text_at(4,34,COL_DIM,L"노아가 학습 중:");text_at(126,34,COL_MAGENTA,CARD_DEF[g.trend_card].short_name);}
    if(g.new_ticks&&g.new_card){text_at(4,66,COL_CYAN,L"구매 카드 귀환:");text_at(126,66,COL_INK,CARD_DEF[g.new_card-1].short_name);}
    else if(g.message_ticks)text_at(4,50,COL_AMBER,L"버린 더미를 섞었습니다.");
    number_at(SCREEN_W-54,18,COL_CYAN,L"편성%d",g.cue);
    /* CUE as filled pips — a small count reads faster as units than as a digit alone. */
    for(int i=0;i<(g.cue>7?7:g.cue);i++)rect(SCREEN_W-54+i*7,27,4,3,COL_CYAN);
    if(g.contract_applied){rect(SCREEN_W-60,34,56,15,COL_PANEL);frame(SCREEN_W-60,34,56,15,COL_MAGENTA);rect(SCREEN_W-57,37,3,9,COL_MAGENTA);text_at(SCREEN_W-51,36,COL_INK,L"계약+1");}
    number_at(4,132,COL_DIM,L"덱%d",g.deck.draw_n+g.deck.discard_n+g.deck.hand_n+(g.cached_card!=0));number_at(62,132,COL_DIM,L"뽑기%d",g.deck.draw_n);number_at(132,132,COL_DIM,L"버림%d",g.deck.discard_n);
    /* SEEK is a HUD invariant (docs 10 s15) but was never shown — surface its once-per-hand state. */
    text_at(210,132,g.seek_used?COL_DIM:COL_CYAN,g.seek_used?L"탐색 소진":L"탐색 가능");
    text_at(4,145,COL_DIM,L"확인:배정  공백:탐색  탭:전투");
    if(!g.cache_mode&&!g.prefetch_mode)draw_combat_build(4,64);
    if(!g.cache_mode&&!g.prefetch_mode)text_at(4,116,COL_INK,card_hint(g.deck.hand[g.cursor]));
    /* Hand widened to fill the roomier 400px layout — a Dominion hand should read at a glance. */
    for(int i=0;i<g.deck.hand_n;i++)draw_card(4+i*79,164-(i==g.cursor?2:0),74,72,g.deck.hand[i],i==g.cursor,i);
    if(g.cache_mode){int px=(SCREEN_W-194)/2;rect(px,55,194,68,COL_PANEL);frame(px,55,194,68,COL_AMBER);text_at(px+14,63,COL_INK,L"다음 구절에 보관할 카드");draw_icon(px+48,87,g.deck.hand[g.cursor],COL_AMBER);text_at(px+74,89,COL_INK,CARD_DEF[g.deck.hand[g.cursor]].short_name);}
    if(g.prefetch_mode){int px=(SCREEN_W-194)/2;rect(px,55,194,68,COL_PANEL);frame(px,55,194,68,COL_CYAN);text_at(px+9,61,COL_INK,L"미리 읽기 / 하나 선택");for(int i=0;i<g.prefetch_n;i++){int x=px+14+i*58;frame(x,79,50,34,i==g.prefetch_cursor?COL_INK:COL_DIM);draw_icon(x+4,86,g.prefetch_cards[i],COL_CYAN);text_at(x+22,87,COL_INK,CARD_DEF[g.prefetch_cards[i]].short_name);}}
}

static void draw_air(void){
    draw_background();draw_world();draw_header();
    /* 공명 정점 field — a following damage ring while a program's resonance is active (docs 60 §3.4). */
    if(!g.low_fx&&g.resonance_ticks){int x=(int)g.px,y=(int)g.py,r=RESONANCE_FIELD_RADIUS;uint32_t rc=(g.resonance_ticks/3&1)?COL_MAGENTA:COL_CYAN;for(int a=0;a<16;a++){double t=a*6.283185307/16;rect(x+(int)(cos(t)*r)-1,y+(int)(sin(t)*r)-1,2,2,rc);}}
    /* Live fusion readout: the kill chain and the signal it is banking toward the shop (docs 60). */
    if(g.combo>1){int tier=combo_tier();uint32_t cc=tier>=3?COL_MAGENTA:tier>=1?COL_CYAN:COL_INK;if(tier>=COMBO_TIER_MAX)text_at(SCREEN_W/2-58,20,COL_MAGENTA,L"공명");number_at(SCREEN_W/2-30,20,cc,L"연쇄x%d",g.combo);for(int k=0;k<tier;k++)rect(SCREEN_W/2-30+k*5,32,3,3,cc);}
    if(g.signal)number_at(SCREEN_W/2+34,20,COL_AMBER,L"신호%d",g.signal);
    /* Overdrive 필살기 charge — fills from kills; press J at full. Color/label track the deck school. */
    {int full=g.special_charge>=SPECIAL_MAX,w=54*g.special_charge/SPECIAL_MAX;uint32_t sc=full?COL_MAGENTA:COL_BLUE;
     text_at(4,20,COL_DIM,L"특수");rect(4,29,54,3,COL_TRACK);rect(4,29,w>54?54:w,3,sc);
     if(full&&(g.anim_ticks/8&1))text_at(62,25,COL_MAGENTA,L"J!");}
    if(g.special_ticks)text_at(4,36,COL_CYAN,L"연사 과부하");
    if(!g.low_fx&&g.mirror_label_ticks>PROGRAM_LABEL_TICKS-12)frame(2,18,SCREEN_W-4,188,COL_MAGENTA);
    rect(0,208,SCREEN_W,32,COL_PANEL);
    /* ON AIR countdown — the verse drains as an amber sliver so time pressure is felt, not read. */
    rect(0,208,SCREEN_W*g.phase_ticks/ON_AIR_TICKS,1,COL_AMBER);
    if(g.mirror_label_ticks){text_at(4,211,COL_MAGENTA,L"노아 복제");text_at(4,224,COL_INK,CARD_DEF[g.mirror_card-1].short_name);}
    else if(g.message_ticks&&g.program_fired){text_at(4,211,COL_CYAN,L"송출");text_at(4,224,COL_INK,CARD_DEF[g.effect_card].short_name);}
    else if(g.queue_at<g.queue_n){text_at(4,211,COL_DIM,g.turn<=3?L"WASD+공백":L"공백:송출");text_at(4,224,COL_CYAN,CARD_DEF[g.queue[g.queue_at]].short_name);}
    else{text_at(4,211,COL_DIM,g.turn<=3?L"WASD+공백":L"공백:송출");text_at(4,224,COL_DIM,g.queue_n?L"편성 완료":L"편성 없음");}
    for(int i=0;i<g.queue_n;i++){int x=88+i*48;uint32_t c=i<g.queue_at?COL_DIM:i==g.queue_at?COL_INK:COL_CYAN;if(i)line(x-22,223,x-2,223,c);frame(x,211,38,24,c);number_at(x+2,216,c,L"%d",i+1);draw_icon(x+19,215,g.queue[i],c);if(i==g.queue_at)rect(x+2,212,34,2,COL_INK);}
    number_at(SCREEN_W-46,211,COL_INK,L"%d초",(g.phase_ticks+59)/60);
}

static void draw_break(void){
    draw_background();draw_world();rect(0,16,SCREEN_W,224,0x00171322);draw_header();number_at(4,19,COL_BLUE,L"휴식  전송량%d",g.baud);
    if(g.signal_baud)number_at(120,19,COL_AMBER,L"신호+%d",g.signal_baud); /* combat-funded baud this verse */
    if(g.echo_archived)art_blit(SCREEN_W-28,35,ART_SEEK_AVATAR,192,((g.anim_ticks/24)&1)*24,0,24,24);
    if(g.defrag_mode||g.trade_mode){int px=(SCREEN_W-192)/2;text_at(4,42,g.trade_mode?COL_AMBER:COL_INK,g.trade_mode?L"시크 보관 / 호박+2":L"정리 / 카드 한 장 제거");frame(px,72,192,70,COL_INK);draw_icon(px+14,91,(CardId)g.shop_cursor,COL_AMBER);text_at(px+44,88,COL_INK,CARD_DEF[g.shop_cursor].name);number_at(px+44,108,COL_DIM,L"보유%d",deck_count(g.shop_cursor));text_at(px-12,166,COL_DIM,L"좌우:선택  확인:결정  취소:닫기");return;}
    text_at(4,36,g.turn==1?COL_CYAN:COL_DIM,g.turn==1?(g.baud>=CARD_DEF[CARD_CHAT].cost?L"첫 응답 +1 / 지금 카드 1장을 고르세요":L"첫 응답 +1 / 다음에는 수신을 늘리세요"):L"구매 카드는 섞은 뒤 돌아옵니다.");
    draw_combat_build(4,50);
    if(g.turn>=5){text_at(174,36,COL_DIM,L"노아 학습:");text_at(252,36,COL_MAGENTA,CARD_DEF[g.trend_card].short_name);}
    int page=(g.shop_cursor/5)*5;
    for(int i=0;i<5;i++){int slot=page+i,x=4+i*79;if(slot>10)continue;CardId id=slot<8?shop_card(slot):CARD_CHECKSUM;
        uint32_t ac=slot==10?(g.turn>=7?COL_AMBER:COL_DIM):slot==9?(g.turn>=5?COL_MAGENTA:COL_DIM):slot==8?COL_AMBER:(CARD_DEF[id].cost<=g.baud?COL_INK:COL_DIM);if(slot==g.shop_cursor)rect(x+3,66,59,86,COL_BLACK);rect(x,63,59,86,COL_PANEL);frame(x,63,59,86,slot==g.shop_cursor?COL_INK:ac);rect(x+4,65,51,2,ac);rect(x,63,2,2,COL_BG);rect(x+57,63,2,2,COL_BG);if(slot==g.shop_cursor)frame(x+2,65,55,82,ac);
        if(slot==9){frame(x+4,68,51,75,COL_MAGENTA);rect(x+9,71,41,1,COL_MAGENTA);}else if(slot==10){line(x+2,141,x+56,69,COL_AMBER);rect(x+5,137,16,4,COL_AMBER);}
        if(slot<8)draw_icon(x+21,70,id,ac);else if(slot==9)art_blit(x+18,66,ART_NOA_PROXY,144,((g.anim_ticks/24)&1)*24,0,24,24);else if(slot==10)art_blit(x+18,66,ART_SEEK_AVATAR,192,((g.anim_ticks/24)&1)*24,0,24,24);text_at(x+3,92,ac,slot==10?L"시크":slot==9?L"노아+":slot==8?L"정리":CARD_DEF[id].short_name);if(slot<8)number_at(x+3,111,ac,L"값%d",CARD_DEF[id].cost);
        if(slot==10)text_at(x+3,126,ac,L"보관+2");if(slot==9)text_at(x+3,126,ac,L"편성+1");if(slot==8)text_at(x+3,126,ac,L"제거");
    }
    number_at(SCREEN_W-46,42,COL_DIM,L"%d/3쪽",page/5+1);CardId focus=g.shop_cursor<8?shop_card(g.shop_cursor):CARD_CHECKSUM;frame(4,153,SCREEN_W-8,38,g.shop_cursor==9?COL_MAGENTA:g.shop_cursor==10?COL_AMBER:COL_DIM);text_at(10,158,COL_INK,g.shop_cursor==10?L"시크의 수제 보관 계약":g.shop_cursor==9?L"노아의 대칭 계약":g.shop_cursor==8?L"덱에서 카드 한 장 제거":CARD_DEF[focus].name);if(g.shop_cursor<8){number_at(SCREEN_W-180,155,COL_DIM,L"비용%d",CARD_DEF[focus].cost);text_at(10,174,COL_INK,card_hint(focus));if(CARD_DEF[focus].type==PROGRAM){uint8_t tag=program_modifier(focus);text_at(SCREEN_W-180,169,COL_MAGENTA,final_modifier_name(tag));number_at(SCREEN_W-124,169,COL_MAGENTA,L"→%d",program_modifier_count(tag)+1);}else number_at(SCREEN_W-180,169,COL_DIM,CARD_DEF[focus].type==CARRIER?L"전송%d":L"응답%d",CARD_DEF[focus].type==CARRIER?CARD_DEF[focus].baud:CARD_DEF[focus].echo);}
    number_at(4,198,COL_CYAN,L"실제%d",g.echo_live);number_at(76,198,COL_AMBER,L"보관%d",g.echo_archived);number_at(177,198,COL_MAGENTA,L"모방%d",g.echo_mimicked);
    if(g.turn>=8){text_at(4,216,COL_DIM,L"지금 개방:");text_at(82,216,COL_CYAN,final_form_name(g.final_form));text_at(174,216,COL_INK,final_modifier_name(g.final_modifier));number_at(246,216,COL_MAGENTA,L"강도%d",g.final_power);text_at(SCREEN_W-72,216,COL_CYAN,L"O:개방");}else text_at(10,216,COL_DIM,L"좌우:선택  확인:구매  탭:넘김");
}

static void draw_open(void){
    draw_background();draw_world();draw_header();draw_ring(SCREEN_W/2,112,88,true);rect(0,16,SCREEN_W,40,COL_PANEL);
    if(g.echo_total>=32)draw_noa(SCREEN_W-52,72);else art_blit(SCREEN_W-40,43,ART_NOA_PROXY,144,((g.anim_ticks/30)&1)*24,0,24,24);
    text_at(4,19,COL_MAGENTA,L"열린 채널 / 노아 유행 복제");text_at(4,31,g.mirror_label_ticks?COL_MAGENTA:COL_DIM,g.mirror_label_ticks?L"노아 복제 송출:":L"노아가 학습 중:");text_at(126,31,COL_MAGENTA,CARD_DEF[g.mirror_label_ticks?g.mirror_card-1:g.trend_card].short_name);
    text_at(4,43,COL_DIM,L"최종 방송:");text_at(82,43,COL_CYAN,final_form_name(g.final_form));text_at(174,43,COL_INK,final_modifier_name(g.final_modifier));number_at(246,43,COL_MAGENTA,L"강도%d",g.final_power);
    number_at(SCREEN_W-50,19,COL_RED,L"%d초",(g.open_ticks+59)/60);rect(0,208,SCREEN_W,32,COL_PANEL);
    text_at(48,212,g.protocol_ticks?COL_DIM:COL_INK,L"공백:최종 방송");static const int8_t gx[16]={0,4,7,9,10,9,7,4,0,-4,-7,-9,-10,-9,-7,-4},gy[16]={-10,-9,-7,-4,0,4,7,9,10,9,7,4,0,-4,-7,-9};int cooldown=final_protocol_cooldown(),ready=16*(cooldown-g.protocol_ticks)/cooldown;for(int i=0;i<16;i++)rect(24+gx[i],223+gy[i],2,2,i<ready?COL_CYAN:COL_DIM);if(g.final_form==FORM_CHATSTORM){line(20,223,28,223,COL_INK);rect(23,220,3,7,COL_INK);}else if(g.final_form==FORM_RESONANCE){frame(21,220,7,7,COL_INK);rect(23,222,3,3,COL_CYAN);}else{line(20,226,28,220,COL_INK);line(20,220,28,226,COL_INK);}
}

static void draw_title(void){
    /* Centred composition shifted +40 for the 400px width (centre 160 -> 200). */
    clear(COL_BG);art_blit((SCREEN_W-192)/2,63,ART_KEYART,192,0,0,192,108);rect(198,13,3,3,COL_RED);text_at(150,22,COL_DIM,L"목록 밖 생방송");
    int answer_x=161+(g.anim_ticks/2)%67;rect(answer_x,136,2,2,COL_CYAN);if((g.anim_ticks/24)&1)rect(281,151,2,2,COL_MAGENTA);
    text_scaled(123,37,COL_INK,L"에코/144",3);text_at(116,184,COL_CYAN,L"64번만 대답해 주세요.");
    rect(106,203,102,24,COL_PANEL);frame(106,203,102,24,COL_INK);rect(110,205,94,2,COL_CYAN);text_at(117,210,COL_INK,L"확인  접속");
    rect(214,203,108,24,COL_PANEL);frame(214,203,108,24,COL_DIM);rect(218,205,100,2,COL_MAGENTA);text_at(224,210,COL_DIM,L"F2  오늘 채널");if(g.save_corrupt)text_at(85,229,COL_AMBER,L"손상된 기록은 제가 보관 중입니다.");
}

static void draw_result(void){
    /* Centred composition shifted +40 for the 400px width. */
    clear(COL_BG);draw_ring(SCREEN_W/2,92,65,true);art_blit((SCREEN_W-64)/2,56,ART_RESULT_PORTRAIT,128,g.won?0:64,0,64,64);text_scaled(g.won?111:145,28,g.won?COL_CYAN:COL_RED,g.won?L"양방향 연결":L"연결 끊김",2);
    rect(96,137,208,68,COL_PANEL);frame(96,137,208,68,g.won?COL_CYAN:COL_RED);
    if(g.won){text_at(152,142,COL_INK,ending_name(g.ending));text_at(136,156,COL_DIM,final_form_name(g.final_form));text_at(220,156,COL_DIM,final_modifier_name(g.final_modifier));}
    else{text_at(g.result_reason==RESULT_OFFLINE?134:140,146,COL_RED,result_reason_name(g.result_reason));text_at(114,157,COL_DIM,g.result_reason==RESULT_OFFLINE?L"다음: 기록·같은 계열 투자":L"다음: 이동·송신·방벽 조정");}
    number_at(123,171,COL_CYAN,L"실제%d",g.echo_live);number_at(183,171,COL_AMBER,L"보관%d",g.echo_archived);number_at(251,171,COL_MAGENTA,L"모방%d",g.echo_mimicked);
    number_at(156,190,COL_DIM,L"도달 구절 %d/12",g.turn>12?12:g.turn);
    text_at(g.today?131:109,211,COL_INK,g.today?L"확인:오늘의 신호 재접속":L"확인:같은 신호  오른쪽:새 신호");
}

static void render(void){
    if(g.mode==TITLE)draw_title();else if(g.mode==EDIT)draw_edit();else if(g.mode==ON_AIR)draw_air();else if(g.mode==BREAK)draw_break();else if(g.mode==OPEN_CHANNEL)draw_open();else draw_result();
    if(g.flash_ticks)frame(0,0,SCREEN_W,SCREEN_H,COL_INK);
    if(g.mode!=RESULT&&g.threshold_ticks){static const wchar_t *milestones[]={L"",L"첫 응답",L"교차 채팅",L"가면 균열",L"양방향 수신"};int px=(SCREEN_W-136)/2;rect(px,70,136,34,COL_PANEL);frame(px,70,136,34,g.ring_threshold==4?COL_CYAN:COL_INK);text_scaled(px+16,78,g.ring_threshold==3?COL_MAGENTA:g.ring_threshold==4?COL_CYAN:COL_INK,milestones[g.ring_threshold],2);}
    if(g.paused){int px=(SCREEN_W-210)/2;rect(px,86,210,78,COL_PANEL);frame(px,86,210,78,COL_INK);text_scaled(px+36,96,COL_INK,L"일시정지",2);text_at(px+21,128,COL_DIM,L"취소:계속  M:음소거");text_at(px+53,144,COL_DIM,L"F1:저자극");}
}
