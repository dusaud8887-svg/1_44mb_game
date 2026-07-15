# 30 — 기술 설계와 구현 현황

스택 결정의 근거 조사는 [archive/ECHO_144_FINAL_SPEC.md](archive/ECHO_144_FINAL_SPEC.md) §12에 동결. 이 문서는 **현재 코드 기준(as-built)** 정본이다.

## 1. 구현 현황 — 2026-07-14 실측

| 항목 | 상태 |
|---|---|
| 소스 | [src/echo144.c](../src/echo144.c) 단일 파일 1,174줄 |
| 릴리스 exe | **135,168 B** (한도 1,474,560 B의 9.2%) |
| 의존 DLL | USER32, GDI32, WINMM, KERNEL32만 (`dumpbin /dependents` 통과) |
| selftest | 전부 PASS — 결정론 리플레이, 9 NODE 풀런, 4빌드 경로, GO LIVE 조기/강제, 버스트/도장 경계값, 뮤트 합성 |
| 최악 충돌 틱 | 0.162 ms (기준 16.7 ms) — 공간 해시 불필요 확정 |
| 미구현 | 픽셀 스프라이트·초상(현재 프로시저럴 블록아웃), 음악 모티프, 첫 NODE 조각 미리보기 |

크기 예산표(구 스펙 §13의 768KB 내부 목표)는 **해소된 리스크**다. 이후 크기 검사는 build.bat의 자동 게이트(한도 초과 시 빌드 실패)로 충분하며, 커밋마다 기록하지 않는다. 패커·`/GS-`·`/NODEFAULTLIB`는 영구 불채택.

## 2. 스택 (확정, 변경 금지)

C11 + MSVC `/O1 /GL /Gy /Gw /GS /MT`, x64 무패킹, Win32 직접 호출. 렌더는 320×240 32비트 `CreateDIBSection` → `StretchBlt`, 오디오는 `waveOut` 4중 버퍼 22.05kHz 모노 런타임 합성. 저장·네트워크·파일 I/O 없음(DEV_LOG 제외).

## 3. 소스 구조 지도 (단일 파일 유지)

구 스펙의 4파일 분할(platform/game/data)은 채택하지 않았고 현 규모에서 분할하지 않는다 — 1,174줄은 책임 구획 주석으로 충분하다. 2,500줄 초과 시에만 `data.c`(아트·텍스트 상수) 분리를 재검토한다.

| 구획 | 내용 |
|---|---|
| 상수·타입 | CardDef 표, VALID_MASKS 41개, Game 단일 전역 |
| 덱 엔진 | 셔플·드로우·손패·SEEK·구매력·예상 공식 |
| 카드 실행 | attack_card / execute_card, last_payload, LINK 판정 |
| 전투 | 적 4종 AI·스폰 예산·탄·충돌(이중 루프)·버스트 |
| 상태 머신 | TITLE→CHANNEL→PLAY⇄SHOP→ENDING→RESULT, 입력 |
| 렌더 | 픽셀 프리미티브 5종 + GDI 텍스트, 화면별 draw_* |
| 오디오 | 사각파 2 + LFSR 노이즈 1 + SFX 1보이스 합성 |
| 하니스 | DEV_LOG 계측 / SELF_TEST main / wWinMain 60Hz 루프 |

## 4. 결정론과 루프

- `QueryPerformanceCounter` 고정 60Hz, 프레임당 최대 5틱 후 잔여 지연 폐기.
- RNG는 시드 저장 xorshift32 단일 스트림. 같은 seed+입력이면 같은 셔플·웨이브 — selftest가 600틱 상태 해시 동일성으로 단언.
- 상점·일시정지 중 시뮬레이션 정지. 동일 틱 64/FORMAT 동시 도달은 승리 우선(판정 순서 코드 고정).
- **알려진 한계**: 좌표에 float 사용. 같은 빌드·같은 머신에서는 완전 결정론이나, TODAY 결과의 기기 간 비교는 IEEE 일치에 의존한다(x64 MSVC 기본 /fp:precise에서 실용상 일치). 크로스 머신 리플레이 검증은 W6 호환성 테스트에 포함.

## 5. 텍스트 렌더링 — 결정 변경 (구 스펙 §12-9 대체)

**구 계획**: 사용 글리프만 2bpp로 구워 임베드(8KB 목표). **현재 구현**: `CreateFontW(GulimChe, HANGUL_CHARSET)` GDI 출력.

- 채택 이유: 두 번째 폰트 파이프라인(추출 도구+글리프 ID 시퀀스) 제거. 크기는 이미 문제가 아니므로 8KB 절약의 근거가 소멸.
- **잔여 리스크**: 한국어 언어팩 없는 Windows에는 GulimChe가 없어 글리프가 깨질 수 있다. 국내 공모전이라 심사 PC는 한국어 환경일 가능성이 높지만 **확인된 사실이 아니다**.
- **게이트(W6)**: 영문 클린 Windows 10/11 VM에서 실행 확인. 깨지면 그때 글리프 subset 임베드로 회귀(구 스펙 §12-9 절차 부활). 이 확인 전에는 임베드 작업을 하지 않는다.

## 6. 테스트 하니스

### selftest (`build.bat test`, SELF_TEST 정의)

현행 커버: 마스크 불변식 41개 / 채널·시작 결정론 / 예상 SIGNAL 검산 30 / PREFETCH +1·소거 / MACRO SIGNAL 비복사 / 버스트 1회성·저자극·다중 문턱 / 지침 3종 보너스 경계 / BAD 상한 / PATCH 최소 덱 / 9 NODE 풀런·FORMAT 패배 / 동일 틱 승리 / 도장 4종 경계 / TODAY 상태 해시 리플레이 / 4빌드 경로 스모크 / GO LIVE 조기·강제 / 최악 충돌 벤치 / 뮤트 무음.

수정 필요: MIRROR 스모크가 12장 추가(실전 불가 경제)로 통과 중 → [20_BALANCE.md](20_BALANCE.md) 결함-1 수정 시 9구매 제약 덱으로 교체.

### SIM (구현 완료, 2026-07-14)

20_BALANCE §SIM 명세의 몬테카를로가 SELF_TEST 하니스에 포함되어 `build.bat test`마다 실행된다(240런, 수 초). 정책별 결과는 `build/simtest.csv`, 수용 기준(4경로 승리 가능·70% 독점 금지)은 assert로 강제된다. SELF_TEST 전용 코드이므로 릴리스에 포함되지 않는다.

### DEV 빌드 (`build.bat debug`, DEV_LOG 정의)

- 종료 시 `playtest.csv` 1줄 기록(스키마는 코드 정본). **주의: F5~F9 치트키 사용 세션이 섞이므로 밸런스 집계 전 반드시 분리** — 치트 사용 시 `cheated` 컬럼 1을 기록하도록 W-BAL에서 스키마에 추가한다.
- 치트: F5 상점 강제 / F6 4:30 LIVE / F7 SIGNAL+16 / F8 즉사 / F9 엔딩 스킵.

## 7. 릴리스 체크리스트 (제출 전)

1. `build.bat test` PASS → `build.bat` 크기·의존·SHA256 기록.
2. VC++ 재배포 없는 클린 Windows 10/11 두 대(한국어 1, 영문 1 — §5 게이트 겸용)에서 실행.
3. 한글·공백 경로, 읽기 전용 폴더, 네트워크 차단, 오디오 장치 없음, 포커스 전환, Alt+F4.
4. Defender 빠른 검사 — 탐지 시 패커류 우회가 아니라 코드 원인 제거.
5. 제출 폼 업로드→다운로드→재실행 드라이런.
