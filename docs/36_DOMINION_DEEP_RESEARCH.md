# 36 — 도미니언·덱빌딩 게임 심층 조사

> 조사 기준일: 2026-07-19. 영문 카드명은 판본 차이와 번역 혼선을 피하기 위해 병기한다. 카드 효과는 기획 분석용 요약이며 공식 카드 문구의 번역본이 아니다. 기본판은 **Dominion 2nd Edition**, 확장은 2024년 **Rising Sun**까지를 기준으로 한다.

이 문서는 [35_REFERENCES.md](35_REFERENCES.md)의 결론을 뒷받침하는 조사 자료다. 도미니언을 그대로 복제하기 위한 카드 목록이 아니라, **무슨 규칙이 어떤 전략과 감정을 만드는지**를 역기획하고 솔로 덱빌더에 옮길 때 무엇을 보존해야 하는지를 정리한다.

### 문서의 완전성 범위와 읽는 순서

이 문서에서 “빠짐없이”는 **도미니언을 처음 접한 사람이 기본판을 이해하고, 카드 기능을 분류하고, 대표 전략을 선택하며, 주요 확장·솔로 변형·비교작의 설계 차이를 설명할 수 있는 범위**를 뜻한다. 기본판 2판의 킹덤 카드 26종은 전부 다룬다. 16개 확장은 핵심 규칙과 대표 카드를 다루되, 수백 장에 이르는 모든 확장 카드의 원문·예외를 복제한 카드 백과는 아니다. 그런 정보는 판본과 정오표 영향을 받으므로 §9의 공식 규칙서와 통합 규칙을 인덱스로 삼는다.

처음 읽는 사람은 다음 순서가 가장 쉽다.

1. §1에서 실제 준비·턴·셔플·승리를 이해한다.
2. §2에서 카드의 공식 유형과 전략적 역할을 구분한다.
3. §4의 용어 사전과 첫 게임 분석을 읽은 뒤 다섯 전략을 비교한다.
4. §3의 확장은 기본판 문법을 어떻게 바꾸는지 본다.
5. §5~§8에서 재미의 원인, 솔로화, 비교작, ECHO/144 적용을 읽는다.

## 0. 한눈에 보는 결론

도미니언의 핵심은 “카드를 사는 게임”이 아니다.

1. 이번 판에 공개된 10개 킹덤 더미를 보고 **최종 덱의 작동 방식을 먼저 설계**한다.
2. 산 카드는 즉시 강해지는 대신 버림 더미에 들어가 **다음 셔플 뒤에 돌아온다**.
3. 약한 시작 카드와 저주를 제거해 좋은 카드의 **등장 빈도와 충돌 확률**을 바꾼다.
4. 드로우·추가 액션·추가 구매·생산 효과를 연결해 한 턴의 처리량을 키운다.
5. 승점 카드는 승리에 필요하지만 대개 플레이 중에는 무용하므로, **성장을 멈추고 덱을 오염시킬 시점**을 결정한다.
6. 게임 종료는 외부 타이머가 아니라 공급 더미의 고갈이다. 따라서 “점수가 많은가”뿐 아니라 **지금 끝낼 수 있는가**가 전략이다.

이 여섯 요소가 합쳐져 `판독 → 투자 → 지연 → 재등장 → 가속 → 오염 → 종료 통제`라는 고유한 감정 곡선을 만든다. 다른 덱빌더는 여기서 시장, 전투, 공간, 적 의도, 영구 성장 중 일부를 바꿔 서로 다른 장르가 된다.

---

## 1. 기본 플레이 방법과 승리

### 1-1. 목표와 준비

각 플레이어는 동 7장과 사유지 3장, 총 10장으로 시작한다. 개인 덱을 섞어 5장을 뽑는다. 중앙 공급에는 항상 쓰는 기본 카드 7종과 이번 게임에만 쓰는 킹덤 카드 10종을 놓는다. 기본판 2판에는 킹덤 카드가 26종 있으며, 매 판 그중 10종만 선택한다. 2인 게임의 승점 더미는 각 8장, 저주는 10장을 쓴다. [공식 기본판 2판 규칙서](https://www.riograndegames.com/wp-content/uploads/2016/09/Dominion2nd.pdf)

| 구역 | 내용 | 기획적 의미 |
|---|---|---|
| 개인 덱 | 아직 뽑지 않은 자기 카드 | 미래의 확률 분포 |
| 손패 | 보통 5장 | 이번 턴의 제한된 실행 창 |
| 플레이 영역 | 이번 턴에 사용한 카드 | 실행 순서와 지속 효과 추적 |
| 버림 더미 | 구매·사용을 마친 카드 | 다음 셔플에 합류할 투자 대기열 |
| 폐기(Trash) | 게임에서 제거된 카드 | 덱 압축, 공급으로 돌아가지는 않음 |
| 공급(Supply) | 기본 7더미 + 킹덤 10더미 | 공동 시장이자 종료 시계 |

### 1-2. 한 턴: ABC

공식 규칙은 턴을 `Action → Buy → Clean-up`, 즉 ABC로 설명한다.

1. **Action:** 기본 1회. 손의 액션 카드 1장을 쓰고 위에서 아래로 해결한다. `+Action`이 있어야 액션을 더 잇는다.
2. **Buy:** 손의 보물 카드를 원하는 만큼 내고 기본 1회 구매한다. `+Buy`가 있으면 여러 장을 살 수 있지만 돈도 각각 지불한다.
3. **Clean-up:** 플레이 영역과 남은 손패를 모두 버리고 새 5장을 뽑는다. 덱이 모자랄 때만 버림 더미를 섞는다.

핵심은 구매한 카드가 손이나 덱 위가 아니라 보통 **버림 더미**로 간다는 점이다. 구매는 즉시 수치 상승이 아니라 다음 셔플을 향한 투자다. [공식 규칙서의 턴 구조](https://www.riograndegames.com/wp-content/uploads/2016/09/Dominion2nd.pdf)

#### 카드를 읽는 법

| 카드 영역·표기 | 뜻 | 초보가 헷갈리는 점 |
|---|---|---|
| 왼쪽 아래 비용 | 공급에서 이 카드를 살 때 필요한 비용 | 덱 안에 들어간 뒤에는 카드의 생산량이 아님 |
| 아래쪽 유형선 | Action, Treasure, Victory 등 공식 유형 | 흰색 액션도 Attack·Reaction 같은 유형을 함께 가질 수 있음 |
| `+N Cards` | 즉시 개인 덱에서 N장 드로우 | 다음 턴 손이 아니라 현재 턴 손에 추가 |
| `+N Actions` | 이번 턴 액션 허용량 N회 추가 | 액션 카드를 뽑는 효과가 아님 |
| `+N Buys` | 이번 턴 구매 허용량 N회 추가 | 살 돈을 주지는 않음 |
| `+N Coins` | 이번 턴 구매력 N 추가 | 물리 코인 카드를 얻는 것이 아님 |
| 구분선 위 | 카드를 플레이하면서 지금 해결 | 적힌 순서대로 가능한 만큼 수행 |
| 구분선 아래 | 반응·획득·지속 등 적힌 시점에 해결 | 액션으로 플레이했을 때만 생기는 효과가 아닐 수 있음 |

카드 텍스트가 일반 규칙과 충돌하면 카드가 우선한다. `may`가 없으면 가능한 만큼 수행하는 것이 의무다. 카드 한 장을 완전히 해결한 다음 다음 카드를 사용한다.

#### 비슷해 보이지만 다른 조작

| 조작 | 카드가 가는 곳 | 덱 장수 변화 | 예와 의미 |
|---|---|---:|---|
| Draw(드로우) | 덱 → 손 | 없음 | 지금 쓸 선택지를 늘림 |
| Discard(버림) | 손/플레이 영역 → 개인 버림 더미 | 없음 | 다음 셔플에 다시 돌아옴 |
| Trash(폐기) | 소유 영역 → 공용 폐기 더미 | 감소 | 기본적으로 내 덱에서 영구 제거 |
| Gain(획득) | 공급 → 보통 개인 버림 더미 | 증가 | 구매가 아니어도 Workshop 등으로 가능 |
| Buy(구매) | 비용과 구매 1회를 쓰고 획득 | 증가 | 구매는 획득을 일으키지만 모든 획득이 구매는 아님 |
| Reveal(공개) | 지정 영역에서 모두에게 보임 | 없음 | 공개 뒤 어디로 가는지는 카드가 별도 지시 |
| Look at(확인) | 소유자만 봄 | 없음 | 공개 정보가 아님 |
| Set aside(따로 둠) | 카드가 지정한 임시 영역 | 보통 없음 | 돌아오는 시점과 종료 점수 포함 여부를 카드가 정함 |

이 차이는 효과 발동 조건을 바꾼다. 예를 들어 “카드를 획득할 때” 효과는 Workshop으로 얻어도 발동하지만, “카드를 구매할 때” 효과는 Workshop 획득으로 발동하지 않는다. Cellar로 버린 사유지는 나중에 돌아오지만 Chapel로 폐기한 사유지는 기본적으로 돌아오지 않는다.

#### 액션 수 계산 예시

손에 Village, Smithy, Militia가 있어도 기본 액션은 1회뿐이므로 Smithy부터 쓰면 그 턴에는 Militia를 못 쓴다. Village부터 쓰면 다음처럼 모두 연결된다.

| 순서 | 실행 | 남은 액션 | 손 변화 |
|---:|---|---:|---|
| 시작 | — | 1 | 시작 손 5장 |
| 1 | Village 사용: 1장 드로우, +2 Actions | 2 | Village 1장을 냈지만 1장을 보충 |
| 2 | Smithy 사용: 3장 드로우 | 1 | 손이 크게 늘지만 Smithy는 액션을 주지 않음 |
| 3 | Militia 사용: 코인+공격 | 0 | 남은 액션을 payload에 소비 |

`+2 Actions`는 “총 액션을 2로 만든다”가 아니라 사용 가능한 횟수에 2를 더한다. Village를 내는 데 기존 1회를 썼으므로 순증은 1회다.

#### 구매와 셔플이 실제로 돌아오는 예

아래는 특수 카드가 없는 가장 단순한 첫 순환이다.

1. 첫 손이 동 4+사유지 1이면 액션 단계는 건너뛰고 동 4장을 내 Smithy 같은 4비용 카드를 산다. 새 Smithy는 버림 더미로 간다.
2. Clean-up에서 사용한 동과 남은 사유지도 같은 버림 더미로 가고, 남은 시작 덱 5장을 뽑는다.
3. 둘째 턴에는 남은 카드의 동으로 은 등을 산다. 둘째 Clean-up에서 사용 카드와 남은 손을 버린 뒤 새 5장을 뽑으려 하면 개인 덱이 비어 있다.
4. 바로 이 드로우 시점에 처음 버림 더미를 섞어 새 덱을 만들고 5장을 뽑는다. 첫째·둘째 턴에 산 카드도 이 새 덱에 포함된다.
5. 산 카드를 셋째 턴 손에서 반드시 보는 것은 아니다. 새 덱 어딘가에 섞였으며 덱을 계속 뽑으면서 만나게 된다.

이것이 도미니언의 기본 시간 단위인 **셔플(shuffle)**이다. “이번 구매가 몇 번째 턴에 보이는가”보다 “다음 셔플에 들어갔는가, 셔플 직후 버림 더미에 고립됐는가”를 보는 편이 정확하다.

#### 초보용 한 턴 체크리스트

1. 손의 액션 중 지금 먼저 써야 할 드로우·Village·공격이 있는가?
2. 액션 허용량이 남아 있는가? 카드의 효과를 끝까지 해결했는가?
3. 구매 단계에서 보물과 액션이 만든 코인을 합산했는가?
4. 구매 횟수와 코인이 각각 충분한가?
5. 산 카드를 버림 더미에 놓았는가?
6. 플레이한 카드와 남은 손을 모두 버리고 정확히 5장을 뽑았는가?
7. 종료 조건은 **턴이 끝난 뒤** 확인했는가?

### 1-3. 종료와 승리

2~4인 기본 규칙에서는 턴 종료 시 다음 중 하나면 게임이 끝난다.

- 속주(Province) 더미가 비었다.
- 공급의 아무 3개 더미가 비었다. 저주·보물 더미도 공급이면 포함한다.

자기 소유의 모든 카드와 승점 토큰을 합산해 가장 높은 사람이 이긴다. 동점이면 **더 적은 턴을 플레이한 사람**이 이기고, 턴 수도 같으면 공동 승리다. 5~6인은 빈 더미 조건이 4개로 늘어난다. [공식 종료 규칙](https://www.riograndegames.com/wp-content/uploads/2016/09/Dominion2nd.pdf)

종료 규칙이 만드는 중요한 결과는 다음과 같다.

- 속주 레이스만 보지 않고 값싼 더미 3개를 비워 기습 종료할 수 있다.
- 내가 점수 우위일 때 끝낼 수단도 일종의 자원이다.
- 강한 엔진을 더 완성하는 것이 목표가 아니다. **승리하는 시점까지 필요한 만큼만** 만들면 된다.
- 사유지·공작령을 사는 행동은 점수 획득인 동시에 특정 더미를 줄이는 종료 조작이다.

### 1-4. 기본 카드 7종

| 카드 | 비용/가치 | 효과·목적 | 사용 판단 |
|---|---:|---|---|
| Copper(동) | 비용 0 / 1코인 | 시작 경제 | 초반 필수지만 후반에는 손 1칸당 효율이 낮아 폐기 대상 |
| Silver(은) | 3 / 2코인 | 안정적인 중간 경제 | 빅머니의 주력, 엔진에서는 지나친 수량이 드로우를 막음 |
| Gold(금) | 6 / 3코인 | 고밀도 구매력 | 한 장당 강하지만 강한 액션 엔진에는 반드시 최선은 아님 |
| Estate(사유지) | 2 / 1VP | 값싼 승점 | 시작 덱을 막고 막판 3더미 종료·동점 계산에 중요 |
| Duchy(공작령) | 5 / 3VP | 중간 승점 | 속주가 줄었거나 8코인 도달이 불안할 때 전환점 |
| Province(속주) | 8 / 6VP | 표준 종결 승점 | 구매 순간 덱 생산력을 낮추지만 기본 승리의 중심 |
| Curse(저주) | 비용 0 / -1VP | 공격이 주입하는 오염 | 손을 막고 점수도 낮춘다. 폐기 수단의 가치를 급상승시킴 |

### 1-5. 기본판 2판 킹덤 카드 26종

아래의 “목적”은 효과를 플레이 역할로 번역한 것이다. 실제 세부 해결은 공식 규칙서 카드 설명을 따른다.

| 비용 | 카드 | 유형 | 효과 요약 | 주목적·사용법 |
|---:|---|---|---|---|
| 2 | Cellar | Action | +액션, 원하는 만큼 버리고 같은 수 드로우 | 승점·저주를 좋은 카드로 교환하는 필터; 덱 크기는 줄지 않음 |
| 2 | Chapel | Action | 손에서 최대 4장 폐기 | 가장 강한 초반 압축기 중 하나; 동·사유지를 빠르게 제거 |
| 2 | Moat | Action–Reaction | 2장 드로우; 손에서 공개하면 공격 면역 | 약한 드로우와 방어를 겸하나 공격이 없으면 밀도는 낮음 |
| 3 | Harbinger | Action | +카드 +액션, 버림 더미 카드 1장을 덱 위로 선택 가능 | 다음 드로우·셔플에 핵심 카드를 예약 |
| 3 | Merchant | Action | +카드 +액션, 그 턴 첫 은에 추가 코인 | 은 중심 경제를 보조하는 캔트립 |
| 3 | Vassal | Action | 코인, 덱 위를 버리고 액션이면 즉시 사용 가능 | 덱 위 조작과 결합하는 변동형 액션/경제 |
| 3 | Village | Action | +카드 +2액션 | 터미널 액션을 여러 장 쓰게 하는 대표 ‘Village’ |
| 3 | Workshop | Action | 비용 4 이하 카드 획득 | 구매와 별도인 공급 가속; Gardens 러시·부품 확보 |
| 4 | Bureaucrat | Action–Attack | 은을 덱 위로 얻고 상대는 승점 카드를 덱 위로 | 내 다음 손 경제 보장 + 상대 드로우 지연 |
| 4 | Gardens | Victory | 덱 10장마다 1VP | 카드 수 자체를 점수화; Workshop과 3더미 러시 |
| 4 | Militia | Action–Attack | 코인, 상대 손을 3장까지 버리게 함 | 내 payload와 상대 안정성 저하를 동시에 수행 |
| 4 | Moneylender | Action | 동 1장을 폐기하면 큰 일회 코인 | 압축과 템포를 함께 얻지만 동이 사라지면 정지 카드 |
| 4 | Poacher | Action | +카드 +액션 +코인, 빈 공급 더미 수만큼 버림 | 초중반 고효율, 3더미 종반에는 급격히 약화 |
| 4 | Remodel | Action | 손 1장을 폐기하고 비용 +2까지 획득 | 약한 카드 업그레이드, 막판 금→속주 등 점수 변환 |
| 4 | Smithy | Action | 3장 드로우 | 강한 터미널 드로우; Village 또는 빅머니와 결합 |
| 4 | Throne Room | Action | 손의 액션 1장을 두 번 사용 | 핵심 효과 증폭; 대상 부재·액션 순서가 리스크 |
| 5 | Bandit | Action–Attack | 금 획득, 상대 덱 위 보물 공격 | 경제 성장과 상대 고가 보물 파괴; 액션 엔진에는 영향 편차 |
| 5 | Council Room | Action | 4장 드로우 +구매, 상대도 1장 드로우 | 대형 드로우와 멀티바이 payload, 상대 보상은 비용 |
| 5 | Festival | Action | +2액션 +구매 +2코인 | 드로우만 빠진 엔진 접착제; Smithy류와 상보적 |
| 5 | Laboratory | Action | 2장 드로우 +액션 | 손과 액션을 순증하는 가장 단순한 비터미널 드로우 |
| 5 | Library | Action | 손 7장까지 드로우, 액션을 따로 치울 수 있음 | 작은 손·승점 오염을 복구; Village가 부족한 덱에도 유용 |
| 5 | Market | Action | +카드 +액션 +구매 +코인 | 모든 자원을 조금씩 주는 캔트립 payload |
| 5 | Mine | Action | 보물을 폐기하고 비용 +3까지 보물을 손으로 획득 | 구매력을 손실 없이 업그레이드하지만 덱 장수는 줄지 않음 |
| 5 | Sentry | Action | +카드 +액션, 덱 위 2장을 보고 폐기/버림/되돌림 | 압축·필터·정렬을 한 장에 제공 |
| 5 | Witch | Action–Attack | 2장 드로우, 상대마다 저주 획득 | 공격과 드로우가 결합한 대표 저주 살포기 |
| 6 | Artisan | Action | 비용 5 이하를 손으로 얻고 손 1장을 덱 위로 | 즉시 사용 가능한 획득과 다음 손 예약; 유연한 엔진 도구 |

---

## 2. 카드 유형과 기능 문법

### 2-1. “유형”과 “역할”은 다르다

카드 하단의 공식 유형은 규칙이 참조하는 태그다. 전략적 역할은 플레이어가 효과를 보고 붙이는 분류다. 예를 들어 Smithy의 공식 유형은 `Action` 하나지만 역할은 `터미널 드로우`, Militia는 `Action–Attack`이면서 `payload + 손패 공격`이다.

| 층위 | 예 | 무엇을 결정하는가 |
|---|---|---|
| 공식 카드 유형 | Action, Treasure, Victory, Attack, Duration | 다른 카드가 참조하는 규칙·사용 시점 |
| 비공급 카드/상태 | Horse, Loot, Boon, Hex, State, Artifact | 획득 경로·일회성/지속성 |
| Landscape | Event, Landmark, Project, Way, Ally, Trait, Prophecy | 덱에 들어가지 않고 구매 선택·점수 규칙·전역 규칙을 변경 |
| 전략 역할 | draw, village, payload, gainer, trasher, sifter | 덱 설계에서 그 카드가 맡는 기능 |

### 2-2. 주요 공식 유형

| 유형 | 규칙상 의미 | 전략적 의미 |
|---|---|---|
| Action | 액션 단계에 액션 1회를 소비해 사용 | 엔진 부품·공격·압축·획득의 주 무대 |
| Treasure | 구매 단계에 사용해 주로 코인 생산 | 안정적 payload, 액션 충돌 없음 |
| Victory | 종료 시 VP 계산 | 대개 플레이 중 정지 카드; 성장과 승리의 역설 |
| Curse | 보통 -1VP | 공격성 오염, 덱 압축 요구 |
| Attack | 다른 플레이어에게 해로운 효과 | 상호작용·속도 저하·방어 가치 생성 |
| Reaction | 지정 사건에 손 등에서 반응 | 상대 카드·획득·버림을 읽는 전술 층 |
| Duration | 현재 턴 이후에도 효과가 남음 | 미래 턴 예약, 플레이 영역 추적 필요 |
| Reserve | Tavern 매트에 두고 조건 시 호출 | 효과 타이밍을 플레이어가 보존·선택 |
| Traveller | 버릴 때 다음 단계 카드로 교환 가능 | 여러 셔플에 걸친 성장선 |
| Night | 구매 단계 뒤 Night 단계에 사용 | 액션 수와 별개인 두 번째 실행 채널 |
| Command | 특정 조건의 액션을 대신 사용 | 킹덤 맥락에 따라 가치가 크게 변하는 복제기 |
| Liaison | Favor를 생산 | Allies의 전역 능력 자원 공급원 |
| Omen | Prophecy의 해금을 앞당김 | 후반 전역 규칙의 시계를 조작 |
| Shadow | 손이 아니라 덱에서 직접 사용 가능 | 손패 5장 제한을 비트는 숨은 접근성 |

확장에는 `Looter`, `Knight`, `Castle`, `Fate`, `Doom`, `Heirloom`, `Spirit`, `Shelter`, `Ruins`, `Gathering`처럼 특정 세트의 준비나 참조에 쓰이는 유형도 있다. 전체 상호작용은 팬이 편찬한 [Complete Rules v11](https://madforest.com/Dominion_CompleteRules_v11.pdf)이 Rising Sun까지 한 문서로 정리하지만, 충돌 시 각 확장의 공식 규칙과 최신 정오표가 우선이다.

### 2-3. 전략 역할 사전

| 역할 | 판별 기준 | 대표 카드 | 설계상 목적 |
|---|---|---|---|
| Cantrip | 최소 +1 Card, +1 Action | Market, Merchant | 손·액션을 거의 쓰지 않고 작은 효과 추가 |
| Village | 순 +액션을 제공 | Village, Festival | 터미널 액션 충돌 해소 |
| Terminal draw | 액션을 돌려주지 않는 큰 드로우 | Smithy, Council Room | 손패를 크게 늘리되 Village 요구 |
| Non-terminal draw | 자기 사용분을 보상하며 드로우 | Laboratory | 엔진 안정성, 보통 가격이 높음 |
| Payload | 코인·구매·VP·공격 등 최종 산출 | Gold, Militia, Bridge | 덱이 돌아간 뒤 실제 승리를 생산 |
| Trasher | 카드를 폐기 | Chapel, Sentry | 좋은 카드의 출현 빈도와 셔플 속도 증가 |
| Sifter/Filter | 버리고 다시 뽑거나 선택 드로우 | Cellar, Warehouse | 덱을 줄이지 않고 손 품질 개선 |
| Gainer | 구매 외 카드 획득 | Workshop, Artisan | 빌드 속도·더미 고갈·멀티게인 증가 |
| Remodeler | 폐기와 더 비싼 획득 결합 | Remodel, Upgrade | 시작 카드 제거를 가치 상승으로 전환 |
| Top-deck control | 덱 위를 놓거나 확인 | Harbinger, Sentry | 다음 손·셔플 경계의 불확실성 축소 |
| Alt-VP | 속주 외 점수원 | Gardens, Duke, Vineyard | 덱의 평가 함수를 판마다 변경 |
| Junker | 저주·폐허·동 등을 상대에게 줌 | Witch, Cultist | 상대 덱의 평균 품질과 템포 저하 |

### 2-4. 핵심 자원 네 가지

- **Card:** 이번 턴 선택지를 늘린다. 단, 뽑은 카드가 정지 카드라면 가치가 낮다.
- **Action:** 액션 카드를 실제로 실행할 허용량이다. 카드 수와 별개다.
- **Coin:** 살 수 있는 카드 가격의 상한을 올린다.
- **Buy/Gain:** 한 턴의 획득 장수를 늘린다. 코인이 많아도 구매가 1이면 2장을 못 산다.

좋은 엔진은 네 자원을 모두 무한히 늘리는 것이 아니라 목표 산출에 맞게 균형을 맞춘다. `Village 5장 + Smithy 1장`은 액션만 남고, `Smithy 5장 + Village 1장`은 터미널 충돌로 손에서 썩는다. `카드 드로우 → 액션 → payload → 추가 구매`의 병목 중 가장 낮은 것이 실제 처리량을 정한다.

---

## 3. 확장팩: 새 카드보다 새 평가 규칙

확장은 카드 수를 늘리는 것보다 “좋은 덱의 정의”를 바꾼다. 아래 표의 대표 카드는 전부가 아니라 그 세트의 설계 의도를 가장 잘 드러내는 예다.

| 확장 | 핵심 문법 | 대표 카드/요소와 용도 | 바뀌는 전략 질문 |
|---|---|---|---|
| Intrigue 2E | 선택지, 다유형 카드, 간접 상호작용 | **Steward**: 드로우/코인/폐기 중 선택. **Masquerade**: 패스와 폐기. **Bridge**: 비용 감소+구매. **Nobles**: Action–Victory | 한 장의 모드 유연성과 상대에게 넘길 카드까지 계산하는가 |
| Seaside 2E | Duration, 다음 턴 예약 | **Fishing Village**: 현재·다음 턴 액션/코인. **Wharf**: 두 턴 드로우+구매. **Island**: 카드와 자신을 격리하며 VP. **Sailor**: Duration 획득/폐기 연계 | 지금의 손을 미래 턴과 어떻게 나누는가 |
| Alchemy | Potion이라는 두 번째 비용, 액션 밀도 | **Alchemist**: 강한 드로우와 재사용. **University**: 액션 획득. **Vineyard**: 액션 수 기반 VP. **Familiar**: 저주 공격 | 별도 통화를 살 지연을 감수할 만큼 보상이 큰가 |
| Prosperity 2E | 고가 경제, Platinum/Colony, 보물 중심, VP 토큰 | **King's Court**: 액션 3회. **Grand Market**: 고밀도 캔트립. **Bishop**: 폐기+VP 토큰. **Collection**: 카드 획득을 점수화 | 8이 아니라 11코인과 거대 턴을 목표로 할 때 덱 규모는 어떻게 달라지는가 |
| Cornucopia 2E | 카드 이름의 다양성 | **Menagerie**: 손의 중복이 없으면 대량 드로우. **Hunting Party**: 다른 이름을 찾는 드로우. **Fairgrounds**: 서로 다른 카드 수를 VP화 | 같은 강카드 반복보다 한 장씩 섞는 편이 이득인가 |
| Guilds 2E | Coffers 저장, overpay | **Baker**: Coffers 경제. **Butcher**: 폐기 후 Coffers로 업그레이드 폭 조절. **Merchant Guild**: 구매가 미래 Coffers를 생산 | 남는 돈을 턴 사이에 저장하면 가격 임계값이 어떻게 변하는가 |
| Hinterlands 2E | 획득 순간·버림 순간 효과 | **Border Village**: 획득 시 싼 카드 추가. **Highway**: 전역 비용 감소. **Trail**: 버림/폐기에 반응해 사용. **Weaver**: 버릴 때 획득 | 카드를 ‘플레이’하지 않아도 가치가 발생하는가 |
| Dark Ages | 폐기, Ruins, Shelters, 쓰레기의 자원화 | **Junk Dealer**: 캔트립 폐기. **Fortress**: 폐기되면 손으로 복귀. **Rats**: 자기 증식+폐기 유도. **Cultist**: Ruins 공격과 연속 사용. **Knights**: 혼합 더미 공격 | 나쁜 카드를 없애는 것과 효과를 위해 일부러 폐기하는 것을 결합할 수 있는가 |
| Adventures | Event, Reserve, Traveller, 더미 토큰 | **Page/Peasant**: 셔플마다 진화. **Royal Carriage**: 나중에 액션 재사용. **Bridge Troll**: Duration 비용 감소. **Lost City**: 고성능과 상대 보상 | 카드를 사는 대신 Event를 사고, 효과 시점을 저장할 가치가 있는가 |
| Empires | Debt, split pile, Landmark, Gathering, VP 토큰 | **City Quarter**: 코인 없이 Debt로 사는 드로우. **Engineer**: Debt 기반 획득. **Castles**: 한 더미의 서로 다른 VP 카드. **Crown**: 액션/보물 복제. **Landmarks**: 종료 점수 규칙 변경 | 현재 돈 없이 미래 구매를 담보로 당겨 쓰고, 판마다 다른 평가 함수에 맞출 수 있는가 |
| Nocturne | Night, Heirloom, Boon/Hex, State | **Cursed Village**: 손 보충+Hex. **Devil's Workshop**: 그 턴 획득 수에 따라 보상. **Exorcist**: 카드를 Spirit으로 변환. **Leprechaun**: 금과 Hex/특수 보상 | 액션 단계 뒤의 별도 채널과 통제하기 어려운 상태 변화를 감당하는가 |
| Renaissance | Project, Artifact, Coffers/Villagers 정식화 | **Recruiter**: 폐기 비용만큼 Villagers. **Silk Merchant**: 획득/폐기 때 토큰. **Inventor**: 획득+비용 감소. **Seer**: 특정 가격대 드로우 | 남는 액션·돈을 저장하고 영구 규칙을 구매하면 엔진 안정성이 얼마나 오르는가 |
| Menagerie | Exile, Way, Horse, Event | **Bounty Hunter**: 손 카드를 Exile하고 중복 여부로 보상. **Sanctuary**: 캔트립 Exile. **Mastermind**: 다음 턴 액션 3회. **Cavalry/Horse**: 일회성 대량 드로우 | 모든 액션에 대체 사용법이 생기면 정지 카드도 비상구가 되는가 |
| Allies | Favor, Ally, Liaison, 회전 split pile | **Underling**: 캔트립+Favor. **Importer**: Duration Favor와 시작 카드 획득. **Broker**: 폐기를 여러 보상으로 교환. **Augurs 등**: 4단 회전 더미 | 개인 덱의 자원이 전역 Ally 능력과 결합할 때 언제 저장·소비하는가 |
| Plunder | Loot, Trait, 다수의 Treasure–Duration, Event | **Gondola**: 획득 시 액션 사용 가능. **King's Cache**: 보물 3회 사용. **Crew**: 다음 턴 덱 위로 돌아오는 Duration. **Loot**: 무작위 고급 보물. **Traits**: 특정 공급 더미 성질 변경 | 같은 카드도 붙은 Trait에 따라 역할이 바뀌고, 무작위 보상을 어떻게 흡수하는가 |
| Rising Sun | Shadow, Omen/Prophecy, Debt·Event 재등장 | **Ninja**: 덱에서 직접 쓸 수 있는 Shadow 공격. **Daimyo**: Debt 비용의 액션 반복. **Mountain Shrine**: Debt와 폐기. **Omens/Prophecies**: 토큰이 다 빠지면 전역 규칙 발동 | 손패 밖 카드 접근과 예고된 규칙 전환 전에 덱을 어느 방향으로 준비하는가 |

현행 확장 세부 규칙은 [Allies 공식 규칙](https://www.riograndegames.com/wp-content/uploads/2021/09/Dominion-Allies-Rules.pdf), [Menagerie 공식 규칙](https://www.riograndegames.com/wp-content/uploads/2020/01/Dominion-Menagerie-Rules.pdf), [Rising Sun 공식 규칙](https://www.riograndegames.com/wp-content/uploads/2024/04/DomRisingSunRules.pdf), [Rio Grande의 전체 제품 목록](https://www.riograndegames.com/games/dominion/)을 기준으로 교차 확인했다.

### 3-1. Landscape가 중요한 이유

Event·Project·Landmark·Way·Ally·Trait·Prophecy는 보통 개인 덱에 섞이지 않는다. 이들은 새 카드 한 장이 아니라 **이번 게임의 규칙 또는 평가 함수**를 바꾼다.

- Event: 구매 1회를 카드가 아닌 즉시 효과에 쓴다.
- Landmark: 종료 점수 계산을 바꾼다.
- Project: 구매 후 개인에게 지속되는 능력을 준다.
- Way: 모든 액션 카드에 공통 대체 사용법을 준다.
- Ally: Favor를 쓰는 공용 규칙을 제공한다.
- Trait: 특정 공급 더미의 모든 카드에 성질을 붙인다.
- Prophecy: 예고된 전역 규칙이 게임 도중 발동한다.

기획적으로는 적은 콘텐츠로 조합 공간을 크게 늘리는 방법이다. 카드 10장을 더 만드는 대신 기존 카드 100장의 평가를 바꾸는 규칙 1개가 더 큰 변주를 낼 수 있다. 반대로 추적 상태와 예외가 늘어나는 비용도 크다.

---

## 4. 전략과 플레이 방식

### 4-0. 전략 용어 사전

공식 규칙서에 없는 커뮤니티 용어가 많다. 아래를 알면 이후 전략 문장을 그대로 읽을 수 있다.

| 용어 | 뜻 |
|---|---|
| Kingdom(왕국) | 이번 게임에 선택된 킹덤 카드 10종과 그 조합 |
| Opening(오프닝) | 첫 두 구매. 시작 10장을 두 손으로 쓰므로 보통 3/4·4/3, 드물게 2/5·5/2 코인 분할이 생김 |
| Shuffle(셔플) | 덱이 모자랄 때 버림 더미를 섞어 새 덱을 만드는 한 순환 |
| Collision | 같이 잡혔지만 액션 수·대상 부재 등으로 둘 다 못 쓰는 상태 |
| Terminal | 사용 뒤 액션을 돌려주지 않는 액션 카드 |
| Terminal collision | 기본 액션 1회인데 terminal 액션 여러 장이 한 손에 잡혀 나머지가 썩는 현상 |
| Cantrip | 보통 +1 Card +1 Action으로 자기 손·액션 비용을 보상하는 카드 |
| Village | 순 액션을 늘려 terminal 여러 장을 연결하는 카드군 |
| Draw | 손의 카드 수 또는 덱을 보는 범위를 늘리는 기능 |
| Payload | 엔진이 최종적으로 생산하려는 코인·구매·획득·VP·공격 |
| Enabler | 압축·드로우·Village처럼 다른 payload를 안정적으로 작동시키는 부품 |
| Stop card | 드로우를 이어 주지 않아 엔진 진행을 멈추는 카드 |
| Thinning | 약한 카드를 폐기해 덱을 얇게 만드는 것. trashing/압축과 같은 맥락 |
| Cycling | 필터·드로우로 덱을 더 빨리 훑는 것. 덱 장수가 줄지는 않을 수 있음 |
| Gainer | 구매를 쓰지 않고 카드를 획득하는 카드 |
| Junk/Junking | 저주·폐허·동처럼 약한 카드를 덱에 넣거나 상대에게 주는 것 |
| Alt-VP | 속주 외의 대체 승점 카드·토큰·평가 규칙 |
| Green/Greening | Victory 카드, 또는 그것을 사기 시작하는 단계 |
| Pile split | 한 공급 더미의 카드가 플레이어 사이에 몇 대 몇으로 나뉘었는가 |
| Pile-out/3-pile | 필요한 공급 더미를 비워 게임을 끝내는 것 |
| Megaturn | 여러 턴 준비 후 한 턴에 대량 득점·획득하며 게임을 끝내는 엔진/콤보 턴 |
| Overdraw | 현재 덱을 다 뽑는 데 필요한 양보다 드로우가 많은 상태. 안정성·공격 복구에는 여유가 될 수 있음 |
| Overterminal | 실제로 실행할 액션보다 terminal 액션이 지나치게 많은 덱 |
| Tempo | 미래 상한보다 지금 몇 턴 빨리 구매·공격·득점하는가 |
| Reliability | 원하는 턴 구조가 셔플 편차 속에서도 반복될 확률 |

### 4-1. 킹덤을 읽는 순서

숙련 플레이는 “가장 강한 카드는 무엇인가”보다 다음 질문의 답을 연결하는 작업이다.

1. **압축:** 시작 동·사유지·저주를 얼마나 빨리 없앨 수 있는가?
2. **드로우:** 덱을 매 턴 얼마나 많이 볼 수 있는가? terminal인가?
3. **액션:** terminal draw와 payload를 모두 실행할 Village가 있는가?
4. **payload:** 한 턴에 점수·코인·공격을 무엇으로 생산하는가?
5. **멀티바이/획득:** 한 턴에 여러 점수 카드나 엔진 부품을 얻을 수 있는가?
6. **공격/방어:** 상대가 내 계획의 신뢰도를 얼마나 낮추는가?
7. **대체 VP:** 속주 외 점수원이 덱 구성이나 종료 시계를 바꾸는가?
8. **종료:** 누가 어떤 3개 더미를 비울 수 있는가?

#### 기본판 첫 게임 왕국을 실제로 읽기

공식 첫 게임 권장 왕국은 Cellar, Market, Merchant, Militia, Mine, Moat, Remodel, Smithy, Village, Workshop이다. 이 10장을 위 질문으로 읽으면 다음과 같다.

| 질문 | 이 왕국의 답 | 전략적 결과 |
|---|---|---|
| 빠른 압축이 있는가? | Chapel은 없고 Remodel/Mine은 카드를 교체할 뿐 장수는 줄이지 않음 | 완전한 초박형 덱보다 보물 중심 또는 중간 크기 엔진이 현실적 |
| 드로우가 있는가? | Smithy +3, Moat +2, Cellar 필터 | Smithy가 가장 강한 대량 드로우지만 terminal |
| Village가 있는가? | Village, Market/Merchant 캔트립 | Village–Smithy–Militia 연결 가능 |
| payload는? | 보물, Militia의 코인, Market의 코인/+Buy | 공격과 경제를 같이 가져갈 수 있음 |
| 추가 구매는? | Market만 제공 | 여러 장을 사는 엔진은 Market 수와 코인이 병목 |
| 획득기는? | Workshop이 4비용 이하 획득 | Village·Smithy·Militia 등을 빨리 모으고 Workshop 더미도 줄임 |
| 대체 VP는? | 없음 | 주 득점은 속주, 막판 공작령·사유지 |
| 공격/방어는? | Militia / Moat | Militia가 많으면 큰 손을 유지할 드로우와 Moat의 반응 가치 상승 |

여기서 초보가 선택할 수 있는 두 계획은 다음과 같다.

**계획 A — Smithy Big Money:** 첫 4코인에 Smithy 1장, 3코인에는 은을 사고 이후 은·금 중심으로 간다. Smithy는 1~2장만 유지해 terminal collision을 피하고 8코인 빈도가 높아지면 속주를 산다. 단순하고 빠른 기준선이다.

**계획 B — Village/Smithy 엔진:** Workshop·Village·Smithy를 모으고 Market으로 +Buy와 코인을 보충한다. Smithy 수보다 Village의 실행 여유가 부족하지 않게 하고 Militia 1장을 payload로 넣는다. 덱을 다 뽑아도 Market이 적으면 속주를 한 장밖에 못 사므로, 엔진 크기를 늘리기 전에 “한 턴 2구매와 16코인이 가능한가”를 확인한다.

상대가 빠르게 속주를 사면 계획 B는 완성을 줄이고 보물·속주로 전환한다. 상대가 Workshop으로 Village·Smithy 더미를 빠르게 줄이면, 점수 우위와 3더미 종료 가능성을 함께 계산한다. 이처럼 전략은 카드 목록에서 자동 결정되는 정답이 아니라 **왕국 구조 + 상대 속도 + 현재 더미**의 함수다.

### 4-2. 주요 다섯 덱 유형

커뮤니티의 고전적 분류는 Big Money, Slog, Engine, Rush, Combo다. 경계는 연속적이며 한 판 중 다른 유형으로 전환할 수 있다. [Five Fundamental Deck Types 소개](https://dominionstrategy.com/2013/01/21/the-five-fundamental-deck-types-introduction/)

| 유형 | 핵심 계획 | 필요한 카드·조건 | 강점 | 실패 패턴 |
|---|---|---|---|---|
| Big Money | 은·금으로 8코인 빈도를 높여 속주 구매 | 특별한 조건 없음; Smithy 같은 터미널 드로우 1~2장 보강 가능 | 빠르고 안정적, 실행 실수 적음 | 강한 압축·멀티바이 엔진의 후반 폭발에 밀림 |
| Slog | 저주·폐허·약한 경제 속에서 작은 VP와 장기 효율로 우위 | 강한 junking, 제한된 폐기, alt-VP | 모두가 망가진 판에서 복원력 우수 | 깨끗한 엔진이 공격을 상쇄하면 장기적으로 압도당함 |
| Engine | 덱 대부분/전체를 뽑아 Village→draw→payload를 반복 | 압축, 드로우, 액션, payload, 구매/획득 | 다중 속주·정밀한 3더미 종료, 높은 상한 | 조립이 늦거나 비율이 틀리면 Big Money보다 느림 |
| Rush | 값싼 VP와 획득기로 점수 우위를 만든 뒤 3더미 종료 | Workshop류, Gardens류, 빠르게 빌 더미 | 상대 엔진 완성 전에 게임 종료 | 핵심 더미 분할에 지거나 종료 속도가 부족하면 약한 덱만 남음 |
| Combo | 특정 카드 상호작용으로 비정상적으로 큰 턴·점수·종료 생성 | 왕국에 존재하는 좁고 강한 조합 | 완성 시 일반 효율 곡선을 건너뜀 | 부품 충돌, 셔플 운, 상대의 선점·공격, 느린 조립 |

Big Money의 단순 규칙은 대략 `8+ 속주 → 6~7 금 → 그 이하 은`, 속주가 5장 남으면 공작령을 고려하는 식이다. 무공격 기준 약 17턴에 속주 4장을 얻는 벤치마크로 소개되며, “정답”이 아니라 복잡한 전략이 넘어야 할 기준선이다. [Big Money 해설](https://dominionstrategy.com/big-money/)

### 4-3. 엔진의 구조

```text
압축/필터 → Village(+Action) → Draw(+Card) → Payload(돈·VP·공격)
                                      └────→ +Buy/Gain → 한 턴 다중 획득
```

엔진의 정지 카드(stop card)는 뽑았을 때 다음 카드를 연결하지 못하는 카드다. 보물, 승점, 저주, +Action 없는 액션이 대표적이다. 엔진은 단순히 좋은 액션을 많이 사는 덱이 아니라 **정지 카드 수를 통제해 매 턴 목표 지점까지 도달하는 덱**이다. 강한 드로우가 terminal이면 Village가 필요하고, 덱을 다 뽑아도 payload나 +Buy가 없으면 승리 산출이 없다. [Dominion 101: Engine](https://dominionstrategy.com/2017/11/06/dominion-101-what-is-an-engine/)

### 4-4. 실전 전략 15가지

| 전략 | 응용 카드 유형·예 | 운용 핵심 | 대응·주의 |
|---|---|---|---|
| Smithy Big Money | 터미널 드로우 + 보물 | Smithy 소수만 넣어 돈 밀도를 유지하며 손을 확장 | Smithy 과매수는 서로 충돌하고 승점 오염 뒤 급락 |
| Chapel 압축 | 대량 trasher | 첫 셔플들에 동·사유지를 3~4장씩 제거, 핵심 카드 재등장 가속 | 너무 빨리 돈을 모두 없애 다음 구매가 멈추지 않게 함 |
| Village–Smithy | Village + terminal draw | 대략 draw terminal을 실행할 만큼 Village를 맞추고 payload 추가 | 둘만 늘리면 카드를 뽑기만 하고 구매 산출이 없음 |
| Workshop–Gardens | gainer + deck-size VP | Workshop·Gardens·값싼 카드 더미를 함께 비워 3더미 | 상대가 Gardens 분할을 막거나 속주 점수로 앞서면 전환 필요 |
| Witch slog | draw+junker + 제한된 폐기 | 먼저 저주를 뿌려 상대 덱을 늦추고 내 저주는 더 잘 처리 | 저주가 다 떨어진 뒤 Witch는 단순 terminal draw가 됨 |
| Remodel ladder | remodeler | 사유지→4코스트, 은/4→5~6, 금→속주로 단계 상승 | 좋은 카드를 너무 일찍 희생하면 엔진 붕괴 |
| Bridge megaturn | 비용 감소 + +Buy + 복제 | 여러 Bridge를 한 턴에 사용해 속주 가격을 낮추고 대량 구매 | 조립 전 상대 러시, Bridge 더미 분할, terminal 충돌 |
| Alt-VP rush | Gardens, Vineyard, Duke 등 | 그 VP가 요구하는 덱 구성 자체를 생산 계획으로 삼음 | 액면 점수가 아닌 최종 장수·종류·액션 수를 계속 계산 |
| Gain-and-play | Artisan, Gondola, Villa/Cavalry류 | 얻은 카드를 같은 턴 사용해 구매 단계에서 액션 흐름 재개 | 단계 전환과 남은 액션·구매의 정확한 규칙 이해 필요 |
| Trash-for-benefit | Fortress + Remodel류, Rats | 폐기될 때 돌아오거나 보상하는 카드를 반복 연료로 사용 | 콤보 부품 하나가 없으면 평범하거나 해로운 카드가 됨 |
| Discard synergy | Cellar류 + Tunnel/Trail류 | 버림을 비용이 아니라 금 획득·즉시 사용 트리거로 전환 | Clean-up의 버림과 효과에 의한 버림을 구분 |
| Topdeck/shuffle control | Harbinger, Sentry, Scheme류 | 좋은 카드가 버림 더미에 들어온 뒤 셔플되도록 시점을 조정 | 덱이 떨어지는 순간과 공개 정보 추적이 필요 |
| Attack lock | 손패 감소/덱 위 방해 + 반복 | 상대가 회복하기 전에 매 턴 같은 제약을 재현 | 공격만 많고 내 payload가 없으면 이길 점수가 없음 |
| Pile control | gainer, +Buy, split pile | 빈 더미 후보 2~3개와 양쪽 점수를 동시에 추적해 즉시 종료 | 마지막 획득 후 내가 실제 점수 우위인지 먼저 계산 |
| Engine pivot | 초반 엔진→중반 Big Money/green 또는 rush | 상대 속도와 더미 상황에 따라 완성을 포기하고 득점 전환 | “처음 정한 덱”에 집착하면 최적 종료 창을 놓침 |

### 4-5. 그리닝: 언제 승점으로 전환하는가

`Greening`은 승점 카드를 사기 시작하는 것이다.

- 1구매 덱은 매 턴 8코인을 안정적으로 만들 즈음 속주로 전환한다.
- 엔진은 13(속주+공작령), 16(속주 2장), 18(속주+공작령 2장) 같은 **한 턴 득점 임계값**을 기준으로 볼 수 있다.
- Gardens rush는 덱 개선과 득점이 같은 구매이므로 처음부터 green한다.
- 성장 속도가 빠를수록 전환을 늦출 수 있지만, 상대가 먼저 종료할 수 있으면 이론적 완성도는 의미가 없다.

즉 “몇 턴부터”라는 고정 답은 없다. 남은 속주, 상대의 점수·구매력, 내 다음 셔플의 오염, 3더미 가능성을 함께 본다. [When Should I Start Greening?](https://dominionstrategy.com/2019/03/31/when-should-i-start-greening/)

### 4-6. 초보가 자주 하는 실수

- 가격이 높은 액션을 종류별로 한 장씩 산다 → 덱의 목적과 비율이 없다.
- 모든 손의 돈을 반드시 쓴다 → 약한 카드 한 장이 이후 모든 셔플에 비용을 만든다.
- 액션 수와 손의 액션 카드 수를 혼동한다 → terminal collision.
- 드로우만 늘리고 +Buy/payload를 빼먹는다 → 거대한 손으로 카드 한 장만 산다.
- 승점 구매를 너무 늦춘다 → 완벽한 엔진으로 패배한다.
- 속주 수만 본다 → 공작령·사유지·alt-VP와 3더미 기습을 놓친다.
- 폐기를 손해로 본다 → 덱 평균 품질과 핵심 카드 재등장 속도를 과소평가한다.

---

## 5. 게임 메커니즘과 재미의 역기획

이 절에서 “플레이어가 느낀다”는 문장은 공식 규칙과 전략 자료에서 도출한 **기획적 추론**이다. 모든 사용자의 취향을 대표하는 설문 결과로 읽어서는 안 된다.

### 5-1. Mechanics → Dynamics → Experience

| Mechanics: 구현 규칙 | Dynamics: 플레이 중 발생 | Experience: 기대 감정 |
|---|---|---|
| 매 판 킹덤 10종만 공개 | 같은 카드도 동료·카운터가 달라져 평가 변동 | 판을 읽고 답을 발견하는 퍼즐 |
| 구매 카드는 버림 더미로 | 보상이 한 셔플 늦게 도착 | 투자 기대, 다시 만났을 때의 회수감 |
| 손 5장·기본 액션 1 | 좋은 액션끼리 충돌 | 비율 조정과 엔진이 맞물리는 만족 |
| 시작 동·사유지 | 약한 카드가 계속 재등장 | 폐기 전후가 눈에 띄는 정리 쾌감 |
| 승점 카드가 덱에 들어감 | 이기기 위한 구매가 생산력을 낮춤 | 성장과 종결 사이의 긴장 |
| 공급 더미가 종료 시계 | 구매·획득이 시장과 남은 시간을 동시에 변경 | 종료를 계산해 빼앗는 전술적 쾌감 |
| 공용 공급, 개인 덱 | 같은 재료로 서로 다른 기계를 만듦 | 공정한 출발과 빌드 소유감 |
| 셔플과 불완전한 손 | 계획이 확률적으로 흔들림 | 위험 관리, 고점 손패의 폭발감 |

### 5-2. 재미의 핵심 여덟 가지

1. **조합 발견:** 카드 자체보다 두세 카드 사이의 상보성을 찾는다.
2. **기계 제작:** 초반의 약한 3~4코인 손이 후반에 덱 전체를 돌리는 턴으로 변한다.
3. **압축의 체감:** 카드를 추가하는 성장뿐 아니라 삭제가 성장이라는 역설을 경험한다.
4. **지연된 보상:** 산 카드가 다음 셔플에서 등장할 때 이전 선택이 현재 결과가 된다.
5. **맥락적 가치:** Chapel, Witch, Village의 가치는 왕국·상대·게임 시점에 따라 바뀐다.
6. **종료 창 계산:** 점수 우위를 만든 뒤 마지막 더미를 정확히 비우는 순간이 작은 체크메이트처럼 작동한다.
7. **짧은 재도전:** 규칙 골격은 같고 킹덤만 바뀌므로 실패 원인을 바꿔 바로 다시 시험할 수 있다.
8. **명확한 인과:** 카드 텍스트, 덱 구성, 손패 결과의 연결이 비교적 직접적이다.

디자이너 Donald X. Vaccarino는 출발점을 “플레이 중 덱을 만들며 모든 것이 덱 안에 있다”는 전제로 설명했고, 속주 중심 목표가 덱을 만드는 재미를 누릴 만큼 게임을 지속시키는 장치라고 설명했다. [Cardboard Edison 인터뷰](https://cardboardedison.com/blog/meaningful-decisions-donald-x-vaccarino-dominion)

### 5-3. 핵심 긴장 네 쌍

| 한쪽 | 반대쪽 | 플레이 질문 |
|---|---|---|
| 덱 성장 | 즉시 득점 | 한 번 더 만들 것인가 지금 green할 것인가 |
| 카드 추가 | 덱 순도 | 이 카드는 가격만큼 미래 5장 손에 들어올 가치가 있는가 |
| 엔진 상한 | 엔진 신뢰도 | 고점 콤보와 매 턴 안정성 중 무엇이 현재 레이스에 맞는가 |
| 개인 최적화 | 공유 더미 통제 | 내 덱만 개선할 것인가 상대가 원하는 더미를 먼저 가져갈 것인가 |

### 5-4. 변주가 큰데 학습은 누적되는 이유

26종 중 10종을 고르는 기본판만으로도 조합 수는 `C(26,10) = 5,311,735`다. 확장을 섞으면 실질 조합 공간은 훨씬 커진다. 그러나 플레이어는 500만 개 왕국을 외우지 않는다. `Village`, `terminal draw`, `trasher`, `gainer`, `payload`, `alt-VP`라는 **기능 문법**을 배워 처음 보는 왕국에 전이한다.

2024년 연구가 숙련자 온라인 게임 200만 판 이상을 데이터셋으로 삼고 Dominion을 강화학습 벤치마크로 제안한 것도, 규칙은 이산적이고 명확하지만 장기 보상·큰 조합 공간·상대 적응이 함께 있기 때문이다. [Dominion: A New Frontier for AI Research](https://arxiv.org/abs/2405.06846)

### 5-5. 약점과 취향 갈림

- 테마가 규칙과 느슨해 추상 퍼즐처럼 느껴질 수 있다.
- 직접 전투보다 간접 공격과 공급 경쟁이 많아 “멀티플레이 솔리테어”라는 인상을 줄 수 있다.
- 셔플 운이 중요한 한 턴을 망칠 수 있다.
- 확장의 Landscape·토큰·상태가 누적되면 기본판의 우아한 ABC 구조가 흐려진다.
- 숙련도 차이가 나면 초보는 왜 졌는지 결과가 나올 때까지 모를 수 있다.
- 물리판은 잦은 셔플과 설치·정리가 마찰이다.

따라서 도미니언식 재미를 차용할 때 카드 수만 늘리는 것은 답이 아니다. **구매의 지연, 덱 순환의 가시성, 압축 전후 차이, 종료 판단**이 화면과 피드백으로 읽혀야 한다.

---

## 6. 사용자 제작 1인 규칙과 챌린지

도미니언 기본판에는 물리판 공식 솔로 규칙이 없다. 아래는 서로 호환되는 하나의 표준이 아니라, 각기 다른 문제를 푸는 팬 변형이다.

### 6-1. The Race Against Curses

Jeremy Tarpey의 솔로 변형. AI 덱을 흉내 내지 않고 **승점 획득 빈도와 저주 시계**를 맞바꾼다. [공식 배포 페이지](https://www.tarpeygames.com/DominionRAC)

#### 준비와 진행

- 시작 덱: 동 7, 은 2, 사유지 3 = 12장.
- 매 턴 손 6장.
- 공급: 속주 3, 공작령 12, 사유지 12, 저주 6, 모든 기본 보물.
- 킹덤: 각 비용마다 최대 2종을 골라 각 10장. 첫 게임 추천 세트도 제공된다.
- 일반적인 액션·구매·버림·폐기·획득 규칙을 따른다. 다른 플레이어 대상 효과는 무시한다.
- 그 턴 승점 카드를 하나도 구매하거나 획득하지 못하면 저주 1장을 얻는다.
- 손에 Moat가 있으면 그 턴 승점 획득 없이도 저주를 막는다.
- 속주 더미를 저주 더미보다 먼저 비우면 승리하고 점수를 기록한다.
- 다른 3더미 고갈은 종료를 일으키지 않는다.

#### 만들어지는 전략

- 매 턴 승점을 얻는 것이 방어이므로 원작보다 훨씬 일찍 green한다.
- +Buy와 Workshop류가 공격·방어를 겸한다.
- 저주는 패배 시계이면서 덱 오염이므로 한 번 뒤처지면 복구가 어려워지는 양의 피드백이 있다.
- Moat는 상대가 없어도 시간 면역 카드로 재해석된다.
- 원작의 3더미 통제는 거의 사라지고 속주/저주 두 더미 레이스로 단순화된다.

#### 장단점

| 장점 | 한계 |
|---|---|
| AI 처리 없이 매우 빠르고 규칙 기억이 적음 | 매 턴 VP 요구가 엔진·메가턴의 긴 빌드를 억제 |
| 공격 카드를 일부 솔로 의미로 바꿀 수 있음 | 시작 덱·손 크기가 원작과 달라 카드 밸런스가 변함 |
| 점수와 성공/실패를 모두 기록 가능 | 왕국 카드에 따라 매 턴 VP 획득 가능성이 크게 달라짐 |

### 6-2. 턴 수 제한·Shortest Rounds / Dominion Golf

이 이름은 단일 공인 규칙을 가리키지 않는다. 공통 아이디어는 **고정 왕국과 시작 조건에서 목표를 가장 적은 자기 턴으로 달성**하는 것이다. 커뮤니티의 `Dominion Golf`도 속주 또는 3더미라는 정상 종료 조건을 최소 턴에 달성하는 퍼즐로 제안됐다. [Dominion Golf 제안](https://www.reddit.com/r/dominion/comments/130u0rt/dominion_golf/)

재현 가능한 권장 기록 규격:

1. 왕국 10종, Landscape, 첫 손/셔플 시드, 플레이어 수 규칙을 고정한다.
2. 목표를 `속주 8장 고갈`, `합법적 3더미`, `N VP 이상`, `특정 카드 콤보 실행` 중 하나로 명시한다.
3. 점수는 우선 **성공 여부**, 다음 **사용한 턴 수**, 다음 **최종 VP** 순으로 비교한다.
4. 무한 루프·Mission 같은 추가 턴이 있는 확장은 “턴”의 정의를 로그 기준으로 미리 고정한다.
5. 이론상 1턴 종료가 가능한 조합도 있으므로 왕국 선택 자체를 경쟁으로 두지 말고 **동일 문제**를 공유한다.

보존하는 재미는 빌드 최적화와 재도전이다. 잃는 것은 상대 적응과 점수 우위에 맞춘 종료 판단이다. 따라서 일반 모드보다 Daily 퍼즐·밸런스 벤치마크에 적합하다.

### 6-3. The “Big Money” Dummy Opponent

가장 단순한 오토마는 더미도 실제 덱·손·셔플을 가지되 구매 결정을 규칙표로 자동화한다.

#### Box of Delights 버전

- 2인 규칙으로 준비하고 더미가 선 플레이어다.
- 더미의 `may` 선택은 하지 않고, `must`는 수행한다. 버림 등 선택은 무작위다.
- 0~2코인이면 구매하지 않는다.
- 속주/식민지가 3장 이상 남으면 은·금·백금·공작령·속주·식민지 중 살 수 있는 가장 비싼 것을 산다.
- 2장 이하 남으면 사유지·공작령·속주·식민지 중 가장 비싼 것을 산다.
- 정상 종료 뒤 더미보다 높은 VP면 승리한다. [Box of Delights 솔로 규칙](https://www.boxofdelights.net/dominion)

더 단순한 커뮤니티 기준선은 `속주 → 막판 공작령/사유지 → 금 → 은 → 패스` 우선순위를 쓴다. Smithy나 Chapel 한 장을 더미에 넣어 `Big Money Plus` 기준선을 만들 수도 있다. [Big Money 더미 활용 논의](https://boardgames.stackexchange.com/questions/681/how-can-i-beat-big-money-in-dominion/689)

#### 평가

- 장점: 실제 공급을 비우고 공격도 받으므로 원작 종료 압력과 상대가 유지된다.
- 장점: “내 복잡한 전략이 단순 돈 전략보다 실제로 빠른가”를 검증한다.
- 한계: 더미는 왕국을 읽지 않아 획득기·폐기·alt-VP에 적응하지 못한다.
- 한계: 공격 카드의 선택 처리와 특수 확장 규칙에 예외가 생긴다.
- 용도: 재미있는 인간 대체 AI보다 **회귀 테스트용 기준선**에 가깝다.

### 6-4. The Pyramid Solo Challenge

GameRulesforOne의 복합 솔로 변형. 6장 VP 피라미드가 시장·타이머·AI 점수판을 동시에 맡는다. 원본은 여러 확장을 지원하며 난이도 5단계를 둔다. [Pyramid 규칙 전문](https://www.ultraboardgames.com/dominion/pyramid-solo-game-rules.php), [BGG 파일 목록](https://boardgamegeek.com/files/thing/36218?sort=hot)

#### 핵심 준비

- 보물 공급을 동 5, 은 9, 금 6, 선택 시 백금 4로 제한한다.
- 킹덤 10종을 고르되 각 더미는 5장만 쓴다.
- 사유지 12장을 반드시 포함한 VP 덱 30장을 만든다. 권장 예: 사유지 12/공작령 10/속주 8.
- VP 덱에서 아래 3, 중간 2, 위 1의 6장 피라미드를 공개한다.
- 저주 5장을 둔다. 시작 덱은 정상적인 동 7/사유지 3이다.
- 고난도에서는 지정 공격 카드 5장을 VP 덱에 섞는다.

#### AI 반응과 구매

- 개인 덱을 다시 섞을 때 저주를 받거나, 피라미드 아래 왼쪽 VP를 AI에게 준다.
- 손+플레이 카드가 7장 이상이 되거나 4번째 액션을 쓰면 AI가 아래 VP를 득점한다.
- 금/백금, 킹덤 Victory, 피라미드의 고가 VP를 사면 규칙에 따라 AI도 VP를 가져간다.
- 피라미드의 위층 카드는 층마다 비용이 2코인씩 비싸지만 AI 반응은 줄어든다.
- 구매를 하나도 완료할 수 없으면 즉시 패배한다. 동을 얻거나 손의 저주로 아래 사유지를 저주·제거하는 것도 허용된 구매 행동이다.
- 아래가 비거나 연결이 무너지면 카드를 아래로 낙하시키고 VP 덱에서 다시 채운다.

#### 종료와 점수

- 공급 3더미 고갈, VP 피라미드/덱 소진, 또는 구매 불능으로 종료한다.
- AI는 가져간 VP 카드 수, 남은 VP, 남은 저주 등을 난이도별 공식으로 점수화한다.
- 플레이어는 VP에서 저주, 남은 동, Ruins, 손대지 않은 킹덤 더미 등에 페널티를 받는다.
- AI보다 1~5/6~10/11~15/16+ 앞서는지에 따라 승리 등급을 나눈다.

#### 역기획 평가

| 보존되는 것 | 바뀌는 것 |
|---|---|
| 정상 5장 손, 액션·구매, 압축, 다양한 확장 효과 | 킹덤 더미가 5장이고 보물도 제한되어 공급 경제가 다름 |
| 과도한 드로우·액션·고가 구매에 비용을 붙여 선택 생성 | 원작에서 좋은 엔진 행동을 AI 점수 트리거로 직접 벌함 |
| VP 피라미드 위치와 붕괴라는 공간 퍼즐 추가 | 규칙량과 예외가 많아 도미니언의 간결함이 약해짐 |
| 5단 난이도와 승리 등급으로 반복 목표 제공 | 실제 상대의 덱·공격·더미 선점 판단은 없음 |

### 6-5. 솔로 규칙 비교

| 모드 | 압력의 정체 | 처리량 | 원작 보존도 | 가장 적합한 용도 |
|---|---|---:|---:|---|
| Race Against Curses | 매 턴 저주 | 낮음 | 중간 | 빠른 솔로, +Gain/VP 레이스 |
| Shortest Rounds/Golf | 턴 수·고정 퍼즐 | 매우 낮음 | 중간 | Daily, 최적화, 리플레이 비교 |
| Big Money Dummy | 실제 더미 덱과 VP 레이스 | 중간 | 높음 | 전략 기준선·공격 포함 연습 |
| Pyramid | VP 피라미드와 반응형 점수 AI | 높음 | 중간 | 복합 솔로 퍼즐·다단 난이도 |
| 공식 디지털 AI/Daily | 규칙 엔진·AI 또는 고정 문제 | 자동 | 높음 | 학습, 반복, 경쟁 로그 |

솔로화의 교훈은 인간 구매를 어설프게 흉내 내는 것이 유일한 답이 아니라는 것이다. `저주 시계`, `턴 예산`, `단순 기준선`, `공개된 반응표`, `고정 퍼즐`은 각각 다른 원작 감각을 보존한다.

---

## 7. 도미니언과 유사한 덱빌딩 게임

### 7-1. 구조 비교표

| 게임 | 시장/카드 획득 | 승리 | 카드·자원 유형 | 도미니언과 다른 핵심 |
|---|---|---|---|---|
| Ascension | 섞인 중앙 덱에서 6장 시장이 계속 교체 | Honor 토큰+카드 VP 최다 | Hero, Construct, Monster; Rune, Power; 4 factions | 고정 10더미가 아니라 전술적 변동 시장 |
| Star Realms | 중앙 Trade Row에서 함선·기지 구매 | 상대 Authority를 0으로 | Ship, Base/Outpost; Trade, Combat, Authority; 4 factions | 승점 오염 없이 만든 덱으로 직접 피해 |
| Clank! | 변동 던전 시장에서 카드 구매 | 유물을 들고 탈출한 생존자 중 점수 | Skill, Sword, Boot, Clank!, 장비·동료·괴물 | 덱 출력이 보드 이동·전투·소음 위험으로 변환 |
| Aeon's End | 고정 시장에서 Gem/Relic/Spell 구매 | Nemesis 격파 또는 덱 소진 생존 | Gem, Relic, Spell; Aether, Charge, Breach | 덱을 섞지 않아 버림 순서 자체를 설계, 협동/솔로 보스전 |
| Slay the Spire | 전투 보상 3택, 상점, 이벤트; 거절 가능 | Act 보스들을 넘어 정상/진엔딩 | Attack, Skill, Power, Status, Curse; Energy, Relic, Potion | 런 중 전투가 카드 평가를 계속 바꾸는 싱글플레이 로그라이크 |
| Monster Train | 전투 보상·상점에서 유닛/주문을 얻고 개별 업그레이드 | 최상층 Pyre를 지키며 최종 보스 격파 | Unit, Spell; Ember, Capacity; clan, artifact | 3개 전투 층의 공간 배치와 덱빌딩 결합 |
| Friday | 위험을 이기면 그 카드를 뒤집어 덱에 추가, 패배 비용으로 약한 카드 제거 | 마지막 해적 2척 격파 | Hazard/Fighting 양면, Aging, Pirate; Life | 일부러 패배해 체력을 지불하고 압축하는 순수 솔로 곡선 |
| Mage Knight | 지도 보상·레벨업·시장으로 Advanced Action/Spell/Artifact 추가 | 시나리오 목표; Solo Conquest는 도시 정복 | Action, Spell, Artifact, Unit; Mana, Fame, Wound | 손의 카드를 이동·공격·방어·영향력으로 변환하는 공간 최적화 |

### 7-2. Ascension: 고정 공급을 변동 시장으로

#### 플레이와 승리

기본 덱으로 시작해 Rune으로 영웅·Construct를 획득하고 Power로 괴물을 쓰러뜨린다. 중앙 6칸은 카드가 나갈 때마다 즉시 새 카드로 채워진다. Honor 풀 고갈 뒤 카드 VP와 토큰 Honor를 합산해 최고점이 승리한다. 카드군은 Enlightened, Void, Mechana, Lifebound 네 faction으로 나뉜다. [Ascension 규칙 개요](https://www.playascensiongame.com/ascension_game_rules/)

#### 전략과 재미

- 도미니언은 시작부터 전체 시장을 보고 장기 덱을 설계하지만 Ascension은 지금 나온 6장에 대응한다.
- faction 시너지를 밀되 시장에 원하는 카드가 다시 나온다는 보장이 없어 유연성이 중요하다.
- 괴물 처치는 덱에 카드를 넣지 않고 즉시 점수를 주므로 덱 오염 없는 득점 채널이다.
- 재미는 “이번 판의 해답 발견”보다 **계속 변하는 시장에서 가치 포착**에 가깝다.

### 7-3. Star Realms: 덱 출력이 곧 피해

#### 플레이와 승리

Trade로 중앙 시장의 Ship/Base를 사고 Combat으로 상대 Authority를 깎는다. Authority 0이 패배 조건이다. Trade Federation은 경제·회복, Blob은 공격·시장 파괴, Star Empire는 공격·드로우/상대 버림, Machine Cult는 폐기로 특화된다. 같은 faction 카드를 한 턴에 함께 내면 Ally 능력이 켜진다. [공식 Learn to Play](https://www.starrealms.com/learn-to-play/), [공식 faction 설명](https://www.starrealms.com/factions/)

#### 전략과 재미

- 승점 카드가 덱을 막지 않아 성장과 공격이 같은 방향을 본다.
- 기지는 턴 사이에 남아 엔진과 방어 목표가 된다.
- faction을 모을수록 폭발하지만 변동 시장 때문에 혼합 덱의 즉시 효율과 경쟁한다.
- 도미니언의 간접 레이스보다 **타격·회복·기지 제거의 즉각 피드백**이 강하다.

### 7-4. Clank!: 덱이 보드 위 위험으로 번역됨

#### 플레이와 승리

카드가 Skill(구매), Sword(괴물 처리), Boot(이동), Clank!(용의 주머니에 들어갈 자기 큐브)를 만든다. 던전에서 유물을 하나 들고 지상으로 탈출해야 정상 점수 자격을 얻으며, 유물·비밀·카드 점수를 합산한다. 더 깊은 유물은 비싸지만 소음과 용 공격 위험도 커진다. [공식 Clank! 소개](https://clankthegame.com/clank/)

#### 전략과 재미

- 구매 효율이 이동 경로와 생존 시간으로 실체화된다.
- 높은 점수 유물을 향한 push-your-luck와 먼저 탈출해 상대에게 시간 압력을 주는 선택이 충돌한다.
- 도미니언의 공급 더미가 하던 종료 압력을 **다른 플레이어의 탈출과 용 주머니**가 맡는다.
- 카드 한 장이 시장 가치뿐 아니라 현재 지도 위치에서 필요한 아이콘으로 평가된다.

### 7-5. Aeon's End: 셔플을 제거한 협동 엔진

#### 플레이와 승리

마법사들은 Gravehold를 지키며 Nemesis의 체력을 0으로 만들거나, Nemesis 덱이 비고 남은 minion/power가 없을 때까지 버틴다. 플레이어 탈진이나 Gravehold 파괴, 보스 고유 조건은 패배다. Gem은 Aether, Relic은 유틸리티, Spell은 열린 Breach에 준비했다가 다음 주문 단계에 발사한다. 가장 큰 특징은 개인 덱이 빌 때 버림 더미를 **섞지 않고 그대로 뒤집는다**는 점이다. [Aeon's End 디지털 공식 소개](https://www.handelabra.com/aeonsend)

#### 전략과 재미

- 버리는 순서가 다음 덱 순서이므로 좋은 카드 묶음을 의도적으로 예약한다.
- 주문은 준비와 발사가 턴을 가르므로 미래 적 행동을 예측한다.
- 무작위성은 개인 셔플보다 턴 순서 덱과 Nemesis 덱에 집중된다.
- 솔로는 여러 마법사를 한 사람이 운영하거나 1인 규칙을 쓰며, 재미는 **보스별 위협 우선순위와 공동 경제 최적화**다.

### 7-6. Slay the Spire: 전투가 시장을 평가한다

#### 플레이와 승리

캐릭터별 시작 덱·유물로 시작해 절차 생성 지도에서 전투, 정예, 휴식처, 상점, 이벤트를 고른다. 전투에서는 매 턴 Energy를 써 Attack, Skill, Power를 사용하고 적의 다음 의도를 보고 방어·공격을 조정한다. 전투 보상 카드 3장 중 하나를 고르거나 **아무것도 받지 않을 수 있다**. Act 보스를 꺾어 탑을 오르며 조건을 갖추면 진엔딩 보스까지 간다. [공식 Steam 페이지](https://store.steampowered.com/app/646570/Slay_the_Spire/)

#### 카드 유형과 역할

| 유형 | 기능 | 덱 설계 질문 |
|---|---|---|
| Attack | 직접 피해, 다단 타격, 광역 | 힘·독·취약 등 내 scaling과 맞는가 |
| Skill | 방어, 드로우, 디버프, 자원 | 즉시 생존과 장기 세팅 중 무엇이 필요한가 |
| Power | 전투 동안 지속되는 규칙 | 초반 tempo를 포기할 만큼 장기전 가치가 있는가 |
| Status | 적이 넣는 일시적 방해 | 소멸·배기·드로우로 처리 가능한가 |
| Curse | 대개 영구적인 덱 오염 | 보상과 맞바꿀 가치가 있는가, 제거 경로가 있는가 |
| Relic/Potion | 덱 밖의 지속/일회 효과 | 카드 선택의 평가 함수를 어떻게 바꾸는가 |

#### 주요 플레이 스타일

- Ironclad: Strength scaling, Exhaust, 자해/회복, 방어 누적.
- Silent: Poison, Shiv 다단, 버리기, 민첩 방어.
- Defect: Orb 채널/발동, Focus, Power, 0코스트.
- Watcher: Wrath/Calm 자세 전환, retain, 큰 배수 피해.

#### 도미니언과의 차이

- 도미니언은 판 시작 시 시장을 모두 보지만 StS는 보상과 경로가 순차 공개된다.
- 도미니언은 상대보다 빨리 점수화하고, StS는 현재 적을 살면서 장기 scaling을 준비한다.
- 카드 획득 거절, 상점 제거, 업그레이드가 있어 **카드 한 장의 개별 품질과 덱 최소화**가 더 직접적이다.
- 적 의도는 다음 턴의 문제를 공개해 매 손패에 전술적 맥락을 준다.
- 재미는 런마다 주어진 카드·유물·적에 맞춰 계획을 수정하는 **즉흥적 시너지 수렴**이다.

### 7-7. Monster Train: 공간을 가진 Slay the Spire 계열

#### 플레이와 승리

열차의 전투 3층에 유닛을 배치하고 주문을 사용한다. 살아남은 적이 위층으로 올라가 최상층 Pyre를 공격하므로, 어느 층에서 막고 어느 층을 포기할지 정한다. 전투 보상·상점에서 유닛과 주문을 얻고 카드마다 업그레이드를 붙인다. 주 clan과 보조 clan의 카드 풀을 결합해 최종 보스를 꺾는다. [공식 Steam 페이지](https://store.steampowered.com/app/1102190/Monster_Train/)

#### 전략과 재미

- Unit은 층 Capacity를, Spell은 Ember를 쓰므로 두 자원 병목이 다르다.
- 탱커 앞/딜러 뒤, 다단 공격, sweep, armor, burnout 등 위치와 상태 시너지가 핵심이다.
- 모든 층을 균등 강화하기보다 한 kill floor에 scaling을 집중하는 전략이 자주 강하다.
- 도미니언의 엔진 조립이 **공간 배치와 웨이브 처리**로 즉시 시각화된다.

### 7-8. Friday: 실패를 압축 비용으로 쓰는 순수 솔로

#### 플레이와 승리

위험 카드 하나를 골라 정해진 무료 드로우 수 안에서 전투 수치를 맞춘다. 성공하면 위험 카드를 더 강한 Fighting 면으로 뒤집어 덱에 넣는다. 실패하면 부족한 수치만큼 Life를 내고, 지불한 범위에서 플레이한 약한 카드를 제거할 수 있다. 덱이 빌 때 Aging 카드가 섞여 장기적으로 악화된다. 세 난이도 단계를 지나 마지막 해적 2장을 모두 이기면 승리한다. [공식 Friday 규칙](https://www.riograndegames.com/wp-content/uploads/2013/02/Friday-Rules.pdf), [2F Games 소개](https://2f-games.com/2f-spiele/friday/)

#### 전략과 재미

- 초반의 의도적 패배는 체력을 압축 비용으로 바꾸는 투자다.
- 너무 자주 뽑으면 셔플이 빨라지고 Aging이 들어와 덱이 늙는다.
- 도미니언의 폐기는 좋은 선택지지만, Friday는 **피해를 감수해야 얻는 핵심 성장**으로 전면화한다.
- 외부 AI 없이 hazard deck의 단계 상승이 난이도 곡선과 타이머를 모두 맡는다.

### 7-9. Mage Knight: 카드 한 장을 여러 동사로

#### 플레이와 승리

카드가 이동·공격·방어·영향력 등을 만들고, 같은 카드를 기본 효과로 쓸지 Mana를 내 강한 효과로 쓸지 선택한다. 지도를 탐험하고 적을 쓰러뜨려 Fame과 새 Advanced Action/Spell/Artifact를 얻고 Unit을 모집한다. 공식 Solo Conquest는 제한된 낮/밤 라운드 안에 도시들을 발견하고 정복하는 것이 목표이며, 성공 후 Fame 등으로 성과를 평가한다. [공식 제품 소개](https://wizkids.com/mage-knight/), [Ultimate Edition 공식 규칙서](https://www.mageknight.net/wp-content/uploads/Mage-Knight-Board-Game-Ultimate-Edition-Rule-Book-September-2018.pdf)

#### 전략과 재미

- 덱빌딩보다 **손패 최적화와 경로 계획**의 비중이 크다.
- Wound는 손을 차지해 행동을 줄이는 오염 카드이며 휴식과 회복의 비용을 만든다.
- 더미 플레이어는 경쟁 AI라기보다 라운드 종료 시계로 기능한다.
- 같은 손으로 불가능해 보이던 요새·도시를 카드 횡전, Mana, Unit을 엮어 해결하는 계산 퍼즐이 핵심 쾌감이다.

### 7-10. 비교작에서 추출한 설계 축

| 설계 축 | 한쪽 | 다른 쪽 | 대표작 |
|---|---|---|---|
| 시장 정보 | 처음부터 고정·완전 공개 | 순차·무작위 공개 | Dominion ↔ Ascension/StS |
| 승리 자원 | 덱 안에 들어와 오염 | 전투 피해·외부 점수 | Dominion ↔ Star Realms/Ascension |
| 셔플 | 무작위 재조합 | 순서 보존 | Dominion ↔ Aeon's End |
| 출력 공간 | 숫자/카드 안에서 해결 | 지도·층·유닛 위치로 변환 | Dominion ↔ Clank!/Monster Train/Mage Knight |
| 상대 | 인간의 공유 공급 경쟁 | 규칙형 보스·타이머 | Dominion ↔ Aeon's End/Friday |
| 성장 단위 | 카드 획득 중심 | 카드 업그레이드·유물·영구 상태 | Dominion ↔ StS/Monster Train |
| 실패 기능 | 대개 순손실 | 압축·학습 기회 | Dominion ↔ Friday |

---

## 8. ECHO/144에 적용할 때의 기획 판단

이 절은 조사에서 바로 도출되는 최소 결론만 남긴다. 구체 규칙의 정본은 [10_MECHANICS.md](10_MECHANICS.md), 카드 정본은 [15_CARDS.md](15_CARDS.md), 수치는 [20_BALANCE.md](20_BALANCE.md)다.

### 반드시 보존할 것

- 구매한 카드가 다음 순환에 나타나는 **지연과 재등장 피드백**.
- 약한 카드를 제거했을 때 핵심 카드가 더 자주 보이는 **압축 체감**.
- 액션 허용량과 좋은 카드 수가 충돌하는 **terminal collision**.
- 엔진을 더 만들지 승리 자원을 넣을지 결정하는 **그리닝**.
- 고정 빌드가 아니라 이번 공급군을 읽는 **왕국 적응**.
- 단순 생존 시간이 아니라 플레이어가 앞당기거나 늦추는 **종료 통제**.

### 그대로 복제하지 않을 것

- 원작 카드명·문구·미술·프레임.
- 물리판의 잦은 셔플과 정리 마찰.
- 인간처럼 구매하는 척하는 복잡한 AI.
- 확장별 토큰·매트·Landscape를 전부 쌓은 규칙 부피.
- 테마와 분리된 추상 코인/VP를 설명 없이 이식하는 것.

### 솔로 압력의 선택지

| 원하는 경험 | 적합한 압력 모델 | 조사 근거 |
|---|---|---|
| 빠른 매턴 판단 | 오염/저주 시계 | Race Against Curses |
| 공정한 Daily 비교 | 고정 시드+턴/틱 예산 | Shortest Rounds/Golf |
| 빌드 성능 기준선 | 단순 Big Money 오토마 | Big Money Dummy |
| 공개 반응을 읽는 보스 | 행동 임계값별 점수/공격 | Pyramid |
| 손마다 전술 대응 | 다음 행동 intent 공개 | Slay the Spire |
| 엔진의 공간적 가시화 | 층·방향·위치로 출력 | Monster Train/Clank! |

가장 작은 유효 조합은 `고정 시드 + 공개된 상대 규칙 + 오염 + 플레이어가 선택하는 최종 진입`이다. Pyramid 전체를 옮기거나 인간형 구매 AI를 만들 필요는 없다.

---

## 9. 출처와 신뢰도

### 1차 자료

- [Rio Grande Games — Dominion Second Edition Rulebook](https://www.riograndegames.com/wp-content/uploads/2016/09/Dominion2nd.pdf)
- [Rio Grande Games — Dominion 제품/확장 목록](https://www.riograndegames.com/games/dominion/)
- [Rio Grande Games — Allies Rules](https://www.riograndegames.com/wp-content/uploads/2021/09/Dominion-Allies-Rules.pdf)
- [Rio Grande Games — Menagerie Rules](https://www.riograndegames.com/wp-content/uploads/2020/01/Dominion-Menagerie-Rules.pdf)
- [Rio Grande Games — Rising Sun Rules](https://www.riograndegames.com/wp-content/uploads/2024/04/DomRisingSunRules.pdf)
- [Tarpey Games — The Race Against Curses](https://www.tarpeygames.com/DominionRAC)
- [Star Realms — Learn to Play](https://www.starrealms.com/learn-to-play/)
- [Clank! — Official Game Page](https://clankthegame.com/clank/)
- [Slay the Spire — Steam](https://store.steampowered.com/app/646570/Slay_the_Spire/)
- [Monster Train — Steam](https://store.steampowered.com/app/1102190/Monster_Train/)
- [2F Games — Friday](https://2f-games.com/2f-spiele/friday/)
- [Mage Knight — Official Rulebook](https://www.mageknight.net/wp-content/uploads/Mage-Knight-Board-Game-Ultimate-Edition-Rule-Book-September-2018.pdf)

### 전략·커뮤니티·보조 자료

- [Dominion Strategy — Five Fundamental Deck Types](https://dominionstrategy.com/2013/01/21/the-five-fundamental-deck-types-introduction/)
- [Dominion Strategy — Big Money](https://dominionstrategy.com/big-money/)
- [Dominion Strategy — What is an Engine](https://dominionstrategy.com/2017/11/06/dominion-101-what-is-an-engine/)
- [Dominion Strategy — When Should I Start Greening?](https://dominionstrategy.com/2019/03/31/when-should-i-start-greening/)
- [Cardboard Edison — Donald X. Vaccarino 인터뷰](https://cardboardedison.com/blog/meaningful-decisions-donald-x-vaccarino-dominion)
- [Complete Rules for Dominion and All Its Expansions v11](https://madforest.com/Dominion_CompleteRules_v11.pdf) — 팬 편찬 통합 참조; 공식 규칙보다 우선하지 않음.
- [Box of Delights — Dominion Solo Rules](https://www.boxofdelights.net/dominion)
- [UltraBoardGames — Pyramid Solo Game Rules](https://www.ultraboardgames.com/dominion/pyramid-solo-game-rules.php) — BGG 팬 변형의 웹 전재본.
- [BoardGameGeek — Dominion Files](https://boardgamegeek.com/files/thing/36218?sort=hot)
- [Dominion: A New Frontier for AI Research](https://arxiv.org/abs/2405.06846)

### 해석 시 주의

- Dominion Strategy의 “다섯 덱 유형”은 공식 규칙 분류가 아니라 유용한 전략 모델이다.
- 팬 솔로 변형은 카드 판본·확장 조합에 따라 깨질 수 있으며 공식 밸런스를 보장하지 않는다.
- 카드 효과는 판본 교체와 정오표가 있으므로 구현·번역 단계에서는 해당 세트 최신 공식 규칙을 다시 확인해야 한다.
- 비교작의 “재미” 평가는 규칙 구조에서 도출한 역기획이며 정량 사용자 조사 결과가 아니다.

---

## 10. 요청 범위 충족 감사

| 원 요청 | 문서 위치 | 포함 내용 | 범위 경계 |
|---|---|---|---|
| 1. 기본 플레이·승리·구성 카드 | §1 | 준비, 공간, ABC 턴, 카드 판독, 조작 차이, 액션 계산, 구매→셔플 예, 종료·동점, 기본 7종, 킹덤 26종 전부 | 확장 고유 준비는 각 공식 규칙 링크가 정본 |
| 2. 카드 유형·카드별 효과·확장 | §1-5, §2, §3 | 기본판 전 카드의 비용/유형/효과/목적, 공식 유형, 전략 역할, 16개 확장의 핵심 규칙과 대표 카드 | 모든 확장 카드 수백 장의 원문·개별 예외를 전재하지 않음 |
| 3. 주요 5개와 다양한 전략 | §4 | Big Money/Slog/Engine/Rush/Combo, 용어 25개, 왕국 판독, 첫 게임 예, 실전 전략 15개, 그리닝·실수 | 카드 조합은 왕국마다 달라 고정 티어표를 만들지 않음 |
| 4. 메커니즘·재미·역기획 | §5 | 규칙→동역학→경험, 재미 8축, 긴장 4쌍, 조합 공간, 약점 | 재미 평가는 설계 추론이며 사용자 전체를 대표하는 정량 설문은 아님 |
| 5. 사용자 제작 1인 규칙 | §6 | Race Against Curses, Shortest/Golf, Big Money Dummy, Pyramid의 준비·진행·승리·전략 왜곡·비교 | 팬 규칙은 공식 솔로 표준이 아니며 버전별 차이가 있음 |
| 6. 유사·1인 덱빌딩 게임 | §7 | Ascension, Star Realms, Clank!, Aeon's End, Slay the Spire, Monster Train, Friday, Mage Knight의 플레이·승리·카드·전략·재미 | 각 게임의 모든 확장·캐릭터·카드를 나열한 개별 공략집은 아님 |

### 이 문서만 읽은 초심자가 답할 수 있어야 하는 질문

- 왜 산 카드가 즉시 손에 들어오지 않으며 언제 처음 등장하는가?
- Action, Card, Coin, Buy는 왜 서로 대체되지 않는가?
- 버림과 폐기, 획득과 구매는 어떻게 다른가?
- Village를 Smithy보다 먼저 쓰는 이유는 무엇인가?
- 승점 카드를 너무 일찍 사면 왜 오히려 질 수 있는가?
- Big Money와 Engine 중 무엇을 고를지 왕국에서 어떤 기능을 찾는가?
- 속주가 남아 있어도 3더미로 왜 게임이 끝나는가?
- Race Against Curses, Big Money Dummy, Pyramid는 각각 어떤 종류의 압력을 만드는가?
- Dominion의 고정 시장과 Slay the Spire의 순차 보상은 어떤 재미 차이를 만드는가?
- ECHO/144가 카드 표면이 아니라 어떤 시간 구조를 가져와야 하는가?

위 질문에 답할 수 없다면 해당 절의 설명이나 예시가 부족한 것이다. 반대로 특정 확장 카드의 정확한 문구·예외 판정이 필요하면 이 조사문의 요약이 아니라 §9의 최신 공식 규칙서를 확인한다.
