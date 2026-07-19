# 20 — 밸런스 데이터 (V2 설계 정본)

**수치의 기계적 단일 정본은 이 문서가 아니라 `content/balance.def`다**([30](30_TECH.md) §7 — 아직 미착수, [90](90_STATUS.md) 참조) — 손으로 수치를 고치는 곳은 balance.def 하나뿐이며, `generated/balance.h`·`balance_test.inc`·`docs/20_BALANCE.generated.md`는 거기서 자동 생성된다. 이 문서(`20_BALANCE.md`)는 **그 값들의 설계 의도·이유·상호 관계를 사람이 읽는 정본**이다 — 숫자가 왜 그 값인지, 무엇과 무엇이 서로를 견제하는지를 설명한다. 수치 변경 절차는 §"튜닝 절차" 참조. **여기의 값 대부분은 `[시드값]`** — 원문이 수치를 확정하지 않아 본 개정에서 자기일관적으로 설계한 초기값이며, SIM·플레이테스트로 조정한다. V1 수치 정본은 [archive/v1-last-live/20_BALANCE.md](archive/v1-last-live/20_BALANCE.md)에 동결.

## B2-턴 · 시간

| 항목 | 값 |
|---|---:|
| 일반 방송 턴 수 | 12 (강제 OPEN CHANNEL) |
| 조기 OPEN CHANNEL | 8턴 종료 후의 BREAK부터 |
| EDIT | 완전 정지 (기본) / 숙련 옵션: 8초 제한 + 25% 슬로모션 |
| EDIT 무입력 자동 추천 | 10초 |
| PROGRAM 발동 이름 표시 | 1초 |
| 구매 카드 첫 귀환 강조 | 3초 |
| 첫 구절 응답 보너스 | BAUD +1 — 송신1/수신1 추천을 따르면 첫 BREAK에서 CHAT 구매 가능 |
| 결과 화면 입력 보호 | 0.5초 (전투 이동 입력의 재시작 오인 방지) |
| ON AIR | 8.0초 (480틱 @60Hz) |
| OPEN CHANNEL (OFFLINE 타이머) | 60초 |
| OC 카드 간격 / 손패 교체 | 0.50초 / 0.25초 |
| 셔플 정지 (인지 박자) | 0.3초 |
| 목표 런 길이 | 5~7분 |

## B2-시작 · 덱

| 항목 | 값 |
|---|---:|
| HP / 피격 무적 | 5 / 0.8초 |
| 시작 덱 `[본 개정 구체화 — 정규화 패스]` | `2400.MODEM ×6, CHAT.LOG ×2, FIREWALL.FRAME ×1, MULTI.FORK ×1` (10장) — PROGRAM 2종을 시작부터 쥐어 줘야 1~2턴 튜토리얼이 "카드가 없어서 못 가르치는" 상황을 피한다 |
| 첫 런 첫 손패 `[본 개정 구체화]` | 셔플 이전 고정 배치: `2400 / 2400 / FIREWALL / CHAT / MULTI` — [10](10_MECHANICS.md) §11 스테이지 플로우 1~2턴 참조. 이후 손패부터는 정상 셔플 |
| CUE / 턴 | 1 |
| SEEK / 턴 | 1 (미사용 1장을 덱 아래로 + 1장 드로우) |
| 덱 최소 / 최대 | 5 / 40장 |
| NOISE 상한 / 오염 면역 | 5장 / 4초 |
| 이동 속도 | 54 px/s (float 유지 — [30](30_TECH.md) §3-1) |
| 플레이어 히트박스 | 6×7 (보이는 몸 ≈18×21, [45](45_UI_UX.md) §7) |
| 구매 / BREAK | 1회, BAUD 이월 없음 (매 턴 BREAK — 2구절 A/B는 [10](10_MECHANICS.md) §16-17) |
| CARRIER TX/RX | 매 턴 카드별 지정. TX = 공격만 / RX = BAUD만. 첫 구절 송신1/수신1 기본값, 이후 직접 지정 |

## B2-SYNC `[시드값]`

| 항목 | 값 |
|---|---|
| 범위 | 0~3, 시작 0 |
| 상승 (+1) | 피격 없는 구절 종료 / 예고 의도 적합 프로그램 / 마킹 연쇄 제거 / 타이밍 창 발동 |
| 하락 (−1, 피격당 최대 1) | 큰 피해 / CUE 미사용 종료 / MUTE 봉인 / 가짜 메아리 수용 |
| 회복 | 피격 후 다음 구절 첫 성공 시 즉시 +1 |
| 효과 | 0 기본 / 1 CARRIER 연출 강화 / 2 프로그램 범위·지속 +10% / 3 구절 종료 시 CUE 환급 25% 확률 또는 쿨다운 단축 — **SYNC는 링을 올리지 않는다**([10](10_MECHANICS.md) §3) |
| 안전장치 | SYNC 0에서 추가 감소 없음, HP·BAUD 직접 감소 없음, 엔딩 조건 무관 |

## B2-카드 — 기본 공급

| 카드 | 타입 | 가격 | RX BAUD | CUE | ECHO | TX 효과 (자동) |
|---|---|---:|---:|---:|---:|---|
| 2400 MODEM | CARRIER | 시작 전용 | 1 | 0 | 0 | 패킷 1발, 피해 6, 주기 0.8초 |
| 14K TURBO | CARRIER | 3 | 2 | 0 | 0 | 패킷 열, 피해 9, 2체 관통, 주기 0.8초 |
| 56K MAXIMUM | CARRIER | 6 | 3 | 0 | 0 | 최근접 2체 지속 회선 0.6초, 초당 12, 재접속 1회, 주기 1.2초 |
| CHAT.LOG | ARCHIVE | 2 | 0 | — | 1 | OC: 글리프 군집, 반경 14에 12 피해 |
| VOICE.OGG | ARCHIVE | 5 | 0 | — | 3 | OC: 동심원 음파, 반경 28에 28 피해 + 밀어냄 |
| CLIP.20?? | ARCHIVE | 7 | 0 | — | 6 | OC: 프레임 절단, 전 화면 30 + 히트스톱 0.1초 |
| NOISE (BAD) | NOISE | 불가 | 0 | — | 0 | 발동 불가, 슬롯 점유 |
| PATCH.TMP | 특수 | 불가 | 0 | 0 | 0 | 전 화면 24 후 자기 폐기 |

ECHO = OPEN CHANNEL에서 실물 발동 시 점등하는 청록 칸 수. V1의 SIG 값과 동일하게 유지 — 검산 기준점 승계 목적.

## B2-카드 — 킹덤 PROGRAM 8종 풀 (세션당 5종)

| 카드 | phase | 가격 | CUE | ON AIR (수동) | OFF AIR (미선택) |
|---|---|---:|---:|---|---|
| MULTI.FORK `[정규화 패스: phase 정정]` | `EDIT_IMMEDIATE` | 3 | 1(CUE +2 수령, 순증 +1) | 없음 — EDIT 안에서 즉시 해소, 다음 PROGRAM 연속 편성 가능 | 해당 없음 |
| CACHE.RAM `[정규화 패스]` | `EDIT_IMMEDIATE` | 3 | 1 | 없음 — EDIT 안에서 즉시 해소: 1장 보관 + 1장 드로우, 보관 카드 다음 EDIT 첫 발동 150% | 해당 없음 |
| MACRO.REC | `ON_AIR_ACTIVE` | 4 | 1 | 직전 수동 PROGRAM 형태 전체 70% 재생 (최근접 반올림, 최소 1) | 직전 CARRIER 잔상 재생 |
| FIREWALL.FRAME | `ON_AIR_ACTIVE` | 3 | 1 | 3면 벽 2.5초, 적탄 차단 | — |
| PREFETCH `[정규화 패스]` | `EDIT_IMMEDIATE` | 2 | 1 | 없음 — EDIT 안에서 즉시 해소: 덱 위 3장 중 1장 선택. ARCHIVE 선택 시 예고 효과 25% | 해당 없음 |
| MARKER.TAG `[정규화 패스: phase 분리]` | `EDIT_IMMEDIATE`(드로우) + `ON_AIR_ACTIVE`(표식) | 4 | 1 | EDIT: CUE 시 즉시 1장 드로우(선택 무관). ON AIR: 최근접 5체 태그 4초(피해 +50%) | 최근접 1체 태그(드로우는 그대로 발생) |
| SURGE.NET | `ON_AIR_ACTIVE` | 5 | 1 | 태그 적 연결 회선 3초, 초당 8, 최대 4체. 무태그 시 최근접 3체 | 태그 1 소모, 낙뢰 10 |
| CHECKSUM | `ON_AIR_ACTIVE` | 2 | 1 | NOISE 1 비활성 또는 자홍 1→청록(`origin=REAL` 제약, [10](10_MECHANICS.md) §8). 없으면 다음 2카드 안정화 | — |

킹덤 보장 조건: 페이로드형(MACRO/SURGE/MARKER/FIREWALL) ≥2, 엔진형(MULTI/CACHE/PREFETCH) ≥1, 정화형(CHECKSUM/FIREWALL) ≥1. 유효 마스크는 코드 생성 시 콘텐츠 컴파일러가 검증([30](30_TECH.md) §7).

## B2-카드 — SERVICE · CONTRACT · 시크 거래

`[본 개정 구체화 — 정규화 패스: 즉시 효과 → 계약 타이밍]` CONTRACT(구 SPONSOR)는 구매 즉시 발동하지 않는다. `BREAK_CONTRACT` phase([10](10_MECHANICS.md) §14) — 구매 시 계약이 확정되고, 명시된 다음 페이즈 1회에 발동한다.

| 항목 | 비용 | 계약(구매 시 확정) | 발동 시점 | 메아리 |
|---|---:|---|---|---|
| DEFRAG (SERVICE) | 구매 1회 소비 | 카드 1장 영구 삭제. ESC 취소 가능(구매 미소비) | 구매 즉시(SERVICE는 계약이 아니다) | NOISE 삭제 시 청록 +1 |
| NØA BOOST | 0 | 다음 EDIT의 CUE +1 | 다음 EDIT 시작 시 1회 | 자홍 +2 |
| AUTO CHAT | 1 | 다음 턴 지정 CARRIER 1장이 TX+RX 동시 적용 | 다음 턴 EDIT에서 지정 확정 시 1회 | 자홍 +1 |
| PERFECT CUT | 2 | 화면 적탄 전부 삭제 + 넉백 24 | 다음 ON AIR 시작 시 1회 | 자홍 +2, 직전 PROGRAM 복제 목록 등록 |
| RECOMMEND | 1 | 지정 PROGRAM −2 할인 | 다음 BREAK 상점에서 적용 | 그 카드 TREND 등록 |
| 시크 거래 (TRADE) | 구매 1회 소비 | 카드 1장 영구 보관 (덱 압축, 엔딩 흔적) | 구매 즉시(TRADE도 계약이 아니다) | 호박 +2 |

CONTRACT 등장: 5턴부터 BREAK마다 1종 `[시드값]`, TREND 카드와 중복 금지. 시크 거래: 7턴(엘리트) 이후.

## B2-링 — 64칸 수급과 엔딩 판정

`[본 개정 구체화 — 정규화 패스]` 각 칸은 `EchoCell{origin, state}`([10](10_MECHANICS.md) §8)다. 아래 표의 "변화"는 신규 점등(빈 칸 채움)과 색 전환(기존 칸의 `state` 덮어씀)을 구분해 표기한다 — 이 구분이 16칸 상한·복구 규칙의 근거다.

### 일반 방송 (신규 점등 합계 상한 16)

| 원인 | EchoCell 변화 | 종류 |
|---|---|---|
| NØA CONTRACT 발동·사용 | `{SYNTHETIC, MIMICKED}` 신규 점등(자홍 +, 빈 칸에만) | 신규 점등 |
| 시크 거래 | `{REAL, ARCHIVED}` 신규 점등(호박 +2) | 신규 점등 |
| 시크 엘리트: 탈취 방치(격퇴 실패) | 기존 청록/ARCHIVE 근거 칸의 `state`를 `ARCHIVED`로(호박 전환) | 색 전환(칸 수 불변) |
| 시크 엘리트 격퇴 | 훔친 것 반환 + `{REAL, LIVE}` 신규 점등(청록 +1) | 신규 점등 |
| DEFRAG로 NOISE 삭제 | `origin=REAL`이며 `state≠LIVE`인 칸 1개를 `LIVE`로(청록 +1) — **가려진 실제 흔적만 복구, 새 칸을 만들지 않는다** | 색 전환(칸 수 불변) |

**16칸 상한은 신규 점등에만 적용된다.** 16개가 이미 점등된 뒤 신규 점등 조건이 다시 충족되면 초과분은 소실(오류 아님, 조용히 버림). 색 전환 행(방치·DEFRAG)은 칸 수를 늘리지 않으므로 상한과 무관하게 항상 적용된다.

### OPEN CHANNEL

| 원인 | EchoCell 변화 | 제한 |
|---|---|---|
| ARCHIVE 실물 발동 | `{REAL, LIVE}` 신규 점등(청록 +ECHO) | — |
| 노아 공격 적중 (피격) | 기존 `{*, LIVE}` 칸의 `state`를 `MIMICKED`로(청록 → 자홍). `origin`은 유지 | 쿨다운 5초 |
| 시크 케이블 개입 | 기존 `{*, LIVE}` 칸의 `state`를 `ARCHIVED`로(청록 → 호박). `origin`은 유지 | 최대 3회/OC |
| CHECKSUM | `origin=REAL`이며 `state=MIMICKED`인 칸만 `LIVE`로(자홍 → 청록). `origin=SYNTHETIC`(CONTRACT가 만든 순수 합성 자홍)은 대상 아님 | 발동당 1 |
| 재송출 PROGRAM(P1+) | `origin=REAL`이며 `state=ARCHIVED`인 칸만 `LIVE`로(호박 → 청록) | 발동당 1 |
| 색 전환 공통 | — | 틱당 소스별 1회 |

### 위상 임계 (수치 이득 없음, 위상 연출만 — [10](10_MECHANICS.md) §10)

`16 FIRST REPLY / 32 CROSS CHAT / 48 MASK BREAK / 64 TWO-WAY`. 한 발동이 여러 임계를 넘으면 낮은 순서로 각 1회.

### 엔딩 판정 (64 도달 시, 위에서부터 우선)

| 순위 | 엔딩 | 조건 |
|---:|---|---|
| 1 | UNRESOLVED ECHO | 세 색 각 ≥12 그리고 max−min ≤8, 그리고 런 중 세 경로 카드(ARCHIVE/시크·CACHE/CONTRACT) 각 1회 이상 사용 |
| 2 | PERFECT AUDIENCE | 자홍 ≥24 |
| 3 | LAST ARCHIVE | 호박 ≥24 |
| 4 | OPEN CHANNEL | 그 외 (청록 우세) |

실패: HP 0 `STREAM LOST` / OFFLINE `CHANNEL CLOSED` + 그 시점 우세 색의 마지막 문장.

## B2-공식 — 메아리 예상 모델 `[본 개정 구체화 — 정규화 패스: 컴파일 모델로 재계산]`

§10(OPEN CHANNEL 컴파일 모델, [10](10_MECHANICS.md) §10)에서 순환하는 것은 **덱 전체가 아니라 CARRIER + ARCHIVE뿐**이다 — PROGRAM은 컴파일 시 패시브 modifier로 등록되고 순환 큐에 남지 않는다. 예전 공식이 "덱 장수"를 그대로 썼던 것은 개별 카드 재선택 모델(폐기됨)의 잔재였다.

HUD `예상 ≥N/64`는 보수 계산으로 표시한다 (전환 손실·시크/노아 개입 제외 — 실제는 다를 수 있음을 `≥`로 표기):

```text
순환 카드 수 = CARRIER 장수 + ARCHIVE 장수   (PROGRAM·NOISE는 제외)
OC 순환 시간 = 0.50초 × 순환 카드 수 + 0.25초 × ceil(순환 카드 수 / 5)
예상 청록   = 현재 청록 + floor(60 / 순환 시간) × 덱 ECHO 합

컴파일 강도 P = 최다 PROGRAM 태그 장수 (최소 1, 속도 계산 상한 5)
REPEAT 추가 ECHO = ceil(카드 ECHO × (P−1) / 3), P≥2
NETWORK 카드 간격 = 0.50초 × 4 / (P+3), P≥2
최종 프로토콜 쿨다운 = 3.0초 × 4 / (P+3), SYNC 3이면 다시 ×0.75
```

**검산 기준점 (정규화 패스에서 재계산 — V1 승계값 30/54는 폐기)**: 시작 덱(§"B2-시작") = `2400×6 + CHAT×2 + FIREWALL×1 + MULTI×1`, 순환 대상은 CARRIER 6 + ARCHIVE(CHAT) 2 = **8장**(ECHO 합 2) → 순환 시간 0.50×8 + 0.25×ceil(8/5) = 4.5초 → floor(60/4.5) = 13순환 × ECHO합 2 = **26**. 시작 덱 + VOICE 1장 추가(순환 대상 9장, ECHO 합 5) → 순환 5.0초 → 12순환 × 5 = **60**. 이 두 값이 깨지면 공식이나 카드 값이 바뀐 것이다 — selftest 단언 대상(구 30/54 단언은 제거).

함의: 시작 덱은 REPEAT 태그 1장뿐이라 컴파일 강도 보너스가 없고 기존 검산값 26을 유지한다. ARCHIVE 추가 구매 없이 승리할 수 없지만, 같은 PROGRAM 계열을 2장 이상 모으면 늦은 엔진 투자가 최종 처리량으로 돌아온다. 시작 덱에 CACHE 1장을 더한 REPEAT 강도 2의 검산값은 **52**다. 시작 덱 + VOICE 1장의 기본값 60과 함께 selftest에 고정한다.

## B2-적 — P0 4종·시크 계열·P1 (역할 정의는 [10](10_MECHANICS.md) §9)

P0 기본 적 4종 `[시드값 — 이동·비용은 V1 실측치를 시드로 이식]`:

| 적 | HP | 속도 px/s | 스폰 비용 | 행동 요지 |
|---|---:|---:|---:|---|
| BOT.CHAT | 4 | 22 | 1.0 | 군집 접근, 접촉 시 카드 부착 — 부착당 발동 지연 +0.5초(최대 3). 동일 오타 채팅 생성 |
| POP.AD | 8 | 0 | 1.2 | 경로 차단 창. COMMENT WALL에서는 현재 위치 반대편 내부 축에 등간격 한 줄 배치, 그 외 의도는 가장자리 배치. HUD 마스크 준수 |
| SPON.GIFT | 10 | 0 | 2.0 | 위험 지대 보상 상자 — 수령: 강한 효과+자홍 / 파괴: 안전+보상 감소. 가짜율은 CONTRACT 사용량 비례 |
| MOD.MASK | 14 | 10 | 3.0 | 슬롯 1개 봉인 5초, 봉인 카드 실행 시 NOISE 삽입 |

시크 계열: BUF.WRM (HP 4 — 카드 지연, 방치 시 카드를 '보관'해 다음 턴으로) / TAG.LARVA (HP 3 — 파편에 날짜표, 호박 경로 강화). P1: MIRROR.REPLY / CLIPPER / RETENTION / RAID.GATE / GHOST.VIEWER (`[시드값]` 미정 — P1 진입 시 책정). 엘리트 SEEK.WRM (7턴): HP = MOD.MASK ×4, ARCHIVE/청록 1개 보관 — 처치 시 반환+청록1, ON AIR 종료까지 방치 시 호박 전환. NØA(OC 보스): 게이지 없음, TREND MIRROR.

군중 규칙: 적 간 분리 벡터(겹침 반발) 적용 — 반발 반경 8px, 최대 보정 0.3px/틱 `[시드값]`.

## B2-의도 — 의도 덱과 감사 프로토콜

의도 덱 12장 구성 `[시드값]` — 절차 생성 문법([10](10_MECHANICS.md) §5: 초반3 단순/중반4 덱 공격/후반3 전략 대응/종결2 NØA)을 따르는 기본 분포: BOT RAID ×3, MUTE ×2, GIFT DROP ×2, COMMENT WALL ×2, MIRROR ×1, CLIP THEFT ×1, TREND ×1. 상황 의도(LATENCY·EMPTY CHAT·SPONSORED RAID)는 시간층·프로토콜이 치환 삽입. SEEK HUNT는 7턴 고정 이벤트(단, ARCHIVE 미보유 시 금지 규칙 우선). 정보량: 입문 전체 공개 / 일반 종류+방향 / 고난도 30% 은닉·10% 거짓 `[시드값]`.

감사 프로토콜 (런당 1종, 정의는 [10](10_MECHANICS.md) §5): RESPONSE RACE(두 BREAK 무수급 시 NOISE +1) / ENGINE AUDIT(구절 내 PROGRAM 3+ 발동 → QUARANTINE 삽입) / **BANDWIDTH CAP**(`[본 개정 구체화]` 하드 캡 없음 — BAUD 7 이상 전부 사용 가능하되 다음 의도 덱에 POP.AD 감사 카드 삽입) / **ARCHIVE HUNT**(`[본 개정 구체화]` 기본 SEEK HUNT 1회(7턴) + ARCHIVE 4장 이상 보유 시 SEEK HUNT 의도 카드 1장 추가 삽입) / PERFECT RETENTION(CONTRACT 2배·자홍 +1).

TREND 집계 `[시드값]`: 기본 = **실제 발동 횟수**, 최근 6구절 ×2 가중, 48 메아리에서 1회 갱신, 고난도 = 상위 2개 조합. HUD `NØA is learning:` 5턴부터 상시. 복제 페어링은 [10](10_MECHANICS.md) §9.

## B2-스폰

```text
ON AIR 예산   = 6.0 + 1.2 × (턴-1)   (8초당, 의도 카드가 방향·구성 지정)
OC 초당 예산  = 6.0 + 0.067 × OC경과초
동시 적 상한 256 / spawn 실패 시 예산 미소모
```

COMMENT WALL 배치: `count = 3 + floor(turn/2)`, 세로/가로는 encounter RNG로 결정, 고정 축은 에코가 있는 화면 절반의 반대편 `x=80/320` 또는 `y=56/168`, 나머지 좌표는 전장 안쪽에 등간격 배치한다. 별도 장애물·충돌 맵은 두지 않는다.

## B2-지표 — 수용 기준 (원문 §95의 실제화)

| 측정 | 목표 | 벗어나면 먼저 바꿀 것 |
|---|---|---|
| 입문: 신규 5명 중 EDIT·Space 60초 내 이해 | ≥4/5 | 온보딩 문구, 추천 선택 노출 |
| TX/RX UI 이해 | 30초 내 | 포트 방향 문법([45](45_UI_UX.md) §1), 추천 표시 |
| 손패 선택: 매 턴 이유를 말로 설명 | ≥70% | 의도 정보량, 카드 OFF AIR 차등 |
| 같은 손패·다른 의도에서 다른 선택 | 관찰됨 | 의도 덱 구성, 대응 카드 가격 |
| **TX/RX 배분이 갈리는 구절** | ≥30%, 전부 TX·전부 RX 어느 쪽도 상시 정답 아님 | TX 화력·RX BAUD 비율, 의도 강도 |
| EDIT 편성 시간 (숙련 후) | 평균 ≤3초 | 카드 정보 밀도, 추천 |
| "추천 카드만 항상 누름" 비율 | <60% | 의도 다양성, 추천 노출 시점 |
| SYNC: 숙련자 유지 목표화 / SYNC 0 클리어 가능 | 둘 다 성립 | SYNC 효과 크기 (화력화 금지) |
| 최소 5개 전략 봇 클리어 가능 | 5/7 이상 | 지침·가격, 목표 64 아님 |
| 단일 전략 승리 독점 | <40% | 해당 경로 가격·수치 |
| 복잡 엔진 고점 > BIG BAUD | 성립 | 엔진 카드 상향 (BIG BAUD 하향 아님) |
| 첫 런 OPEN CHANNEL 도달 | 70~85% | 중반 예산, 의도 강도 |
| 성공 OC 소요 | 중앙값 35~50초 | ECHO 값, 순환 박자 |
| OC를 가장 기억나는 순간으로 지목 | ≥4/5 | 위상 연출, 최종 프로토콜 |
| 노아 복제 자각 | ≥3/5 | TREND HUD, 복제 연출 |
| 클리어 후 다른 색 엔딩 재시작 의향 | ≥3/5 | 엔딩 예고 가독성 |

승률 50%가 목적이 아니다. 첫 실패의 원인이 보이고, 학습 후 승률이 실제로 오르는지가 우선한다.

## B3-융합 — 신호 경제 + 연쇄 공명

전투↔경제 융합 루프의 튜닝값. 설계 의도·인과·레퍼런스 매핑은 [60_FUSION_SIGNAL_COMBO.md](60_FUSION_SIGNAL_COMBO.md) 정본이며, 기계값은 `content/balance.def` `B3-융합` 블록이다. **모두 `[시드값]`.**

| 상수 | 값 | 견제 관계 |
|---|---:|---|
| `SIGNAL_PER_BAUD` / `SIGNAL_BAUD_CAP` | 5 / 3 | 전투 자금이 RX 경제를 대체하지 않고 보완하도록: 구절당 최대 +3 BAUD |
| `PICKUP_MAGNET_BASE` + `NETWORK_MAGNET_PER_TIER` | 16 + 9/티어 | 수집을 이동 보상으로 남기되 확산 학파가 회수를 특화 |
| `PICKUP_LIFE_TICKS` / `PICKUP_ATTRACT_MUL` | 600 / 3 | 조각이 오래 남고 근접 시 흡인 — 손맛과 접근성 균형 |
| `COMBO_TIER_STEP` / `COMBO_TIER_MAX` | 4 / 4 | 4처치=1티어, 최대 4티어(16처치) |
| `COMBO_SCALE_PER_TIER` + `REPEAT_COMBO_PER_TIER` | 8% + 3%/티어 | 프로그램 배율 상한 ≈ (8+9)×4 = 68% (다발 3티어 기준) — SYNC와 곱연산 |
| `COMBO_DECAY_TICKS` + `REPLAY_COMBO_WINDOW_PER_TIER` | 84 + 30/티어 | 체인 유지 부담을 연사 학파가 완화 |
| `COMBO_CUE_KILLS` | 9 | 큰 체인만 편성 +1(도미니언 +액션) — 초·중반 남발 방지 |

불변식(1000시드 SIM, 융합 후): 어느 정책도 지배하지 않고(`max×10 ≤ total×4`), 방어 정책 CLEAN_SIGNAL의 필사 생존 우위가 유지된다. 전투 자금 도입으로 최약 공격 정책 BIG_BAUD가 상향(6/30→300/1000)됐으나 상한 정책 THREE_WAY와의 격차는 유지된다.

## SIM — 전략 봇과 시뮬레이션 계층

"봇 AI"가 아니라 **스크립트된 구매·편성 정책의 몬테카를로**다. 주 계층은 전투를 무적 더미로 두고 덱·경제·CUE·링만 시뮬레이션한다(회피 실력 변수 제거). 보조 계층은 같은 7정책×30시드를 실제 피격 가능한 고정 이동으로 실행해 방어 가치와 위험 전략을 비교한다. 사람의 조작 재미를 대신하지 않으며, 두 계층의 목적과 합격선을 섞지 않는다.

기본 봇 7종 + 고급 3종:

봇 정책은 구매 우선순위 + **TX/RX 배분 규칙** + 편성 우선순위 + OPEN CHANNEL 전환 조건의 4요소다:

```text
BIG_BAUD      CARRIER 중심·목표 가격까지 RX 우선, PROGRAM 최소  → 안정적이지만 최고 성능 아님 (기준선)
LOOP_ENGINE   MULTI·CACHE·PREFETCH·cantrip, 얇은 덱             → 완성 전 약함, 완성 후 손패 가치 최고, NOISE 취약
ECHO_RUSH     초반 ARCHIVE·RX 투자 우선, 조기 OPEN CHANNEL      → 빠르지만 준비 구간 생존 난도 높음
CLEAN_SIGNAL  FIREWALL·CHECKSUM·DEFRAG·중급 CARRIER             → 느리지만 안정, 자홍 저항
CACHE_COMBO   MARKER→SURGE, MULTI→MACRO, CACHE→강카드           → 고점 높고 손패 의존 큼
PERFECT_SHOW  NØA CONTRACT 우선 구매·자홍 수용                  → 가장 화려, 빠른 성장, 위험한 엔딩
THREE_WAY     세 색 균형, 진엔딩 목표                           → 가능하되 난도 최고
TREND_BAIT    약한 PROGRAM 최다 사용으로 복제 조작 (고급)
LAST_ARCHIVE  CACHE·시크 거래·호박 보관·덱 압축 (고급)          → 장기 안정, 시크 엔딩
DIRTY_BROADCAST 오염 활용 (확장판 보류)
```

계측 지표: 승률 / 평균 OC 진입 턴 / 평균 64 도달 시간 / 덱 크기·셔플 횟수 / 구매 카드 첫 귀환 턴 / 턴당 사용 CUE / **terminal 충돌률**(선택 못 한 PROGRAM 비율) / NOISE 평균 / 카드별 구매율·피해 기여 / 3색 비율 / 엔딩 분포 / TREND 분포 / 의도별 사망률.

검증 계층:

```text
커밋 테스트     정책 7종 × 30 시드          — 크래시·결정론·극단 회귀 (build test마다)
생존 보조층      정책 7종 × 30 시드          — 실제 피격·방어 가치·위험 순위
릴리스 테스트   정책별 ≥1,000               — 승률·분산·전략 편향
사람 테스트     신규 ≥5명                   — 재미·학습·가독성 ([50](50_PRODUCTION.md) §4)
```

수용 기준(assert): 7종 중 ≥5종 도달률 >0, 최고 정책이 전체 승리의 40%를 독점하지 않음, BIG_BAUD 승률이 중앙값 부근(최강도 최약도 아님). 미달 시 카드 추가가 아니라 가격·지침·목표를 조정한다.

## 튜닝 절차

1. 수치 변경은 `content/balance.def`(기계 정본) → 이 문서(설계 의도 갱신, 손으로) → `generated/balance.h`·`balance_test.inc`·`docs/20_BALANCE.generated.md`(빌드 시 자동) 순으로 한 커밋. 수치의 코드·문서·테스트 3중 기재를 금지하는 단일 원천 구조는 [30](30_TECH.md) §7. selftest 검산 기준점은 **26 / 60**(§"B2-공식").
2. 사람 테스트 전 SIM으로 후보 값을 거른다. 사람은 재미·가독성 판정에만 쓴다.
3. 지배 전략 발견 시 순서: 가격 → 수치 → 의도·프로토콜 → (최후) 목표 64. **카드·버튼 추가는 레버가 아니다.**
