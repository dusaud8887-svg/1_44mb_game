# 60 — 신호 경제 + 연쇄 공명 (도미니언×뱀서 융합 정본)

**이 문서는 ON AIR 전투와 덱빌딩 경제를 하나로 묶는 융합 루프의 설계 정본이다.** 기존 [10_MECHANICS](10_MECHANICS.md)의 4-태그 학파 전투([10](10_MECHANICS.md) §4, [15](15_CARDS.md) §9)를 확장해, "덱을 사면 마지막 60초뿐 아니라 매 구절의 전투·경제가 바뀐다"는 약속을 완성한다. 수치의 기계적 정본은 [`content/balance.def`](../content/balance.def) `B3-융합` 블록이며, 이 문서는 그 의도·인과·레퍼런스 매핑을 사람이 읽는 정본이다.

> **레퍼런스 정본 주의** — 이 설계는 `docs/36_DOMINION_DEEP_RESEARCH`, `docs/37_VAMPIRE_SURVIVORS_HOLOCURE_RESEARCH`, `docs/38_DOMINION_DIGITAL_IMPLEMENTATION_RESEARCH`, `docs/reference-source/`의 심층 조사를 반영하도록 의도됐다. **이 원본들은 아직 리포지토리에 커밋되지 않았다**(로컬 `D:\` 사본만 존재). 본 개정은 도미니언과 뱀파이어 서바이버즈/홀로큐어에 대한 일반적 설계 지식으로 작성했으며, 원본이 push되면 수치·명칭을 정밀 정합한다.

## 1. 왜 — 두 절반을 하나로

| 절반 | 레퍼런스 | 기존 구현 | 공백 |
|---|---|---|---|
| **덱빌딩(main)** | 도미니언 | EDIT 편성·BREAK 상점·킹덤 5종·정리/거래 | 경제(BAUD)가 오직 수신(RX) 반송파에서만 나온다 — 전투를 잘해도 살 돈이 늘지 않음 |
| **서바이버(sub)** | 뱀서/홀로큐어 | ON AIR 자동사격·4학파 전투 정체성 | 처치 자체에 순간 보상이 없다 — 킬 체인·수집의 손맛이 없음 |

**융합 루프**: 전투로 번 것이 덱을 사고, 덱이 전투의 형태를 다시 바꾼다.

```
 ON AIR 처치 ──▶ 신호 조각 드롭 ──▶ (이동으로 수집) ──▶ 신호 은행
      │                                                      │
      └─▶ 연쇄(combo) +1 ──▶ 프로그램 배율↑, 조각 가치↑        ▼
                                                      end_air: 신호→BAUD
                                                      큰 연쇄→다음 편성 +1
                                                              │
                                                              ▼
                                                        BREAK 상점 구매
                                                              │
                                                     덱 태그 학파가 전투·수집·연쇄를 재구성 ◀┘
```

## 2. 무엇 — 세 가지 기계

### 2.1 신호 조각 (Signal shards) — 뱀서 젬 → 도미니언 코인
- ON AIR에서 적을 **처치**하면 그 자리에 신호 조각이 드롭된다(`on_enemy_killed`). OPEN CHANNEL·EDIT 등 다른 모드의 처치는 드롭하지 않는다 — 최종 링 계산을 오염시키지 않기 위함.
- 플레이어 **근접**으로 수집한다(`pickup_magnet` 반경). 자석 반경의 `PICKUP_ATTRACT_MUL`배 안에 들어온 조각은 플레이어 쪽으로 빨려온다(뱀서 자석).
- 조각 가치(`worth`)는 **드롭 순간의 연쇄 티어**로 고정된다 — 체인이 높을수록 떨어지는 조각이 더 값지다.
- 수집분은 그 구절의 **신호 은행**(`g.signal`)에 쌓이고, `end_air`에서 BAUD로 환산된다: `bonus = min(signal / SIGNAL_PER_BAUD, SIGNAL_BAUD_CAP)`. 상한으로 폭주를 막는다.

### 2.2 연쇄 공명 (Combo resonance) — 홀로큐어/뱀서 킬 체인
- 처치마다 `g.combo` +1, 창(`combo_ticks`)이 리셋된다. 창이 소진되면 연쇄는 0으로 붕괴.
- 티어 = `combo / COMBO_TIER_STEP` (상한 `COMBO_TIER_MAX`). 티어가:
  - **프로그램 배율**을 올린다(`execute_program_scaled`): `+combo_tier × (COMBO_SCALE_PER_TIER + REPEAT_COMBO_PER_TIER × repeat티어)%`. 기존 동조(SYNC) +10%와 곱연산.
  - **조각 가치**를 올린다(2.1).
- **피격은 체인을 끊는다**(뱀서식 리스크): `damage_player`에서 연쇄 0. 단 SAFE 학파 티어≥1이면 절반만 깎인다.
- **VS→도미니언 페이오프**: 한 구절의 최고 연쇄(`combo_best`)가 `COMBO_CUE_KILLS` 이상이면 다음 EDIT에서 **편성 +1**(도미니언 +액션에 해당). 전투 기량이 덱빌딩 템포를 산다.

### 2.3 덱이 융합을 재구성 — 4학파 경제·연쇄 정체성 (도미니언 아키타입)
기존 전투 정체성([10](10_MECHANICS.md) §4)에 경제·연쇄 정체성을 겹쳐, "무엇을 사느냐"가 경제와 체인까지 바꾼다.

| 학파 | 태그 카드 | 기존 전투 | **추가 융합 정체성** |
|---|---|---|---|
| 확산 NETWORK | 표식·폭주 | 주변 다수 타격 | **자석 반경↑** (`NETWORK_MAGNET_PER_TIER`) — 흩어진 처치의 신호를 넓게 흡수 |
| 다발 REPEAT | 분기·저장 | 대상 다발사격 | **연쇄 배율↑** (`REPEAT_COMBO_PER_TIER`) — 같은 체인이 더 큰 프로그램 배율로 |
| 연사 REPLAY | 반복·예독 | 재장전↑·관통 | **연쇄 창↑** (`REPLAY_COMBO_WINDOW_PER_TIER`) — 체인을 더 오래 유지 |
| 내성 SAFE | 방벽·검사 | 무적 시간↑ | **연쇄 방어** — 피격해도 체인 절반 유지 |

## 3. 수치 (`content/balance.def` `B3-융합`)

| 상수 | 값 | 의미 |
|---|---:|---|
| `PICKUP_LIFE_TICKS` | 600 | 조각이 사라지기까지(~10초) |
| `PICKUP_MAGNET_BASE` | 16 | 수집 반경(px) |
| `NETWORK_MAGNET_PER_TIER` | 9 | 확산 학파 반경 증가 |
| `PICKUP_ATTRACT_MUL` | 3 | 자석 흡인 반경 배수 |
| `SIGNAL_PER_BAUD` | 5 | 신호 5 = BAUD +1 |
| `SIGNAL_BAUD_CAP` | 3 | 구절당 전투 자금 상한 |
| `COMBO_DECAY_TICKS` | 84 | 체인 창(무처치 시) |
| `REPLAY_COMBO_WINDOW_PER_TIER` | 30 | 연사 학파 창 연장 |
| `COMBO_TIER_STEP` | 4 | 티어당 처치 수 |
| `COMBO_TIER_MAX` | 4 | 최대 티어 |
| `COMBO_SCALE_PER_TIER` | 8 | 티어당 프로그램 배율 % |
| `REPEAT_COMBO_PER_TIER` | 3 | 다발 학파 배율 가산 |
| `COMBO_CUE_KILLS` | 9 | 이 이상 최고 연쇄 → 다음 편성 +1 |

**모든 값은 `[시드값]`** — SIM·플레이테스트로 조정한다.

## 4. 밸런스 검증 (자동 게이트)

1000시드 SIM에서 융합 도입 후에도 정본 불변식이 모두 유지된다(어느 정책도 지배하지 않음, 방어 정책 생존 우위 유지):

| 정책 | 융합 전 승 | 융합 후 승 (1000시드) |
|---|---:|---:|
| BIG_BAUD | 6/30 | **300/1000** (전투 자금으로 상향) |
| LOOP_ENGINE | 26/30 | 904/1000 |
| ECHO_RUSH | 26/30 | 863/1000 |
| CLEAN_SIGNAL | 0/30 | 7/1000 (여전히 방어·저속) |
| CACHE_COMBO | 26/30 | 894/1000 |
| PERFECT_SHOW | 19/30 | 770/1000 |
| THREE_WAY | 30/30 | 1000/1000 |

- `test_signal_combo` — 드롭·수집·붕괴·티어 배율·피격 붕괴·SAFE 절반·NETWORK 자석·신호→BAUD·연쇄→편성·상한을 회귀 고정.
- 4학파 전투 다양성(`test_combat_diversity`)·피격 생존 순서(`test_mortal_strategy_sim`)는 반송파를 건드리지 않아 불변.

## 5. 연출 (render.c)
- **draw_world**: 신호 조각을 호박색(가치>1은 자홍) 점으로.
- **draw_air**: 상단 중앙에 `연쇄x{n}` + 티어 핍, `신호{n}` 은행량.
- **draw_break**: `신호+{n}` — 이번 구절 전투가 번 BAUD.

## 6. 미구현 스펙 — 새 킹덤 카드 (아트 파이프라인 의존)
사용자가 요청한 "더 많은 왕국 카드"는 카드 아이콘 스트립이 정확히 13종으로 고정(`tools/build_art.py` `range(13)` + 고유성 assert)이라, 새 `Card` 항목마다 아트 파이프라인 변경이 필요하다. 리눅스 CI에서 아트 빌드를 검증할 수 없어 이번 패스에서는 **기계만** 구현하고 카드는 스펙으로 남긴다. 융합 루프를 전제로 한 후보:

| 후보 카드 | 학파 | 효과 초안 | 융합 상호작용 |
|---|---|---|---|
| **증폭기 AMP** | REPEAT | 이번 구절 조각 가치 +1 | 연쇄·경제 동시 가속 |
| **자기장 MAGNET** | NETWORK | 자석 반경 대폭↑ 1구절 | 흩뿌린 처치 회수 |
| **정지 FREEZE** | SAFE | 피격 시 연쇄 유지 1회 | 체인 보험 |
| **오버클럭 O.C.** | REPLAY | 연쇄 창 2배 30틱 | 롱 체인 빌드 |
| **환류 FEEDBACK** | 엔진 | 신호 10 소모 → 편성 +1 즉시 | 경제→템포 명시 변환 |

착수 시: `Card` enum + `CARD_DEF` + `balance.def` 비용 + `build_art.py` 아이콘(kind 13+) + 킹덤 풀 + `card_hint` + 회귀 테스트.

## 7. 관련 문서
- [10_MECHANICS](10_MECHANICS.md) §4 (4학파 전투), §8 (링/경제)
- [15_CARDS](15_CARDS.md) §9 (최종 컴파일)
- [20_BALANCE](20_BALANCE.md) `B3-융합`
- [90_STATUS](90_STATUS.md) (구현 상태)
- [CHANGELOG](CHANGELOG.md)
