#ifndef ECHO144_GAME_H
#define ECHO144_GAME_H

#define SCREEN_W 400
#define SCREEN_H 240
#define ARENA_TOP 16
#define ARENA_BOTTOM 208
#define TICK_HZ 60
#define MAX_DECK 40
#define MAX_ENEMIES 96
#define MAX_BULLETS 192
#define MAX_PICKUPS 64
#define HAND_SIZE 5
#define QUEUE_SIZE 5

typedef uint8_t CardId;
typedef enum { TITLE, EDIT, ON_AIR, BREAK, OPEN_CHANNEL, RESULT } Mode;
typedef enum { CARRIER, PROGRAM, ARCHIVE, NOISE } CardType;
typedef enum { CARD_2400, CARD_14K, CARD_MULTI, CARD_CACHE, CARD_FIREWALL,
               CARD_MACRO, CARD_PREFETCH, CARD_MARKER, CARD_SURGE, CARD_CHECKSUM,
               CARD_CHAT, CARD_VOICE, CARD_NOISE, CARD_COUNT } Card;
typedef enum { BOT_RAID, MUTE, GIFT_DROP, COMMENT_WALL, MIRROR, CLIP_THEFT, TREND, INTENT_COUNT } Intent;
typedef enum { BOT_CHAT, POP_AD, SPON_GIFT, MOD_MASK, BUF_WORM } EnemyType;
typedef enum { ECHO_EMPTY, ECHO_LIVE, ECHO_ARCHIVED, ECHO_MIMICKED } EchoState;
typedef enum { FORM_CHATSTORM, FORM_RESONANCE, FORM_OPEN_ECHO } FinalForm;
typedef enum { MOD_REPEAT, MOD_NETWORK, MOD_SAFE, MOD_REPLAY } FinalModifier;
typedef enum { END_OPEN_CHANNEL, END_LAST_ARCHIVE, END_PERFECT_AUDIENCE, END_UNRESOLVED_ECHO } Ending;
typedef enum { RESULT_NONE, RESULT_TWO_WAY, RESULT_STREAM_LOST, RESULT_OFFLINE } ResultReason;

typedef struct {
    const wchar_t *name, *short_name;
    uint8_t type, cost, baud, echo;
} CardDef;

typedef struct { uint8_t origin, state; } EchoCell;
typedef struct {
    float x, y, vx, vy;
    int16_t hp;
    uint16_t fire, marked;
    uint8_t type, active;
} Enemy;
typedef struct {
    float x, y, vx, vy;
    int16_t damage, life;
    uint8_t hostile, active, hits;
} Bullet;
/* Signal shard: dropped by a kill during ON AIR (VS-style pickup), collected by proximity,
   banked into baud at the shop. worth = per-shard value frozen at drop by the combo tier. */
typedef struct { float x, y; uint16_t life; uint8_t active, worth; } Pickup;
typedef struct {
    CardId draw[MAX_DECK], discard[MAX_DECK], hand[HAND_SIZE];
    uint8_t draw_n, discard_n, hand_n;
} Deck;

typedef struct {
    Mode mode;
    uint32_t seed, deck_rng, encounter_rng, reward_rng;
    bool running, muted, low_fx, paused, won, seek_used, turn_hit, program_fired, defrag_mode, trade_mode, cache_mode, prefetch_mode, today, save_corrupt;
    bool contract_used, seek_path_used;
    uint8_t turn, hp, sync, cursor, cue, queue_n, queue_at, shop_cursor;
    uint8_t carrier_rx[HAND_SIZE], selected[HAND_SIZE], queue[QUEUE_SIZE], queue_scale[QUEUE_SIZE];
    uint8_t program_uses[CARD_COUNT], trend_card, intent, intent_deck[12], kingdom[5];
    uint8_t contract_boost, contract_applied, new_card, new_ticks, cached_card, cached_ready_slot, cache_slot, open_sequence_at, last_program, stolen_card, stolen_program, effect_card, mirror_card;
    uint8_t final_form, final_modifier, final_power, ending, result_reason, ring_threshold, threshold_seen, firewall_open_dir, seek_interventions;
    uint8_t prefetch_cards[3], prefetch_n, prefetch_cursor, prefetch_slot;
    uint8_t cards_bought[CARD_COUNT], cards_fired[CARD_COUNT], cards_cued[CARD_COUNT];
    uint8_t program_recent[6][CARD_COUNT];
    int phase_ticks, carrier_ticks, queue_delay_ticks, auto_fire_ticks, open_ticks, open_card_ticks, protocol_ticks, protocol_replay_ticks, victory_ticks, threshold_ticks, seek_ticks;
    int invuln_ticks, echo_convert_ticks, firewall_ticks, flash_ticks, shake_ticks, message_ticks, mirror_label_ticks;
    int baud, mirror_ticks, surge_ticks, effect_ticks, anim_ticks, echo_total, echo_live, echo_archived, echo_mimicked;
    float px, py, last_dx, last_dy, spawn_budget;
    /* Signal economy + combo resonance (docs 60): the ON AIR combat<->deck economy loop. */
    uint8_t combo, combo_best, bonus_cue;
    int combo_ticks, signal, signal_baud, resonance_ticks;
    Deck deck;
    EchoCell ring[64];
    Enemy enemies[MAX_ENEMIES];
    Bullet bullets[MAX_BULLETS];
    Pickup pickups[MAX_PICKUPS];
} Game;

extern Game g;
extern const CardDef CARD_DEF[CARD_COUNT];
void game_start(uint32_t seed);
void game_tick(void);
void game_press(int key);
void game_hold(int key, bool down);
int deck_count(CardId id);
const wchar_t *intent_name(uint8_t intent);
const wchar_t *ending_name(uint8_t ending);
const wchar_t *result_reason_name(uint8_t reason);
const wchar_t *final_form_name(uint8_t form);
const wchar_t *final_modifier_name(uint8_t modifier);
uint8_t program_modifier(CardId id);
int program_modifier_count(uint8_t modifier);
int combat_tier(uint8_t modifier);
int combo_tier(void);
int pickup_magnet(void);
int final_protocol_cooldown(void);

#endif
