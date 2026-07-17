# ECHO/144에 적용할 1.44MB 레퍼런스 심층 분석

## 핵심 결론

업로드한 네 개의 조사문은 참고 가치가 높습니다. 다만 ECHO/144가 가져와야 할 것은 “더 작은 EXE를 만드는 묘기”나 “유명 경량 엔진” 자체가 아닙니다.

가장 가치 있는 원칙은 다음 여덟 가지입니다.

| 우선순위 | 가져올 원칙                | ECHO/144에서의 적용                      |
| ---: | --------------------- | ----------------------------------- |
|    1 | **에셋 대신 레시피를 저장**     | 카드 이펙트·적 패턴·배경·음악을 작은 파라미터로 생성      |
|    2 | **단일 핵심 동사와 깊은 변주**   | `CUE` 하나를 편성·발동·복제·봉인·오염의 중심으로 사용   |
|    3 | **게임 상태와 표현의 분리**     | 결정론적 게임 코어 + 렌더·오디오 이벤트 계층          |
|    4 | **카드를 원자 효과 조합으로 정의** | 카드 1장당 전용 코드 대신 4~6개의 작은 효과 명령      |
|    5 | **적 의도를 미리 공개**       | 손패를 보고 적 의도에 대응하는 수동 편성             |
|    6 | **간단한 전략 봇으로 밸런스 검증** | Big BAUD·Engine·Archive Rush 등 정책 봇 |
|    7 | **죽음·실패 뒤 즉시 재도전**    | 1초 미만 재시작, 같은 시드 재도전, 이전 방송 리플레이    |
|    8 | **후반에 한 번의 압도적 합성**   | 덱 전체가 `최종 방송 프로토콜` 하나로 컴파일          |

반대로 다음은 공모전판에서 채택하지 않는 것이 좋습니다.

* raylib·Odin으로의 전면 마이그레이션
* Crinkler·UPX 중심의 실행 파일 압축
* `.kkrieger`식 본격 절차적 3D·텍스처 생성
* GPU 셰이더 중심 렌더러 재작성
* 뱀서식 경험치 보석·상시 3택 레벨업
* 무기 슬롯 6개와 별도 진화 트리
* 런타임 XML 카드 정의
* JavaScript식 전체 불변 상태 복사
* 프로파일링 전 공간 해시·ECS·멀티스레드 도입

현재 공모전 규칙은 압축 해제 후 실행 가능한 전체 결과물이 정확히 **1,474,560바이트 이하**여야 하고, 엔진과 런타임도 포함되며, 독립 실행 파일이어야 합니다. 내부 데이터 압축은 허용됩니다. ([2pgarcade.com][1])

현재 저장소 기술 문서에는 2026년 7월 14일 빌드가 **135,168바이트**, 제한의 약 9.2%, 최악 충돌 틱 0.162ms라고 기록되어 있습니다. 최신 리팩터링 후 다시 측정해야 하지만, 문서상의 수치만 보면 ECHO/144는 지금 **용량과 성능이 아니라 의사결정 밀도와 게임 구조가 병목**입니다. ([GitHub][2])

---

# 1. 업로드 조사문 검증과 보정

네 조사문은 각각 기술·레포지터리·저용량 게임 사례·덱빌더/서바이버 구현을 다룹니다. 전체적인 방향은 적절하지만, 일부 표현은 범용적인 추천을 ECHO/144에 바로 적용하기에는 과장되어 있습니다.    

## 1.1 “1.44MB는 생각보다 크다” — 정확하며 가장 중요한 전제

이는 맞습니다.

현재 ECHO/144가 문서상 135KB 수준이라면 약 1.3MB의 여유가 있는 셈입니다. 물론 이후 캐릭터 프레임, 한글 글꼴, 음악 패턴, 엔딩, 카드 데이터가 늘어나겠지만, 2D 팔레트 픽셀 게임에서 1.44MB는 “아무것도 못 넣는 제한”이 아닙니다.

따라서 다음과 같은 사고는 버려야 합니다.

> “용량이 작으니 캐릭터 애니메이션을 못 넣는다.”
> “용량이 작으니 카드 효과가 모두 레이저여야 한다.”
> “용량이 작으니 스토리와 엔딩을 못 넣는다.”
> “용량이 작으니 적 종류와 반복 변주가 적을 수밖에 없다.”

실제로 16×16 2bpp 프레임은 64바이트이고, 24×24 4bpp 프레임도 288바이트입니다. 주요 캐릭터 애니메이션 100프레임을 추가해도 원시 데이터 기준 약 28.8KB입니다. 런타임 그림 데이터는 텍스트·일러스트 PNG보다 훨씬 작게 설계할 수 있습니다.

ECHO/144의 실제 제한은 다음입니다.

* 한 명 또는 소수 인력의 제작 시간
* 카드와 이펙트의 가독성
* 320×240 화면의 정보 밀도
* 전투와 편성의 템포
* 테스트 가능한 규칙 수
* 심사 마감까지의 안정화 시간

즉 **바이트보다 디자인 복잡도 예산을 관리해야 합니다.**

---

## 1.2 raylib — 좋은 라이브러리지만 현재 교체 이유는 없다

raylib은 2026년 4월 v6.0이 공개됐고, C 기반이며 정적 링크가 가능한 zlib 라이선스를 사용합니다. 프로토타이핑, 교육, 도구 제작과 멀티플랫폼 게임에 좋은 선택입니다. ([GitHub][3])

다만 조사문의 “정적 링크 시 500KB~1MB” 같은 수치는 빌드 옵션·백엔드·컴파일러·사용 모듈에 따라 달라지는 경험적 범위이지 보장값이 아닙니다.

ECHO/144에는 이미 다음이 구현되어 있습니다.

* Win32 창
* 입력
* 320×240 소프트웨어 프레임버퍼
* GDI 출력
* waveOut 오디오
* 고정 틱
* 결정론 RNG
* 빌드 크기 검사
* 테스트 하니스

raylib으로 바꾸면 얻는 것은 편한 API와 멀티플랫폼 기반이지만, 잃는 것은 다음입니다.

* 이미 검증한 코드
* 작은 현재 EXE
* Win32 동작에 대한 직접 통제
* 기존 테스트와 빌드 안정성
* 남은 기간

raylib 전환은 재미를 개선하지 않습니다. 현재 문제인 자동 카드 실행, 공간적으로 비슷한 공격, 약한 손패 의사결정은 엔진을 바꿔도 그대로 남습니다.

### 판정

```text
공모전판: 불채택
별도 프로토타입·툴: 사용 가능
향후 대형 확장판: 후보
```

---

## 1.3 Sokol — 확장판의 가장 적합한 플랫폼 계층

Sokol은 독립적으로 사용할 수 있는 작은 C 헤더 집합이고, 창·입력, D3D11·Metal·GL·WebGPU 그래픽, 오디오 스트리밍, CPU 프레임버퍼, 레터박스 유틸리티를 제공합니다. 공식 문서도 실행 파일 오버헤드를 작게 유지하는 것을 설계 이유 중 하나로 밝히고 있습니다. 2026년 7월에도 활발히 변경되고 있습니다. ([GitHub][4])

특히 ECHO/144에는 다음 두 유틸리티가 잘 맞습니다.

* `sokol_framebuffer.h`: CPU 프레임버퍼를 GPU로 표시
* `sokol_letterbox.h`: 고정 종횡비와 정수 배율 출력 계산

향후 Windows 외 플랫폼, Steam Deck, macOS, 웹 데모, 하드웨어 셰이더를 고려하면 Sokol이 현재 구조에서 가장 자연스러운 확장 경로입니다.

### 판정

```text
공모전판: 도입하지 않음
확장판: 플랫폼·렌더·오디오 계층 1순위
게임 코어: 지금부터 Sokol 없이도 분리
```

---

## 1.4 Crinkler·UPX — 기술적으로 가능하지만 프로젝트 목적에는 맞지 않음

Crinkler는 수 KB 규모의 1k·4k·8k 데모를 위한 압축 링커입니다. 2026년 5월에도 새 버전이 나왔지만, 공식 설명 자체가 “몇 KB짜리 데모씬 실행 파일”을 목표로 한다고 명시합니다. ([GitHub][5])

UPX는 일반 실행 파일을 통상 상당히 줄일 수 있지만, 현재 프로젝트는 압축이 없어도 크기 여유가 큽니다. ([GitHub][6])

패커 사용은 다음 문제를 만듭니다.

* Defender·SmartScreen 오탐 가능성 증가
* 크래시 덤프와 스택 분석 난도 증가
* 패킹 전·후 실행 환경 차이
* 제출 PC에서의 불확실성
* “무패킹 단일 EXE”라는 현재 기술 철학 훼손

현재 기술 문서도 패커를 영구 불채택으로 기록하고 있으며, 클린 Windows와 Defender 검사까지 릴리스 게이트로 둡니다. ([GitHub][2])

### 판정

```text
실행 파일 패커: 불채택
내부 자산 압축: 필요할 때만 채택
```

---

## 1.5 `.kkrieger` — 기술을 복제하지 말고 사고방식을 가져와야 한다

`.kkrieger`는 텍스처의 픽셀을 저장하는 대신 생성 이력을 저장하고, 기본 입체를 변형해 메시를 만들며, V2 신시사이저가 MIDI 데이터를 실시간 음악으로 변환합니다. 전체가 97,280바이트이며, 일반 방식으로 저장했다면 훨씬 큰 콘텐츠가 되었을 것이라는 설명이 공개 소스에 포함돼 있습니다. ([GitHub][7])

하지만 ECHO/144에 노이즈 텍스처 생성기, 메시 변형기, 레이마칭을 넣는 것은 잘못된 적용입니다.

가져올 원칙은 이것뿐입니다.

> **결과물을 저장하지 말고 결과물을 만드는 문법을 저장한다.**

이를 ECHO/144에 맞게 번역하면 다음과 같습니다.

| 저장할 결과물          | 대신 저장할 레시피                |
| ---------------- | ------------------------- |
| 카드별 완성 이펙트 애니메이션 | 도형·방향·속도·수명·팔레트·히트 규칙     |
| 적 웨이브 배열 전체      | 적 의도 카드·시드·웨이브 문법         |
| 시간층별 배경 이미지      | 배경 프레임·그리드·오류 오버레이 파라미터   |
| 여러 곡의 PCM/WAV    | 모티프·음표·악기 패치·패턴           |
| 색상별 스프라이트 복제     | 인덱스 스프라이트 + 팔레트 리맵        |
| NØA의 공격 애니메이션    | 플레이어 효과 레시피의 대상·방향·팔레트 반전 |
| 모든 채팅 문장         | 작가가 만든 짧은 문장 조각과 제한된 문법   |

이것이 `.kkrieger`로부터 가져올 정확한 부분입니다.

---

## 1.6 Slay the Web — 구조는 매우 유용하지만 그대로 복제하지 않는다

Slay the Web은 전체 게임 상태를 하나의 UI 독립 상태로 보존하고, 모든 행동을 액션으로 표현하며, 액션 설명을 큐에 넣고 순서대로 처리합니다. 콘텐츠, 게임 코어, UI, 테스트도 분리합니다. 적은 다음 행동인 `intent` 목록을 갖습니다. ([GitHub][8])

이는 ECHO/144에 매우 유용합니다.

다만 JavaScript식으로 매 액션마다 전체 상태를 복사하고 새 객체를 반환하는 방식은 C와 60Hz 실시간 게임에는 불필요합니다.

### ECHO/144식 번안

```c
bool game_apply_command(
    GameState *state,
    const GameCommand *command,
    GameEventBuffer *events
);
```

* `GameCommand`: 플레이어 또는 적이 무엇을 하려는가
* `GameState`: 실제 결정론 상태
* `GameEventBuffer`: 화면·음향에 보여 줄 결과
* 함수는 상태를 직접 수정
* 모든 명령은 로그에 남길 수 있음
* 렌더러는 상태를 변경하지 않음

예:

```c
GameCommand command = {
    .type = CMD_CUE_CARD,
    .actor = ACTOR_ECHO,
    .card_slot = 2
};

game_apply_command(&game, &command, &events);
```

이 구조로 얻는 것은 다음입니다.

* 결정론 리플레이
* TODAY 시드 재현
* 테스트에서 명령 단위 검증
* NØA가 플레이어 명령을 모방
* 시크가 이전 방송을 재생
* 디버그 로그
* 전략 봇
* 향후 확장판 프런트엔드 교체

---

## 1.7 Dominiate — 코드를 쓰기보다 밸런스 봇 철학을 가져온다

Dominiate는 카드를 살 조건과 우선순위를 나열하는 간단한 전략 봇으로 도미니언 전략을 비교합니다. 다만 개발자 본인도 핵심 코드가 2014년 중심의 오래된 CoffeeScript라고 명시합니다. ([GitHub][9])

가져올 것은 코드가 아니라 이 방법입니다.

```text
전략 = 구매 우선순위
     + 프로그램 사용 우선순위
     + OPEN CHANNEL 전환 조건
     + 정리 조건
```

예:

```c
static PurchaseRule BIG_BAUD_RULES[] = {
    { CARD_56K,      COND_CAN_AFFORD },
    { CARD_ARCHIVE,  COND_ECHO_BELOW_TARGET },
    { CARD_14K,      COND_ALWAYS },
    { CARD_DEFRAG,   COND_NOISE_AT_LEAST_2 },
};
```

복잡한 강화학습 없이도 다음 질문을 검증할 수 있습니다.

* Big BAUD가 모든 시장에서 최선인가
* Engine이 구축 비용을 회수하는가
* 아카이브 조기 구매가 실제로 위험한가
* Sponsor 카드가 너무 강한가
* 시크 경로가 단순 청록 경로보다 항상 안전한가
* 특정 프로그램이 매번 첫 구매인가

ECHO/144는 이미 몬테카를로 시뮬레이션과 네 경로 검사를 갖고 있으므로, 이 구조를 정교하게 확장하는 것이 매우 높은 ROI를 가집니다. ([GitHub][2])

---

## 1.8 XML 기반 카드 엔진 — 아이디어는 좋지만 해당 레포는 교과서가 아니다

조사문이 언급한 `deck-builder-game`은 게임 규칙과 카드 효과를 XML로 구성하고, 효과 이름을 원자 액션 함수에 연결합니다. 이 발상은 좋습니다.

하지만 해당 프로젝트 README는 아직 게임이 실제로 플레이 불가능하고, 여러 액션과 테스트가 미구현임을 명시합니다. 따라서 완성된 아키텍처의 레퍼런스라기보다 **원자 효과 조합 아이디어의 참고 자료**로 봐야 합니다. ([GitHub][10])

ECHO/144에서는 런타임 XML을 사용하지 않습니다.

```text
개발 원본: JSON/CSV/TSV
↓ Python 빌드 도구
검증·ID 생성·문자열 변환
↓
압축된 C 배열
```

런타임은 XML 파서·문자열 검색·리플렉션을 전혀 포함하지 않습니다.

---

## 1.9 Cat Survivors — “13KB에서도 된다”보다 더 중요한 교훈

js13kGames 2025의 `Cat Survivors`는 12.91KB이며 종합 상위권에 들었습니다. 심사 피드백은 콘텐츠와 비주얼을 칭찬하면서도 적이 느리고 플레이어가 강해 실질적인 위험이 약하다는 점을 지적했습니다. ([js13kGames 2026][11])

이는 ECHO/144에 중요한 경고입니다.

> 서바이버류를 작은 용량에 넣는 것은 어렵지 않다.
> **10분 동안 위협과 성장 곡선을 유지하는 것이 어렵다.**

따라서 적 수와 무기 수를 늘리기보다 다음을 검증해야 합니다.

* 플레이어가 위험을 읽고 피해야 하는가
* 이동 경로를 바꾸게 하는 적이 있는가
* 현재 손패 때문에 다른 위치를 선택하는가
* 강해진 뒤에도 NØA가 대응하는가
* 후반이 단순 청소 작업으로 변하지 않는가

---

## 1.10 CLAWSTRIKE — 즉시 재시작과 같은 콘텐츠의 재해석

CLAWSTRIKE는 자주 죽더라도 재시작이 즉각적이어서 흐름을 끊지 않는 것을 명시적 설계로 두며, 클리어 후 같은 콘텐츠를 다른 규칙으로 플레이하는 `9 Lives Mode`를 해금합니다. ([GitHub][12])

ECHO/144에서 가져올 것은 다음입니다.

```text
실패 → 1초 이내 같은 시드 재시작
결과 화면 → 재도전 / 새 신호 두 선택
클리어 → 새 능력치가 아니라 새 규칙 모드
```

예:

* `MIRROR LINE`: NØA가 첫 턴부터 프로그램을 모방
* `ARCHIVE LINE`: 이전 런의 손패 기록이 호박색 고스트로 등장
* `NO RESPONSE`: 아카이브가 더 적지만 청록 메아리 가치 증가
* `PERFECT CHAT`: 모든 채팅이 처음부터 합성되어 있음
* `SHORTEST LIVE`: 64까지 필요한 턴 수 경쟁

같은 적·카드·배경을 재사용하면서 완전히 다른 의미를 만들 수 있습니다.

---

## 1.11 Vampire Crawlers — 장르 융합의 가능성과 실패 위험을 동시에 보여 준다

2026년 4월 출시된 Vampire Crawlers는 공식적으로 턴제·카드 기반 던전 크롤러이며, 카드의 마나 비용을 오름차순으로 이어 효과를 증폭하고 강력한 조합을 만드는 구조입니다. 이는 “서바이버의 과장된 성장 쾌감과 덱빌더를 합치는 것”이 상업적으로 이해 가능한 콘셉트임을 보여 줍니다. ([Steam Store][13])

다만 평가가 한 방향으로만 모이지는 않았습니다.

The Verge는 단순한 숫자 순서 조합이 강한 빌드를 순환시키는 만족감을 준다고 평가했지만, PC Gamer는 오름차순이 너무 명백한 최적해가 되어 오랫동안 같은 순서로 카드를 내게 되고, 의미 있는 선택과 난도가 너무 늦게 열린다고 비판했습니다. ([PC Gamer][14])

ECHO/144가 반드시 피해야 할 실수입니다.

```text
카드가 많다
≠ 선택이 많다

콤보가 길다
≠ 전략이 깊다

강한 최종 빌드가 있다
≠ 그 과정이 재미있다
```

따라서 ECHO/144의 카드 선택은 “항상 왼쪽부터”, “항상 오름차순”, “항상 같은 LINK”가 되어서는 안 됩니다.

같은 손패라도 다음에 따라 다른 선택이 나와야 합니다.

* 적 의도
* 현재 위치
* 구매 목표
* 청록·호박·자홍 링 상태
* NØA가 학습 중인 TREND
* 다음 셔플까지 남은 카드
* OPEN CHANNEL까지 남은 턴
* 현재 SYNC 등급

---

# 2. 현재 ECHO/144에서 가장 크게 바꿔야 하는 부분

현재 `main`의 규칙 문서는 다음 구조입니다.

```text
5장 자동 실행
→ 이동·SEEK
→ 일정 시간마다 NODE 정지
→ 다음 5장의 B 합으로 구매
→ GO LIVE
→ SIGNAL 64 대 FORMAT 100%
```

문서도 “아래 5장이 왼쪽부터 자동 실행된다”를 첫 온보딩 문장으로 사용하며, 플레이어의 주 조작은 이동이고 SEEK는 선택적 보조입니다. ([GitHub][15])

이 구조의 좋은 점은 다음입니다.

* 접근이 쉽다.
* 실시간 이동과 카드 UI가 충돌하지 않는다.
* 덱 순환을 관찰할 수 있다.
* 구매 카드가 다음 셔플 뒤 돌아오는 시간 구조가 있다.
* 미래 조각의 현재 부담과 후반 반전이 있다.
* 구현과 자동 시뮬레이션이 단순하다.

그러나 V2 콘셉트와 목표에는 다음이 부족합니다.

* 손패가 나온 뒤의 선택
* 액션 수 제한
* 강한 프로그램 간 충돌
* 현재 생존과 미래 구매의 직접적인 선택
* 카드 사용 위치와 타이밍
* 적 행동을 읽고 대응하는 전략
* 카드가 공간을 바꾸는 감각
* NØA가 플레이어를 학습한다는 체감
* 한 런 안에서 전략이 온라인 되는 순간
* 덱이 최종 방송 형태로 변환되는 장면

이를 해결하려면 자동 실행에 작은 기능을 덧붙이는 정도가 아니라, **자동 캐리어 + 수동 프로그램** 구조로 바꿔야 합니다.

---

# 3. 제안하는 최종 핵심 루프

## 장르 정의

> **5장 방송 구절을 편성하고 직접 발동하는 실시간 솔로 덱빌더 서바이버**

## 한 구절의 사이클

```text
[INTENT]
다음 8초에 벌어질 적 행동 공개

↓

[EDIT]
5장 손패 공개
CARRIER를 TX 또는 RX로 지정
CUE를 소비해 PROGRAM 편성
SEEK로 카드 한 장 교체

↓

[ON AIR]
약 7~9초 실시간 전투
TX 캐리어는 자동 공격
Space로 준비한 PROGRAM을 원하는 순간 발동
플레이어는 에코를 이동

↓

[CLEANUP]
사용·미사용 카드 처리
버림더미 이동
필요 시 셔플

↓

두 구절마다 [BREAK]
RX 대역으로 카드 한 장 구매 또는 정리
```

이 구조는 도미니언과 서바이버의 역할을 명확히 나눕니다.

```text
EDIT       도미니언의 손패·액션 경제
ON AIR     서바이버의 이동·공간·타이밍
BREAK      도미니언의 구매·덱 성장
OPEN       뱀서·홀로큐어의 최종 진화
```

---

# 4. 가장 강하게 권하는 신규 메커니즘: CARRIER의 `TX / RX` 양면 사용

현재 모뎀 카드는 공격과 구매력을 동시에 제공합니다. 이는 이해하기 쉽지만, 모뎀이 현재 생존과 미래 경제를 모두 해결해 다른 카드군보다 구조적으로 유리해질 가능성이 큽니다.

이를 다음처럼 바꿉니다.

## TX — 송신

```text
이번 ON AIR에서 자동 공격
구매 대역에는 기여하지 않음
```

## RX — 수신·다운로드 예약

```text
이번 ON AIR에서는 공격하지 않음
BREAK에서 BAUD 제공
```

예:

| 카드   | TX         |     RX |
| ---- | ---------- | -----: |
| 2400 | 작은 패킷 연사   | BAUD 1 |
| 14K  | 관통 패킷 열    | BAUD 2 |
| 56K  | 적 사이 지속 회선 | BAUD 3 |

손패:

```text
2400 / 14K / MULTI / CHAT / FIREWALL
```

플레이어는 다음처럼 판단합니다.

### 현재 적 의도가 BOT RAID

```text
2400 TX
14K TX
FIREWALL CUE
구매력 0
```

지금 살아남는 선택입니다.

### 현재 적 의도가 약한 FILE DRIFT

```text
2400 RX
14K RX
MULTI 미사용
구매력 3
```

현재 화력을 포기하고 다음 프로그램을 삽니다.

이 한 규칙은 다음을 동시에 해결합니다.

* Treasure와 공격 카드의 역할 혼합 문제
* 현재 생존과 장기 성장의 긴장
* 손패마다 결정이 부족한 문제
* 모뎀 카드를 많이 산 전략의 개성
* 구매력이 자동으로 생기는 문제
* 프로그램·아카이브가 덱을 희석하는 체감
* 방송이라는 세계관

## 입문성 보호

초보자에게는 첫 세 구절 동안 자동 추천을 표시합니다.

```text
위험 높음 → TX 추천
위험 낮음 → RX 추천
```

또는 접근성 옵션으로 `자동 대역 배정`을 제공할 수 있습니다.

하지만 기본 규칙에서 플레이어가 언제 투자하고 언제 버틸지 결정하게 해야 합니다.

이 메커니즘은 ECHO/144의 새로운 중심 후보입니다.

---

# 5. 핵심 동사는 `CUE` 하나로 통일

Celeste Classic이나 PICOHOT 같은 소규모 게임의 강점은 동사 수가 적고, 그 한 동사의 의미가 계속 바뀐다는 점입니다. 업로드 조사문도 저용량 게임의 반복 패턴으로 “단일 동사, 깊은 변주”를 강조합니다. 

ECHO/144의 핵심 동사는 다음이어야 합니다.

> **CUE — 다음에 무엇을 방송할지 지정하고, 원하는 순간 내보낸다.**

`CUE`는 단순 카드 선택 버튼이 아닙니다.

* 프로그램을 활성화한다.
* 프로그램 실행 순서를 정한다.
* MULTI가 추가 CUE를 준다.
* NØA가 CUE된 프로그램을 학습한다.
* 적이 CUE 슬롯을 봉인한다.
* 시크가 CUE된 아카이브를 보관한다.
* MACRO가 직전 CUE를 재생한다.
* CACHE가 CUE를 다음 구절로 넘긴다.
* 최종 방송이 가장 많이 CUE한 태그를 계승한다.

## 기본 액션 경제

```text
기본 CUE 1
```

PROGRAM은 일반적으로 CUE 1을 소비합니다.

```text
MULTI.FORK  → CUE +1
CACHE.RAM   → 다음 구절 CUE 보존
SPONSOR     → CUE +1, 자홍 메아리 증가
NOISE       → CUE 슬롯 방해
```

강한 프로그램을 많이 사도 한 손패에서 전부 사용할 수 없으므로, 도미니언의 terminal collision이 복원됩니다.

---

# 6. 프로그램은 EDIT에서 선택하고 ON AIR에서 수동 발동

모든 카드를 일일이 수동으로 발동시키면 조작 부담이 커집니다.

따라서 다음 경계를 권합니다.

## 자동

* TX로 지정된 CARRIER
* 단순 지속 효과
* REACTION 카드
* 아카이브의 작은 패시브
* 기본 최근접 조준

## 수동

* 범위 프로그램
* 방어벽
* 연결 공격
* 화면 절단
* 카드 복제
* 긴급 방어
* 최종 방송 기술

조작은 다음 정도면 충분합니다.

```text
WASD / 방향키     이동
Space              다음 CUE 프로그램 발동
Space 길게         쿨다운마다 자동 발동
Shift              향후 REACTION/보조 기능
```

P0 프로토타입에서는 Shift를 빼도 됩니다.

## 난도가 생기는 위치

버튼 수가 아니라 다음에서 숙련도가 발생합니다.

* 발동 위치
* 발동 시점
* 프로그램 순서
* 적 의도 대응
* CARRIER의 TX/RX 배분
* NØA의 TREND 유도
* 셔플 예측
* OPEN CHANNEL 전환 시점

---

# 7. Cave Story에서 가져올 교차 시스템: `SYNC`

Cave Story의 무기 경험치가 피격으로 감소하는 구조는 신규 콘텐츠 없이 공격 성장과 회피를 직접 연결합니다. 업로드 조사문이 강조한 “기존 시스템 둘을 연결하는 규칙 하나”의 좋은 사례입니다. 

ECHO/144에는 이를 그대로 무기 레벨로 넣지 않고 **방송 동기화 `SYNC`**로 번역하는 것이 좋습니다.

## SYNC 규칙

```text
SYNC 0~3
```

### 상승

* 한 구절을 피격 없이 종료
* 예고된 적 의도에 적합한 프로그램 사용
* 마킹한 적을 회선으로 연쇄 제거
* 프로그램을 적절한 타이밍 창에 발동

### 하락

* 큰 피해를 받음
* CUE 프로그램을 사용하지 못하고 구절 종료
* NØA의 MUTE에 프로그램 봉인
* 가짜 메아리를 그대로 수용

## 효과

| SYNC | 효과                             |
| ---: | ------------------------------ |
|    0 | 기본 상태                          |
|    1 | CARRIER 시각·사운드 강화              |
|    2 | 프로그램 범위 또는 지속시간 소폭 증가          |
|    3 | 구절 종료 시 작은 청록 메아리 또는 CUE 일부 환급 |

## 피격 후 악순환 방지

Cave Story식 레벨다운을 그대로 쓰면 한 번 맞은 플레이어가 더 약해지고 다시 맞는 악순환이 생길 수 있습니다.

따라서 다음 안전장치를 둡니다.

* 한 번의 피격으로 최대 1단계만 감소
* SYNC 0에서는 추가 감소 없음
* 피격 후 다음 구절의 첫 성공으로 즉시 1 회복
* HP와 구매력은 직접 감소시키지 않음
* 최종 엔딩 조건에는 필수가 아님

SYNC는 고수의 점수·화려함·최적화를 높이되, 초보자의 기본 클리어를 막지 않아야 합니다.

---

# 8. 적 의도 오토마 덱

Slay the Web의 적 `intent`, 솔로 도미니언의 더미 상대, 조사문이 언급한 Pyramid·Curse Race의 장점을 하나로 묶는 방식입니다.

## 기본 구조

각 시간층은 8~12장의 `AUDIENCE INTENT` 덱을 가집니다.

매 구절 시작에 다음 적 행동 한 장을 공개합니다.

```text
BOT RAID
동쪽에서 작은 봇 다수 진입
```

```text
MUTE
현재 손패 PROGRAM 한 장 봉인
```

```text
GIFT DROP
중앙에 강한 보상과 위험 동시 생성
```

```text
TREND
가장 많이 사용한 프로그램을 NØA가 복제
```

플레이어는 이를 보고 EDIT를 수행합니다.

## 기본 의도 카드

| 의도             | 전장 변화        | 전략적 대응             |
| -------------- | ------------ | ------------------ |
| BOT RAID       | 다수 소형 적      | CHAT, SURGE, TX 강화 |
| MUTE           | 슬롯 봉인        | MULTI, CHECKSUM    |
| COMMENT WALL   | 이동 경로 차단     | 관통, CLIP, FIREWALL |
| GIFT DROP      | 위험 지역에 보상    | 방어, 기동             |
| CLIP THEFT     | 직전 효과 탈취     | 약한 기술 미끼           |
| SEEK HUNT      | 아카이브 탈취      | 빠른 단일 피해           |
| SPONSORED RAID | 강한 적 + 무료 카드 | 위험한 투자             |
| MIRROR         | 첫 프로그램 반사    | 실행 순서 변경           |
| LATENCY        | 발동 지연        | CACHE, PREFETCH    |
| EMPTY CHAT     | 적은 적, 메아리 감소 | RX 투자 또는 아카이브 사용   |

## 절차 생성 방법

완전 무작위로 섞지 않습니다.

```text
초반 3장     학습 가능한 단순 의도
중반 4장     덱과 카드 슬롯 공격
후반 3장     플레이어 전략 대응
종결 2장     NØA 시그니처
```

제약:

* 같은 의도 2연속 금지
* 해결 수단이 시장에 없는 의도는 제한
* 초반에 MUTE와 MIRROR 동시 등장 금지
* 아카이브를 보유하지 않은 플레이어에게 SEEK HUNT 금지
* 가장 강한 의도 뒤에는 회복 또는 투자 구절 1개

이렇게 하면 하나의 아레나에서도 레벨 디자인이 생깁니다.

---

# 9. NØA의 핵심: TREND MIRROR

현재 조사 자료 중 ECHO/144에 가장 고유하게 발전시킬 수 있는 부분은 **상대가 플레이어의 전략을 학습하는 것**입니다.

## 기록

게임은 각 PROGRAM의 다음 값을 기록합니다.

```text
CUE 횟수
실제 발동 횟수
적중 수
총 피해
사용 구절 수
최근 사용 시점
```

NØA는 단순히 총 피해가 높은 카드가 아니라 **가장 반복적으로 의존한 패턴**을 TREND로 선택합니다.

예:

```text
MULTI  7회
SURGE  6회
FIREWALL 4회
```

NØA가 `MULTI` 또는 `SURGE` 계열을 학습합니다.

## 모방은 색상 변경이 아니라 의미 반전

| 플레이어 기술               | NØA 모방             |
| --------------------- | ------------------ |
| FIREWALL이 안전 공간 생성    | 닫히는 사각 감옥          |
| SURGE가 적끼리 연결         | 플레이어와 적을 연결        |
| MARKER가 적에게 번호 부여     | 에코에게 추적 번호 부여      |
| CACHE가 카드 보존          | 준비 카드 하나를 복제·격리    |
| PREFETCH가 다음 카드를 보여 줌 | 다음 프로그램을 미리 봉인     |
| MACRO가 직전 공격 재생       | 이전 공격을 반대 방향으로 되돌림 |
| MULTI가 CUE 증가         | 가짜 NØA 초상 동시 생성    |
| CHECKSUM이 오염 복구       | 청록 메아리를 자홍으로 재서명   |

이것은 다음 네 가지를 동시에 해결합니다.

1. NØA의 “모든 관객을 흉내 낸다”는 캐릭터성
2. 같은 빌드 반복에 대한 자연스러운 카운터
3. 기존 이펙트 레시피 재사용
4. 플레이어가 자신의 습관을 의식하게 만드는 반복 플레이

## 고급 전략: TREND BAIT

숙련자는 일부러 약한 프로그램을 자주 사용해 NØA가 잘못된 기술을 TREND로 학습하게 할 수 있습니다.

그러나 이를 너무 쉽게 악용하지 못하도록:

* 최근 6구절에 더 높은 가중치
* CUE 횟수와 실제 기여도를 함께 계산
* NØA가 48 메아리에서 TREND를 한 번 갱신
* 고난도에서는 상위 2개 프로그램을 조합

하는 편이 좋습니다.

---

# 10. HoloCure식 후반 합성은 하나만 가져온다

HoloCure의 Super Collab은 여러 조건을 만족한 뒤 한 런에서 강한 최종 결합 하나를 만드는 구조입니다. 현재 규칙에서도 필요한 Collab과 진행 조건을 충족해야 하고, 한 런의 중요한 후반 목표가 됩니다. ([Holocure][16])

ECHO/144에 수십 개의 무기 진화표를 넣는 것은 부적합합니다.

대신 OPEN CHANNEL에서 **덱 전체를 단 하나의 최종 방송 프로토콜로 컴파일**합니다.

## 1차 결정 — 아카이브 구성

| 우세 아카이브   | 최종 형태                       |
| --------- | --------------------------- |
| CHAT.LOG  | `CHATSTORM` — 글리프 군집과 연쇄    |
| VOICE.OGG | `RESONANCE` — 음파·넉백·안전 공간   |
| CLIP.20?? | `FRAMECUT` — 대형 화면 절단·보스 피해 |
| 균형        | `OPEN ECHO` — 세 형태 순환       |

## 2차 결정 — PROGRAM 태그

| 우세 태그             | 수정자                    |
| ----------------- | ---------------------- |
| MULTI·CACHE       | `REPEAT` — 반복·복제       |
| MARKER·SURGE      | `NETWORK` — 적 사이 연결    |
| FIREWALL·CHECKSUM | `SAFE` — 공격이 방어 공간 생성  |
| MACRO·PREFETCH    | `REPLAY` — 이전·다음 구절 참조 |

예:

```text
CHATSTORM + NETWORK
→ 채팅 글리프가 표식 적 사이를 연쇄 이동
```

```text
RESONANCE + SAFE
→ 음파가 적탄을 밀어내며 안전 지대 생성
```

```text
FRAMECUT + REPLAY
→ 화면 절단이 같은 위치에 한 번 더 재생
```

실제 구현은 핵심 효과 3~4개와 수정자 4개지만, 플레이어에게는 여러 최종 빌드가 보입니다.

---

# 11. 64개의 메아리와 세 색은 모든 시스템을 연결해야 한다

```text
청록    실제 메아리 — 에코
호박    보관 메아리 — 시크
자홍    모방 메아리 — NØA
```

64링은 다음을 동시에 담당합니다.

* 승리 진행
* 덱 전략
* 캐릭터 관계
* 보스전 상태
* 최종 프로토콜
* 엔딩 분기
* UI 상징
* 키아트의 중심 이미지

## 게임 중 변환

| 사건             | 결과                |
| -------------- | ----------------- |
| 아카이브 정상 송출     | 청록 증가             |
| 시크에게 조각 보관     | 호박 증가             |
| NØA Sponsor 사용 | 자홍 증가             |
| CHECKSUM 성공    | 자홍 → 청록 일부 복구     |
| 시크에게서 재전송      | 호박 → 청록           |
| NØA 공격 피격      | 청록 → 자홍 일부 변환     |
| 캐시 영구 저장       | 청록 또는 미완성 조각 → 호박 |
| 실제 관객 응답 이벤트   | 청록 직접 증가          |

따라서 “64를 채운다”만으로 끝나지 않습니다.

> **무엇으로 채웠는가가 결말이다.**

---

# 12. 솔로 도미니언 변형을 `감사 프로토콜`로 변환

업로드 자료가 언급한 솔로 도미니언 변형을 별도 게임 모드로 그대로 복제할 필요는 없습니다. 핵심 압박 규칙만 NØA의 감사 프로토콜로 번역합니다. 

## RESPONSE RACE

Race Against Curses 계열.

```text
두 BREAK 동안 청록·호박·자홍 어느 메아리도 증가하지 않음
→ NOISE 한 장 삽입
```

현재 생존 카드만 계속 사는 전략을 견제합니다.

## BIG BAUD DUMMY

플레이어가 직접 상대하는 더미가 아니라 자동 밸런스 기준선입니다.

```text
가장 비싼 CARRIER 구매
필요 최소 아카이브 구매
가능한 가장 이른 안정 OPEN
```

복잡한 전략이 이 봇보다 약하면 카드 엔진이 복잡성의 값을 하지 못한다는 뜻입니다.

## ENGINE AUDIT

Pyramid·오토마 반응 규칙의 변형.

```text
한 구절에서 PROGRAM 3개 이상 발동
→ 다음 의도 덱에 QUARANTINE 삽입
```

## BANDWIDTH CAP

```text
한 BREAK에서 BAUD 7 이상
→ 다음 두 구절 POPUP 증가
```

## ARCHIVE HUNT

```text
아카이브 4장 이상
→ 시크 등장 확률·회수 속도 증가
```

한 런에는 감사 프로토콜 하나만 사용합니다. 여러 개를 동시에 적용하면 특정 전략을 지나치게 처벌합니다.

---

# 13. 반복 플레이 설계

## 13.1 반복 플레이의 변주 축

한 런은 다음 조합으로 생성합니다.

```text
PROGRAM 공급 5종
시간층 1종
NØA 감사 프로토콜 1종
적 의도 덱 1종
아카이브 분포
초기 덱 또는 에코 방송 스타일
```

예:

```text
시간층       1997 FILE BOARD
PROGRAM      MULTI / CACHE / FIREWALL / PREFETCH / CHECKSUM
NØA 감사     RESPONSE RACE
아카이브     VOICE 우세
```

다음 런:

```text
시간층       2026 RECOMMEND FEED
PROGRAM      MARKER / SURGE / MACRO / SPONSOR / MULTI
NØA 감사     ENGINE AUDIT
아카이브     CHAT 우세
```

같은 카드도 상대 규칙에 따라 가치가 달라집니다.

---

## 13.2 영구 능력치 대신 규칙·콘텐츠 해금

Vampire Survivors는 런 사이 골드 업그레이드를 핵심 진행으로 사용하지만, ECHO/144에서 영구 공격력·HP를 올리면 덱 판단이 약해질 가능성이 큽니다. 공식 설명도 골드를 모아 다음 생존자를 강화하는 구조를 강조합니다. ([Poncle][17])

권장 해금:

* 새 PROGRAM
* 새 시작 덱
* 새 적 의도
* 새 시간층
* 새 감사 프로토콜
* 새 NØA Sponsor
* 새 시크 거래
* 새 최종 프로토콜 수정자
* 방송 로그
* 키아트
* 팔레트
* 엔딩
* TODAY 모드
* 도전 스탬프

비권장 해금:

* 공격력 +10%
* 시작 HP +20
* 시작 CUE +1
* 적 피해 -15%
* 시작 BAUD +2

반복 횟수가 덱 판단을 대체해서는 안 됩니다.

---

## 13.3 즉시 재시작과 시드 재도전

결과 화면:

```text
ENTER     같은 신호 재접속
RIGHT     새 신호 탐색
TAB       방송 기록
```

같은 신호 재접속:

* 시장 동일
* 의도 덱 동일
* 웨이브 동일
* 셔플 동일
* 첫 입력 전까지 즉시 시작

목표:

```text
사망/실패 → 다시 조작 가능
1초 미만
```

---

## 13.4 이전 방송 리플레이를 세계관으로 활용

결정론 명령 로그를 만들면 이전 런의 움직임과 CUE를 저장할 수 있습니다.

6분 동안 틱당 1바이트로 기록해도 약 21.6KB이며, 이는 EXE가 아니라 저장 파일에 들어갑니다.

활용:

### 기본

* 디버그 리플레이
* TODAY 결과 재현
* 버그 신고용 입력 로그

### 게임 콘텐츠

* 세 번째 런부터 호박색 “이전 방송 에코”가 잠깐 나타남
* 시크가 이전 런의 프로그램 타이밍을 재생
* NØA가 이전 성공 빌드를 학습
* 결과 화면에서 과거 에코와 현재 에코의 이동 경로 비교
* 특정 엔딩에서 이전 실패 에코가 현재 방송에 한 번 응답

이는 기술 기능과 세계관이 정확히 결합하는 좋은 확장 요소입니다.

---

# 14. 카드 시스템의 데이터 구조

## 14.1 카드 정의

```c
typedef struct CardDef {
    uint8_t type;
    uint8_t cost;
    uint8_t baud;
    uint8_t cue_cost;

    uint8_t tag_bits;
    uint8_t off_air_recipe;
    uint8_t on_air_recipe;
    uint8_t open_recipe;

    uint8_t icon_id;
    uint8_t sound_id;
    uint8_t custom_hook;
    uint8_t flags;
} CardDef;
```

카드 한 장당 12~16바이트면 충분합니다.

64장이어도 약 1KB입니다.

---

## 14.2 작은 효과 명령

```c
typedef struct EffectOp {
    uint8_t opcode;
    int8_t  value;
    uint8_t arg;
    uint8_t flags;
} EffectOp;
```

예시 명령:

```text
DRAW
GAIN_CUE
RESERVE_CARD
REPLAY_LAST
SPAWN_PACKET
SPAWN_LINE
SPAWN_RING
SPAWN_FRAME
MARK_TARGET
LINK_MARKS
PUSH_ENEMIES
DELETE_PROJECTILES
CLEAN_NOISE
ADD_ECHO
CONVERT_ECHO
LOCK_SLOT
CHANGE_SYNC
```

카드 하나당 4개 명령이면:

```text
4바이트 × 4 = 16바이트
```

64장이어도 약 1KB입니다.

## 80/20 원칙

### 데이터 명령으로 처리

* 피해
* 드로우
* CUE
* 마킹
* 선·원·프레임
* 넉백
* 오염 제거
* 메아리 증감
* 기본 상태 효과

### 전용 C 함수

* CACHE의 다음 구절 보존
* MACRO의 효과 레시피 재생
* PREFETCH의 덱 위 선택
* NØA TREND 분석
* 시크의 영구 보관
* 최종 프로토콜 컴파일

모든 카드를 VM으로 만들려 하지 않습니다.

---

# 15. 결정론 코어 구조

## 권장 파일 구조

```text
src/
├─ core/
│  ├─ game_state.c
│  ├─ game_command.c
│  ├─ deck.c
│  ├─ cards.c
│  ├─ turn.c
│  ├─ echo_ring.c
│  ├─ enemy_intent.c
│  ├─ combat.c
│  ├─ noa.c
│  ├─ seek.c
│  └─ replay.c
│
├─ render/
│  ├─ framebuffer.c
│  ├─ sprites.c
│  ├─ effects.c
│  ├─ ui.c
│  └─ font.c
│
├─ audio/
│  └─ synth.c
│
├─ platform/
│  └─ win32.c
│
├─ generated/
│  ├─ cards.inc
│  ├─ effects.inc
│  ├─ intents.inc
│  ├─ strings.inc
│  └─ assets.inc
│
└─ echo144_unity.c
```

릴리스에서는 `echo144_unity.c`가 각 `.c`를 include해 단일 translation unit으로 만들 수 있습니다.

소스 분리는 실행 파일 크기를 의미 있게 증가시키지 않으면서 유지보수성을 높입니다.

---

## 명령·상태·이벤트

```c
typedef struct GameCommand {
    uint8_t type;
    uint8_t actor;
    uint8_t slot;
    int8_t  x;
    int8_t  y;
} GameCommand;
```

```c
typedef struct GameEvent {
    uint8_t type;
    uint8_t source;
    uint8_t target;
    uint8_t recipe;
    int16_t x;
    int16_t y;
    int16_t value;
} GameEvent;
```

예:

```text
CMD_SET_CARRIER_TX
CMD_SET_CARRIER_RX
CMD_CUE_PROGRAM
CMD_SEEK_CARD
CMD_FIRE_PROGRAM
CMD_BUY_CARD
CMD_OPEN_CHANNEL
```

이벤트:

```text
EV_CARD_CUED
EV_CARD_FIRED
EV_DAMAGE
EV_ENEMY_KILLED
EV_ECHO_ADDED
EV_ECHO_CONVERTED
EV_TREND_SELECTED
EV_SYNC_CHANGED
EV_SHUFFLE
EV_NEW_CARD_RETURNED
```

렌더러와 오디오는 이벤트만 소비합니다.

---

## RNG 스트림 분리

현재 하나의 RNG 스트림에 셔플·웨이브·시각 랜덤이 모두 섞이면 작은 연출 변경이 게임 결과를 바꿀 수 있습니다.

다음처럼 분리합니다.

```c
Rng deck_rng;
Rng encounter_rng;
Rng reward_rng;
Rng cosmetic_rng;
```

* `deck_rng`: 셔플
* `encounter_rng`: 적 의도와 웨이브
* `reward_rng`: 시장·보상
* `cosmetic_rng`: 파티클·오류 프레임

파티클 수를 바꿔도 TODAY 시드의 카드 순서가 바뀌지 않아야 합니다.

---

# 16. 서바이버 성능 기법 적용 판단

업로드 조사문은 풀링·공간 해시·배칭·적 밀침을 강조합니다. 일반적인 서바이버류에서는 유효합니다. 

그러나 현재 ECHO/144 문서는 256 적 상한과 이중 루프에서도 최악 충돌 틱이 0.162ms라고 기록합니다. 지금 공간 해시를 넣는 것은 조기 최적화입니다. ([GitHub][2])

## 지금 채택

### 고정 배열 풀

현재 고정 배열 자체가 이미 단순 오브젝트 풀입니다.

개선:

* 활성 플래그
* 자유 인덱스 스택
* 생성 실패 계측
* 최대 사용량 기록

### 파티클 전용 풀

```text
MAX_PARTICLES 768~1024
```

파티클은 게임 판정과 분리하고, 가득 차면 오래된 장식 파티클부터 덮어씁니다.

### 적의 간단한 분리 벡터

적끼리 완전히 겹치지 않게 가까운 적 사이에 작은 반발을 줍니다.

효과:

* 느린 적이 밀려 들어오는 예측 불가능성
* 군중이 흐르는 듯한 움직임
* 화면 밀도 증가
* 추가 스프라이트 없이 난이도 상승

### 근접 탐색 캐시

자동 캐리어는 매 발사마다 전체 적을 찾지 말고, 현재 타깃이 살아 있고 범위 내라면 유지합니다.

## 조건부 채택

공간 해시는 다음 중 하나가 발생할 때만 넣습니다.

```text
적 384 이상
투사체 512 이상
충돌 틱 평균 1ms 초과
최악 틱 3ms 초과
```

그 전에는 단순 구조가 더 안전합니다.

---

# 17. 비주얼과 자산에 적용할 “레시피 우선” 원칙

## 17.1 이펙트 레시피

```c
typedef struct EffectRecipe {
    uint8_t shape;
    uint8_t emitter;
    uint8_t motion;
    uint8_t hit_rule;

    uint8_t count;
    uint8_t spread;
    uint8_t speed;
    uint8_t lifetime;

    uint8_t palette;
    uint8_t sound;
    uint8_t screen_fx;
    uint8_t flags;
} EffectRecipe;
```

도형:

```text
POINT
PACKET
LINE
ARC
RING
FRAME
GRID
GLYPH
```

움직임:

```text
STRAIGHT
ORBIT
RETURN
CHAIN
EXPAND
SHRINK
FOLLOW
DELAYED_REPLAY
```

동일 레시피를 NØA가 모방할 때:

```text
palette = MAGENTA
target_rule = INVERT
motion = REVERSE
```

로 재사용합니다.

---

## 17.2 배경 레시피

시간층마다 대형 이미지를 따로 저장하지 않습니다.

```c
typedef struct BackgroundRecipe {
    uint8_t base_palette;
    uint8_t grid_type;
    uint8_t frame_type;
    uint8_t noise_density;
    uint8_t timestamp_mode;
    uint8_t profile_density;
    uint8_t scroll_speed;
    uint8_t hidden_clue;
} BackgroundRecipe;
```

예:

### 1997 FILE BOARD

* 짙은 남색
* 문자 셀 그리드
* 자료실 창 프레임
* 낮은 오류 밀도
* `1997` 고정

### 2006 PERSONAL WEB

* 보라·청록
* 개인 홈페이지 테이블
* 배너 팝업
* 중간 오류 밀도

### 2026 RECOMMEND FEED

* 검정·자홍
* 세로 피드
* 프로필 원
* 높은 NØA 밀도

### 2097 DEAD NET

* 회백색·청록
* 비어 있는 서버 행
* 사람 아이콘 없음
* 소리 없는 스크롤

---

## 17.3 채팅 생성은 자유 생성이 아니라 저자 문법

AI 또는 완전 무작위 문장 생성은 불 coherent하고 AI slop처럼 보일 위험이 큽니다.

다음처럼 작가가 만든 제한된 문법을 사용합니다.

```text
[인사]
들려요
여기 어디예요
처음 봐요
아직 방송 중인가요

[시간 오류]
방금 1997이라고 뜬 건가
이 영상 어제 봤는데
이 채팅은 아직 안 썼어요
다음 방송이 먼저 끝났어요

[반응]
예뻐요
조금 무서워요
계속해 주세요
목소리가 두 번 들려요
```

NØA의 가짜 계정은 다음 특징을 공유합니다.

* 같은 오타
* 같은 구두점
* 같은 0.2초 지연
* 같은 줄바꿈 위치
* 다른 닉네임인데 같은 문장 길이

텍스트 데이터는 작지만 반복해서 볼수록 설정이 드러납니다.

---

# 18. 오디오 적용

`.kkrieger`의 V2나 js13k의 ZzFX·Sonant 계열에서 배울 것은 외부 신스를 그대로 넣는 것이 아니라 **패치와 음표 데이터를 저장하는 방식**입니다. `.kkrieger`도 MIDI 스트림과 실시간 신시사이저로 음악과 효과음을 생성합니다. ([GitHub][7])

현재 waveOut 합성기를 유지하며 다음을 추가합니다.

## 보이스

```text
사각파 2
삼각파 1
노이즈 1
SFX 2
```

## 패치 데이터

```c
typedef struct SynthPatch {
    uint8_t wave;
    uint8_t attack;
    uint8_t decay;
    uint8_t sustain;
    uint8_t release;
    int8_t  slide;
    uint8_t vibrato;
    uint8_t crush;
} SynthPatch;
```

## 패턴

```text
에코    상승하는 3음 + 답장을 위한 빈 박자
시크    같은 3음을 역방향·지연 재생
NØA     마지막 음을 수많은 작은 보이스가 복제
```

## 카드와 음악 결합

* CUE 프로그램이 음악의 한 악기 레이어를 켬
* 한 구절 마지막 카드는 낮은 종결음
* SYNC가 올라가면 화음 레이어 추가
* OPEN CHANNEL에서 아카이브 종류에 따라 리듬 변경
* 64에서 해결음 직전에 정적
* 엔딩별로 마지막 한 음만 다름

수십 KB의 패턴 데이터로 게임 전체의 정체성을 만들 수 있습니다.

---

# 19. 권장 크기 예산

다음은 목표치이지 현재 실측값이 아닙니다.

내부 소프트 캡을 **900KB**로 두고 약 574KB의 안전 여유를 남기는 것이 좋습니다.

| 영역           |             목표 |
| ------------ | -------------: |
| 플랫폼·게임·렌더 코드 |      250~350KB |
| 스프라이트·초상·아이콘 |      100~180KB |
| 비트맵 글꼴       |         8~24KB |
| 음악 패턴·신스 패치  |        20~50KB |
| 카드·적·의도 데이터  |        10~30KB |
| 텍스트·로그·엔딩    |        20~60KB |
| 빌드 메타·리소스    |        10~30KB |
| 여유           |       200KB 이상 |
| **내부 목표**    |   **900KB 이하** |
| 공모전 상한       | **1,474,560B** |

## 압축 순서

1. 1bpp·2bpp·4bpp 비트 패킹
2. 투명 영역 크롭
3. 동일 프레임 재사용
4. 팔레트 리맵
5. 애니메이션 델타
6. 단순 행 RLE
7. 실제 측정 후 heatshrink 검토

heatshrink는 작은 메모리에서 동작하는 LZSS 계열 압축 라이브러리이지만, 디코더 코드 크기까지 포함해 순이익이 있을 때만 도입해야 합니다. ([GitHub][18])

판정 기준:

```text
압축 전 전체 EXE
vs
디코더 + 압축 데이터 포함 전체 EXE
```

자산 파일만 작아졌다는 이유로 채택해서는 안 됩니다.

---

# 20. 엔진·도구 최종 추천

## 공모전 런타임

```text
C11
MSVC
Win32
소프트웨어 프레임버퍼
GDI 최종 출력
waveOut 합성
고정 배열
무패킹 EXE
```

유지합니다.

## 빌드 타임 도구

```text
Aseprite
Python
선택적으로 JSON/TSV
MSVC map 분석
GitHub Actions Windows 빌드
clang-cl 검증 빌드
```

## 확장판

```text
결정론 C 게임 코어
+ Sokol App
+ Sokol GFX
+ Sokol Audio
```

Sokol은 현재도 Win32·macOS·Linux·모바일·WASM과 여러 그래픽 API를 지원하고, CPU 프레임버퍼와 레터박스 유틸리티까지 갖춰 현재 구조를 점진적으로 옮기기 좋습니다. ([GitHub][4])

## raylib 사용처

* 별도 카드 편집기
* 웨이브 시각화 도구
* 빠른 메커니즘 프로토타입
* 확장판 대안 프런트엔드

공모전 런타임 교체에는 사용하지 않습니다.

---

# 21. P0 수직 슬라이스

전체 V2를 한 번에 구현하면 실패 원인을 알기 어렵습니다.

다음만 먼저 만듭니다.

## 카드 8장

```text
2400
14K
MULTI.FORK
CACHE.RAM
FIREWALL.FRAME
CHAT.LOG
VOICE.OGG
NOISE
```

## 적 의도 4장

```text
BOT RAID
MUTE
GIFT DROP
MIRROR
```

## 핵심 기능

* EDIT
* TX/RX
* CUE 1
* ON AIR 수동 Space
* 두 구절마다 BREAK
* 카드 한 장 구매
* 셔플과 NEW 귀환
* SYNC 0~3
* 16칸 임시 메아리 링
* NØA가 한 프로그램 모방

## P0에서 제외

* 시크 정식 보스
* 64칸 완전 UI
* 엔딩 4종
* 4개 시간층
* 저장·해금
* 모든 카드
* 최종 키아트
* 공간 해시
* 자산 압축
* Sokol
* 셰이더

---

# 22. P0 성공 기준

## 손패 의사결정

* 같은 손패라도 다른 적 의도에서는 다른 CUE가 선택됨
* 테스트 플레이어의 70% 이상이 선택 이유를 설명
* 한 구절의 편성 시간이 평균 3초 이내
* “추천 카드만 항상 누름” 비율이 60% 미만

## TX/RX

* 최소 30%의 구절에서 TX/RX 배분이 달라짐
* 전부 TX와 전부 RX가 모두 항상 정답이 아님
* 구매 목표 때문에 위험을 감수하는 순간이 발생
* TX/RX UI를 30초 안에 이해

## 프로그램 시각 차별

* 음소거 영상만 보고 FIREWALL·CACHE·CHAT·VOICE를 구분
* 프로그램이 단순 탄환 수 차이로 보이지 않음
* 카드→효과 인과를 1초 안에 읽을 수 있음

## SYNC

* 숙련자에게는 유지 목표가 됨
* 초보자는 SYNC 0이어도 기본 클리어 가능
* 피격 후 악순환이 발생하지 않음

## NØA

* 플레이어가 자신의 기술을 NØA가 복제했다는 것을 알아챔
* 복제가 단순 색상 변경으로 보이지 않음
* TREND를 조작하려는 고급 전략이 자연스럽게 발견됨

## 반복

* 재시작 1초 미만
* 한 런 직후 다른 TX/RX·PROGRAM 조합으로 다시 시도하려는 반응
* Big BAUD와 Engine이 서로 다른 장단점을 보임

---

# 23. 전략 봇 구성

## BIG_BAUD

```text
CARRIER 우선
PROGRAM 최소
목표 가격을 위해 RX 배정
필요 최소 ARCHIVE
```

목표:

* 이해하기 쉬움
* 안정적
* 최고점은 낮음

## LOOP_ENGINE

```text
MULTI
CACHE
PREFETCH
얇은 덱
PROGRAM 다중 실행
```

목표:

* 완성 전 약함
* 완성 후 손패 가치 높음
* NOISE에 취약

## ECHO_RUSH

```text
ARCHIVE 조기 구매
RX 투자 우선
빠른 OPEN CHANNEL
```

목표:

* 런 단축
* 준비 구간 생존 난도 높음

## CLEAN_SIGNAL

```text
FIREWALL
CHECKSUM
DEFRAG
중급 CARRIER
```

목표:

* 안정적
* 느림
* 자홍 오염 저항

## PERFECT_SHOW

```text
NØA Sponsor
무료 CUE
강한 즉시 효과
자홍 메아리 수용
```

목표:

* 가장 화려함
* 빠른 성장
* 위험한 엔딩

## LAST_ARCHIVE

```text
CACHE
시크 거래
호박 보관
덱 압축
```

목표:

* 장기 안정
* 생방송보다 보관에 가까움
* 시크 엔딩

---

# 24. 반드시 버려야 할 유혹

## “남는 용량을 전부 콘텐츠로 채우자”

용량이 남는다고 카드·적·엔딩을 무조건 늘리면 테스트 표면만 폭증합니다.

공모전 심사 기준은 공식적으로 완성 여부, 용량, 재미입니다. 콘텐츠 개수 자체가 아닙니다. ([2pgarcade.com][1])

## “뱀서처럼 경험치와 3택을 넣자”

덱 구매와 3택 레벨업이 동시에 존재하면 두 성장 시스템이 경쟁합니다.

ECHO/144에서는 성장 보상을 다음으로 통일해야 합니다.

```text
BREAK 구매
조건부 시크 거래
조건부 NØA Sponsor
OPEN CHANNEL 컴파일
```

## “카드마다 전용 코드를 쓰자”

초기에는 빠르지만 카드 수가 늘면 조합·테스트가 폭발합니다.

원자 효과 + 소수 전용 hook 구조가 필요합니다.

## “모든 것을 데이터화하자”

CACHE·MACRO·TREND처럼 상태를 많이 참조하는 효과까지 범용 VM으로 넣으면 오히려 구현이 커집니다.

80% 데이터, 20% 전용 코드가 적절합니다.

## “적 수를 1,000마리로 늘리자”

화면 크기 320×192에서는 1,000개 적이 있어도 읽히지 않습니다.

256개의 잘 설계된 적이 손패·위치·이동로를 공격하는 편이 낫습니다.

## “셰이더가 화려하니 GPU 렌더러로 바꾸자”

현재 작품은 픽셀 캐릭터와 UI 인과 관계가 핵심입니다.

대부분의 필요한 효과는 CPU로 가능합니다.

* 팔레트 스왑
* 원호
* 회선
* 프레임
* 행 오프셋
* 잔상
* 파편
* 화면 흔들림
* 제한적 글리치

셰이더는 확장판에서 추가합니다.

---

# 25. 최종 채택표

## 그대로 채택

| 요소             | 판정 |
| -------------- | -- |
| 에셋 대신 레시피      | 채택 |
| 원자 효과 기반 카드 정의 | 채택 |
| UI 독립 게임 상태    | 채택 |
| 명령·이벤트 큐       | 채택 |
| 전략 우선순위 봇      | 채택 |
| 적 의도 공개        | 채택 |
| 즉시 재시작         | 채택 |
| 같은 콘텐츠의 규칙 변주  | 채택 |
| 한 런 한 번의 최종 합성 | 채택 |
| 절차적 오디오        | 채택 |
| 팔레트 기반 이펙트     | 채택 |
| 빌드 타임 콘텐츠 컴파일  | 채택 |

## 비틀어 채택

| 레퍼런스                  | ECHO/144식 변형            |
| --------------------- | ----------------------- |
| `.kkrieger` 절차 생성     | 3D가 아니라 이펙트·배경·음악 레시피   |
| Cave Story 무기 레벨다운    | 방송 SYNC 등급              |
| Celeste 단일 동사         | CUE를 게임 전체 동사로          |
| Slay the Web 불변 상태    | C의 직접 수정 상태 + 명령 로그     |
| Dominion Treasure     | TX/RX 양면 CARRIER        |
| Dominion Action       | CUE를 소비하는 PROGRAM       |
| Dominion Victory      | OPEN에서 반전되는 ARCHIVE     |
| Dominion Curse        | NOISE·MIMIC             |
| 솔로 오토마                | NØA 적 의도 덱              |
| HoloCure Super Collab | 최종 방송 프로토콜 하나           |
| Survivors 적 군집        | 제한된 적 수 + 분리 벡터 + 공간 압박 |
| js13k 콘텐츠 재활용         | 감사 프로토콜·미러 모드·이전 방송     |
| 반복 리플레이               | 시크의 보관된 방송으로 세계관화       |

## 불채택

| 요소                 | 이유                  |
| ------------------ | ------------------- |
| raylib 전면 이전       | 현재 스택의 이득을 버릴 이유 없음 |
| Odin 전환            | 언어·도구 리스크만 증가       |
| Crinkler           | 수 KB 데모용            |
| UPX                | 현재 크기 여유, 배포 리스크    |
| 전체 3D 절차 생성        | 게임 방향과 무관           |
| 런타임 XML            | 파서·문자열·오류 표면 증가     |
| 전면 immutable state | C 실시간 코어에 불필요       |
| 경험치 보석·레벨업 3택      | 덱 구매와 역할 중복         |
| 별도 무기 슬롯           | 카드와 성장 시스템 충돌       |
| 대량 영구 능력치 강화       | 덱 판단 약화             |
| 공간 해시 즉시 도입        | 현재 성능상 필요 없음        |
| 대형 범용 카드 VM        | 코드·디버깅 복잡도 증가       |

---

# 최종 제안

업로드된 조사에서 ECHO/144를 가장 크게 개선할 수 있는 것은 특정 라이브러리나 압축 도구가 아닙니다.

다음 다섯 가지를 실제 플레이로 구현하는 것이 핵심입니다.

```text
1. CARRIER를 TX와 RX 중 하나로 사용한다.
   지금 싸울 것인가, 다음 카드를 살 것인가.

2. 적의 다음 의도를 보고 CUE할 PROGRAM을 고른다.
   같은 손패라도 상황에 따라 선택이 달라진다.

3. ON AIR에서 준비한 PROGRAM을 직접 발동한다.
   덱 선택이 화면의 위치와 타이밍으로 이어진다.

4. NØA가 내가 가장 의존한 전략을 학습해 뒤집어 사용한다.
   반복한 선택이 보스의 캐릭터성과 패턴이 된다.

5. OPEN CHANNEL에서 덱 전체가 하나의 최종 방송으로 컴파일된다.
   초반에 손패를 막던 아카이브가 후반의 화면·음악·엔딩을 지배한다.
```

이 다섯 구조가 성립하면 조사 자료의 장점을 단순히 모은 게임이 아니라 다음과 같은 고유한 작품이 됩니다.

> **현재 화력을 포기해 미래의 방송을 구축하고, 예고된 관객의 공격에 맞춰 손패를 편성하며, 직접 송출한 기술을 가짜 관객이 학습해 되돌려 주고, 마지막에는 자신이 만든 덱 전체가 어떤 대답을 진짜로 받아들일지 결정하는 게임.**

1.44MB는 그 게임을 방해하는 제한이 아닙니다.

오히려 **카드·전투·캐릭터·연출을 소수의 강한 문법으로 통일하게 만드는 제작 원칙**으로 사용하는 것이 가장 좋습니다.

[1]: https://2pgarcade.com/contest-144mb.html "1.44MB GAME_DEV CONTEST"
[2]: https://raw.githubusercontent.com/dusaud8887-svg/1_44mb_game/main/docs/30_TECH.md "raw.githubusercontent.com"
[3]: https://github.com/raysan5/raylib "GitHub - raysan5/raylib: A simple and easy-to-use library to enjoy videogames programming · GitHub"
[4]: https://github.com/floooh/sokol "GitHub - floooh/sokol: minimal cross-platform standalone C headers · GitHub"
[5]: https://github.com/runestubbe/Crinkler "GitHub - runestubbe/Crinkler: Crinkler is an executable file compressor (or rather, a compressing linker) for compressing small 32-bit Windows demoscene executables. As of 2026, it is the most widely used tool for compressing 1k/4k/8k intros. · GitHub"
[6]: https://github.com/upx/upx?utm_source=chatgpt.com "UPX - the Ultimate Packer for eXecutables - GitHub"
[7]: https://github.com/jaromil/kkrieger-werkkzeug3 "GitHub - jaromil/kkrieger-werkkzeug3: source code of kkrieger and werkkzeug3 tool by the. produkkt. / farb-rausch · GitHub"
[8]: https://github.com/oskarrough/slaytheweb/blob/main/DOCUMENTATION.md "slaytheweb/DOCUMENTATION.md at main · oskarrough/slaytheweb · GitHub"
[9]: https://github.com/rspeer/dominiate/ "GitHub - rspeer/dominiate: A simulator for Dominion card game strategies · GitHub"
[10]: https://github.com/dostjh/deck-builder-game "GitHub - dostjh/deck-builder-game: A fully configurable deck building card game engine based on the mechanics of the game Dominion. · GitHub"
[11]: https://js13kgames.com/2025/games/cat-survivors?utm_source=chatgpt.com "Cat Survivors | js13kGames 2025"
[12]: https://github.com/remvst/clawstrike "GitHub - remvst/clawstrike: My entry for 2025's js13k · GitHub"
[13]: https://store.steampowered.com/app/3265700/Vampire_Crawlers_The_Turbo_Wildcard_from_Vampire_Survivors/ "Save 10% on Vampire Crawlers: The Turbo Wildcard from Vampire Survivors on Steam"
[14]: https://www.pcgamer.com/games/roguelike/vampire-crawlers-review/ "Vampire Crawlers review | PC Gamer"
[15]: https://raw.githubusercontent.com/dusaud8887-svg/1_44mb_game/main/README.md "raw.githubusercontent.com"
[16]: https://holocure.wiki.gg/wiki/Super_Collab?utm_source=chatgpt.com "Super Collab - The HoloCure Wiki"
[17]: https://poncle.games/vampire-survivors?utm_source=chatgpt.com "poncle | Vampire Survivors"
[18]: https://github.com/atomicobject/heatshrink?utm_source=chatgpt.com "GitHub - atomicobject/heatshrink: data compression library for embedded/real-time ..."
