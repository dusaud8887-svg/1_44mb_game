# 35 — 레퍼런스 분석과 차용 원칙

외부 레퍼런스(초저용량 게임, 덱빌더, 서바이버, 현대 레트로 작품)에서 **무엇을, 왜, 어떻게 비틀어 가져오는가**의 정본. 원문 분석 전문은 [archive/ECHO144_1_44MB_REFERENCE_ANALYSIS.md](archive/ECHO144_1_44MB_REFERENCE_ANALYSIS.md)와 [archive/ECHO144_V2_ART_VISUAL_REFACTOR.md](archive/ECHO144_V2_ART_VISUAL_REFACTOR.md) §4·§32. 이 문서는 결론과 적용처만 유지한다 — 레퍼런스는 복제 대상이 아니라 번안 대상이다.

## 1. 대전제 — 1.44MB는 생각보다 크다

16×16 2bpp 1프레임 = 64B, 24×24 4bpp 1프레임 = 288B. 주요 캐릭터 애니메이션 100프레임을 추가해도 원시 데이터 약 28.8KB다. **"용량이 작아서 애니메이션·엔딩·적 변주를 못 넣는다"는 사고를 금지한다.**

ECHO/144의 실제 제한은 바이트가 아니라: 소수 인력의 제작 시간 / 카드·이펙트의 가독성 / 320×240 정보 밀도 / 전투·편성 템포 / 테스트 가능한 규칙 수 / 마감까지의 안정화 시간. **바이트 예산보다 디자인 복잡도 예산을 관리한다.** (용량 운용은 [30_TECH.md](30_TECH.md) §9 — 내부 소프트 캡 900KB.)

## 2. 여덟 가지 차용 원칙

| 우선 | 원칙 | ECHO/144 적용처 |
|---:|---|---|
| 1 | **에셋 대신 레시피를 저장** | 카드 이펙트·적 패턴·배경·음악을 파라미터로 생성 ([30](30_TECH.md) §6·§9) |
| 2 | **단일 핵심 동사와 깊은 변주** | `CUE` 하나가 편성·발동·복제·봉인·오염·학습의 중심 ([10](10_MECHANICS.md) §3) |
| 3 | **게임 상태와 표현의 분리** | 결정론 코어 + 명령/이벤트 계층 ([30](30_TECH.md) §5) |
| 4 | **카드 = 원자 효과 조합** | 카드당 전용 코드 대신 4~6개 효과 명령 + 소수 hook ([30](30_TECH.md) §6) |
| 5 | **적 의도를 미리 공개** | 손패를 보고 의도에 대응하는 수동 편성 ([10](10_MECHANICS.md) §5) |
| 6 | **간단한 전략 봇으로 밸런스 검증** | 구매·편성 우선순위 봇 ([20](20_BALANCE.md) §SIM) |
| 7 | **실패 뒤 즉시 재도전** | 1초 미만 재시작, 같은 시드 재접속 ([10](10_MECHANICS.md) §13) |
| 8 | **후반에 한 번의 압도적 합성** | 덱 전체가 최종 방송 프로토콜 하나로 컴파일 ([15](15_CARDS.md) §9) |

## 3. 사례별 교훈 — 비틀어 채택

### `.kkrieger` (96KB FPS) — 결과물이 아니라 문법을 저장한다

텍스처 픽셀 대신 생성 이력을, PCM 대신 MIDI+신시사이저를 저장했다. **3D 절차 생성 기술 자체는 가져오지 않는다.** 번안:

| 저장할 결과물 | 대신 저장할 레시피 |
|---|---|
| 카드별 완성 이펙트 애니메이션 | 도형·방향·속도·수명·팔레트·히트 규칙 |
| 적 웨이브 배열 전체 | 적 의도 카드·시드·웨이브 문법 |
| 시간층별 배경 이미지 | 배경 타일·그리드·오류 오버레이 파라미터 |
| 여러 곡의 PCM/WAV | 모티프·음표·악기 패치·패턴 |
| 색상별 스프라이트 복제 | 인덱스 스프라이트 + 팔레트 리맵 |
| NØA의 공격 애니메이션 | 플레이어 효과 레시피의 대상·방향·팔레트 반전 |
| 모든 채팅 문장 | 작가가 만든 문장 조각 + 제한 문법 ([40](40_ART_AUDIO_TEXT.md) §6) |

### Slay the Web — 명령·상태·이벤트 분리 (불변 상태 복사는 버림)

전체 게임 상태의 UI 독립성, 모든 행동의 액션화, 적 `intent` 공개를 가져온다. JS식 전체 상태 복사는 C 60Hz에 불필요 — `game_apply_command(state, cmd, events)`의 직접 수정 + 명령 로그로 번안 ([30](30_TECH.md) §5). 이 구조가 결정론 리플레이·TODAY 재현·NØA의 명령 모방·시크의 이전 방송 재생을 전부 가능하게 한다.

### Dominiate — 코드가 아니라 봇 철학

전략 = 구매 우선순위 + 프로그램 사용 우선순위 + OPEN CHANNEL 전환 조건 + 정리 조건. 강화학습 없이 "Big BAUD가 항상 최선인가 / Sponsor가 너무 강한가 / 아카이브 조기 구매가 실제로 위험한가"를 검증한다 ([20](20_BALANCE.md) §SIM).

### Cave Story (무기 레벨다운) → SYNC

피격이 공격 성장과 직접 연결되는 "기존 시스템 둘을 잇는 규칙 하나". 무기 레벨 대신 **방송 동기화 SYNC 0~3**으로 번안 — 상승은 회피·적합 편성·타이밍, 하락은 피격·미사용 CUE. **악순환 방지 안전장치가 본체다** ([10](10_MECHANICS.md) §4-1, 수치 [20](20_BALANCE.md) B2-SYNC).

### Celeste Classic / PICOHOT — 단일 동사

동사 수를 줄이고 한 동사의 의미를 계속 바꾼다. ECHO/144의 동사는 **CUE**: 프로그램 활성화 / 실행 순서 / MULTI가 CUE를 늘림 / NØA가 CUE를 학습 / 적이 CUE 슬롯을 봉인 / 시크가 CUE된 아카이브를 보관 / MACRO가 직전 CUE를 재생 / CACHE가 CUE를 다음 구절로 넘김 / 최종 방송이 최다 CUE 태그를 계승.

### Dominion 카드 경제 → 카드 타입 번안

Treasure → **TX/RX 양면 CARRIER** ([10](10_MECHANICS.md) §3-1, ADR-0007) / Action → CUE 소비 PROGRAM / Victory → OPEN에서 반전되는 ARCHIVE / Curse → NOISE·MIMIC / 솔로 오토마·Curse Race → 적 의도 덱·감사 프로토콜.

### HoloCure Super Collab — 수십 개 진화표가 아니라 딱 하나

한 런의 후반 목표가 되는 강한 최종 결합 **하나**: 덱 전체 → 최종 방송 프로토콜 컴파일. 핵심 효과 3~4개 × 수정자 4개지만 플레이어에게는 여러 최종 빌드로 보인다.

### Cat Survivors (js13k 12.91KB) — 경고

"서바이버를 작은 용량에 넣는 것"은 어렵지 않다. **10분 동안 위협과 성장 곡선을 유지하는 것이 어렵다.** 심사평: 적이 느리고 플레이어가 강해 실질 위험이 약함. 검증 항목: 위험을 읽고 피해야 하는가 / 이동 경로를 바꾸게 하는 적이 있는가 / 현재 손패 때문에 다른 위치를 선택하는가 / 강해진 뒤에도 NØA가 대응하는가 / 후반이 청소 작업이 되지 않는가 ([20](20_BALANCE.md) B2-지표).

### CLAWSTRIKE (js13k) — 즉시 재시작과 규칙 변주

실패 → 1초 미만 같은 시드 재시작. 클리어 → 새 능력치가 아니라 **새 규칙 모드** 해금(MIRROR LINE·ARCHIVE LINE·NO RESPONSE·PERFECT CHAT·SHORTEST LIVE — [10](10_MECHANICS.md) §13). 같은 적·카드·배경으로 완전히 다른 의미를 만든다.

### Vampire Crawlers — 장르 융합의 성공과 실패를 동시에

"서바이버의 과장된 성장 + 덱빌더"가 상업적으로 이해되는 콘셉트임을 증명. 동시에 PC Gamer 비판 — **오름차순이 너무 명백한 최적해가 되어 매번 같은 순서로 카드를 낸다.** ECHO/144의 방어:

```text
카드가 많다 ≠ 선택이 많다 / 콤보가 길다 ≠ 전략이 깊다 / 강한 최종 빌드 ≠ 재미있는 과정
```

같은 손패라도 적 의도·현재 위치·구매 목표·링 상태·TREND·다음 셔플·남은 턴·SYNC에 따라 다른 선택이 나와야 한다. "항상 왼쪽부터·항상 같은 LINK"가 관찰되면 코어 실패([00](00_VISION.md) §7).

### 현대 레트로 5작품 — 원리만 (아트 방향, [40](40_ART_AUDIO_TEXT.md) §1)

《도시전설 해체센터》 제한 색과 인물 확대 컷의 감정 중심 / 《SIGNALIS》 레트로테크 UI와 세계관 구조의 결합 / 《ENA: Dream BBQ》 설명하지 않는 캐릭터·공간 / 《VA-11 Hall-A》 일상 대화·습관으로 세계 전달 / 《Sorry We're Closed》 매력 캐릭터 위에 겹치는 위협.

가져올 원리: 강한 색의 역할 분담 / 인물 중심 감정 훅 / **UI를 세계관의 물건으로** / 미스터리를 설명이 아니라 반복 패턴으로 / 마케팅과 인게임의 모티프 통일. 복제 금지: 의상·색 배치·화면 전환·로고·호러 장면.

## 4. 불채택 결정표

| 요소 | 이유 |
|---|---|
| raylib·Odin 전면 이전 | 현 스택의 이득(검증 코드·작은 EXE·직접 통제)을 버릴 이유 없음. raylib은 도구·프로토타입·확장판 어댑터로만 |
| Crinkler | 수 KB 데모씬용 압축 링커 — 규모 불일치 |
| UPX·패커 | 크기 여유 + Defender/SmartScreen + 크래시 분석 (영구 불채택 재확인) |
| `.kkrieger`식 3D 절차 생성·레이마칭 | 게임 방향과 무관 |
| GPU 셰이더 렌더러 재작성 | 필요한 효과는 CPU로 충분(팔레트 스왑·원호·회선·프레임·행 오프셋·잔상). 확장판에서 |
| 런타임 XML 카드 정의 | 파서·문자열·오류 표면 증가. 빌드 타임 JSON→C 배열로 대체 ([30](30_TECH.md) §7) |
| JS식 전면 불변 상태 | C 실시간 코어에 불필요 |
| 뱀서식 경험치 보석·상시 3택 레벨업 | 덱 구매와 성장 시스템 경쟁 — 성장 보상은 BREAK 구매·시크 거래·CONTRACT·OPEN 컴파일로 통일 |
| 무기 슬롯 6개·별도 진화 트리 | 카드와 이중 성장계 |
| 대량 영구 능력치 해금 | 덱 판단 약화 |
| 공간 해시·ECS·멀티스레드 선제 도입 | 실측(최악 충돌 0.162ms) 근거 없음 — 조건부 기준은 [30](30_TECH.md) §10 |
| 적 1,000마리 | 320×192에서 읽히지 않음. 잘 설계된 256이 손패·위치·이동로를 공격하는 편이 낫다 |

## 5. 반드시 버려야 할 유혹 (요약)

- **"남는 용량을 콘텐츠로 채우자"** — 심사 기준은 완성·용량·재미이지 콘텐츠 개수가 아니다. 테스트 표면만 폭증한다.
- **"카드마다 전용 코드"** — 초기엔 빠르지만 조합·테스트가 폭발. 원자 효과 + 소수 hook.
- **"모든 것을 데이터화"** — CACHE·MACRO·TREND처럼 상태를 많이 참조하는 효과까지 범용 VM화하면 오히려 커진다. **80% 데이터, 20% 전용 코드.**

## 6. 참고 링크

프로젝트: [저장소](https://github.com/dusaud8887-svg/1_44mb_game) / [공모전 규정](https://2pgarcade.com/contest-144mb.html) (상한 1,474,560B, 압축 해제 후 전체, 내부 데이터 압축 허용)

기술: [Sokol](https://github.com/floooh/sokol) / [raylib](https://www.raylib.com/) / [SDL3](https://wiki.libsdl.org/SDL3/FrontPage) / [miniaudio](https://miniaud.io/) / [heatshrink](https://github.com/atomicobject/heatshrink) / [stb](https://github.com/nothings/stb) / [kkrieger 소스](https://github.com/jaromil/kkrieger-werkkzeug3)

게임 구조: [Slay the Web DOCUMENTATION](https://github.com/oskarrough/slaytheweb/blob/main/DOCUMENTATION.md) / [Dominiate](https://github.com/rspeer/dominiate/) / [HoloCure Super Collab](https://holocure.wiki.gg/wiki/Super_Collab) / [Cat Survivors](https://js13kgames.com/2025/games/cat-survivors) / [CLAWSTRIKE](https://github.com/remvst/clawstrike) / [Vampire Crawlers](https://store.steampowered.com/app/3265700/) · [PC Gamer 리뷰](https://www.pcgamer.com/games/roguelike/vampire-crawlers-review/)

아트 도구·규격: [Aseprite](https://www.aseprite.org/) · [CLI](https://www.aseprite.org/docs/cli/) / [Pixelorama](https://github.com/Orama-Interactive/Pixelorama) / [LibreSprite](https://libresprite.github.io/) / [LDtk](https://ldtk.io/) / [Tiled](https://www.mapeditor.org/) / [Steam Graphical Assets](https://partner.steamgames.com/doc/store/assets) / [WCAG Contrast](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html)

현대 레트로: [Urban Myth Dissolution Center](https://store.steampowered.com/app/2089600/) / [SIGNALIS](https://store.steampowered.com/app/1262350/) / [ENA: Dream BBQ](https://store.steampowered.com/app/2134320/) / [Sorry We're Closed](https://store.steampowered.com/app/1796580/) / [VA-11 Hall-A](https://store.steampowered.com/app/447530/)

차원 통신 참고: [「次元通信 / Signaling」 공식 영상](https://www.youtube.com/watch?v=PqpCRSOUuIE) — **통신을 반복 몸짓과 규칙으로 시각화하는 설계 방식만 참고한다.** 수기 신호·2인 색 분할·동일 서사·멜로디·의상·안무는 복제하지 않는다. ECHO/144의 차별점: 사람 없는 미래의 방송, 64개의 메아리, 실제·보관·모방의 삼각관계, 수동 덱 편성.
