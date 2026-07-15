#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <mmsystem.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>
#include <assert.h>
#ifdef SELF_TEST
#include <stdio.h>
#endif

#define SCREEN_W 320
#define SCREEN_H 240
#define ARENA_H 192
#define TICK_HZ 60
#define MAX_DECK 40
#define MAX_ENEMIES 256
#define MAX_BULLETS 512
#define MAX_ENEMY_SHOTS 128
#define ARRAY_COUNT(a) (sizeof(a) / sizeof((a)[0]))

/* ===== 밸런스 상수 — 수치 정본: docs/20_BALANCE.md. 문서와 다르면 버그다.
   selftest는 의도적으로 리터럴을 유지해 이 값들을 교차 검증한다. ===== */
enum {
    SIGNAL_GOAL         = 64,
    HP_START            = 5,
    DECK_MIN            = 5,
    BAD_CAP             = 5,
    CARD_TICKS_NORMAL   = 30,  /* 카드 간격 0.50초 */
    CARD_TICKS_SWAP     = 15,  /* 손패 교체 0.25초 */
    CARD_TICKS_PREFETCH = 3,   /* 프리패치 예약 조각 0.05초 */
    SHOP_FIRST_SEC      = 30,
    SHOP_INTERVAL_SEC   = 40,
    GOLIVE_EARLIEST_SEC = 270, /* 4:30 */
    LIVE_FORCED_SEC     = 360, /* 6:00 */
    LIVE_MAX_TICKS      = 60 * TICK_HZ,
    CHEST_INTERVAL_SEC  = 45,
    HIT_INVULN_TICKS    = 48,  /* 피격 무적 0.8초 */
    FIREWALL_INVULN_TICKS = 45,
    BAD_IMMUNE_TICKS    = 240, /* 오염 면역 4초 */
    STAMP_EARLY_SEC     = 310, /* 조기 방송: LIVE 시작 < 5:10 */
    STAMP_FAST_SEC      = 30,
    ELITE_HP_MULT       = 4,
    DIR_INDEX_PER = 2, DIR_INDEX_CAP = 10,
    DIR_CLEAN_PER = 2, DIR_CLEAN_CAP = 12,
    DIR_MIRROR_PER = 2, DIR_MIRROR_CAP = 16, /* 실전 최대 덱 19장 기준 도달 가능 — 20 §결함-1 */
    MARKER_TARGETS = 6, MARKER_DURATION_TICKS = 150, /* 2.5초 */
    SURGE_TARGETS = 4,
    RANSOM_FIRE_TICKS = 300, /* 5초 */
    DMG_2400 = 6,  DMG_14K = 9,   DMG_56K = 16,
    DMG_CHAT = 12, DMG_VOICE = 28, DMG_CLIP = 30,
    DMG_PATCH = 24, DMG_CACHE = 4, DMG_SURGE = 7
};

enum {
    COL_BG = 0x00100d18, COL_PANEL = 0x00201c2b, COL_WHITE = 0x00f2f0e6,
    COL_DIM = 0x007b7b86, COL_CYAN = 0x004ddbc8, COL_AMBER = 0x00e5a84b,
    COL_MAGENTA = 0x00ed4f9a, COL_BLUE = 0x006da9e8, COL_RED = 0x00e55b57,
    COL_BLACK = 0x00000000
};

/* 3음 모티프 — docs/40_ART_AUDIO_TEXT.md §4: 에코=정방향, 시크=역방향, 제로=단음 반복 */
enum { NOTE_E4 = 330, NOTE_G4 = 392, NOTE_B4 = 494, NOTE_E5 = 659, NOTE_G5 = 784, NOTE_B5 = 988 };

typedef uint8_t CardId;
typedef enum { TITLE, CHANNEL, PLAY, SHOP, PAUSE_MODE, ENDING, RESULT } Mode;
typedef enum { WORM, POPUP, TROJAN, RANSOM } EnemyType;
typedef enum { DIR_INDEX, DIR_CLEAN, DIR_MIRROR } Directive;

enum Card {
    C_2400, C_14K, C_56K, C_CHAT, C_VOICE, C_CLIP, C_BAD, C_PATCH,
    C_MULTI, C_CACHE, C_MACRO, C_FIREWALL, C_PREFETCH, C_SURGE, C_MARKER, C_DEFRAG,
    CARD_COUNT
};

typedef struct {
    uint8_t cost, buy, signal;
    const wchar_t *name, *short_name;
} CardDef;

static const CardDef CARD[CARD_COUNT] = {
    {0,1,0,L"2400 모뎀",L"2400"}, {3,2,0,L"14K 터보",L"14K"},
    {6,3,0,L"56K 맥시멈",L"56K"}, {2,0,1,L"채팅 로그",L"채팅"},
    {5,0,3,L"보이스 조각",L"보이스"}, {7,0,6,L"클립 20??",L"클립"},
    {0,0,0,L"불량 구역",L"불량"}, {0,0,0,L"임시 패치",L"패치"},
    {3,0,0,L"멀티 퀵",L"멀티"}, {3,0,0,L"캐시 트리오",L"캐시"},
    {4,0,0,L"리피트 매크로",L"매크로"}, {3,0,0,L"세이프 월",L"방벽"},
    {2,0,0,L"프리패치",L"프리"}, {5,0,0,L"서지 라인",L"서지"},
    {4,0,0,L"마크 온",L"마크"}, {2,0,0,L"정리 타임",L"정리"}
};

static const CardId KINGDOM[8] = {
    C_MULTI, C_CACHE, C_MACRO, C_FIREWALL, C_PREFETCH, C_SURGE, C_MARKER, C_DEFRAG
};

static const uint8_t VALID_MASKS[] = {
    0x1F,0x3B,0x3D,0x3E,0x5B,0x5D,0x5E,0x79,0x7A,0x7C,0x8F,0x97,0x9E,0xA7,
    0xAB,0xAD,0xAE,0xB3,0xB5,0xB6,0xBA,0xBC,0xC7,0xCB,0xCD,0xCE,0xD3,0xD5,
    0xD6,0xDA,0xDC,0xE3,0xE5,0xE6,0xE9,0xEA,0xEC,0xF1,0xF2,0xF4,0xF8
};

/* WORM, POPUP, TROJAN, RANSOM 순 — docs/20_BALANCE.md B-적 */
static const int ENEMY_HP[4] = {6, 4, 28, 16};
static const float ENEMY_SPEED[4] = {14, 28, 10, 12};
static const float ENEMY_COST[4] = {1.0f, 1.2f, 4.0f, 3.0f};

typedef struct {
    CardId draw[MAX_DECK], discard[MAX_DECK], hand[5];
    uint8_t draw_n, discard_n, hand_n;
    bool seek_used, prefetch_pending, multi_next;
} Deck;

typedef struct {
    float x, y, vx, vy;
    int16_t hp;
    uint16_t fire, marked;
    uint8_t type, active, elite;
} Enemy;

typedef struct {
    float x, y, vx, vy;
    int16_t damage, life, last_hit;
    uint8_t active, hits, splash;
} Bullet;

typedef struct {
    float x, y, vx, vy;
    uint16_t life;
    uint8_t active;
} EnemyShot;

typedef struct {
    Mode mode, pause_return;
    uint32_t seed, rng;
    bool today, muted, low_fx, running, live, won;
    bool shop_due, go_confirm, defrag_select, shop_all, elite_spawned, chest_active, seek_spoken, bad_spoken, cheated;
    uint8_t kingdom_mask, directive, distinct_mask, trash_count, bad_count, burst_mask;
    uint8_t hp, shop_sel, defrag_sel, tutorial, purchase_n, previous_card;
    uint8_t log_ids[2], log_shown, fragment_count;
    CardId purchases[16];
    int dead_ticks, live_ticks, live_start_ticks, next_shop_ticks, next_chest_ticks;
    int card_ticks, invuln_ticks, bad_immune_ticks, flash_ticks, shake_ticks, shuffle_ticks;
    int transition_ticks, ending_ticks, result_ticks, hitstop_ticks, link_ticks, card_fx_ticks, seek_fx_ticks, message_ticks, message_id;
    int first_shuffle_ticks, predicted_at_live;
    int signal, last_damage_card;
    float px, py, last_dx, last_dy, spawn_budget, chest_x, chest_y;
    Deck deck;
    Enemy enemies[MAX_ENEMIES];
    Bullet bullets[MAX_BULLETS];
    EnemyShot enemy_shots[MAX_ENEMY_SHOTS];
} Game;

static Game g;
static uint8_t key_down[256], key_pressed[256], key_pending[256];
static bool onboarding_seen, shop_help_seen;

/* ===== 공용 유틸 ===== */
static uint32_t rng_next(void) {
    uint32_t x = g.rng ? g.rng : 0x6d2b79f5u;
    x ^= x << 13; x ^= x >> 17; x ^= x << 5;
    return g.rng = x;
}

static int clampi(int v, int lo, int hi) { return v < lo ? lo : v > hi ? hi : v; }

static float length2(float x, float y) { return x*x + y*y; }

static void normalize(float *x, float *y) {
    float d = sqrtf((*x)*(*x) + (*y)*(*y));
    if (d > 0.001f) { *x /= d; *y /= d; }
    else { *x = 1.0f; *y = 0.0f; }
}

static int popcount8(uint8_t x) {
    int n = 0;
    while (x) { n += x & 1; x >>= 1; }
    return n;
}

static void sfx(int freq, int ticks);
static void sfx_motif(int f0, int f1, int f2, int ticks_per_note);
static void show_message(int id);
static int kingdom_bit(CardId id);

/* ===== 덱 엔진 — 규칙: docs/10_MECHANICS.md §2·§3 ===== */
static void shuffle(CardId *cards, int n) {
    for (int i = n - 1; i > 0; --i) {
        int j = (int)(rng_next() % (uint32_t)(i + 1));
        CardId t = cards[i]; cards[i] = cards[j]; cards[j] = t;
    }
}

static int deck_total(void) {
    return g.deck.draw_n + g.deck.discard_n + g.deck.hand_n;
}

static int deck_count(CardId id) {
    int n=0;
    for(int i=0;i<g.deck.draw_n;++i)n+=g.deck.draw[i]==id;
    for(int i=0;i<g.deck.discard_n;++i)n+=g.deck.discard[i]==id;
    for(int i=0;i<g.deck.hand_n;++i)n+=g.deck.hand[i]==id;
    return n;
}

static void deck_add_discard(CardId id) {
    if (deck_total() < MAX_DECK) g.deck.discard[g.deck.discard_n++] = id;
}

static CardId deck_draw_one(void) {
    if (!g.deck.draw_n && g.deck.discard_n) {
        g.deck.draw_n = g.deck.discard_n;
        for (int i = 0; i < g.deck.discard_n; ++i) g.deck.draw[i] = g.deck.discard[i];
        g.deck.discard_n = 0;
        shuffle(g.deck.draw, g.deck.draw_n);
        if(!g.first_shuffle_ticks)g.first_shuffle_ticks=g.dead_ticks+(g.live?g.live_ticks:0);
        g.shuffle_ticks = 15;
        sfx(180, 4);
    }
    assert(g.deck.draw_n > 0);
    return g.deck.draw[--g.deck.draw_n];
}

static void deck_new_hand(void) {
    g.deck.hand_n = 0;
    while (g.deck.hand_n < 5 && (g.deck.draw_n || g.deck.discard_n))
        g.deck.hand[g.deck.hand_n++] = deck_draw_one();
    g.deck.seek_used = false;
    g.previous_card = 255;
    g.card_ticks = CARD_TICKS_SWAP;
}

static int buy_power(void) {
    int value = 0;
    for (int i = 0; i < g.deck.hand_n; ++i) value += CARD[g.deck.hand[i]].buy;
    return value;
}

static int directive_bonus(void) {
    if (g.directive == DIR_INDEX) return clampi(popcount8(g.distinct_mask) * DIR_INDEX_PER, 0, DIR_INDEX_CAP);
    if (g.directive == DIR_CLEAN) return clampi(g.trash_count * DIR_CLEAN_PER, 0, DIR_CLEAN_CAP);
    return clampi((deck_total() - deck_count(C_PATCH) - 10) * DIR_MIRROR_PER, 0, DIR_MIRROR_CAP);
}

static int signal_sum(void) {
    int sum=0;for(int id=0;id<CARD_COUNT;++id)sum+=deck_count((CardId)id)*CARD[id].signal;return sum;
}

/* 보수 예상 공식 — docs/20_BALANCE.md B-공식. MULTI 단축·PREFETCH +1 제외 */
static int live_signal_estimate(int deck_n, int sig, int bonus) {
    int cycle = CARD_TICKS_NORMAL * deck_n + CARD_TICKS_SWAP * ((deck_n + 4) / 5);
    return bonus + (cycle ? (LIVE_MAX_TICKS / cycle) * sig : 0);
}

static int estimate_signal(void) {
    return live_signal_estimate(deck_total(), signal_sum(), directive_bonus());
}

static int card_now(CardId id) {
    switch(id){case C_2400:return DMG_2400;case C_14K:return DMG_14K;case C_56K:return DMG_56K;
        case C_PATCH:return DMG_PATCH;case C_CACHE:return 3*DMG_CACHE;case C_SURGE:return 4*DMG_SURGE;default:return 0;}
}

static int now_total(void) {
    int total=0;
    CardId *lists[]={g.deck.draw,g.deck.discard,g.deck.hand};
    int counts[]={g.deck.draw_n,g.deck.discard_n,g.deck.hand_n};
    for(int l=0;l<3;++l)for(int i=0;i<counts[l];++i)total+=card_now(lists[l][i]);
    return total;
}


static int now_score(void) { int n=deck_total();return n?now_total()/n:0; }

static int estimate_signal_with(CardId id) {
    if(id==C_DEFRAG)return estimate_signal();
    int n=deck_total()+1,bonus=directive_bonus(),bit=kingdom_bit(id);
    if(g.directive==DIR_INDEX&&bit>=0)bonus=clampi(popcount8(g.distinct_mask|(1u<<bit))*DIR_INDEX_PER,0,DIR_INDEX_CAP);
    if(g.directive==DIR_MIRROR)bonus=clampi((n-deck_count(C_PATCH)-(id==C_PATCH)-10)*DIR_MIRROR_PER,0,DIR_MIRROR_CAP);
    return live_signal_estimate(n,signal_sum()+CARD[id].signal,bonus);
}

static int now_with(CardId id) {
    if(id==C_DEFRAG)return now_score();
    int n=deck_total();return (now_total()+card_now(id))/(n+1);
}

static void remove_bad_once(void) {
    CardId *lists[] = { g.deck.hand, g.deck.draw, g.deck.discard };
    uint8_t *counts[] = { &g.deck.hand_n, &g.deck.draw_n, &g.deck.discard_n };
    for (int l = 0; l < 3; ++l) {
        for (int i = 0; i < *counts[l]; ++i) if (lists[l][i] == C_BAD) {
            for (int j = i; j + 1 < *counts[l]; ++j) lists[l][j] = lists[l][j + 1];
            --*counts[l]; --g.bad_count; return;
        }
    }
}

/* ===== 전투 — 조준·탄·적·웨이브: docs/10_MECHANICS.md §5 ===== */
static int nearest_enemy(float x, float y) {
    int best = -1; float best_d = 1e30f;
    for (int i = 0; i < MAX_ENEMIES; ++i) if (g.enemies[i].active) {
        float d = length2(g.enemies[i].x - x, g.enemies[i].y - y);
        if (d < best_d) { best_d = d; best = i; }
    }
    return best;
}

static void aim(float *dx, float *dy) {
    int e = nearest_enemy(g.px, g.py);
    if (e >= 0) { *dx = g.enemies[e].x - g.px; *dy = g.enemies[e].y - g.py; }
    else { *dx = g.last_dx; *dy = g.last_dy; }
    normalize(dx, dy);
}

static void spawn_bullet(float x, float y, float dx, float dy, int damage, int hits, int splash) {
    normalize(&dx, &dy);
    for (int i = 0; i < MAX_BULLETS; ++i) if (!g.bullets[i].active) {
        Bullet *b = &g.bullets[i];
        b->active = 1; b->x = x; b->y = y; b->vx = dx * 150.0f / TICK_HZ;
        b->vy = dy * 150.0f / TICK_HZ; b->damage = (int16_t)damage; b->life = 90;
        b->hits = (uint8_t)hits; b->splash = (uint8_t)splash; b->last_hit = -1;
        return;
    }
}

static void spawn_enemy_shot(float x, float y) {
    float dx = g.px - x, dy = g.py - y; normalize(&dx, &dy);
    for (int i = 0; i < MAX_ENEMY_SHOTS; ++i) if (!g.enemy_shots[i].active) {
        EnemyShot *s = &g.enemy_shots[i];
        s->active = 1; s->x = x; s->y = y; s->vx = dx * 34.0f / TICK_HZ;
        s->vy = dy * 34.0f / TICK_HZ; s->life = 480; return;
    }
}

static void spawn_enemy(int type, bool elite, float x, float y) {
    for (int i = 0; i < MAX_ENEMIES; ++i) if (!g.enemies[i].active) {
        Enemy *e = &g.enemies[i];
        e->active = 1; e->type = (uint8_t)type; e->elite = elite ? 1 : 0;
        e->x = x; e->y = y; e->hp = (int16_t)(ENEMY_HP[type] * (elite ? ELITE_HP_MULT : 1));
        e->fire = (uint16_t)(60 + rng_next() % 240); e->marked = 0; return;
    }
}

static void spawn_edge_enemy(int type, bool elite) {
    int edge = (int)(rng_next() & 3), p = 8 + (int)(rng_next() % 176);
    float x = 4, y = (float)p;
    if (edge == 1) x = 316;
    else if (edge == 2) { x = (float)(8 + rng_next() % 304); y = 4; }
    else if (edge == 3) { x = (float)(8 + rng_next() % 304); y = 188; }
    spawn_enemy(type, elite, x, y);
}

static void enemy_killed(int index) {
    Enemy dead = g.enemies[index];
    g.enemies[index].active = 0;
    if (dead.type == TROJAN) for (int i = 0; i < 3; ++i)
        spawn_enemy(WORM, false, dead.x + (float)(i * 4 - 4), dead.y + (float)((i & 1) * 5));
    if (dead.elite) {
        remove_bad_once();
        deck_add_discard(C_PATCH);
        show_message(4);
        sfx_motif(NOTE_B4,NOTE_G4,NOTE_E4,4); /* 시크의 선물 — 역방향 */
    }
}

static void damage_enemy(int index, int damage) {
    Enemy *e = &g.enemies[index];
    if (!e->active) return;
    if (e->marked) damage = damage * 3 / 2;
    e->hp -= (int16_t)damage;
    if (e->hp <= 0) enemy_killed(index);
}

static void area_damage(float x, float y, float radius, int damage) {
    float r2 = radius * radius;
    for (int i = 0; i < MAX_ENEMIES; ++i) if (g.enemies[i].active &&
        length2(g.enemies[i].x - x, g.enemies[i].y - y) <= r2) damage_enemy(i, damage);
}

static void splash_damage(float x,float y,float radius,int damage,int except) {
    float r2=radius*radius;
    for(int i=0;i<MAX_ENEMIES;++i)if(i!=except&&g.enemies[i].active&&
        length2(g.enemies[i].x-x,g.enemies[i].y-y)<=r2)damage_enemy(i,damage);
}

static void all_damage(int damage) {
    for (int i = 0; i < MAX_ENEMIES; ++i) if (g.enemies[i].active) damage_enemy(i, damage);
}

static void carrier_burst(int bit) {
    g.burst_mask |= (uint8_t)(1u << bit);
    for (int i = 0; i < MAX_ENEMY_SHOTS; ++i) g.enemy_shots[i].active = 0;
    for (int i = 0; i < MAX_ENEMIES; ++i) if (g.enemies[i].active) {
        float dx = g.enemies[i].x - g.px, dy = g.enemies[i].y - g.py; normalize(&dx, &dy);
        g.enemies[i].x = (float)clampi((int)(g.enemies[i].x + dx * 32), 4, 316);
        g.enemies[i].y = (float)clampi((int)(g.enemies[i].y + dy * 32), 4, 188);
    }
    g.flash_ticks = g.low_fx ? 0 : 2; g.shake_ticks = g.low_fx ? 0 : 7;
    sfx(420 + bit * 180, 10);
}

static void add_signal(int amount) {
    static const int threshold[] = {16,32,48};
    g.signal += amount;
    for (int i = 0; i < 3; ++i)
        if (g.signal >= threshold[i] && !(g.burst_mask & (1u << i))) carrier_burst(i);
    if(g.signal>=32&&g.signal-amount<32)show_message(7);
}

static int nearest_unused_enemy(const bool *used) {
    int best = -1; float bd = 1e30f;
    for (int i = 0; i < MAX_ENEMIES; ++i) if (g.enemies[i].active && !used[i]) {
        float d = length2(g.enemies[i].x-g.px, g.enemies[i].y-g.py);
        if (d < bd) { bd = d; best = i; }
    }
    return best;
}

static void mark_nearest(int count) {
    bool used[MAX_ENEMIES] = {0};
    for (int k = 0; k < count; ++k) {
        int best = nearest_unused_enemy(used);
        if (best < 0) break;
        used[best] = true; g.enemies[best].marked = MARKER_DURATION_TICKS;
    }
}

static void surge_damage(int damage) {
    bool used[MAX_ENEMIES] = {0};
    for (int k = 0; k < SURGE_TARGETS; ++k) {
        int best = nearest_unused_enemy(used);
        if (best < 0) break;
        used[best] = true; damage_enemy(best, damage);
    }
}

/* ===== 카드 실행 — 해석 순서: docs/10_MECHANICS.md §4 ===== */
static bool is_fragment(CardId id) { return id == C_CHAT || id == C_VOICE || id == C_CLIP; }

static void show_message(int id) { g.message_id=id; g.message_ticks=72; }

static void attack_card(CardId id, int scale, bool real_card) {
    float dx, dy; aim(&dx, &dy);
    int live = g.live ? 1 : 0;
    bool damage_payload=true;
    switch (id) {
    case C_2400: spawn_bullet(g.px,g.py,dx,dy,DMG_2400*scale/100,1,0); break;
    case C_14K: spawn_bullet(g.px,g.py,dx,dy,DMG_14K*scale/100,2,0); break;
    case C_56K: spawn_bullet(g.px,g.py,dx,dy,DMG_56K*scale/100,1,12); break;
    case C_CHAT: if (live) area_damage(g.px,g.py,14,DMG_CHAT*scale/100); else damage_payload=false; break;
    case C_VOICE: if (live) area_damage(g.px,g.py,28,DMG_VOICE*scale/100); else damage_payload=false; break;
    case C_CLIP: if (live) { all_damage(DMG_CLIP*scale/100);g.flash_ticks=g.low_fx?0:6;g.hitstop_ticks=6; } else damage_payload=false; break;
    case C_PATCH: all_damage(DMG_PATCH*scale/100); break;
    case C_CACHE:
        spawn_bullet(g.px,g.py,dx,dy,DMG_CACHE*scale/100,1,0);
        spawn_bullet(g.px,g.py,dx*0.9f-dy*0.35f,dy*0.9f+dx*0.35f,DMG_CACHE*scale/100,1,0);
        spawn_bullet(g.px,g.py,dx*0.9f+dy*0.35f,dy*0.9f-dx*0.35f,DMG_CACHE*scale/100,1,0); break;
    case C_SURGE: surge_damage(DMG_SURGE*scale/100); break;
    default: damage_payload=false; break;
    }
    if (real_card && damage_payload)
        g.last_damage_card = id;
}

static void execute_card(CardId id) {
    bool prefetched = is_fragment(id) && g.deck.prefetch_pending;
    if ((g.previous_card==C_MARKER&&id==C_SURGE)||(g.previous_card==C_MULTI&&id==C_MACRO)||
        (g.previous_card==C_PREFETCH&&is_fragment(id))) g.link_ticks=24;
    if (prefetched) g.deck.prefetch_pending = false;
    switch (id) {
    case C_MULTI: g.deck.multi_next = true; break;
    case C_MACRO: if (g.last_damage_card >= 0) attack_card((CardId)g.last_damage_card,70,false); break;
    case C_FIREWALL:
        if (g.invuln_ticks < FIREWALL_INVULN_TICKS) g.invuln_ticks = FIREWALL_INVULN_TICKS;
        for (int i=0;i<MAX_ENEMIES;++i) if(g.enemies[i].active &&
            length2(g.enemies[i].x-g.px,g.enemies[i].y-g.py)<24*24) {
            float dx=g.enemies[i].x-g.px,dy=g.enemies[i].y-g.py; normalize(&dx,&dy);
            g.enemies[i].x += dx*18; g.enemies[i].y += dy*18;
        } break;
    case C_PREFETCH: g.deck.prefetch_pending = true; break;
    case C_MARKER: mark_nearest(MARKER_TARGETS); break;
    case C_BAD: g.flash_ticks = g.low_fx?0:1; sfx(90,3); break;
    default: attack_card(id,100,true); break;
    }
    if (g.live && is_fragment(id)) add_signal(CARD[id].signal + (prefetched ? 1 : 0));
    if(id==C_CHAT && !g.live) {
        ++g.fragment_count;
        if(g.log_shown<2 && (g.fragment_count==2||g.fragment_count==5)) show_message(10+g.log_ids[g.log_shown++]);
    }
    g.previous_card=id;g.card_fx_ticks=7;
    /* 모뎀은 등급이 높을수록 낮고 두꺼운 발사음(2400=300 → 56K=180), 그 외는 가격 비례 상승 */
    if (id != C_BAD && id != C_MULTI && id != C_PREFETCH)
        sfx(id<=C_56K ? 300-CARD[id].cost*20 : 260+CARD[id].cost*45, 2);
}

/* ===== 런 상태머신 — docs/10_MECHANICS.md §1·§6 ===== */
static void prepare_channel(uint32_t seed, bool today) {
    bool muted = g.muted, low = g.low_fx, running = g.running;
    ZeroMemory(&g, sizeof(g));
    g.muted = muted; g.low_fx = low; g.running = running; g.today = today;
    g.seed = seed ? seed : 1; g.rng = g.seed;
    g.kingdom_mask = VALID_MASKS[rng_next() % ARRAY_COUNT(VALID_MASKS)];
    do { g.directive = (uint8_t)(rng_next() % 3); }
    while (g.directive == DIR_CLEAN && !(g.kingdom_mask & (1u << 7)));
    {static const uint8_t light[]={0,1,6};g.log_ids[0]=light[rng_next()%3];do{g.log_ids[1]=(uint8_t)(2+rng_next()%6);}while(g.log_ids[1]==g.log_ids[0]);}
    g.mode = CHANNEL;
}

static void start_run(void) {
    uint32_t seed = g.seed, rng = g.rng; bool today = g.today, muted = g.muted, low = g.low_fx, running = g.running;
    uint8_t mask = g.kingdom_mask, directive = g.directive, log0=g.log_ids[0], log1=g.log_ids[1];
    ZeroMemory(&g, sizeof(g));
    g.seed=seed; g.rng=rng; g.today=today; g.muted=muted; g.low_fx=low; g.running=running;
    g.kingdom_mask=mask; g.directive=directive;g.log_ids[0]=log0;g.log_ids[1]=log1;g.mode=PLAY;g.hp=HP_START;
    g.px=160; g.py=96; g.last_dx=1; g.last_dy=0; g.last_damage_card=-1;
    g.next_shop_ticks=SHOP_FIRST_SEC*TICK_HZ;g.next_chest_ticks=CHEST_INTERVAL_SEC*TICK_HZ;g.tutorial=onboarding_seen?0:1;onboarding_seen=true;
#ifndef FIXED_GUN
    for (int i=0;i<7;++i) g.deck.draw[g.deck.draw_n++]=C_2400;
    for (int i=0;i<3;++i) g.deck.draw[g.deck.draw_n++]=C_CHAT;
    shuffle(g.deck.draw,g.deck.draw_n); deck_new_hand();
#endif
    sfx_motif(NOTE_E4,NOTE_G4,NOTE_B4,5); /* 에코 등장 — 정방향 */
}

static void dev_log_result(void);

static void finish_run(bool won) {
    if (g.mode == RESULT||g.mode==ENDING) return;
    g.won=won;g.mode=won?ENDING:RESULT;g.ending_ticks=won?150:0;
    if(won)sfx_motif(NOTE_E5,NOTE_G5,NOTE_B5,8);else sfx(110,24); /* 승리 — 에코 정방향 한 옥타브 위 */
    dev_log_result();
}

static uint8_t stamp_mask(void) {
    if(!g.won)return 0;
    return (uint8_t)((g.live_start_ticks<STAMP_EARLY_SEC*TICK_HZ?1:0)|(g.bad_count==0?2:0)|(g.live_ticks<=STAMP_FAST_SEC*TICK_HZ?4:0));
}

static void start_live(void) {
    if (g.live) return;
    g.live=true; g.go_confirm=false; g.mode=PLAY; g.live_start_ticks=g.dead_ticks;
    g.predicted_at_live=estimate_signal();g.live_ticks=0;g.signal=directive_bonus();g.burst_mask=0;g.transition_ticks=21;show_message(g.dead_ticks<LIVE_FORCED_SEC*TICK_HZ?8:6);
    for(int i=0;i<MAX_ENEMY_SHOTS;++i)if(g.enemy_shots[i].active){
        float dx=g.enemy_shots[i].x-g.px,dy=g.enemy_shots[i].y-g.py;normalize(&dx,&dy);
        g.enemy_shots[i].x+=dx*28;g.enemy_shots[i].y+=dy*28;
    }
    for(int i=0;i<MAX_ENEMIES;++i) if(g.enemies[i].active) {
        float dx=g.enemies[i].x-g.px,dy=g.enemies[i].y-g.py; normalize(&dx,&dy);
        g.enemies[i].x=(float)clampi((int)(g.enemies[i].x+dx*28),4,316);
        g.enemies[i].y=(float)clampi((int)(g.enemies[i].y+dy*28),4,188);
    }
    g.flash_ticks=g.low_fx?0:15; sfx_motif(NOTE_B4,NOTE_B4,0,9); /* 제로의 전환 — 단음 반복 */
}

static CardId shop_card(int slot) {
    static const CardId basic[5]={C_14K,C_56K,C_CHAT,C_VOICE,C_CLIP};
    if(slot<5) return basic[slot];
    int k=slot-5;
    for(int i=0;i<8;++i) if(g.kingdom_mask&(1u<<i)) {
        if(!k--) return KINGDOM[i];
    }
    return C_2400;
}

static int kingdom_bit(CardId id) {
    for(int i=0;i<8;++i) if(KINGDOM[i]==id) return i;
    return -1;
}

static bool can_buy(CardId id) {
    if(CARD[id].cost>buy_power()) return false;
    if(id==C_DEFRAG) return deck_total()>DECK_MIN;
    return deck_total()<MAX_DECK;
}

static void leave_shop(void) {
    g.mode=PLAY; g.shop_due=false; g.go_confirm=false; g.defrag_select=false;
    g.card_ticks=CARD_TICKS_SWAP;
}

static void buy_selected(void) {
    CardId id=shop_card(g.shop_sel);
    if(!can_buy(id)) { sfx(90,4); return; }
    if(id==C_DEFRAG) { g.defrag_select=true; g.defrag_sel=0; return; }
    deck_add_discard(id);
    int bit=kingdom_bit(id); if(bit>=0) g.distinct_mask|=(uint8_t)(1u<<bit);
    if(g.purchase_n<ARRAY_COUNT(g.purchases)) g.purchases[g.purchase_n++]=id;
    sfx(620,5); leave_shop();
}

static void trash_shop_hand(void) {
    if(g.defrag_sel>=g.deck.hand_n || deck_total()<=DECK_MIN) return;
    CardId id=g.deck.hand[g.defrag_sel];
    for(int i=g.defrag_sel;i+1<g.deck.hand_n;++i) g.deck.hand[i]=g.deck.hand[i+1];
    --g.deck.hand_n; ++g.trash_count; if(id==C_BAD && g.bad_count) --g.bad_count;
    if(g.purchase_n<ARRAY_COUNT(g.purchases)) g.purchases[g.purchase_n++]=C_DEFRAG;
    sfx(760,6); leave_shop();
}

static void enter_shop(void) {
    deck_new_hand();g.mode=SHOP;g.shop_due=false;g.shop_sel=0;g.shop_all=false;
    if(!shop_help_seen){g.tutorial=2;shop_help_seen=true;}
    for(int i=0;i<10;++i) if(can_buy(shop_card(i))) { g.shop_sel=(uint8_t)i; break; }
}

static void seek(void) {
    if(g.deck.seek_used || g.deck.hand_n<2) return;
    CardId first=g.deck.hand[0];
    for(int i=0;i+1<g.deck.hand_n;++i) g.deck.hand[i]=g.deck.hand[i+1];
    g.deck.hand[g.deck.hand_n-1]=first;
    if(g.deck.prefetch_pending&&g.card_ticks<=CARD_TICKS_PREFETCH&&!is_fragment(g.deck.hand[0]))g.card_ticks=CARD_TICKS_NORMAL;
    g.deck.seek_used=true;g.seek_fx_ticks=8;if(!g.seek_spoken){g.seek_spoken=true;show_message(5);}sfx(340,4);
}

static void trigger_next_card(void) {
    if(!g.deck.hand_n) return;
    CardId id=g.deck.hand[0];
    for(int i=0;i+1<g.deck.hand_n;++i) g.deck.hand[i]=g.deck.hand[i+1];
    --g.deck.hand_n;
    execute_card(id);
    if(id!=C_PATCH||deck_total()<DECK_MIN) g.deck.discard[g.deck.discard_n++]=id;
    if(!g.deck.hand_n) {
        if(g.shop_due && !g.live) enter_shop();
        else deck_new_hand();
        return;
    }
    if(g.deck.multi_next) { g.deck.multi_next=false; g.card_ticks=0; }
    else if(g.deck.prefetch_pending && is_fragment(g.deck.hand[0])) g.card_ticks=CARD_TICKS_PREFETCH;
    else g.card_ticks=CARD_TICKS_NORMAL;
}

/* ===== 입력·모드 업데이트 ===== */
static void poll_keys(void) {
    for(int i=0;i<256;++i) {
        key_pressed[i]=key_pending[i]; key_pending[i]=0;
    }
}

static bool pressed(int vk) { return key_pressed[vk]!=0; }
static bool held(int vk) { return key_down[vk]!=0; }

static void global_input(void) {
    if(pressed('M')) g.muted=!g.muted;
    if(pressed(VK_F1)) g.low_fx=!g.low_fx;
#ifdef DEV_LOG
    if(pressed(VK_F5)&&g.mode==PLAY&&!g.live){g.cheated=true;g.dead_ticks=GOLIVE_EARLIEST_SEC*TICK_HZ;enter_shop();}
    if(pressed(VK_F6)&&g.mode==PLAY){g.cheated=true;g.dead_ticks=GOLIVE_EARLIEST_SEC*TICK_HZ;start_live();}
    if(pressed(VK_F7)&&g.live){g.cheated=true;add_signal(16);}
    if(pressed(VK_F8)&&(g.mode==PLAY||g.mode==SHOP)){g.cheated=true;g.hp=0;finish_run(false);}
    if(pressed(VK_F9)&&g.mode==ENDING)g.ending_ticks=1;
#endif
}

static void channel_input(void) {
    if(pressed(VK_RETURN)) start_run();
    if(pressed(VK_ESCAPE)) g.mode=TITLE;
}

static void title_input(void) {
    if(pressed(VK_ESCAPE)) g.running=false;
    if(pressed(VK_RETURN)) {
        LARGE_INTEGER q; QueryPerformanceCounter(&q);
        prepare_channel((uint32_t)q.LowPart^(uint32_t)GetTickCount64(),false);
    }
    if(pressed(VK_F2)) {
        SYSTEMTIME t; GetLocalTime(&t);
        prepare_channel((uint32_t)(t.wYear*10000+t.wMonth*100+t.wDay),true);
    }
}

static void shop_input(void) {
    if(g.tutorial==2){if(pressed(VK_RETURN)||pressed(VK_SPACE))g.tutorial=0;return;}
    if(g.go_confirm) {
        if(pressed('Y')) start_live();
        else if(pressed('N')||pressed(VK_ESCAPE)) g.go_confirm=false;
        return;
    }
    if(g.defrag_select) {
        if(pressed(VK_LEFT)||pressed(VK_UP)) g.defrag_sel=(uint8_t)((g.defrag_sel+g.deck.hand_n-1)%g.deck.hand_n);
        if(pressed(VK_RIGHT)||pressed(VK_DOWN)) g.defrag_sel=(uint8_t)((g.defrag_sel+1)%g.deck.hand_n);
        if(pressed(VK_RETURN)) trash_shop_hand();
        return;
    }
    if(pressed(VK_TAB))g.shop_all=!g.shop_all;
    int move=(pressed(VK_LEFT)||pressed(VK_UP))?-1:(pressed(VK_RIGHT)||pressed(VK_DOWN))?1:0;
    if(move)for(int tries=0;tries<10;++tries){g.shop_sel=(uint8_t)((g.shop_sel+10+move)%10);if(g.shop_all||can_buy(shop_card(g.shop_sel)))break;}
    if(pressed(VK_RETURN)) buy_selected();
    if(pressed(VK_ESCAPE)) leave_shop();
    if(pressed('F')&&g.dead_ticks>=GOLIVE_EARLIEST_SEC*TICK_HZ) g.go_confirm=true;
}

static void result_input(void) {
    if(pressed(VK_ESCAPE)) g.mode=TITLE;
    if(pressed(VK_RETURN)) {
        if(g.today) prepare_channel(g.seed,true);
        else { LARGE_INTEGER q; QueryPerformanceCounter(&q);prepare_channel((uint32_t)q.LowPart^(uint32_t)GetTickCount64(),false); }
    }
}

static void player_input(void) {
    if(pressed(VK_ESCAPE)) { g.pause_return=g.mode; g.mode=PAUSE_MODE; return; }
    if(pressed(VK_SPACE)) seek();
    float dx=(held('D')||held(VK_RIGHT)?1.0f:0.0f)-(held('A')||held(VK_LEFT)?1.0f:0.0f);
    float dy=(held('S')||held(VK_DOWN)?1.0f:0.0f)-(held('W')||held(VK_UP)?1.0f:0.0f);
    if(dx||dy) { normalize(&dx,&dy); g.last_dx=dx; g.last_dy=dy; g.px+=dx*54.0f/TICK_HZ; g.py+=dy*54.0f/TICK_HZ; }
    g.px=(float)clampi((int)g.px,7,313);g.py=(float)clampi((int)g.py,7,185);
}

static void insert_bad(void) {
    if(g.bad_count>=BAD_CAP || deck_total()>=MAX_DECK || g.bad_immune_ticks) return;
    deck_add_discard(C_BAD);++g.bad_count;g.bad_immune_ticks=BAD_IMMUNE_TICKS;if(!g.bad_spoken){g.bad_spoken=true;show_message(9);}sfx(100,10);
}

static void update_enemies(void) {
    for(int i=0;i<MAX_ENEMIES;++i) if(g.enemies[i].active) {
        Enemy *e=&g.enemies[i]; float dx=g.px-e->x,dy=g.py-e->y,d2=length2(dx,dy); normalize(&dx,&dy);
        float vx=dx,vy=dy;
        if(e->type==POPUP) { int motion_ticks=g.live?g.live_ticks:g.dead_ticks;float side=((motion_ticks/30+i)&1)?0.65f:-0.65f;vx=dx-dy*side;vy=dy+dx*side;normalize(&vx,&vy); }
        if(e->type==RANSOM) {
            if(d2<50*50) { vx=-dx; vy=-dy; }
            else if(d2<75*75) { vx=-dy; vy=dx; }
            if(e->fire) --e->fire; else { spawn_enemy_shot(e->x,e->y); e->fire=RANSOM_FIRE_TICKS; }
        }
        float live_speed=!g.live?1.0f:g.live_ticks<20*TICK_HZ?1.1f:g.live_ticks<45*TICK_HZ?1.2f:1.3f;
        e->x+=vx*ENEMY_SPEED[e->type]*live_speed/TICK_HZ;
        e->y+=vy*ENEMY_SPEED[e->type]*live_speed/TICK_HZ;
        e->x=(float)clampi((int)e->x,3,317);e->y=(float)clampi((int)e->y,3,189);
        if(e->marked) --e->marked;
#ifndef NO_THREAT /* 대조 빌드: 무적 더미 — 접촉 피해 없음, BAD 오염은 유지 */
        int contact=e->elite?12:e->type==TROJAN?10:7;
        if(length2(e->x-g.px,e->y-g.py)<contact*contact && !g.invuln_ticks) {
            if(g.hp) --g.hp; g.invuln_ticks=HIT_INVULN_TICKS; sfx(120,8);
        }
#endif
    }
}

static void update_bullets(void) {
    for(int b=0;b<MAX_BULLETS;++b) if(g.bullets[b].active) {
        Bullet *p=&g.bullets[b]; p->x+=p->vx; p->y+=p->vy;
        if(--p->life<=0||p->x<0||p->x>=SCREEN_W||p->y<0||p->y>=ARENA_H) {p->active=0;continue;}
        if(g.chest_active&&length2(p->x-g.chest_x,p->y-g.chest_y)<49) {
            g.chest_active=false; if(g.hp<HP_START)++g.hp; p->active=0; sfx(700,6); continue;
        }
        for(int i=0;i<MAX_ENEMIES;++i) if(g.enemies[i].active&&i!=p->last_hit){int hit=g.enemies[i].elite?8:g.enemies[i].type==TROJAN?6:4;if(
            length2(g.enemies[i].x-p->x,g.enemies[i].y-p->y)<hit*hit) {
            damage_enemy(i,p->damage); p->last_hit=(int16_t)i;
            if(p->splash)splash_damage(p->x,p->y,p->splash,p->damage,i);
            if(--p->hits==0) p->active=0;
            break;
        }}
    }
    for(int i=0;i<MAX_ENEMY_SHOTS;++i) if(g.enemy_shots[i].active) {
        EnemyShot *s=&g.enemy_shots[i]; s->x+=s->vx;s->y+=s->vy;
        if(!s->life--||s->x<0||s->x>=SCREEN_W||s->y<0||s->y>=ARENA_H){s->active=0;continue;}
        if(length2(s->x-g.px,s->y-g.py)<25) { insert_bad(); s->active=0; }
    }
}

static void spawn_wave(void) {
    float sec=(float)(g.live?g.live_ticks:g.dead_ticks)/TICK_HZ;
    g.spawn_budget+=(g.live?(6.0f+0.067f*sec):(0.8f+0.012f*sec))/TICK_HZ;
    for(int loops=0;loops<8&&g.spawn_budget>=1.0f;++loops) {
        int type=WORM; uint32_t r=rng_next()%100;
        if(g.live) type=r<35?WORM:r<65?POPUP:r<82?TROJAN:RANSOM;
        else if(sec>=180) type=r<45?WORM:r<70?POPUP:r<86?TROJAN:RANSOM;
        else if(sec>=120) type=r<60?WORM:r<82?POPUP:TROJAN;
        else if(sec>=60) type=r<70?WORM:POPUP;
        float cost=ENEMY_COST[type];
        if(cost>g.spawn_budget) { type=WORM; cost=ENEMY_COST[WORM]; }
        spawn_edge_enemy(type,false); g.spawn_budget-=cost;
    }
    if(!g.live&&!g.elite_spawned&&g.dead_ticks>=180*TICK_HZ) {
        spawn_edge_enemy(RANSOM,true);g.elite_spawned=true;show_message(3);
        sfx_motif(NOTE_B4,NOTE_G4,NOTE_E4,6); /* 시크 등장 — 역방향 */
    }
}

static void update_play(void) {
    if(g.transition_ticks){if(pressed(VK_ESCAPE)){g.pause_return=g.mode;g.mode=PAUSE_MODE;return;}--g.transition_ticks;return;}
    if(g.hitstop_ticks){--g.hitstop_ticks;return;}
    player_input(); if(g.mode!=PLAY)return;
    if(g.invuln_ticks)--g.invuln_ticks; if(g.bad_immune_ticks)--g.bad_immune_ticks;
    if(g.flash_ticks)--g.flash_ticks;if(g.shake_ticks)--g.shake_ticks;if(g.shuffle_ticks)--g.shuffle_ticks;
    if(g.link_ticks)--g.link_ticks;if(g.card_fx_ticks)--g.card_fx_ticks;if(g.seek_fx_ticks)--g.seek_fx_ticks;if(g.message_ticks)--g.message_ticks;
    if(!g.live) {
        ++g.dead_ticks;
#ifndef FIXED_GUN /* 대조 빌드: 상점·덱 없음 — docs/50 §2 */
        if(g.dead_ticks>=g.next_shop_ticks) {g.shop_due=true;g.next_shop_ticks+=SHOP_INTERVAL_SEC*TICK_HZ;}
#endif
        if(g.dead_ticks>=g.next_chest_ticks){g.chest_active=true;g.chest_x=(float)(24+rng_next()%272);g.chest_y=(float)(20+rng_next()%150);g.next_chest_ticks+=CHEST_INTERVAL_SEC*TICK_HZ;}
        if(g.dead_ticks==60*TICK_HZ)show_message(1);
        if(g.dead_ticks==120*TICK_HZ)show_message(2);
        if(g.dead_ticks>=LIVE_FORCED_SEC*TICK_HZ) start_live();
    }
    spawn_wave(); update_enemies(); update_bullets();
#ifdef FIXED_GUN
    if(g.card_ticks>0)--g.card_ticks;
    else { float dx,dy; aim(&dx,&dy); spawn_bullet(g.px,g.py,dx,dy,8,1,0); g.card_ticks=CARD_TICKS_NORMAL; }
#else
    if(g.card_ticks>0)--g.card_ticks; else trigger_next_card();
#endif
    if(g.signal>=SIGNAL_GOAL) {finish_run(true);return;}
    if(!g.hp) {finish_run(false);return;}
    if(g.live){
        ++g.live_ticks;
        if(g.live_ticks==LIVE_MAX_TICKS*3/4)sfx_motif(NOTE_B4,NOTE_B4,0,6); /* 종료 진행 75% — 제로 단음 */
#ifdef FIXED_GUN
        if(g.live_ticks>=LIVE_MAX_TICKS)finish_run(true); /* 대조 빌드: 60초 생존 = 승리 */
#else
        if(g.live_ticks>=LIVE_MAX_TICKS)finish_run(false);
#endif
    }
}

static void game_tick(void) {
    poll_keys(); global_input();
    switch(g.mode) {
    case TITLE:title_input();break;
    case CHANNEL:channel_input();break;
    case PLAY:
        if(g.tutorial&&pressed(VK_RETURN)){g.tutorial=0;show_message(0);}
        else if(!g.tutorial)update_play();
        break;
    case SHOP:shop_input();break;
    case PAUSE_MODE:if(pressed(VK_ESCAPE)||pressed(VK_RETURN))g.mode=g.pause_return;break;
    case ENDING:if(--g.ending_ticks<=0)g.mode=RESULT;break;
    case RESULT:++g.result_ticks;result_input();break;
    }
}

#ifdef DEV_LOG
static void dev_log_result(void) {
    char path[MAX_PATH];GetModuleFileNameA(0,path,MAX_PATH);int slash=lstrlenA(path)-1;while(slash>=0&&path[slash]!='\\')--slash;lstrcpyA(path+slash+1,"playtest.csv");
    HANDLE h=CreateFileA(path,FILE_APPEND_DATA,FILE_SHARE_READ,0,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
    if(h==INVALID_HANDLE_VALUE)return;
    DWORD wrote;if(GetFileSize(h,0)==0){static const char header[]="seed,kingdom_mask,directive,buy_count,purchase_ids,trash_count,final_deck_ids,first_shuffle_sec,seek_used,live_start_sec,predicted_sig_at_live,live_clear_sec,end_signal,hp,result,fail_reason,cheated\r\n";WriteFile(h,header,sizeof(header)-1,&wrote,0);}
    char line[1024];int n=wsprintfA(line,"%u,%02X,%u,%u,",g.seed,g.kingdom_mask,g.directive,g.purchase_n);
    for(int i=0;i<g.purchase_n;++i)n+=wsprintfA(line+n,"%s%u",i?"|":"",g.purchases[i]);
    n+=wsprintfA(line+n,",%u,",g.trash_count);
    bool first=true;CardId *lists[]={g.deck.draw,g.deck.discard,g.deck.hand};int counts[]={g.deck.draw_n,g.deck.discard_n,g.deck.hand_n};
    for(int l=0;l<3;++l)for(int i=0;i<counts[l];++i){n+=wsprintfA(line+n,"%s%u",first?"":"|",lists[l][i]);first=false;}
    const char *reason=g.won?"none":!g.live?"prelive_hp":g.hp?"format":"hp";
    n+=wsprintfA(line+n,",%d,%u,%d,%d,%d,%d,%u,%s,%s,%d\r\n",g.first_shuffle_ticks/TICK_HZ,g.seek_spoken?1:0,
        g.live_start_ticks/TICK_HZ,g.predicted_at_live,g.won?g.live_ticks/TICK_HZ:-1,g.signal,g.hp,g.won?"win":"loss",reason,g.cheated?1:0);
    WriteFile(h,line,(DWORD)n,&wrote,0);CloseHandle(h);
}
#else
static void dev_log_result(void) {}
#endif

/* ===== 렌더 — 팔레트: docs/40_ART_AUDIO_TEXT.md §2 ===== */
static HINSTANCE app_instance;
static HWND app_window;
static HDC back_dc;
static HBITMAP back_bitmap;
static HDC present_dc;
static HBITMAP present_bitmap;
static int present_w,present_h;
static uint32_t *pixels;
static HFONT font_small, font_big;
static BITMAPINFO bmi;

static void clear(uint32_t color) {
    for(int i=0;i<SCREEN_W*SCREEN_H;++i)pixels[i]=color;
}

static void rect(int x,int y,int w,int h,uint32_t color) {
    int x0=clampi(x,0,SCREEN_W),y0=clampi(y,0,SCREEN_H);
    int x1=clampi(x+w,0,SCREEN_W),y1=clampi(y+h,0,SCREEN_H);
    for(int yy=y0;yy<y1;++yy)for(int xx=x0;xx<x1;++xx)pixels[yy*SCREEN_W+xx]=color;
}

static void frame(int x,int y,int w,int h,uint32_t color) {
    rect(x,y,w,1,color);rect(x,y+h-1,w,1,color);rect(x,y,1,h,color);rect(x+w-1,y,1,h,color);
}

static void line(int x0,int y0,int x1,int y1,uint32_t color) {
    int dx=abs(x1-x0),sx=x0<x1?1:-1,dy=-abs(y1-y0),sy=y0<y1?1:-1,err=dx+dy;
    for(;;){if(x0>=0&&x0<SCREEN_W&&y0>=0&&y0<SCREEN_H)pixels[y0*SCREEN_W+x0]=color;
        if(x0==x1&&y0==y1)break;int e2=err*2;if(e2>=dy){err+=dy;x0+=sx;}if(e2<=dx){err+=dx;y0+=sy;}}
}

static void disk(int cx,int cy,int r,uint32_t color) {
    int rr=r*r;for(int y=-r;y<=r;++y)for(int x=-r;x<=r;++x)if(x*x+y*y<=rr)rect(cx+x,cy+y,1,1,color);
}

static void text_at(int x,int y,uint32_t color,const wchar_t *s) {
    SetTextColor(back_dc,(COLORREF)color);TextOutW(back_dc,x,y,s,lstrlenW(s));
}

static void number_text(int x,int y,uint32_t color,const wchar_t *fmt,int value) {
    wchar_t buf[64];wsprintfW(buf,fmt,value);text_at(x,y,color,buf);
}

static void card_box(int x,int y,CardId id,bool active,bool live_preview) {
    uint32_t edge=active?COL_WHITE:is_fragment(id)?(g.live||live_preview?COL_MAGENTA:COL_DIM):id==C_BAD?COL_RED:COL_CYAN;
    rect(x,y,55,27,COL_PANEL);frame(x,y,55,27,edge);
    text_at(x+3,y+2,edge,CARD[id].short_name);
    if(CARD[id].buy)number_text(x+3,y+14,COL_AMBER,L"B%d",CARD[id].buy);
    if(is_fragment(id))number_text(x+31,y+14,g.live||live_preview?COL_MAGENTA:COL_DIM,L"S%d",CARD[id].signal);
    if(id==C_BAD)text_at(x+35,y+14,COL_RED,L"X");
}

static void draw_echo(int x,int y,int scale) {
    frame(x-7*scale,y-7*scale,15*scale,15*scale,COL_MAGENTA);rect(x+4*scale,y-7*scale,4*scale,3*scale,COL_BG);
    disk(x,y-2*scale,4*scale,COL_CYAN);rect(x-3*scale,y-3*scale,6*scale,4*scale,COL_WHITE);
    rect(x-2*scale,y-2*scale,1*scale,1*scale,COL_BLACK);rect(x+2*scale,y-2*scale,1*scale,1*scale,COL_BLACK);
    rect(x-4*scale,y+2*scale,8*scale,5*scale,COL_WHITE);rect(x,y+2*scale,4*scale,5*scale,COL_CYAN);rect(x+3*scale,y+2*scale,1*scale,1*scale,COL_RED);
}

static void draw_seek(int x,int y,int scale) {
    disk(x,y,5*scale,COL_AMBER);disk(x,y,4*scale,COL_BLACK);rect(x-3*scale,y+2*scale,6*scale,2*scale,COL_AMBER);
    rect(x+4*scale,y,7*scale,2*scale,COL_AMBER);rect(x+9*scale,y-2*scale,2*scale,2*scale,COL_AMBER);
    rect(x-2*scale,y-2*scale,2*scale,2*scale,COL_WHITE);rect(x-1*scale,y-2*scale,1*scale,1*scale,COL_BLACK);
}

static void draw_format(int x,int y,int scale) {
    rect(x-4*scale,y-7*scale,8*scale,15*scale,COL_BLACK);frame(x-4*scale,y-7*scale,8*scale,15*scale,COL_MAGENTA);
    rect(x-3*scale,y-5*scale,6*scale,4*scale,COL_WHITE);rect(x-3*scale,y-3*scale,6*scale,2*scale,COL_MAGENTA);
    rect(x-6*scale,y+1*scale,2*scale,5*scale,COL_WHITE);rect(x+4*scale,y+1*scale,2*scale,5*scale,COL_WHITE);
    rect(x-2*scale,y+3*scale,4*scale,1*scale,COL_MAGENTA);rect(x-1*scale,y-5*scale,1*scale,1*scale,COL_BLACK);
}

static const wchar_t *directive_name(void) {
    return g.directive==DIR_INDEX?L"다종 편성":g.directive==DIR_CLEAN?L"클린 편성":L"증원 편성";
}

static void draw_title(void) {
    clear(COL_BG);SelectObject(back_dc,font_big);
    text_at(50,36,COL_WHITE,L"에코/144");text_at(66,58,COL_MAGENTA,L"LAST LIVE");
    draw_echo(86,112,3);draw_format(235,112,3);line(108,112,213,112,COL_DIM);
    SelectObject(back_dc,font_small);
    text_at(73,146,COL_CYAN,L"시청자 1 / 오늘도 만석");
    text_at(82,184,COL_WHITE,L"ENTER  일반 채널");text_at(82,198,COL_AMBER,L"F2     오늘의 채널");
    text_at(82,216,COL_DIM,L"M 음소거  F1 저자극");
}

static void draw_channel(void) {
    clear(COL_BG);SelectObject(back_dc,font_big);text_at(76,18,COL_WHITE,L"오늘의 채널");
    SelectObject(back_dc,font_small);number_text(12,49,COL_DIM,L"SEED %u",(int)g.seed);
    text_at(12,66,COL_AMBER,directive_name());
    text_at(12,83,COL_DIM,g.directive==DIR_INDEX?L"여러 킹덤 종류를 쓰면 선송출":g.directive==DIR_CLEAN?L"직접 정리한 카드마다 선송출":L"10장 넘는 덱마다 선송출");
    int row=0;for(int i=0;i<8;++i)if(g.kingdom_mask&(1u<<i)){
        CardId id=KINGDOM[i];int x=17+(row%2)*150,y=110+(row/2)*27;
        frame(x,y,137,22,COL_CYAN);text_at(x+5,y+4,COL_WHITE,CARD[id].name);number_text(x+107,y+4,COL_AMBER,L"%dB",CARD[id].cost);++row;
    }
    text_at(91,205,COL_WHITE,L"ENTER 방송 준비");text_at(112,219,COL_DIM,L"ESC 뒤로");
}

static void draw_background(void) {
    clear(g.live?0x00130918:COL_BG);
    for(int y=16;y<ARENA_H;y+=32)line(0,y,SCREEN_W-1,y,g.live?0x00341a35:0x0018232b);
    for(int x=16;x<SCREEN_W;x+=32)line(x,0,x,ARENA_H-1,g.live?0x00221b35:0x00152229);
    frame(1,1,SCREEN_W-2,ARENA_H-2,g.live?COL_MAGENTA:COL_CYAN);
}

static void draw_world(void) {
    if(g.chest_active){rect((int)g.chest_x-4,(int)g.chest_y-4,9,9,COL_AMBER);frame((int)g.chest_x-5,(int)g.chest_y-5,11,11,COL_WHITE);}
    for(int i=0;i<MAX_ENEMIES;++i)if(g.enemies[i].active){
        Enemy *e=&g.enemies[i];int x=(int)e->x,y=(int)e->y;
        uint32_t c=e->elite?COL_AMBER:e->type==RANSOM?COL_RED:e->type==TROJAN?COL_BLUE:e->type==POPUP?COL_MAGENTA:COL_DIM;
        int r=e->elite?7:e->type==TROJAN?5:3;disk(x,y,r,c);if(e->marked)frame(x-r-2,y-r-2,2*r+5,2*r+5,COL_WHITE);
        if(e->elite)draw_seek(x,y,1);
    }
    for(int i=0;i<MAX_BULLETS;++i)if(g.bullets[i].active)disk((int)g.bullets[i].x,(int)g.bullets[i].y,1,COL_CYAN);
    for(int i=0;i<MAX_ENEMY_SHOTS;++i)if(g.enemy_shots[i].active){int x=(int)g.enemy_shots[i].x,y=(int)g.enemy_shots[i].y;frame(x-2,y-2,5,5,COL_RED);}
    if(!g.invuln_ticks||(g.invuln_ticks&4))draw_echo((int)g.px,(int)g.py,1);
}

static void draw_hud(void) {
    rect(0,ARENA_H,SCREEN_W,SCREEN_H-ARENA_H,COL_PANEL);line(0,ARENA_H,319,ARENA_H,g.live?COL_MAGENTA:COL_CYAN);
    wchar_t top[128];
    if(g.live)wsprintfW(top,L"HP %d   송출 신호 %d/64   종료 진행 %d%%",g.hp,g.signal,g.live_ticks/(LIVE_MAX_TICKS/100));
    else wsprintfW(top,L"HP %d   %d:%02d   현재 %d   신호 ≥%d/64",g.hp,g.dead_ticks/3600,(g.dead_ticks/60)%60,now_score(),estimate_signal());
    text_at(5,3,COL_WHITE,top);
    if(g.live){int sw=118*clampi(g.signal,0,SIGNAL_GOAL)/SIGNAL_GOAL,fw=123*clampi(g.live_ticks,0,LIVE_MAX_TICKS)/LIVE_MAX_TICKS;frame(5,15,120,5,COL_MAGENTA);rect(6,16,sw,3,COL_MAGENTA);frame(190,15,125,5,COL_RED);rect(314-fw,16,fw,3,COL_RED);}
    int count=g.deck.hand_n;for(int i=0;i<count;++i)card_box(4+i*63,198-(i==0?2:0),g.deck.hand[i],i==0,false);
    if(g.seek_fx_ticks)line(31,195,31+(8-g.seek_fx_ticks)*252/8,195,COL_AMBER);
#ifdef FIXED_GUN
    if(!count)text_at(96,207,COL_DIM,L"대조 빌드 — 고정 총");
#else
    if(!count)text_at(110,207,COL_DIM,L"셔플 중...");
#endif
    text_at(5,229,COL_DIM,g.deck.seek_used?L"SEEK 사용":L"SPACE SEEK");
    text_at(121,229,COL_AMBER,directive_name());text_at(258,229,COL_DIM,L"시청자 1");
    if(g.shuffle_ticks){text_at(137,181,COL_AMBER,L"SHUFFLE");rect((15-g.shuffle_ticks)*SCREEN_W/15,ARENA_H,3,SCREEN_H-ARENA_H,COL_AMBER);}
    if(g.link_ticks)text_at(145,181,COL_MAGENTA,L"LINK!");
    if(g.live)for(int i=0;i<4;++i){uint32_t c=g.signal>=(i+1)*16?COL_MAGENTA:COL_DIM;frame(278+i*9,20,7,7,c);if(g.signal>=(i+1)*16)rect(280+i*9,22,3,3,c);}
    if(g.tutorial){rect(23,74,274,46,COL_BLACK);frame(23,74,274,46,COL_WHITE);text_at(37,84,COL_WHITE,L"아래 5장이 왼쪽부터 자동 실행됩니다.");text_at(78,101,COL_DIM,L"ENTER로 시작");}
}

static const wchar_t *message_text(void) {
    static const wchar_t *logs[]={
        L"오늘도 한 분. 접속 상태 매우 혼잡.",L"이 상품은 1997년에는 판매하지 않습니다.",
        L"출연 1 / STAFF 0 / 시청자 1",L"대피 안내는 엔딩 뒤에— [CUT]",
        L"첫 방송 관람 완료 ×3",L"제목: 모두 돌아온 날 / 길이 00:00",
        L"다음 방송: 어제",L"오늘은 엔딩 멘트 하지 마"
    };
    switch(g.message_id){
    case 0:return L"채널 체크. 대체로 굿입니다!";
    case 1:return L"주문하지 않은 창이 도착했습니다.";
    case 2:return L"선물 아닌 것이 세 개나 들어 있습니다.";
    case 3:return L"첫 방송 축하드립니다. 저는 세 번째부터 봤습니다.";
    case 4:return L"빠진 장면은 임시 보관입니다. 영구적으로.";
    case 5:return L"다음 장면, 뒤로 부탁합니다.";
    case 6:return L"지원되지 않는 시간입니다. 정상 종료를 시작합니다.";
    case 7:return L"오늘은 엔딩 멘트 하지 마";
    case 8:return L"조금 이르지만, 지각보단 라이브!";
    case 9:return L"깨진 건 아직 남아 있다는 뜻입니다. 대체로.";
    default:return logs[clampi(g.message_id-10,0,7)];
    }
}

static void draw_message(void) {
    if(!g.message_ticks)return;
    rect(12,145,296,40,COL_BLACK);frame(12,145,296,40,g.message_id==6?COL_MAGENTA:g.message_id==3||g.message_id==4?COL_AMBER:COL_CYAN);
    if(g.message_id==6)draw_format(27,165,1);else if(g.message_id==3||g.message_id==4||g.message_id==9)draw_seek(27,165,1);else draw_echo(27,165,1);
    text_at(44,153,COL_WHITE,message_text());
    text_at(44,170,COL_DIM,g.message_id>=10?L"CHAT.LOG":g.message_id==6?L"포맷 제로":g.message_id==3||g.message_id==4||g.message_id==9?L"시크 웜":L"에코 일사사");
}

static void draw_play(void) {
    draw_background();draw_world();if(g.card_fx_ticks)line(31,190,(int)g.px,(int)g.py,g.live?COL_MAGENTA:COL_CYAN);draw_hud();draw_message();
    if(g.transition_ticks){rect(55,67,210,58,COL_BLACK);frame(55,67,210,58,COL_MAGENTA);draw_format(76,96,2);text_at(102,77,COL_WHITE,L"포맷 제로");text_at(102,94,COL_MAGENTA,L"UNSUPPORTED TIMESTAMP");text_at(102,110,COL_DIM,L"지원되지 않는 시간입니다.");}
    if(g.flash_ticks&&!g.low_fx)frame(2,2,316,188,COL_WHITE);
}

static void draw_shop(void) {
    clear(COL_BG);SelectObject(back_dc,font_big);text_at(86,9,COL_WHITE,L"접속실 09");SelectObject(back_dc,font_small);
    number_text(11,36,COL_AMBER,L"다음 5장 B 합: %d",buy_power());
    for(int i=0;i<g.deck.hand_n;++i)card_box(8+i*61,53,g.deck.hand[i],g.defrag_select&&i==g.defrag_sel,false);
    for(int i=0;i<10;++i){CardId id=shop_card(i);int x=12+(i%2)*154,y=88+(i/2)*24;uint32_t c=can_buy(id)?COL_WHITE:COL_DIM;
        if(i==g.shop_sel&&!g.defrag_select)rect(x-3,y-2,148,21,COL_PANEL);
        if(i==g.shop_sel&&!g.defrag_select)frame(x-3,y-2,148,21,COL_CYAN);
        text_at(x,y,c,CARD[id].name);number_text(x+118,y,c,L"%dB",CARD[id].cost);
    }
    CardId selected=shop_card(g.shop_sel);text_at(8,202,COL_WHITE,CARD[selected].name);
    number_text(118,202,COL_AMBER,L"가격 %dB",CARD[selected].cost);
    if(selected!=C_DEFRAG){wchar_t delta[96];wsprintfW(delta,L"NOW %d→%d  SIG %d→%d",now_score(),now_with(selected),estimate_signal(),estimate_signal_with(selected));text_at(187,202,COL_CYAN,delta);}
    text_at(5,222,COL_DIM,L"←→ 선택 ENTER 구매 ESC 패스");text_at(165,222,COL_DIM,L"TAB 전체");
    if(g.dead_ticks>=GOLIVE_EARLIEST_SEC*TICK_HZ)number_text(229,222,COL_MAGENTA,L"F 방송 ≥%d",estimate_signal());
    if(g.defrag_select){rect(25,105,270,45,COL_BLACK);frame(25,105,270,45,COL_AMBER);text_at(42,116,COL_WHITE,L"정리할 공개 카드 1장을 고르세요.");text_at(77,132,COL_DIM,L"←→ / ENTER");}
    if(g.go_confirm){rect(25,96,270,55,COL_BLACK);frame(25,96,270,55,COL_MAGENTA);text_at(39,108,COL_WHITE,L"구매를 포기하고 마지막 방송 시작?");text_at(116,129,COL_DIM,L"Y / N");}
    if(g.tutorial==2){rect(23,74,274,103,COL_BLACK);frame(23,74,274,103,COL_WHITE);
        text_at(34,84,COL_WHITE,L"모뎀은 지금 강하고, 조각은 LIVE에서 송출.");
        text_at(34,102,COL_WHITE,L"다음 5장의 B 합으로 1장만 받습니다.");
        card_box(85,122,C_CHAT,false,false);text_at(146,129,COL_MAGENTA,L"→");card_box(163,122,C_CHAT,false,true);
        text_at(92,157,COL_DIM,L"ENTER로 계속");}
}

static void draw_pause(void) {
    draw_play();rect(91,87,138,49,COL_BLACK);frame(91,87,138,49,COL_WHITE);text_at(132,98,COL_WHITE,L"일시정지");text_at(105,116,COL_DIM,L"ESC 또는 ENTER");
}

static void draw_result(void) {
    clear(COL_BG);SelectObject(back_dc,font_big);text_at(g.won?98:110,17,g.won?COL_CYAN:COL_RED,g.won?L"송출 성공":L"연결 종료");SelectObject(back_dc,font_small);
    if(g.won){number_text(92,49,COL_MAGENTA,L"A:\\ SIGNAL %d/64",g.signal);text_at(83,65,COL_WHITE,L"NO CARRIER — 시청자 1");}
    else if(g.live){number_text(103,49,COL_RED,L"SIGNAL %d/64",g.signal);text_at(105,65,COL_DIM,g.hp?L"DEAD AIR":L"CARRIER LOST");text_at(67,76,COL_DIM,L"불편을 드려 유감이며, 예정대로입니다.");}
    else text_at(70,52,COL_RED,L"CARRIER LOST — CURRENT OUTPUT LOW");
    number_text(34,92,COL_WHITE,L"준비 방송  %d초",g.live_start_ticks/TICK_HZ);
    number_text(34,108,COL_WHITE,L"마지막 방송 %d초",g.live_ticks/TICK_HZ);
    number_text(34,124,COL_WHITE,L"남은 HP    %d",g.hp);number_text(182,124,COL_DIM,L"SEED %u",(int)g.seed);
    text_at(34,140,COL_AMBER,directive_name());number_text(182,140,COL_WHITE,L"최종 덱 %d장",deck_total());
    int shown=0;for(int id=0;id<CARD_COUNT;++id){int n=deck_count((CardId)id);if(n){int x=17+(shown%4)*76,y=158+(shown/4)*14;wchar_t d[32];wsprintfW(d,L"%s×%d",CARD[id].short_name,n);text_at(x,y,COL_DIM,d);++shown;if(shown==8)break;}}
    if(g.won){uint8_t stamps=stamp_mask();bool early=stamps&1,clean=stamps&2,full=stamps&4;
        bool all=stamps==7;int sy=all?176:190,x=25;
        if(early){text_at(x,sy,COL_CYAN,L"조기 방송");x+=92;}if(clean){text_at(x,sy,COL_CYAN,L"클린 송출");x+=92;}if(full)text_at(x,sy,COL_CYAN,L"30초 송출");
        if(all){frame(104,190,112,25,COL_MAGENTA);text_at(132,197,COL_WHITE,L"에코/144");if(!g.result_ticks){rect(83,65,166,12,COL_BG);text_at(83,65,COL_MAGENTA,L"NO CARRIER — 시청자 2");}}
    }
    text_at(78,228,COL_WHITE,L"ENTER 다음 채널  ESC 타이틀");
}

static void draw_ending(void) {
    clear(COL_BLACK);SelectObject(back_dc,font_big);text_at(69,77,COL_MAGENTA,L"A:\\ SIGNAL 64/64");SelectObject(back_dc,font_small);
    text_at(84,122,COL_WHITE,L"NO CARRIER — 시청자 1");text_at(71,143,COL_DIM,L"시청자 수는 정정하지 않겠습니다.");
}

static void render(void) {
    SetBkMode(back_dc,TRANSPARENT);SelectObject(back_dc,font_small);
    switch(g.mode){case TITLE:draw_title();break;case CHANNEL:draw_channel();break;case PLAY:draw_play();break;case SHOP:draw_shop();break;case PAUSE_MODE:draw_pause();break;case ENDING:draw_ending();break;case RESULT:draw_result();break;}
    if(g.muted)text_at(292,2,COL_DIM,L"M");if(g.low_fx)text_at(278,2,COL_DIM,L"F1");
#ifdef NO_THREAT
    text_at(234,2,COL_DIM,L"DUMMY");
#endif
}

/* ===== 오디오 합성 — docs/40_ART_AUDIO_TEXT.md §4 ===== */
static HWAVEOUT wave;
static WAVEHDR wave_headers[4];
static int16_t wave_samples[4][1024];
static uint32_t audio_phase1,audio_phase2,audio_noise=1,sfx_phase;
static int sfx_freq,sfx_left,sfx_volume;
static int sfx_seq_freq[2],sfx_seq_n,sfx_seq_len;
static bool audio_ready;

static void sfx(int freq,int ticks){sfx_freq=freq;sfx_left=ticks*22050/TICK_HZ;sfx_volume=2200;sfx_phase=0;sfx_seq_n=0;}

static void sfx_motif(int f0,int f1,int f2,int ticks_per_note){
    sfx(f0,ticks_per_note);sfx_seq_len=sfx_left;
    if(f1)sfx_seq_freq[sfx_seq_n++]=f1;
    if(f2)sfx_seq_freq[sfx_seq_n++]=f2;
}

static void fill_audio(WAVEHDR *header) {
    int index=(int)(header-wave_headers);int16_t *out=wave_samples[index];
    uint32_t f1=g.live?(g.signal>=48?360u:180u):120u,f2=g.live?90u:180u;
    bool noise_on=true;
    if(g.mode==ENDING){if(g.ending_ticks<100)f2=0;if(g.ending_ticks<50)f1=0;noise_on=g.ending_ticks>=100;}
    else if(g.mode==RESULT){f1=80;f2=0;noise_on=false;}
    uint32_t step1=(uint32_t)(((uint64_t)f1<<32)/22050),step2=(uint32_t)(((uint64_t)f2<<32)/22050);
    for(int i=0;i<1024;++i){int sample=0;
        if(!g.muted){if(f1){audio_phase1+=step1;sample+=(audio_phase1&0x80000000u)?380:-380;}
            if(f2){audio_phase2+=step2;if(!g.live||g.signal>=16)sample+=(audio_phase2&0x80000000u)?220:-220;}
            int noise_mask=g.live&&g.signal>=32?15:127;if(noise_on&&(i&noise_mask)==0){audio_noise=(audio_noise>>1)^((0u-(audio_noise&1u))&0xB400u);sample+=(audio_noise&1)?120:-120;}
            if(sfx_left<=0&&sfx_seq_n>0){sfx_freq=sfx_seq_freq[0];sfx_seq_freq[0]=sfx_seq_freq[1];--sfx_seq_n;sfx_left=sfx_seq_len;sfx_phase=0;}
            if(sfx_left>0){sfx_phase+=(uint32_t)(((uint64_t)(uint32_t)sfx_freq<<32)/22050);sample+=(sfx_phase&0x80000000u)?sfx_volume:-sfx_volume;--sfx_left;}
        }
        out[i]=(int16_t)clampi(sample,-32767,32767);
    }
    if(audio_ready)waveOutWrite(wave,header,sizeof(*header));
}

static void init_audio(HWND hwnd) {
    WAVEFORMATEX fmt={WAVE_FORMAT_PCM,1,22050,22050*2,2,16,0};
    if(waveOutOpen(&wave,WAVE_MAPPER,&fmt,(DWORD_PTR)hwnd,0,CALLBACK_WINDOW)!=MMSYSERR_NOERROR)return;
    audio_ready=true;
    for(int i=0;i<4;++i){wave_headers[i].lpData=(LPSTR)wave_samples[i];wave_headers[i].dwBufferLength=sizeof(wave_samples[i]);
        waveOutPrepareHeader(wave,&wave_headers[i],sizeof(wave_headers[i]));fill_audio(&wave_headers[i]);}
}

static void shutdown_audio(void) {
    if(!audio_ready)return;audio_ready=false;waveOutReset(wave);
    for(int i=0;i<4;++i)waveOutUnprepareHeader(wave,&wave_headers[i],sizeof(wave_headers[i]));waveOutClose(wave);
}

static void present(void) {
    RECT r;GetClientRect(app_window,&r);HDC dc=GetDC(app_window);
    if(r.right<=0||r.bottom<=0){ReleaseDC(app_window,dc);return;}
    if(!present_dc||present_w!=r.right||present_h!=r.bottom){
        if(present_dc)DeleteDC(present_dc);if(present_bitmap)DeleteObject(present_bitmap);
        present_dc=CreateCompatibleDC(dc);present_bitmap=CreateCompatibleBitmap(dc,r.right,r.bottom);
        SelectObject(present_dc,present_bitmap);present_w=r.right;present_h=r.bottom;
    }
    int sx=g.shake_ticks?((g.shake_ticks&1)?2:-2):0,sy=g.shake_ticks?((g.shake_ticks&2)?1:-1):0;
    if(g.shake_ticks)PatBlt(present_dc,0,0,r.right,r.bottom,BLACKNESS);
    SetStretchBltMode(present_dc,COLORONCOLOR);StretchBlt(present_dc,sx*r.right/SCREEN_W,sy*r.bottom/SCREEN_H,r.right,r.bottom,back_dc,0,0,SCREEN_W,SCREEN_H,SRCCOPY);
    BitBlt(dc,0,0,r.right,r.bottom,present_dc,0,0,SRCCOPY);ReleaseDC(app_window,dc);
}

/* ===== Win32 플랫폼 ===== */
static LRESULT CALLBACK window_proc(HWND hwnd,UINT msg,WPARAM wp,LPARAM lp) {
    if(msg==MM_WOM_DONE){if(audio_ready)fill_audio((WAVEHDR*)lp);return 0;}
    switch(msg){
    case WM_SYSKEYDOWN:
        if(wp==VK_F4){g.running=false;return 0;}
        if(wp<256){if(!key_down[wp])key_pending[wp]=1;key_down[wp]=1;}return DefWindowProcW(hwnd,msg,wp,lp);
    case WM_KEYDOWN:
        if(wp<256){if(!key_down[wp])key_pending[wp]=1;key_down[wp]=1;}return 0;
    case WM_SYSKEYUP:
        if(wp<256)key_down[wp]=0;return DefWindowProcW(hwnd,msg,wp,lp);
    case WM_KEYUP:
        if(wp<256)key_down[wp]=0;return 0;
    case WM_KILLFOCUS:ZeroMemory(key_down,sizeof(key_down));ZeroMemory(key_pending,sizeof(key_pending));return 0;
    case WM_CLOSE:g.running=false;return 0;
    case WM_DESTROY:PostQuitMessage(0);return 0;
    case WM_ERASEBKGND:return 1;
    case WM_PAINT:{PAINTSTRUCT ps;BeginPaint(hwnd,&ps);EndPaint(hwnd,&ps);return 0;}
    }
    return DefWindowProcW(hwnd,msg,wp,lp);
}

static bool init_window(void) {
    WNDCLASSW wc={0};wc.lpfnWndProc=window_proc;wc.hInstance=app_instance;wc.lpszClassName=L"ECHO144";wc.hCursor=LoadCursorW(0,MAKEINTRESOURCEW(32512));
    if(!RegisterClassW(&wc))return false;
    RECT r={0,0,960,720};AdjustWindowRect(&r,WS_OVERLAPPEDWINDOW,FALSE);
    app_window=CreateWindowW(wc.lpszClassName,L"에코/144 — LAST LIVE",WS_OVERLAPPEDWINDOW|WS_VISIBLE,
        CW_USEDEFAULT,CW_USEDEFAULT,r.right-r.left,r.bottom-r.top,0,0,app_instance,0);
    if(!app_window)return false;
    HDC dc=GetDC(app_window);back_dc=CreateCompatibleDC(dc);ReleaseDC(app_window,dc);
    ZeroMemory(&bmi,sizeof(bmi));bmi.bmiHeader.biSize=sizeof(BITMAPINFOHEADER);bmi.bmiHeader.biWidth=SCREEN_W;
    bmi.bmiHeader.biHeight=-SCREEN_H;bmi.bmiHeader.biPlanes=1;bmi.bmiHeader.biBitCount=32;bmi.bmiHeader.biCompression=BI_RGB;
    back_bitmap=CreateDIBSection(back_dc,&bmi,DIB_RGB_COLORS,(void**)&pixels,0,0);if(!back_bitmap)return false;
    SelectObject(back_dc,back_bitmap);
    // ponytail: native Windows glyphs avoid a second font pipeline; embed a subset only if clean-PC or size checks fail.
    font_small=CreateFontW(-10,0,0,0,FW_NORMAL,FALSE,FALSE,FALSE,HANGUL_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,NONANTIALIASED_QUALITY,FIXED_PITCH,L"GulimChe");
    font_big=CreateFontW(-20,0,0,0,FW_BOLD,FALSE,FALSE,FALSE,HANGUL_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,NONANTIALIASED_QUALITY,FIXED_PITCH,L"GulimChe");
    return true;
}

static void shutdown_window(void) {
    if(present_dc)DeleteDC(present_dc);if(present_bitmap)DeleteObject(present_bitmap);
    if(back_dc)DeleteDC(back_dc);if(back_bitmap)DeleteObject(back_bitmap);
    if(font_small)DeleteObject(font_small);if(font_big)DeleteObject(font_big);
}

#ifdef SELF_TEST
static uint32_t state_hash(void) {
    uint32_t h=2166136261u;const uint8_t *p=(const uint8_t*)&g;for(size_t i=0;i<sizeof(g);++i)h=(h^p[i])*16777619u;return h;
}

static void assert_live_clear(void) {
    start_live();for(int ticks=0;ticks<5000&&g.mode==PLAY;++ticks){g.hp=255;update_play();}
    assert(g.mode==ENDING&&g.signal>=64);
}

/* ===== SIM — 스크립트 구매 정책 몬테카를로 (docs/20_BALANCE.md §SIM)
   전투를 매 틱 비워 회피 실력 변수를 제거하고 덱·경제·신호 수학만 검증한다. ===== */
static void sim_clear_combat(void) {
    for(int i=0;i<MAX_ENEMIES;++i)g.enemies[i].active=0;
    for(int i=0;i<MAX_BULLETS;++i)g.bullets[i].active=0;
    for(int i=0;i<MAX_ENEMY_SHOTS;++i)g.enemy_shots[i].active=0;
    g.spawn_budget=0;
}

static bool sim_try_buy(CardId id) {
    int slot=-1;
    for(int i=0;i<10;++i)if(shop_card(i)==id){slot=i;break;}
    if(slot<0||!can_buy(id))return false;
    if(id==C_DEFRAG){
        int target=-1;
        for(int i=0;i<g.deck.hand_n&&target<0;++i)if(g.deck.hand[i]==C_BAD)target=i;
        for(int i=0;i<g.deck.hand_n&&target<0;++i)if(g.deck.hand[i]==C_2400)target=i;
        if(target<0)return false;
        g.shop_sel=(uint8_t)slot;buy_selected();g.defrag_sel=(uint8_t)target;trash_shop_hand();return true;
    }
    g.shop_sel=(uint8_t)slot;buy_selected();return true;
}

static void sim_policy_shop(int policy) {
    static const CardId econ[]={C_CLIP,C_56K,C_VOICE,C_14K};
    static const CardId util[]={C_VOICE,C_PREFETCH,C_MULTI,C_CHAT};
    static const CardId clean[]={C_DEFRAG,C_VOICE,C_CHAT};
    static const CardId mirror[]={C_VOICE,C_CHAT,C_14K};
    static const CardId *prio[4]={econ,util,clean,mirror};
    static const int prio_n[4]={4,4,3,3};
    for(int i=0;i<prio_n[policy];++i)if(sim_try_buy(prio[policy][i]))return;
    leave_shop();
}

static bool sim_run(int policy,bool early,uint32_t seed,FILE *csv) {
    prepare_channel(seed,false);start_run();g.tutorial=0;
    for(int guard=0;guard<80000&&g.mode!=RESULT&&g.mode!=ENDING;++guard){
        if(g.mode==SHOP){
            if(early&&g.dead_ticks>=GOLIVE_EARLIEST_SEC*TICK_HZ)start_live();
            else sim_policy_shop(policy);
        } else if(g.mode==PLAY){g.hp=HP_START;update_play();sim_clear_combat();}
        else break;
    }
    bool won=g.mode==ENDING&&g.won;
    if(csv)fprintf(csv,"%d,%s,%u,%u,%d,%d,%s,%d\n",policy,early?"early":"forced",seed,
        g.directive,deck_total(),g.signal,won?"win":"loss",won?g.live_ticks/TICK_HZ:-1);
    return won;
}

int main(void) {
    for(int m=0;m<(int)ARRAY_COUNT(VALID_MASKS);++m){uint8_t v=VALID_MASKS[m];assert(popcount8(v)==5);assert(popcount8(v&0x66)>=2);assert(v&0x88);assert(v&0x90);}
    g.running=true;prepare_channel(12345,false);uint8_t mask=g.kingdom_mask,dir=g.directive,log0=g.log_ids[0],log1=g.log_ids[1];
    start_run();CardId first_hand[5];for(int i=0;i<5;++i)first_hand[i]=g.deck.hand[i];
    prepare_channel(12345,false);assert(g.kingdom_mask==mask&&g.directive==dir&&g.log_ids[0]==log0&&g.log_ids[1]==log1);
    start_run();for(int i=0;i<5;++i)assert(g.deck.hand[i]==first_hand[i]);assert(deck_total()==10&&g.deck.hand_n==5&&g.hp==5);
    assert(estimate_signal()==30);
    int before=deck_total();deck_add_discard(C_14K);assert(deck_total()==before+1);
    g.live=true;g.signal=0;g.deck.prefetch_pending=true;execute_card(C_CHAT);assert(g.signal==2&&!g.deck.prefetch_pending);int sig_after=g.signal;execute_card(C_MACRO);assert(g.signal==sig_after);
    g.live=true;g.signal=15;g.enemy_shots[0].active=1;add_signal(3);
    assert(g.signal==18&&(g.burst_mask&1)&&!g.enemy_shots[0].active);
    g.low_fx=true;g.signal=15;g.burst_mask=0;g.flash_ticks=g.shake_ticks=0;add_signal(1);assert(!g.flash_ticks&&!g.shake_ticks&&(g.burst_mask&1));g.low_fx=false;
    g.signal=15;g.burst_mask=0;add_signal(40);assert((g.burst_mask&7)==7);uint8_t bursts=g.burst_mask;add_signal(1);assert(g.burst_mask==bursts);
    g.directive=DIR_CLEAN;g.trash_count=9;assert(directive_bonus()==12);
    prepare_channel(7,false);start_run();g.directive=DIR_MIRROR;deck_add_discard(C_PATCH);assert(directive_bonus()==0);deck_add_discard(C_14K);assert(directive_bonus()==2);
    for(int i=0;i<9;++i)deck_add_discard(C_CHAT);assert(directive_bonus()==16);
    g.bad_count=0;for(int i=0;i<8;++i){g.bad_immune_ticks=0;insert_bad();}assert(g.bad_count==5);
    ZeroMemory(&g.deck,sizeof(g.deck));for(int i=0;i<4;++i)g.deck.draw[g.deck.draw_n++]=C_2400;g.deck.hand[0]=C_PATCH;g.deck.hand_n=1;trigger_next_card();assert(deck_total()==5);
    prepare_channel(9,false);start_run();g.hp=255;for(int i=0;i<2100&&g.mode==PLAY;++i)update_play();assert(g.mode==SHOP);
    g.mode=PLAY;g.live=true;g.transition_ticks=0;g.live_ticks=3599;g.signal=64;g.hp=5;update_play();assert(g.mode==ENDING&&g.won);
    prepare_channel(88,false);start_run();g.live=true;g.transition_ticks=0;g.live_ticks=3599;g.signal=0;g.hp=5;update_play();assert(g.mode==RESULT&&!g.won);
    g.won=true;g.live_start_ticks=309*TICK_HZ;g.bad_count=0;g.live_ticks=30*TICK_HZ;assert(stamp_mask()==7);
    g.live_start_ticks=310*TICK_HZ;assert(stamp_mask()==6);g.bad_count=1;assert(stamp_mask()==4);g.live_ticks=30*TICK_HZ+1;assert(stamp_mask()==0);g.won=false;assert(stamp_mask()==0);
    for(int run=0;run<10;++run){prepare_channel((uint32_t)(100+run),false);start_run();assert(g.mode==PLAY&&deck_total()==10);g.live=true;g.signal=64;finish_run(true);assert(g.mode==ENDING);}
    prepare_channel(20260714,true);start_run();for(int i=0;i<600;++i){g.hp=255;update_play();}uint32_t today_hash=state_hash();prepare_channel(20260714,true);start_run();for(int i=0;i<600;++i){g.hp=255;update_play();}assert(state_hash()==today_hash);printf("TODAY deterministic replay: PASS\n");
    prepare_channel(31415,false);start_run();int shops=0;
    for(int ticks=0;ticks<30000&&g.mode!=RESULT;++ticks){if(g.mode==SHOP){++shops;leave_shop();}else if(g.mode==PLAY){g.hp=255;update_play();}}
    assert(g.mode==RESULT&&!g.won&&g.live_ticks==3600&&shops==9);
    prepare_channel(27182,false);start_run();for(int i=0;i<5;++i)deck_add_discard(C_VOICE);start_live();
    for(int ticks=0;ticks<5000&&g.mode==PLAY;++ticks){g.hp=255;update_play();}
    assert(g.mode==ENDING&&g.signal>=64&&(g.burst_mask&7)==7&&g.live_ticks<3600);printf("full-run smoke: 9 shops, FORMAT loss, SIGNAL clear at %.2f sec\n",(double)g.live_ticks/TICK_HZ);
    prepare_channel(401,false);start_run();deck_add_discard(C_56K);deck_add_discard(C_CLIP);deck_add_discard(C_CLIP);assert_live_clear();
    prepare_channel(402,false);start_run();g.previous_card=C_PREFETCH;execute_card(C_CHAT);assert(g.link_ticks==24);g.previous_card=C_MULTI;execute_card(C_MACRO);assert(g.link_ticks==24);g.previous_card=C_MARKER;execute_card(C_SURGE);assert(g.link_ticks==24);for(int i=0;i<2;++i){deck_add_discard(C_PREFETCH);deck_add_discard(C_MULTI);}for(int i=0;i<3;++i)deck_add_discard(C_VOICE);assert_live_clear();
    prepare_channel(403,false);start_run();ZeroMemory(&g.deck,sizeof(g.deck));for(int i=0;i<2;++i)g.deck.draw[g.deck.draw_n++]=C_2400;for(int i=0;i<3;++i)g.deck.draw[g.deck.draw_n++]=C_CHAT;g.directive=DIR_CLEAN;g.trash_count=5;shuffle(g.deck.draw,g.deck.draw_n);deck_new_hand();assert_live_clear();
    prepare_channel(404,false);start_run();g.directive=DIR_MIRROR;for(int i=0;i<2;++i)deck_add_discard(C_VOICE);for(int i=0;i<4;++i)deck_add_discard(C_CHAT);for(int i=0;i<3;++i)deck_add_discard(C_14K);assert(deck_total()==19&&directive_bonus()==16);assert_live_clear();printf("build-path smoke: ECON/CLIP, UTIL/LINK, CLEAN, MIRROR(9-buy) PASS\n");
    prepare_channel(405,false);start_run();for(int i=0;i<5;++i)deck_add_discard(C_VOICE);g.dead_ticks=270*TICK_HZ;assert_live_clear();assert(g.live_start_ticks==270*TICK_HZ);
    prepare_channel(406,false);start_run();for(int i=0;i<5;++i)deck_add_discard(C_VOICE);g.dead_ticks=360*TICK_HZ;assert_live_clear();assert(g.live_start_ticks==360*TICK_HZ);printf("GO LIVE smoke: early and forced entry PASS\n");
    {
        static const char *pname[4]={"ECON","UTIL","CLEAN","MIRROR"};
        int wins[4][2]={{0}};
        FILE *csv=fopen("build\\simtest.csv","w");
        if(csv)fprintf(csv,"policy,golive,seed,directive,final_deck,end_signal,result,live_clear_sec\n");
        for(int p=0;p<4;++p)for(int e=0;e<2;++e)for(uint32_t s=0;s<30;++s)
            if(sim_run(p,e==0,1000+s,csv))++wins[p][e];
        if(csv)fclose(csv);
        int total=0,best=0;
        for(int p=0;p<4;++p){
            int w=wins[p][0]+wins[p][1];total+=w;if(w>best)best=w;
            printf("SIM %-6s early %2d/30  forced %2d/30\n",pname[p],wins[p][0],wins[p][1]);
        }
        for(int p=0;p<4;++p)assert(wins[p][0]+wins[p][1]>0); /* 4경로 모두 승리 가능 */
        assert(best*100<=total*70);                          /* 단일 정책 70% 독점 금지 */
        printf("SIM acceptance: PASS (top policy share %d%%)\n",best*100/total);
    }
    ZeroMemory(g.enemies,sizeof(g.enemies));ZeroMemory(g.bullets,sizeof(g.bullets));
    for(int i=0;i<MAX_ENEMIES;++i){g.enemies[i].active=1;g.enemies[i].x=310;g.enemies[i].y=180;g.enemies[i].hp=30000;}
    for(int i=0;i<MAX_BULLETS;++i){g.bullets[i].active=1;g.bullets[i].x=10;g.bullets[i].y=10;g.bullets[i].life=1000;g.bullets[i].hits=1;g.bullets[i].last_hit=-1;}
    LARGE_INTEGER f,a,b;QueryPerformanceFrequency(&f);QueryPerformanceCounter(&a);for(int i=0;i<600;++i)update_bullets();QueryPerformanceCounter(&b);
    double ms=(double)(b.QuadPart-a.QuadPart)*1000.0/f.QuadPart/600.0;printf("worst collision tick: %.3f ms\n",ms);assert(ms<16.7);
    g.muted=true;audio_ready=false;fill_audio(&wave_headers[0]);for(int i=0;i<1024;++i)assert(wave_samples[0][i]==0);printf("mute synthesis: PASS\n");
    return 0;
}
#else
int WINAPI wWinMain(HINSTANCE instance,HINSTANCE previous,PWSTR command,int show) {
    (void)previous;(void)command;(void)show;app_instance=instance;SetProcessDPIAware();
    g.running=true;g.mode=TITLE;
    if(!init_window())return 1;init_audio(app_window);
    LARGE_INTEGER freq,last,now;QueryPerformanceFrequency(&freq);QueryPerformanceCounter(&last);
    double accumulator=0.0,step=(double)freq.QuadPart/TICK_HZ;
    while(g.running){
        MSG msg;while(PeekMessageW(&msg,0,0,0,PM_REMOVE)){if(msg.message==WM_QUIT)g.running=false;TranslateMessage(&msg);DispatchMessageW(&msg);}
        QueryPerformanceCounter(&now);accumulator+=(double)(now.QuadPart-last.QuadPart);last=now;
        int ticks=0;while(accumulator>=step&&ticks<5){game_tick();accumulator-=step;++ticks;}
        if(ticks==5&&accumulator>=step)accumulator=0;
        if(ticks){render();present();}else Sleep(1);
    }
    shutdown_audio();shutdown_window();if(app_window)DestroyWindow(app_window);return 0;
}
#endif
