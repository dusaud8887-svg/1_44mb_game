# 30 — 기술 설계 (V2)

기술 스펙의 정본. **구현 상태·실측치는 여기 쓰지 않는다** — [90_STATUS.md](90_STATUS.md)가 정본(SPEC/STATUS 분리, V1 드리프트의 재발 방지). 스택 유지 결정의 근거는 [adr/0001-keep-win32-stack.md](adr/0001-keep-win32-stack.md), 구조 원칙 변경은 [adr/0006-multifile-savefile.md](adr/0006-multifile-savefile.md).

## 1. 스택 — 공모전판은 엔진을 교체하지 않는다

```text
공모전판     C11 + Win32 (USER32/GDI32/WINMM) + CPU 프레임버퍼 + waveOut + 60Hz 고정 틱
개발 구조    결정론 게임 코어 / 플랫폼 / 렌더 / 오디오 분리 (§4)
확장판 초기  동일 C 코어 + Sokol 프런트엔드
대형판       콘텐츠 비용이 코어 코드를 넘어설 때만 Godot/Defold 재검토
```

이유: 현 스택이 1.44MB 목표에 최적(외부 런타임 0, 크기 직접 통제)이고, **엔진 교체는 V2의 진짜 문제(손패 의사결정·카드 개성)를 하나도 해결하지 않는다.** 마이그레이션 리스크만 추가된다.

조사된 대안 요약 (상세 근거·링크는 원문 13부):

| 라이브러리 | 판단 |
|---|---|
| Sokol | 확장판 1순위 프런트엔드. 결정론 코어 유지, 플랫폼 계층만 교체 |
| raylib | 반복 속도는 좋으나 불필요 기능·바이너리 비용. 보류 |
| SDL3 | 컨트롤러·다중 플랫폼이 중요해질 때. 현재 통합 비용 큼 |
| RGFW | 현 Win32 대체 실익 작음 |
| miniaudio | 확장판 오디오 백엔드 후보. 현재 waveOut으로 충분 |
| Defold / Godot | 공모전 1.44MB 부적합. 대형판에서만 |
| LÖVE | 별도 프로토타입용 |

빌드 플래그 유지: `/O1 /GL /Gy /Gw /GS /MT /LTCG /OPT:REF /OPT:ICF`, x64, **무패킹**. 크기 게이트(1,474,560B 초과 시 빌드 실패)·DLL 의존 검사·SHA-256 유지.

## 2. 플랫폼 경계 — 게임 코어가 몰라야 하는 것

게임 코어는 `HWND`, `HDC`, `waveOut`, `GetAsyncKeyState`, `TextOutW`, `QueryPerformanceCounter`를 직접 만지지 않는다. 경계 인터페이스:

```c
void game_init(Game *game, const RunConfig *config);
void game_tick(Game *game, const InputFrame *input, GameEvents *events);
void game_make_render_snapshot(const Game *game, RenderSnapshot *out);
```

이 경계가 헤드리스 테스트(§10), 리플레이, 확장판 프런트엔드 교체(§1)를 전부 가능하게 한다.

## 3. P0 정확성 결함 — 코드 검증 완료 (2026-07-16)

원문 2부의 결함 주장을 현행 `src/echo144.c`(커밋 `25b3bb1`)와 대조 검증했다. **전부 실재한다.** V1 제출·V2 어느 경로든 최우선 수정 대상. 상태 추적은 [90_STATUS.md](90_STATUS.md) §3.

### 3-1. 이동 정수 절삭 — 방향 비대칭 (P0)

`echo144.c:734` (플레이어), `:755` (적), `:403,569` (넉백):

```c
g.px=(float)clampi((int)g.px,7,313);   /* 매 틱 소수부 절삭 */
```

플레이어 54px/s = 틱당 0.9px. 정수 좌표에서 `+0.9`는 매 틱 잘려 **오른쪽·아래로 거의 이동 불가**, `-0.9`는 내림되어 왼쪽·위로 60px/s 과속. 적(틱당 0.17~0.47px)은 접근 방향에 따라 추적 능력이 완전히 달라진다.

수정 원칙: 게임 상태 좌표는 끝까지 float(또는 고정소수점) 유지, clamp도 실수형(`clamp_f32`), **렌더링에서만 int 변환.**

필수 테스트: 60틱 RIGHT/LEFT/DOWN/UP ≈ ±54px / 8방향 거리 대칭 / 네 방향 스폰 적의 중심 도달 시간 동일 / 넉백 후 소수 좌표 보존 / 장시간 경계 이탈 없음.

### 3-2. 카드 스케줄러 — 문서 공식과 불일치 (P0)

`echo144.c:598,637-656,830`: ① 손패 교체 시 `card_ticks=SWAP(15)`가 기본 30틱을 **대체**한다 — 문서 공식(`30×N + 15×교체`)은 가산. ② `if(card_ticks>0)--; else trigger` 패턴으로 30이 실제 31틱, 15가 16틱. 이 차이는 발동량·SIGNAL 수급·SIM 기준선을 전부 바꾼다.

수정 원칙: **다음 발동 시점을 한 함수에서 명시적으로 계산** — `지연 = 교체 지연 + 활성화 지연`. "N틱"이 정확히 N틱이도록 타이머 의미론 고정. V2 규칙 번역은 [10](10_MECHANICS.md) §14-1.

| 상황 | 교체 | 활성화 | 합계 |
|---|---:|---:|---:|
| 일반 카드 | 0 | 30 | 30 |
| 손패 경계 | 15 | 30 | 45 |
| MULTI + 경계 | 15 | 0 | 15 |
| PREFETCH + 경계 | 15 | 3 | 18 |

필수 테스트: 전체 카드의 정확한 발동 tick 타임라인 단언.

### 3-3. 손패 경계 modifier·복제 의미론 (P1)

- 마지막 카드가 MULTI일 때 다음 손패 **첫** 카드가 가속되어야 한다 (구현 흐름상 둘째 카드가 가속될 수 있음).
- `MULTI→MACRO`의 거짓 `LINK!`: 복사할 payload가 없으면 LINK 아님 — **실효과 기준 판정**([10](10_MECHANICS.md) §14-4).
- MACRO 70%의 정수 내림은 4→2(=50%), 7→4(=57%)를 만든다 — **최근접 반올림·최소 1** 명시.
- PREFETCH/SEEK 재배치 후에는 다음 발동 대상을 먼저 확정하고 지연·modifier 계산.

### 3-4. 강제 상태 전환 후 같은 틱 로직 계속 실행 (P1)

강제 전환 호출 뒤 즉시 `return` 하지 않으면 같은 틱에 이전 상태의 스폰·이동·발동·게이지 변경이 실행된다. 원칙: `if (forced_transition) { start_new_state(); return; }`. 수동 전환 경로와 강제 전환 경로의 진입 직후 상태 비교 테스트.

### 3-5. GDI 텍스트 (P0/P1)

- **COLORREF 채널 순서** — `echo144.c:1568` `(COLORREF)color` 직접 캐스팅: DIB 상수는 `0x00RRGGBB`, COLORREF는 `0x00BBGGRR` — **GDI 텍스트의 R/B가 뒤집힌다.** 수정: `RGB((c>>16)&0xff,(c>>8)&0xff,c&0xff)` 변환 함수 경유.
- **비정수 배율** — `echo144.c:1857` 클라이언트 전체 `StretchBlt`: 창 리사이즈 시 픽셀 비율 파괴. 수정: `scale = max(1, min(cw/320, ch/240))` 정수 배율 + 레터박스.
- `SetBkMode(TRANSPARENT)`는 존재(:1790) — 백버퍼 DC 생성 직후 1회로 이동, `SetTextAlign(TA_LEFT|TA_TOP)` 명시.
- **시스템 폰트 의존**(GulimChe, :1896): 장기 해법은 §8 내장 비트맵 폰트. W6 영문 클린 PC 게이트 전까지 GDI 유지 가능하나 V2에서는 임베드가 정본.

### 3-6. 기타 (P1/P2 표)

| 심각도 | 영역 | 위험 | 권장 |
|---|---|---|---|
| P1 | 적 생성 | spawn 실패에도 wave 예산 소모 | 성공 시에만 차감 |
| P1 | TROJAN 분열 | 배열 순회 중 삽입 → 즉시 재피격 | 다음 틱 스폰 큐 |
| P1 | 상자 생성 | 미수집 상자가 타이머마다 이동 | 비활성일 때만 생성 |
| P1 | 초기 SIGNAL | 초기 보너스가 임계를 건너도 burst 미발동 | `add_signal()` 경로 통일 |
| P2 | 프레임 catch-up | 잔여 지연 폐기로 실시간보다 느려짐 | 시간 정의 명시 또는 accumulator 정책 |
| P2 | MIRROR 지침 | BAD가 카드 수에 포함 — 오염이 보너스 가능 | 의도 명시 |
| P2 | DEV 로그 | 경계 없는 문자열 누적 | bounded append |
| P2 | 오디오 | waveOut 실패 처리 약함 | silent mode + 정리 경로 |
| P2 | 상태 초기화 | ZeroMemory와 설정 보존 결합 | UserPrefs/RunState/PlatformState 분리 |

## 4. 코드 구조 — 단일 파일 원칙 폐기

"2,500줄 전까지 한 파일" 기준 폐기(ADR-0006). 분리 기준은 줄 수가 아니라 **변경 이유**다.

```text
src/
├─ core/       game.c deck.c cards.c combat.c intents.c finale.c story.c save.c
├─ platform/   win32.c
├─ render/     software.c sprites.c effects.c font.c
├─ audio/      synth.c
├─ generated/  cards.inc effects.inc intents.inc waves.inc strings.inc assets.inc  (콘텐츠 컴파일러 산출, §7)
├─ tests/      selftest.c strategy_bots.c simulation.c
└─ echo144_unity.c   (릴리스 unity build — 최종 translation unit은 하나 유지)
```

개발은 분리, 릴리스는 unity `#include` — 크기 최적화(/GL·ICF)와 개발 반복성을 동시에 얻는다.

## 5. 게임 이벤트 — 코어는 렌더·오디오를 호출하지 않는다

코어는 이벤트를 출력하고, 렌더·오디오가 소비한다:

```text
EVENT_CARD_SELECTED  EVENT_CARD_TRIGGERED  EVENT_CARD_CACHED  EVENT_CARD_RETURNED
EVENT_SHUFFLE        EVENT_INTENT_REVEALED EVENT_ECHO_GAINED  EVENT_ECHO_CONVERTED
EVENT_TREND_CHANGED  EVENT_RING_THRESHOLD  EVENT_OPEN_CHANNEL EVENT_ENDING_LOCKED
```

효과: 정확한 테스트(카드 타임라인 단언은 이벤트 스트림 비교) / 리플레이 / 다른 프런트엔드 / 화면-상태 결합 감소.

## 6. 효과 레시피 — 데이터화의 경계

완전한 스크립트 VM은 과하다. 반복되는 공격·이펙트만 데이터화한다:

```c
typedef struct {   /* EffectRecipe — 12B */
    uint8_t emitter, shape, count, spread;
    uint8_t speed, lifetime, damage, hit_rule;
    uint8_t color, sound, screen_fx, hook;
} EffectRecipe;

typedef struct {   /* CardDefPacked — 12B */
    uint8_t cost, baud, echo_value, type;
    uint8_t cue_cost, off_air_recipe, on_air_recipe, open_recipe;
    uint8_t tags, art_id, sound_id, hook;
} CardDefPacked;
```

- **데이터로 처리**: 탄환, 파동, 벽, 마킹, 연쇄, 잔상, 플래시, 기본 드로우·CUE.
- **전용 C 코드(hook)**: CACHE 보관, MACRO 형태 재생, PREFETCH 탐색, DEFRAG 삭제, 메아리 색 변환, TREND MIRROR, 엔딩 판정.

노아의 복제 기술은 기존 레시피에 자홍 팔레트·대상/방향 반전을 적용한 **재사용**이다 — 신규 이펙트 비용 최소화.

## 7. 빌드 타임 콘텐츠 컴파일러 + 수치 단일 원천

런타임 의존성 없이 Python을 개발 도구로 사용 (기존 `tools/` 관행의 확장):

```text
입력: content/cards.json effects.json intents.json waves.json strings.tsv  assets/px/*.px  balance.def
출력: generated/card_ids.h *.inc content_report.md (+ 20_BALANCE 표 자동 생성)
```

검증(빌드 실패 조건): 카드 ID 중복 / 비용 범위 / 레시피 참조 무결성 / 킹덤 보장 조건([20](20_BALANCE.md) B2-카드) / 아이콘 누락 / ON AIR·OFF AIR 정의 / CUE 순환 가능성 / ARCHIVE 합계 / 문자열 글리프 누락 / 콘텐츠 바이트 예산.

**balance.def — 수치의 단일 원천**: 수치가 코드·문서·테스트에 3중 기재되면 드리프트가 필연이다(V1 실증). X-매크로 한 파일에서 C 상수, 문서 표, 테스트 기대값을 생성한다:

```c
BALANCE(PLAYER_SPEED,      54)
BALANCE(CARD_NORMAL_TICKS, 30)
BALANCE(HAND_SWAP_TICKS,   15)
BALANCE(OFFLINE_SECONDS,   60)
```

## 8. 저장 파일 — "파일 I/O 없음" 폐기

해금·엔딩·기록([10](10_MECHANICS.md) §13)에 필요하다(ADR-0006). 64~256B로 충분:

```c
struct SaveData {
    uint32_t magic; uint16_t version; uint16_t checksum;
    uint32_t ending_bits, card_unlock_bits, stage_unlock_bits, challenge_bits;
    uint16_t best_time[8], best_turns[8];
    uint32_t last_daily_seed;
};
```

- 위치: 공모전판 exe 옆 `ECHO144.SAV` / 확장판 `%LOCALAPPDATA%`.
- checksum 불일치·버전 불일치 시 **조용히 새 저장으로 시작** (크래시·경고 금지 — 읽기 전용 폴더에서는 저장 없이 정상 동작). `[본 개정 구체화]` 손상 저장 감지 시 1회성 시크 대사 이스터에그: "손상된 기록은 제가 보관 중입니다."

## 9. 용량 전략

병목은 저장 용량이 아니라 객체 수·가독성·콘텐츠 생산 시간이다. 픽셀 자산의 실제 비용:

```text
16×16 2bpp 1프레임 = 64B      → 100프레임 = 6.4KB
48×48 2bpp 초상 1장 = 576B    → 20장 = 11.5KB
320×240 4bpp 키아트 = 38.4KB
8×12 1bpp 글리프 500개 ≈ 6KB
```

따라서 애니메이션 수십 프레임, 표정 초상 다수, **내장 한글 픽셀 폰트**, 카드·의도 아이콘, 팔레트 다수, 압축 키아트 1~2장이 전부 예산 안이다.

압축 우선순위: ① 비트 패킹(1/2/4bpp, 투명 인덱스, 팔레트 런타임) → ② 애니메이션 델타(기준 프레임+변경 구간) → ③ 반복 행 RLE(`[len:4][color:2]`) → ④ 자산 수백 KB 초과 시에만 블롭 압축(heatshrink / 부분 miniz — **해제 코드 포함한 최종 EXE 크기**로 판단).

**EXE 패커(UPX 등) 영구 불채택**: 용량 여유 + SmartScreen/Defender 신뢰성 + 크래시 분석. `내부 자산 데이터 압축 가능, 최종 EXE 무패킹`.

절차적 시각 효과(자산 0B — 뱀서 후반 쾌감의 핵심): 원형 파동, 호·링, 빔, 사각 프레임 절단, 파편, 잔상, 팔레트 반전, 행 단위 수평 오프셋, 노드 연결선, 공전 카드, 프로필 썸네일 군집, 화면 가장자리 압박, 자홍 복제.

### 내장 비트맵 폰트

`8×12(또는 8×14) 1bpp / ASCII 전체 + 게임에서 쓰는 한글 음절만 / 문장은 글리프 ID 배열`. 효과: 시스템 폰트 의존 제거(§3-5), 픽셀 일관성, `TextOutW`·`CreateFontW` 제거, 색·배경·DPI 문제 소멸. 글리프 subset 추출은 콘텐츠 컴파일러(§7)가 문자열 테이블에서 자동 수집 — 누락 글리프는 빌드 실패.

## 10. 결정론과 테스트

- `QueryPerformanceCounter` 고정 60Hz 유지. RNG는 시드 저장 xorshift32 — **전투·상점·연출 스트림 분리**는 확장판(리플레이 공유·온라인 검증)에서, 고정소수점(24.8 좌표/16.16 속도/256단계 각도)도 그때 검토. 지금의 우선순위는 선택 구조와 카드 개성이다.
- 테스트 계층: 커밋(셀프테스트+SIM 30시드) / 릴리스(1,000+런) / 사람(5명) — [20](20_BALANCE.md) §SIM.

V1 하니스가 이미 커버하는 것(결정론 리플레이, 덱 불변식, 풀런, 경계값)은 유지하고, **빠져 있던 핵심 테스트**를 추가한다:

| 테스트 | 검증 내용 |
|---|---|
| 이동 대칭성 | 좌우상하·대각선 60틱 거리 (§3-1) |
| 적 접근 대칭성 | 네 방향 스폰 도달 시간 |
| 카드 이벤트 타임라인 | 모든 카드의 정확한 발동 tick (§3-2, 이벤트 스트림 비교) |
| 손패 경계 modifier | 마지막 MULTI·PREFETCH·SEEK 조합 (§3-3) |
| LINK 음성 테스트 | payload 없으면 LINK 없음 |
| 상태 전이 | 전환 뒤 이전 상태 부작용 0 (§3-4) |
| 링 임계·전환 | 초기 보너스 다중 임계, 색 전환 틱당 1회 |
| 렌더 smoke | 텍스트 색(R/B), 배경 모드, 정수 배율 |
| 오디오 실패 주입 | waveOut 실패 시 무음 지속 |
| 배열 상한 | 적·탄·이펙트 최대치 정책 |
| 저장 손상 | checksum 불일치 → 새 저장, 읽기 전용 폴더 무저장 동작 |

## 11. 빌드 시스템 개선

`vswhere.exe` VS 탐색 / `clean`·`help`를 툴체인 검사 전에 처리 / 알 수 없는 인자 즉시 실패 / `release`·`test`·`size`·`package` 분리 / MSVC 버전·Git commit 기록 / linker map + `.text/.rdata/.data/.rsrc` 크기 보고 / GitHub Actions `windows-latest`에서 EXE·SHA-256·크기 보고서 릴리스 / LICENSE 명시.

검증 이중화: `MSVC = 공식 릴리스·크기 기준` / `clang-cl = 경고·UB·ASan 개발 검사`.

## 12. 릴리스 체크리스트 (제출 전)

1. `build.bat test` PASS → `build.bat` 크기·의존·SHA256 기록.
2. VC++ 재배포 없는 클린 Windows 10/11 두 대(한국어 1, 영문 1)에서 실행 — 내장 폰트 채택 시 언어팩 게이트는 렌더 검증으로 대체.
3. 한글·공백 경로, 읽기 전용 폴더(저장 무시 동작), 네트워크 차단, 오디오 장치 없음, 포커스 전환, Alt+F4.
4. Defender 빠른 검사 — 탐지 시 패커류 우회가 아니라 코드 원인 제거.
5. 제출 폼 업로드→다운로드→재실행 드라이런.
