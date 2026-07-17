# 90 — 구현 상태 (STATUS 정본)

**스펙 문서(00~50)는 상태를 말하지 않고, 이 문서만 상태를 말한다.** V1에서 SPEC/STATUS 혼합이 만든 드리프트(문서 줄 수·카드 수·구현 선언 불일치 등, 원문 §5.2)의 재발 방지 장치다. 수치·규칙 변경 커밋은 이 문서와 [CHANGELOG.md](CHANGELOG.md)를 함께 갱신한다.

```yaml
status: p1-feature-complete-automated-gates
verified_commit: working-tree
verified_at: 2026-07-17
verified_by: MSVC /W4 selftest + release build + Windows 실실행 화면 검수
```

## 1. 큰 그림

| 항목 | 상태 |
|---|---|
| 코드가 구현하는 게임 | **V2 P1 플레이 빌드** — P0 코어 + 엔진 카드·의도 덱·시크 거래/케이블·최종 프로토콜·4엔딩·TODAY·저장·계측 |
| 문서가 기술하는 게임 | **V2** (수동 편성·노아·3색 링) — 00~50 전체 |
| V2 구현 | **W‑V2‑P1 기능 완결 + 코드 통합 아트 패스 플레이 가능.** 정본 P1 자동 게이트와 실제 Windows 화면 검수 완료. 사람 대상 GV2/G3′와 최종 Aseprite 원본 게이트는 미실시 |
| 소스 | `echo144.c` unity 진입점 + `game.h/game.c/render.c/win32.c` 변경 이유별 분리 |
| 릴리스 exe | 179,200B (2026-07-17, 상한의 12.2%, SHA-256 `B4D7963BA401A899406BCAAC321D0B17B17AF86857D18D34918DB766043F323E`) |
| 카드 수 | 13종: P0 8종 + MACRO / PREFETCH / MARKER / SURGE / CHECKSUM + NØA BOOST 계약 + DEFRAG SERVICE |
| selftest | MSVC `/W4` PASS: P0 회귀 + P1 카드·킹덤·의도·시크·입력/접근성·링 전환·OC 컴파일 강도/4엔딩 + 7정책×30 및 별도 1,000 seed SIM. 복잡 엔진 처리량이 BIG_BAUD를 넘는 자동 목표 PASS, 실제 생존·조작 고점은 사람 검증 필요([91](91_COMPLETENESS_AUDIT.md) §4) |
| 자산 | V2 수작업 PNG: 에코 24×24×10·표정 8종, 시크 아바타 24×24×8·표정 4종·셸 16×16×4, 노아 대리체 24×24×6·보스 48×64×3, 초상 64×64×3, 적 5종×2프레임, 카드 아이콘 13종, 직접 구성한 192×108 키아트 A~F. 로고 2종과 120×45·184×69·300×168·462×174·920×430·1232×706·748×896 수동 구도 마케팅 PNG를 함께 생성한다. 런타임은 4bpp 패킹 |

V1의 초기 정적 평가(콘셉트 9/10, 런타임 정확성 신뢰도 4.5/10, 기능 완성도 ≈80%·제출 준비도 ≈55~65% — 이동·스케줄러·GDI 수정 전 기준)는 [archive/ECHO144_complete_design_history.md](archive/ECHO144_complete_design_history.md) 부록 A에 동결. V1 자산의 검수 상태 분리 표기 원칙(단품 검수 PASS / Windows 실빌드 검수 PENDING / 외부 테스터 검수 PENDING)은 아래 §2에 반영되어 있다.

## 2. V1 잔여 작업 (no-go 시 재개할 것)

- Windows 실빌드 스크린샷 검수 (MSVC 필요 — G-게이트 수동 항목).
- 엘리트 피격 프레임 전용 트리거.
- G1/G2 사람 테스트 미실시 (테스터 미모집 상태).
- 음악 모티프의 음계화 마감 (근사 구현 상태).

## 3. V1 결함의 V2 처리 (2026-07-17)

V2 재작성으로 구 라인 위치는 폐기됐다. 이동 좌표는 상태에서 끝까지 float로 유지하고 렌더에서만 정수화하며, 60틱 54px 대칭 테스트를 둔다. 출력은 정수 배율+레터박스이며 텍스트는 내장 ASCII 5×7 + 사용 음절 한글 12×12 글리프로 그려 런타임 시스템 글꼴 의존을 제거했다. 상태 전환은 각 페이즈의 단일 진입 함수로 끝내며, CACHE 보관 카드 비중복 회귀 테스트를 추가했다.

## 4. V2 구현 체크리스트 (착수 시 갱신)

| 블록 | 스펙 | 상태 |
|---|---|---|
| W-FIX 정확성 수정 + 대칭 테스트 | [30](30_TECH.md) §3 | P0 완료 |
| EDIT/ON AIR/BREAK/CLEANUP 턴 구조 | [10](10_MECHANICS.md) §2~7 | P0 완료 |
| CUE·SEEK(신)·카드 8장 | [15](15_CARDS.md), B2-카드 | P0 완료 |
| 적 의도 4종 + 예고 HUD | [10](10_MECHANICS.md) §5 | P0 완료 |
| 64칸 **논리** 링 — 전투 16대구간/OC 64칸 | [10](10_MECHANICS.md) §8 | P0 완료 |
| OPEN CHANNEL + ARCHIVE 반전 | [10](10_MECHANICS.md) §10 | P0 완료 |
| TREND MIRROR 1종 | [10](10_MECHANICS.md) §9 | P0 완료 |
| P1 카드 5종 + DEFRAG | [15](15_CARDS.md) §4 | P1 완료 |
| 의도 덱·BUF.WRM·COMMENT WALL·시크 탈취 | [10](10_MECHANICS.md) §5·§9 | P1 완료 |
| 전략 봇·SIM 확장 | [20](20_BALANCE.md) §SIM | 실제 ON AIR 전투·PROGRAM 발동·정책별 TX/RX와 CUE 우선순위를 실행하는 무적 처리량 봇. 7정책×30 + 1,000 seed PASS, LOOP 899/1000·CACHE 892/1000로 복잡 엔진 고점 회복 / 실제 생존 모델은 미달 |
| balance.def·콘텐츠 컴파일러·이벤트·구조 분리 | [30](30_TECH.md) §4~7 | P0 balance.def·파일 구조 완료 / 생성기·이벤트 미착수 |
| 내장 비트맵 폰트 | [30](30_TECH.md) §9 | ASCII + 게임 노출 한글 subset 완료, 전 화면 한글화 |
| 접근성·재시작 | [45](45_UI_UX.md) §6 | M 음소거·F1 저자극·ESC 일시정지·Space 홀드·10초 무입력 PROGRAM 추천·결과 0.5초 입력 보호·같은/새 시드 재시작 완료 / 자동 TX/RX 옵션 미착수 |
| P1 규칙 완결 | [10](10_MECHANICS.md) §8~11, [15](15_CARDS.md) §9 | CACHE 대상 선택, FIREWALL 개구부, OFF AIR 3종, BOT/MOD 덱 공격, 시크 거래·OC 케이블, 최근 6구절 TREND, 4 modifier·4엔딩·실패 원인 완료 |
| TODAY·저장·계측 | [10](10_MECHANICS.md) §1·§13, [30](30_TECH.md) §8 | F2 로컬 날짜 시드, 60B 체크섬 저장, 손상 시 시크 문구, 읽기/쓰기 실패 무시, DEV 전이별 CSV 완료 |
| V2 자산 재설계 (DNA 계승) | [41](41_PIXEL_ART.md) §1~§2·§7, [43](43_ART_COMPETITIVE_RESEARCH.md) | 전장 표현 분리·3인 표정/동작 확장·적 5종 2프레임·사건형 키아트·편성/계약/보관/결과 행동·원형 최종 프로토콜·스토어 캡슐 7규격·4bpp 런타임·AI-slop 검수 완료 / 타인 재현·사람 대상 선호도·레이어드 Aseprite 원본 게이트 미실시 |

## 5. 문서-코드 동기화 규칙

1. 스펙 문서에 "구현 ✅" 금지 — 상태는 여기와 CHANGELOG에만.
2. 이 문서의 `verified_commit`이 현재 HEAD와 멀어지면(±10 커밋) 재검증하고 스탬프를 갱신한다.
3. 수치는 [20](20_BALANCE.md) → `balance.def` → 코드 순서의 단일 원천을 지킨다. 코드에서 먼저 바꾸는 것을 금지.
