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
/* proportional fill bar: num/den of width, drawn over a background track */
static void fill_bar(int x,int y,int w,int h,int num,int den,uint32_t fg,uint32_t bg){
    if(den<1)den=1;int f=num<=0?0:num>=den?w:w*num/den;rect(x,y,w,h,bg);if(f>0)rect(x,y,f,h,fg);
}
/* countable pips: filled squares up to `filled`, hollow outlines for the rest (recognition > recall) */
static void draw_pips(int x,int y,int total,int filled,int cell,int gap,uint32_t on,uint32_t off){
    for(int i=0;i<total;i++){int px=x+i*(cell+gap);if(i<filled)rect(px,y,cell,cell,on);else frame(px,y,cell,cell,off);}
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
    switch(ch){case 0x00B7:return row==3?4:0;case L'/':return (uint8_t)(1<<(row<5?row:4));case L'-':return row==3?31:0;case L'_':return row==6?31:0;case L'.':return row==6?4:0;case L':':return row==2||row==5?4:0;case L'+':return row==3?14:(row==2||row==4?4:0);case L'>':return row==2?8:row==3?4:row==4?2:0;case L'?':return (uint8_t[]){14,17,1,2,4,0,4}[row];case L'!':return row<5?4:(row==6?4:0);case L'=':return row==2||row==4?31:0;case L'(':return row==0||row==6?2:4;case L')':return row==0||row==6?8:4;default:return 0;}
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
    (void)c;art_blit(x,y,ART_CARD,208,id*16,0,16,16);
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

static void draw_header(void){
    rect(0,0,SCREEN_W,16,COL_PANEL);
    /* HP as discrete pips — a 5-HP survivor reads life at a glance; red the moment it is low. */
    int hp=g.hp>5?5:g.hp;uint32_t hpc=g.hp<3?COL_RED:COL_INK;
    draw_pips(4,4,5,hp,6,1,hpc,COL_DIM);
    number_at(44,2,COL_CYAN,L"동조%d",g.sync);
    number_at(118,2,COL_INK,L"메아리%d/64",g.echo_total);number_at(250,2,COL_DIM,L"구절%d/12",g.turn>12?12:g.turn);
    /* proportional baseline meters (2px) — the numbers now have a matching visual magnitude */
    fill_bar(44,14,40,2,g.sync,3,COL_CYAN,COL_PANEL);
    /* echo baseline: stacked live|archived|mimicked composition, width ∝ total/64 — ring makeup at all times */
    int bx=118,bw=122;rect(bx,14,bw,2,COL_DIM);
    int wl=bw*g.echo_live/64,wa=bw*g.echo_archived/64,wm=bw*g.echo_mimicked/64;
    if(wl)rect(bx,14,wl,2,COL_CYAN);if(wa)rect(bx+wl,14,wa,2,COL_AMBER);if(wm)rect(bx+wl+wa,14,wm,2,COL_MAGENTA);
    for(int t=16;t<64;t+=16)rect(bx+bw*t/64,13,1,3,COL_BG); /* 16/32/48 phase ticks */
    fill_bar(250,14,70,2,g.turn>12?12:g.turn,12,COL_INK,COL_DIM);
}

static void draw_background(void){clear(COL_BG);for(int y=24;y<ARENA_BOTTOM;y+=16)for(int x=(y&16)?8:0;x<SCREEN_W;x+=16)rect(x,y,1,1,COL_DIM);frame(2,18,316,188,COL_PANEL);}

static void draw_world(void){
    int previous=-1;for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active&&g.enemies[i].marked){if(previous>=0)line((int)g.enemies[previous].x,(int)g.enemies[previous].y,(int)g.enemies[i].x,(int)g.enemies[i].y,COL_CYAN);previous=i;frame((int)g.enemies[i].x-6,(int)g.enemies[i].y-6,12,12,COL_CYAN);}
    for(int i=0;i<MAX_ENEMIES;i++)if(g.enemies[i].active)draw_enemy(&g.enemies[i]);
    for(int i=0;i<MAX_BULLETS;i++)if(g.bullets[i].active){Bullet *b=&g.bullets[i];rect((int)b->x-1,(int)b->y-1,3,3,b->hostile?COL_RED:COL_CYAN);if(b->hostile)rect((int)b->x,(int)b->y,1,1,COL_INK);}
    if(g.firewall_ticks){int x=(int)g.px,y=(int)g.py;frame(x-19,y-17,38,34,COL_CYAN);if(g.firewall_open_dir==0)rect(x+18,y-4,1,8,COL_BG);else if(g.firewall_open_dir==1)rect(x-4,y+16,8,1,COL_BG);else if(g.firewall_open_dir==2)rect(x-19,y-4,1,8,COL_BG);else rect(x-4,y-17,8,1,COL_BG);}
    if(g.effect_ticks&&g.effect_card==CARD_MACRO)frame((int)g.px-13,(int)g.py-13,26,30,COL_DIM);
    if(g.effect_ticks&&g.effect_card==CARD_CHECKSUM)line(8,ARENA_TOP+(24-g.effect_ticks)*8,312,ARENA_TOP+(24-g.effect_ticks)*8,COL_CYAN);
    if(g.turn==7||g.echo_archived)draw_seek_cable();
    draw_echo((int)g.px,(int)g.py);draw_ring((int)g.px,(int)g.py,22,false);
}

static const wchar_t *card_effect(CardId id){
    switch(id){
    case CARD_2400: return L"기본 송출 · 송신/수신 지정";
    case CARD_14K:  return L"고속 관통 · 큰 전송량";
    case CARD_MULTI:return L"편성 +2 즉시 · 더 많은 편성";
    case CARD_CACHE:return L"카드 1장 다음 구절로 보관";
    case CARD_FIREWALL:return L"탄을 막는 벽 · 한 방향만 열림";
    case CARD_MACRO:return L"직전 프로그램 다시 재생";
    case CARD_PREFETCH:return L"다음 3장 보고 1장 선택";
    case CARD_MARKER:return L"적에 표식 · 폭주와 연계";
    case CARD_SURGE:return L"표식된 적 회선 연쇄 타격";
    case CARD_CHECKSUM:return L"잡음 제거 · 모방 복구";
    case CARD_CHAT: return L"기록 · 열린 채널에서 메아리";
    case CARD_VOICE:return L"강한 기록 · 열린 채널 필살";
    default: return L"잡음 · 정리로 제거";
    }
}

static void draw_edit(void){
    draw_background();rect(0,16,SCREEN_W,142,0x00171322);draw_world();draw_header();
    text_at(4,18,COL_MAGENTA,L"다음:");text_at(48,18,COL_INK,intent_name(g.intent));
    /* CUE as countable dots (docs 45: CUE = ● 개수) — Miller-friendly vs a bare number */
    text_at(262,18,COL_CYAN,L"편성");
    if(g.cue<=7)draw_pips(288,19,g.cue,g.cue,3,1,COL_CYAN,COL_BLACK);
    else number_at(288,18,COL_CYAN,L"%d",g.cue);
    /* focused card: name + what it does — teaches each card's method at the decision point */
    if(g.cursor<g.deck.hand_n){CardId fid=g.deck.hand[g.cursor];const CardDef *fc=&CARD_DEF[fid];
        uint32_t nc=fc->type==CARRIER?COL_CYAN:fc->type==ARCHIVE?COL_AMBER:fc->type==NOISE?COL_RED:COL_INK;
        text_at(4,32,nc,fc->short_name);text_at(38,32,COL_DIM,card_effect(fid));}
    if(g.new_ticks&&g.new_card){text_at(4,46,COL_CYAN,L"구매 카드 귀환:");text_at(126,46,COL_INK,CARD_DEF[g.new_card-1].short_name);}
    else if(g.message_ticks)text_at(4,46,COL_AMBER,L"버린 더미를 섞었습니다.");
    else if(g.turn<=3)text_at(4,46,COL_BLUE,L"추천: 공격 1장, 나머지는 수신");
    else if(g.turn>=5){text_at(4,46,COL_DIM,L"노아가 학습 중:");text_at(126,46,COL_MAGENTA,CARD_DEF[g.trend_card].short_name);}
    if(g.contract_applied){rect(260,34,56,15,COL_PANEL);frame(260,34,56,15,COL_MAGENTA);rect(263,37,3,9,COL_MAGENTA);text_at(269,36,COL_INK,L"계약+1");}
    rect(0,130,188,12,0x00120e1a);number_at(4,132,COL_DIM,L"덱%d",g.deck.draw_n+g.deck.discard_n+g.deck.hand_n+(g.cached_card!=0));number_at(62,132,COL_DIM,L"뽑기%d",g.deck.draw_n);number_at(132,132,COL_DIM,L"버림%d",g.deck.discard_n);text_at(4,145,COL_DIM,L"확인:배정  공백:탐색  탭:송출");
    for(int i=0;i<g.deck.hand_n;i++)draw_card(4+i*63,164-(i==g.cursor?2:0),59,72,g.deck.hand[i],i==g.cursor,i);
    if(g.cache_mode){rect(63,55,194,68,COL_PANEL);frame(63,55,194,68,COL_AMBER);text_at(77,63,COL_INK,L"다음 구절에 보관할 카드");draw_icon(111,87,g.deck.hand[g.cursor],COL_AMBER);text_at(137,89,COL_INK,CARD_DEF[g.deck.hand[g.cursor]].short_name);}
    if(g.prefetch_mode){rect(63,55,194,68,COL_PANEL);frame(63,55,194,68,COL_CYAN);text_at(72,61,COL_INK,L"미리 읽기 / 하나 선택");for(int i=0;i<g.prefetch_n;i++){int x=77+i*58;frame(x,79,50,34,i==g.prefetch_cursor?COL_INK:COL_DIM);draw_icon(x+4,86,g.prefetch_cards[i],COL_CYAN);text_at(x+22,87,COL_INK,CARD_DEF[g.prefetch_cards[i]].short_name);}}
}

static void draw_air(void){
    draw_background();draw_world();draw_header();
    rect(0,208,SCREEN_W,32,COL_PANEL);text_at(4,211,COL_DIM,L"공백:송출");
    for(int i=0;i<g.queue_n;i++){int x=58+i*48;uint32_t c=i<g.queue_at?COL_DIM:i==g.queue_at?COL_INK:COL_CYAN;if(i)line(x-22,223,x-2,223,c);frame(x,211,38,24,c);number_at(x+2,216,c,L"%d",i+1);draw_icon(x+19,215,g.queue[i],c);if(i==g.queue_at)rect(x+2,212,34,2,COL_INK);}
    /* ON AIR clock: seconds + a draining bar so the phase length is felt, not just read */
    number_at(280,211,COL_INK,L"%d초",(g.phase_ticks+59)/60);
    fill_bar(258,228,58,3,g.phase_ticks,ON_AIR_TICKS,g.phase_ticks<120?COL_RED:COL_CYAN,COL_BG);
}

static void draw_break(void){
    draw_background();draw_world();rect(0,16,SCREEN_W,224,0x00171322);draw_header();number_at(4,19,COL_BLUE,L"휴식  전송량%d",g.baud);
    /* BAUD as spendable coins — glanceable purchasing power this BREAK (amber = economy) */
    if(g.baud<=8)draw_pips(128,20,g.baud,g.baud,4,2,COL_AMBER,COL_PANEL);
    if(g.echo_archived)art_blit(292,35,ART_SEEK_AVATAR,192,((g.anim_ticks/24)&1)*24,0,24,24);
    if(g.defrag_mode||g.trade_mode){text_at(4,42,g.trade_mode?COL_AMBER:COL_INK,g.trade_mode?L"시크 보관 / 호박+2":L"정리 / 카드 한 장 제거");frame(64,72,192,70,COL_INK);draw_icon(78,91,(CardId)g.shop_cursor,COL_AMBER);text_at(108,88,COL_INK,CARD_DEF[g.shop_cursor].name);number_at(108,108,COL_DIM,L"보유%d",deck_count(g.shop_cursor));text_at(52,166,COL_DIM,L"좌우:선택  확인:결정  취소:닫기");return;}
    text_at(4,36,COL_DIM,L"구매 카드는 섞은 뒤 돌아옵니다.");
    if(g.turn>=5){text_at(174,36,COL_DIM,L"노아 학습:");text_at(252,36,COL_MAGENTA,CARD_DEF[g.trend_card].short_name);}
    int page=(g.shop_cursor/5)*5;
    for(int i=0;i<5;i++){int slot=page+i,x=4+i*63;if(slot>10)continue;CardId id=slot<8?shop_card(slot):CARD_CHECKSUM;
        uint32_t ac=slot==10?(g.turn>=7?COL_AMBER:COL_DIM):slot==9?(g.turn>=5?COL_MAGENTA:COL_DIM):slot==8?COL_AMBER:(CARD_DEF[id].cost<=g.baud?COL_INK:COL_DIM);if(slot==g.shop_cursor)rect(x+3,66,59,86,COL_BLACK);rect(x,63,59,86,COL_PANEL);frame(x,63,59,86,slot==g.shop_cursor?COL_INK:ac);rect(x+4,65,51,2,ac);rect(x,63,2,2,COL_BG);rect(x+57,63,2,2,COL_BG);if(slot==g.shop_cursor)frame(x+2,65,55,82,ac);
        if(slot==9){frame(x+4,68,51,75,COL_MAGENTA);rect(x+9,71,41,1,COL_MAGENTA);}else if(slot==10){line(x+2,141,x+56,69,COL_AMBER);rect(x+5,137,16,4,COL_AMBER);}
        if(slot<8)draw_icon(x+21,70,id,ac);else if(slot==9)art_blit(x+18,66,ART_NOA_PROXY,144,((g.anim_ticks/24)&1)*24,0,24,24);else if(slot==10)art_blit(x+18,66,ART_SEEK_AVATAR,192,((g.anim_ticks/24)&1)*24,0,24,24);text_at(x+3,92,ac,slot==10?L"시크":slot==9?L"노아+":slot==8?L"정리":CARD_DEF[id].short_name);if(slot<8)number_at(x+3,111,ac,L"값%d",CARD_DEF[id].cost);
        if(slot==10)text_at(x+3,126,ac,L"보관+2");if(slot==9)text_at(x+3,126,ac,L"편성+1");if(slot==8)text_at(x+3,126,ac,L"제거");
    }
    number_at(274,42,COL_DIM,L"%d/3쪽",page/5+1);CardId focus=g.shop_cursor<8?shop_card(g.shop_cursor):CARD_CHECKSUM;frame(4,153,312,38,g.shop_cursor==9?COL_MAGENTA:g.shop_cursor==10?COL_AMBER:COL_DIM);text_at(10,158,COL_INK,g.shop_cursor==10?L"시크의 수제 보관 계약":g.shop_cursor==9?L"노아의 대칭 계약":g.shop_cursor==8?L"덱에서 카드 한 장 제거":CARD_DEF[focus].name);if(g.shop_cursor<8){number_at(220,155,COL_DIM,L"비용%d",CARD_DEF[focus].cost);if(CARD_DEF[focus].type==PROGRAM){uint8_t tag=program_modifier(focus);text_at(220,169,COL_MAGENTA,final_modifier_name(tag));number_at(276,169,COL_MAGENTA,L"→%d",program_modifier_count(tag)+1);}else number_at(220,169,COL_DIM,CARD_DEF[focus].type==CARRIER?L"전송%d":L"응답%d",CARD_DEF[focus].type==CARRIER?CARD_DEF[focus].baud:CARD_DEF[focus].echo);}text_at(10,175,COL_DIM,L"좌우:선택  확인:구매  탭:넘김");if(g.turn>=8)text_at(228,175,COL_CYAN,L"O:열린 채널");
    number_at(4,198,COL_CYAN,L"실제%d",g.echo_live);number_at(76,198,COL_AMBER,L"보관%d",g.echo_archived);number_at(177,198,COL_MAGENTA,L"모방%d",g.echo_mimicked);
}

static void draw_open(void){
    draw_background();draw_world();draw_header();draw_ring(160,112,88,true);rect(0,16,SCREEN_W,40,COL_PANEL);
    if(g.echo_total>=32)draw_noa(286,72);else art_blit(284,43,ART_NOA_PROXY,144,((g.anim_ticks/30)&1)*24,0,24,24);
    text_at(4,19,COL_MAGENTA,L"열린 채널");text_at(4,31,COL_DIM,L"노아 학습:");text_at(84,31,COL_MAGENTA,CARD_DEF[g.trend_card].short_name);
    /* finale identity kept left of the NØA portrait; 강도 as pips (capped) so no arithmetic to read */
    text_at(4,43,COL_DIM,L"최종:");text_at(36,43,COL_CYAN,final_form_name(g.final_form));text_at(112,43,COL_INK,final_modifier_name(g.final_modifier));text_at(144,43,COL_DIM,L"강도");
    {int cap=FINAL_POWER_CAP,fp=g.final_power>cap?cap:g.final_power;draw_pips(172,44,cap,fp,4,1,COL_MAGENTA,COL_DIM);}
    /* OFFLINE threat: seconds + a draining red bar, both clear of the portrait */
    number_at(214,19,COL_RED,L"%d초",(g.open_ticks+59)/60);fill_bar(196,30,62,3,g.open_ticks,OPEN_TICKS,COL_RED,COL_PANEL);rect(0,208,SCREEN_W,32,COL_PANEL);
    text_at(48,212,g.protocol_ticks?COL_DIM:COL_INK,L"공백:최종 방송");static const int8_t gx[16]={0,4,7,9,10,9,7,4,0,-4,-7,-9,-10,-9,-7,-4},gy[16]={-10,-9,-7,-4,0,4,7,9,10,9,7,4,0,-4,-7,-9};int cooldown=final_protocol_cooldown(),ready=16*(cooldown-g.protocol_ticks)/cooldown;for(int i=0;i<16;i++)rect(24+gx[i],223+gy[i],2,2,i<ready?COL_CYAN:COL_DIM);if(g.final_form==FORM_CHATSTORM){line(20,223,28,223,COL_INK);rect(23,220,3,7,COL_INK);}else if(g.final_form==FORM_RESONANCE){frame(21,220,7,7,COL_INK);rect(23,222,3,3,COL_CYAN);}else{line(20,226,28,220,COL_INK);line(20,220,28,226,COL_INK);}
}

static void draw_title(void){
    clear(COL_BG);art_blit(64,63,ART_KEYART,192,0,0,192,108);rect(158,13,3,3,COL_RED);text_at(110,22,COL_DIM,L"목록 밖 생방송");
    int answer_x=121+(g.anim_ticks/2)%67;rect(answer_x,136,2,2,COL_CYAN);if((g.anim_ticks/24)&1)rect(241,151,2,2,COL_MAGENTA);
    text_scaled(83,37,COL_INK,L"에코/144",3);text_at(76,184,COL_CYAN,L"64번만 대답해 주세요.");
    rect(66,203,102,24,COL_PANEL);frame(66,203,102,24,COL_INK);rect(70,205,94,2,COL_CYAN);text_at(77,210,COL_INK,L"확인  접속");
    rect(174,203,108,24,COL_PANEL);frame(174,203,108,24,COL_DIM);rect(178,205,100,2,COL_MAGENTA);text_at(184,210,COL_DIM,L"F2  오늘 채널");if(g.save_corrupt)text_at(45,229,COL_AMBER,L"손상된 기록은 제가 보관 중입니다.");
}

static void draw_result(void){
    clear(COL_BG);draw_ring(160,92,65,true);art_blit(128,56,ART_RESULT_PORTRAIT,128,g.won?0:64,0,64,64);text_scaled(g.won?71:105,28,g.won?COL_CYAN:COL_RED,g.won?L"양방향 연결":L"연결 끊김",2);
    if(g.won){text_at(112,142,COL_INK,ending_name(g.ending));text_at(96,156,COL_DIM,final_form_name(g.final_form));text_at(180,156,COL_DIM,final_modifier_name(g.final_modifier));}
    else text_at(g.result_reason==RESULT_OFFLINE?94:112,146,COL_RED,g.result_reason==RESULT_OFFLINE?L"64 미완성 / 채널 종료":L"미송출 편성 남음");
    number_at(83,171,COL_CYAN,L"실제%d",g.echo_live);number_at(143,171,COL_AMBER,L"보관%d",g.echo_archived);number_at(211,171,COL_MAGENTA,L"모방%d",g.echo_mimicked);
    text_at(g.today?91:69,211,COL_INK,g.today?L"확인:오늘의 신호 재접속":L"확인:같은 신호  오른쪽:새 신호");
}

static void render(void){
    if(g.mode==TITLE)draw_title();else if(g.mode==EDIT)draw_edit();else if(g.mode==ON_AIR)draw_air();else if(g.mode==BREAK)draw_break();else if(g.mode==OPEN_CHANNEL)draw_open();else draw_result();
    if(g.flash_ticks)frame(0,0,SCREEN_W,SCREEN_H,COL_INK);
    if(g.threshold_ticks){static const wchar_t *milestones[]={L"",L"첫 응답",L"교차 채팅",L"가면 균열",L"양방향 수신"};rect(92,70,136,34,COL_PANEL);frame(92,70,136,34,g.ring_threshold==4?COL_CYAN:COL_INK);text_scaled(108,78,g.ring_threshold==3?COL_MAGENTA:g.ring_threshold==4?COL_CYAN:COL_INK,milestones[g.ring_threshold],2);}
    if(g.paused){rect(55,86,210,78,COL_PANEL);frame(55,86,210,78,COL_INK);text_scaled(91,96,COL_INK,L"일시정지",2);text_at(76,128,COL_DIM,L"취소:계속  M:음소거");text_at(108,144,COL_DIM,L"F1:저자극");}
}
