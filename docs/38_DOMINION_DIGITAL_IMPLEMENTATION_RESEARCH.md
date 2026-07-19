# 38 — 도미니언 디지털 구현·오픈소스 역설계 조사

> 조사·소스 감사 기준일: 2026-07-19. 각 저장소는 표에 적은 커밋을 얕게 복제해 실제 코드·테스트·라이선스를 확인했다. 링크는 이후 기본 브랜치가 바뀌어도 같은 내용을 가리키도록 가능한 한 커밋 해시로 고정했다.

이 문서는 도미니언 규칙을 다시 설명하는 공략집이 아니라, **도미니언과 유사 덱빌더를 컴퓨터 게임으로 만들 때 어떤 상태·명령·효과·AI·로그·테스트가 필요한지**를 오픈소스 구현과 상용 디지털판의 기능에서 역설계한 개발 참고서다. 도미니언을 처음 접했다면 먼저 [36_DOMINION_DEEP_RESEARCH.md](36_DOMINION_DEEP_RESEARCH.md) §1의 준비·ABC 턴·승리 조건과 §2의 카드 유형을 읽는다.

외부 저장소 소스는 프로젝트 안에 복사하지 않았다. 공개 Git 저장소라는 사실만으로 재사용 권한이 생기지 않으며, 라이선스가 없는 세 저장소는 **열람·아이디어 비교만** 했다. 이 문서의 의사코드와 ECHO/144 제안은 조사 결과를 바탕으로 새로 작성한 설계다.

---

## 0. 결론부터

도미니언 디지털 구현의 본체는 카드 그림이나 애니메이션이 아니라 다음 일곱 경계다.

1. **정본 상태:** 공급, 폐기, 각 플레이어의 덱·손·버림·플레이·지속/보류 영역, 턴 자원, 단계, RNG를 한곳에서 설명한다.
2. **합법 행동 생성:** UI와 AI가 규칙을 추측하지 않고 코어가 내준 `LegalMove[]` 안에서만 고른다.
3. **명시적 선택:** “카드를 버려라”, “하나를 얻어라”, “공격에 반응할까”를 문자열 프롬프트가 아니라 타입 있는 `ChoiceRequest`로 표현한다.
4. **효과 해결:** 드로우·코인·액션·구매·획득·폐기 같은 원자 효과는 공용 처리하고, 정말 특수한 카드만 작은 전용 hook을 쓴다.
5. **명령과 이벤트 로그:** 플레이어의 의도인 Command와 그 결과인 Event를 분리하면 리플레이, Undo, 관전, 재접속, AI, 디버깅이 같은 기반을 쓴다.
6. **결정론:** 시드와 명령열이 같으면 결과가 같아야 Daily, 버그 재현, 시뮬레이션, 저장 복구가 가능하다.
7. **규칙 테스트:** 카드 한 장의 행복 경로보다 셔플 경계, 빈 더미, 반응, 중첩 trigger, 종료 시점, “가능한 만큼” 같은 예외가 중요하다.

ECHO/144에는 전체 도미니언 엔진이 필요하지 않다. 이미 [30_TECH.md](30_TECH.md) §5~§7에 적힌 `GameCommand → GameState → GameEvent`, 분리 RNG, `EffectOp + 소수 hook`, 빌드 타임 데이터 컴파일을 구현하는 것이 조사 결과와 정확히 일치한다. 새 범용 스크립트 VM, 런타임 XML/JSON, 네트워크 계층, 인간처럼 보이는 복잡한 AI는 현재 범위에 필요 없다.

---

## 1. 조사 방법과 판정 기준

### 1-1. 무엇을 확인했는가

저장소 소개문만 읽고 평가하지 않았다. 각 후보에서 다음을 교차 확인했다.

- 저장소의 마지막 감사 커밋과 날짜
- 루트 라이선스 존재 여부와 종류
- 덱·손·버림·플레이·공급의 데이터 모델
- 턴 단계와 게임 종료 판정 위치
- 카드 데이터와 카드별 특수 로직의 경계
- 인간 입력과 AI 입력의 공통 인터페이스 여부
- 합법 행동 생성, 선택 요청, 공격/반응 처리
- RNG 주입과 같은 시드 재현 가능성
- 로그, 저장, Undo/Redo, 관전 또는 네트워크 경계
- 단위/통합/시나리오 테스트가 실제로 다루는 것
- README가 인정하는 미구현 범위와 코드에서 발견되는 구체적 위험

### 1-2. 완성도와 참고 가치는 다르다

- **완성도가 높다:** 많은 카드와 예외를 실제로 처리한다.
- **구조 참고 가치가 높다:** 작은 코드에서 책임 경계가 분명하다.
- **바로 재사용 가능하다:** 라이선스, 언어, 품질, 범위가 모두 맞는다.

세 조건은 같지 않다. Androminion과 DominionSim은 카드 범위가 넓지만 거대한 mutable 객체와 카드별 분기가 많다. `nlonz/dominion-engine`은 읽기 쉽지만 구현 카드가 극히 적고 드로우 경계 결함이 있다. 가장 유용한 접근은 **작은 구현에서 경계를 배우고, 큰 구현에서 빠진 예외를 찾고, 독립 테스트로 규칙을 확정하는 것**이다.

### 1-3. 신뢰도 표기

| 표기 | 의미 |
|---|---|
| 코드 확인 | 감사 커밋의 실제 소스에서 확인 |
| 테스트 확인 | 자동 테스트가 기대 결과를 단언 |
| README 주장 | 프로젝트 저자의 설명이며 완전성을 별도 보증하지 않음 |
| 기능 역설계 | 상용 서비스의 공개 기능으로부터 필요한 구조를 추론; 내부 코드를 안다는 뜻이 아님 |

---

## 2. 실제 디지털 도미니언에서 확인되는 제품 기능

### 2-1. Temple Gates Games판 Dominion

[Steam의 공식 라이선스판](https://store.steampowered.com/app/1131620/Dominion/)은 기본판 무료, 확장 구매, 싱글플레이 AI, 온라인 PvP, 로컬/분할 화면, 크로스 플랫폼을 제공한다. Temple Gates의 [공식 제품 페이지](https://templegatesgames.com/gamepages/dominion.html)도 같은 제품 계열을 설명한다. 공개된 상용판 소스는 없으므로 내부 구조를 단정할 수는 없지만, 제품 기능은 엔진에 다음 요구를 건다.

| 보이는 기능 | 코어에 필요한 것 | UI/서비스에 필요한 것 |
|---|---|---|
| 여러 AI 난이도 | 동일한 합법 행동 API, 상태 관찰 범위, 시간 예산 | 난이도·속도 선택 |
| 온라인/크로스 플랫폼 | 플랫폼 독립 상태와 명령 직렬화 | 로비, 인증, 재접속, 버전 일치 |
| 확장 선택 | 카드/메커니즘 feature 집합과 설정 검증 | 소유권 표시, 세트 필터 |
| Daily | 날짜→고정 kingdom/seed, 결과 지표 | 1일 1회 규칙, 비교·기록 |
| 캠페인/Adventure | 기본 규칙 위에 setup modifier와 목표 | 진행·해금·설명 |
| 로컬 플레이 | 한 코어에 여러 input owner | 비공개 손패 표시 정책 |

중요한 제품 교훈은 “카드 효과를 전부 구현했다”에서 끝나지 않는다는 점이다. 실제 디지털판에는 빠른 애니메이션, 카드 설명, 로그, 선택 취소, AI 대기, 확장 소유권, Daily 재현, 접근성 같은 **규칙 주변 기능**이 플레이 품질을 좌우한다.

### 2-2. Dominion Online

[Dominion Online](https://dominion.games/), [공식 변경 기록](https://dominion.games/changelog.html), 운영사의 [클라이언트 기능 안내](https://forum.shuffleit.nl/index.php?topic=2245.0)는 Undo, 재접속, 관전, 리그/순위, 봇으로 이어 하기, 게임 로그와 같은 서비스 문제를 다룬다. 내부 구현은 비공개지만 이 기능들은 다음을 시사한다.

- 서버가 최종 판정권을 갖고 클라이언트는 명령을 보낸다.
- 게임을 화면 픽셀이 아니라 상태 스냅샷과 행동 이력으로 복구할 수 있어야 한다.
- Undo는 메모리 값을 임의로 되감는 기능이 아니라, 승인 정책과 숨은 정보 노출 여부를 포함한 규칙이다.
- 관전자는 플레이어와 다른 정보 가시성·명령 권한을 가져야 한다.
- 접속이 끊긴 플레이어를 봇이 이어받아도 코어 규칙은 달라지지 않아야 한다.

ECHO/144는 온라인 게임이 아니므로 이 서비스 계층은 만들지 않는다. 다만 **같은 시드 재시작, TODAY, 명령 로그, 결과 리포트**는 같은 코어 경계를 더 작은 형태로 활용한다.

### 2-3. 공개 AI 연구 자산

[Dominion: A New Frontier for AI Research](https://arxiv.org/abs/2405.06846)는 숙련자 게임 200만 판 이상에서 만든 데이터셋, 강화학습 환경과 기준선을 제시한다. 여기서 직접 가져올 결론은 대형 모델 도입이 아니다.

- 연구 환경이 되려면 상태 표현, 행동 공간, 종료/보상, 재현 가능한 episode가 먼저 정의되어야 한다.
- 사람 로그는 “정답 수”가 아니라 특정 메타와 플레이어 집단의 정책 표본이다.
- 학습형 AI 전에도 Big Money, 우선순위 봇, random legal bot이 회귀 기준선이 된다.
- ECHO/144 규모에서는 강화학습보다 4~6개 설명 가능한 정책의 승률·생존률·턴 길이 분포가 훨씬 싸고 유용하다.

---

## 3. Git 저장소 감사표

바로 열어 볼 대표 소스 두 개는 [reference-source/README.md](reference-source/README.md)에 고정 커밋의 얕은 복제본으로 내려받았다. 나머지는 아래 permalink로만 참조한다.

### 3-1. 한눈에 보는 후보

| 저장소·감사 커밋 | 언어/목적 | 확인된 강점 | 중요한 한계 | 라이선스/판정 |
|---|---|---|---|---|
| [mehtank/androminion @ `bf7cf3c`](https://github.com/mehtank/androminion/tree/bf7cf3c400f5b4a552ef13ec127cf1946a1f5eac) | Java, Android 클라이언트+VDOM 서버 | 광범위한 카드, 영역·턴 context·이벤트·원격 선택 프로토콜 | 5천 줄대 `Game`, 3천 줄대 `Player`, 많은 특수 분기, 루트 라이선스 없음 | **열람만**. 코드 복사 금지 |
| [Geronimoo/DominionSim @ `c8a3915`](https://github.com/Geronimoo/DominionSim/tree/c8a391594a6cb182bdaafe60bcc9f5a50d124d16) | Java, 대량 전략 시뮬레이터 | 조건부 구매 규칙, 사용자 봇 XML, 다회전 통계, 넓은 카드 범위 | GUI·엔진·전략 결합, 거대한 Player, RNG 주입 약함, 테스트 적음 | MIT. **봇/통계 철학 참고** |
| [rspeer/dominiate @ `edc75b4`](https://github.com/rspeer/dominiate/tree/edc75b4e8c9162d0679d4d03a1a5837396273734) | CoffeeScript, 브라우저/CLI 시뮬레이터 | 구매 우선순위+조건, 행동 선호 override, 많은 예제 전략 | 주 개발 2014년, 최근 확장 누락, 테스트가 roadmap 상태 | MIT. **전략 DSL 개념 참고** |
| [paulbatum/Dominion @ `28daf2a`](https://github.com/paulbatum/Dominion/tree/28daf2a366332fbd176b4c06f43feb6851fe5f4d) | C#, 게임/호스트/AI workbench | 영역 객체, TurnContext, 텍스트 로그, 80개 안팎 BDD feature 파일 | 2011년 코드·초기 세트 중심, 현대 확장 기준 아님 | MIT. **규칙 시나리오 테스트 참고** |
| [nlonz/dominion-engine @ `1455f77`](https://github.com/nlonz/dominion-engine/tree/1455f770422eb0612a51ea096e3b951d528c2a25) | Python, AI/시뮬레이션 최소 엔진 | `legal_moves → Agent.choose → apply_move` 경계가 매우 작고 선명 | 구현 카드 극소수, 효과 hardcode, 빈 덱 드로우 결함, Moat 미구현 | MIT. **최소 API 참고, 규칙 정본 아님** |
| [shane-riley/dominion-card-game @ `8693964`](https://github.com/shane-riley/dominion-card-game/tree/869396422c9d0568a7bca8a6a14750051a6f5155) | C++17, CLI 인간/봇 | `variant` 원자 효과, JSON 카드+script hook, 고정 seed 테스트, 공격/반응 | 1판 카드 구성, 봇이 프롬프트 문자열 해석, 루트 라이선스 없음 | **구조 열람만**, 코드 복사 금지 |
| [dostjh/deck-builder-game @ `1beb547`](https://github.com/dostjh/deck-builder-game/tree/1beb54723dd4140ad469a1d869ef0d79a8093a36) | C#/.NET, WIP 범용 덱빌더 | 카드 원자 단계, XML 게임/카드 정의, xUnit 일부 | README가 unplayable 명시, 미구현 다수, reflection 문자열 호출, 무시드 `Random`, 라이선스 없음 | **반면교사**, 코드 복사 금지 |
| [oskarrough/slaytheweb @ `a59c130`](https://github.com/oskarrough/slaytheweb/tree/a59c1303421240785ce12ff3886710c83d21d01a) | JS/Astro, Slay the Spire류 웹 게임 | 단일 직렬화 상태, action queue, Undo/Redo, URL 저장, intent, UI 분리, 테스트 | 도미니언 규칙 엔진은 아님, 전체 상태 복사 비용, AGPL | **개념 번안만** |

### 3-2. 내려받은 두 폴더 연결점

| 조사 주제 | 작은 구조 예: `dominion-engine` | 대규모 구현 예: `dominion-sim` |
|---|---|---|
| 상태·턴·합법 행동 (§4~§5) | [`state.py`](reference-source/dominion-engine/dominion/state.py), [`game.py`](reference-source/dominion-engine/dominion/game.py), [`moves.py`](reference-source/dominion-engine/dominion/moves.py) | [`DomGame.java`](reference-source/dominion-sim/src/main/java/be/aga/dominionSimulator/DomGame.java), [`DomPlayer.java`](reference-source/dominion-sim/src/main/java/be/aga/dominionSimulator/DomPlayer.java), [`DomDeck.java`](reference-source/dominion-sim/src/main/java/be/aga/dominionSimulator/DomDeck.java) |
| 카드 정의·효과 (§6) | [`base.py`](reference-source/dominion-engine/dominion/cardsets/base.py) | [`cards/`](reference-source/dominion-sim/src/main/java/be/aga/dominionSimulator/cards/) |
| AI·전략 시뮬레이션 (§8) | [`agent.py`](reference-source/dominion-engine/dominion/agent.py), [`agents/`](reference-source/dominion-engine/dominion/agents/) | [`DomBuyRule.java`](reference-source/dominion-sim/src/main/java/be/aga/dominionSimulator/DomBuyRule.java), [`DomBuyCondition.java`](reference-source/dominion-sim/src/main/java/be/aga/dominionSimulator/DomBuyCondition.java), [`StatsManager.java`](reference-source/dominion-sim/src/main/java/be/aga/dominionSimulator/stats/StatsManager.java) |
| 테스트 (§10) | [`tests/`](reference-source/dominion-engine/tests/) | [`src/test/`](reference-source/dominion-sim/src/test/) |

읽는 순서는 `dominion-engine`으로 경계를 이해한 뒤, 같은 항목이 카드 수백 종을 다루는 `dominion-sim`에서 어떻게 커지는지 비교하면 된다. 두 구현 모두 규칙 정본이 아니라 구조·테스트 참고용이다.

### 3-3. 다른 저장소까지 포함한 읽기 순서

목적별 가장 짧은 읽기 경로다.

| 목적 | 먼저 볼 파일 | 다음에 볼 파일 |
|---|---|---|
| 합법 행동과 AI 경계 | [`dominion/game.py`](https://github.com/nlonz/dominion-engine/blob/1455f770422eb0612a51ea096e3b951d528c2a25/dominion/game.py) | [`moves.py`](https://github.com/nlonz/dominion-engine/blob/1455f770422eb0612a51ea096e3b951d528c2a25/dominion/moves.py), [`agent.py`](https://github.com/nlonz/dominion-engine/blob/1455f770422eb0612a51ea096e3b951d528c2a25/dominion/agent.py) |
| 원자 효과+예외 hook | [`effect.hpp`](https://github.com/shane-riley/dominion-card-game/blob/869396422c9d0568a7bca8a6a14750051a6f5155/src/effect.hpp) | [`game_engine.cpp`](https://github.com/shane-riley/dominion-card-game/blob/869396422c9d0568a7bca8a6a14750051a6f5155/src/engine/game_engine.cpp), [`cards.json`](https://github.com/shane-riley/dominion-card-game/blob/869396422c9d0568a7bca8a6a14750051a6f5155/data/cards.json) |
| 대형 규칙 구현의 실제 복잡도 | [`Game.java`](https://github.com/mehtank/androminion/blob/bf7cf3c400f5b4a552ef13ec127cf1946a1f5eac/vdom/src/main/java/com/vdom/core/Game.java) | [`MoveContext.java`](https://github.com/mehtank/androminion/blob/bf7cf3c400f5b4a552ef13ec127cf1946a1f5eac/vdom/src/main/java/com/vdom/core/MoveContext.java), [`GameEvent.java`](https://github.com/mehtank/androminion/blob/bf7cf3c400f5b4a552ef13ec127cf1946a1f5eac/vdom/src/main/java/com/vdom/api/GameEvent.java) |
| 우선순위 봇·통계 | [`DomBuyRule.java`](https://github.com/Geronimoo/DominionSim/blob/c8a391594a6cb182bdaafe60bcc9f5a50d124d16/src/main/java/be/aga/dominionSimulator/DomBuyRule.java) | [`DomBuyCondition.java`](https://github.com/Geronimoo/DominionSim/blob/c8a391594a6cb182bdaafe60bcc9f5a50d124d16/src/main/java/be/aga/dominionSimulator/DomBuyCondition.java), [`StatsManager.java`](https://github.com/Geronimoo/DominionSim/blob/c8a391594a6cb182bdaafe60bcc9f5a50d124d16/src/main/java/be/aga/dominionSimulator/stats/StatsManager.java) |
| 읽기 쉬운 전략 예 | [`BigMoney.coffee`](https://github.com/rspeer/dominiate/blob/edc75b4e8c9162d0679d4d03a1a5837396273734/strategies/BigMoney.coffee) | [`ChapelWitch.coffee`](https://github.com/rspeer/dominiate/blob/edc75b4e8c9162d0679d4d03a1a5837396273734/strategies/ChapelWitch.coffee), [`basicAI.coffee`](https://github.com/rspeer/dominiate/blob/edc75b4e8c9162d0679d4d03a1a5837396273734/basicAI.coffee) |
| 시나리오형 규칙 테스트 | [`GameEnd.feature`](https://github.com/paulbatum/Dominion/blob/28daf2a366332fbd176b4c06f43feb6851fe5f4d/Dominion.Specs/GameEnd.feature) | [`TurnMechanics.feature`](https://github.com/paulbatum/Dominion/blob/28daf2a366332fbd176b4c06f43feb6851fe5f4d/Dominion.Specs/TurnMechanics.feature), [`Scoring.feature`](https://github.com/paulbatum/Dominion/blob/28daf2a366332fbd176b4c06f43feb6851fe5f4d/Dominion.Specs/Scoring.feature) |
| 액션 큐·Undo·URL 저장 | [`action-manager.js`](https://github.com/oskarrough/slaytheweb/blob/a59c1303421240785ce12ff3886710c83d21d01a/src/game/action-manager.js) | [`actions.js`](https://github.com/oskarrough/slaytheweb/blob/a59c1303421240785ce12ff3886710c83d21d01a/src/game/actions.js), [`save-load.js`](https://github.com/oskarrough/slaytheweb/blob/a59c1303421240785ce12ff3886710c83d21d01a/src/ui/save-load.js) |

---

## 4. 정본 게임 상태: 카드가 어디에 있는가

### 4-1. 최소 상태 모델

도미니언 규칙에서 카드 한 장은 항상 정확히 한 영역에 있어야 한다. 디지털 구현은 카드 이름 목록만 보관하면 부족하다. 최소 상태는 다음과 같다.

```text
GameState
├─ setup: player_count, selected_sets, kingdom, landscape/modifier, rules_version
├─ supply[pile]: ordered cards/tokens/counts
├─ trash[]
├─ players[]
│  ├─ draw[] / hand[] / discard[] / in_play[]
│  ├─ duration[] / set_aside[] / mats_or_tokens[]
│  ├─ actions / buys / coins / debt / potion
│  └─ per_turn_flags / owned_projects / triggered_effects
├─ active_player / turn_number / phase
├─ pending_effects[] / pending_choice
├─ rng_state[]
└─ result / end_pending
```

`Androminion`의 `Player`와 `MoveContext`, Paul Batum 구현의 `Hand`, `DrawDeck`, `DiscardPile`, `PlayArea`, `TurnContext`는 영역과 턴성 상태를 분리해야 한다는 점을 보여 준다. 동시에 대형 구현의 수백 개 boolean/카운터는 확장이 쌓일수록 Player가 “모든 카드의 기억 장소”가 되는 위험도 보여 준다.

### 4-2. 카드 ID와 카드 인스턴스

둘을 구분해야 한다.

- `CardDef`: 이름, 비용, 유형, 고정 효과, 아트 ID처럼 모든 복사본이 공유하는 정의.
- `CardInstance`: 현재 영역, 토큰, face-down 여부, 소유자, 획득 순번처럼 개별 복사본 상태가 필요할 때만 존재.

기본판 수준에서는 많은 카드를 작은 `CardId` 값으로 보관할 수 있다. 그러나 Duration, 교환 더미, 카드 위 토큰, Command처럼 개별 추적이 필요한 확장을 전부 지원하려면 instance identity가 필요하다. ECHO/144의 현재 카드는 개별 영구 상태가 거의 없으므로 `CardId` 배열과 별도 `cached_card`, `stolen_card` 같은 명시적 슬롯이 더 작다. 미래 가능성만 보고 모든 카드에 32비트 UUID를 붙이지 않는다.

### 4-3. 보존해야 할 불변식

매 명령 뒤 개발 빌드에서 다음을 검사하면 카드 중복·증발을 일찍 잡는다.

```text
초기 총 카드 + 이후 생성/획득 - 폐기/반납 = 모든 영역의 카드 합
한 CardInstance는 정확히 한 영역에만 존재
공급 더미 count는 음수가 아님
actions, buys, coins는 규칙이 허용하지 않는 한 음수가 아님
pending_choice가 있으면 그 선택과 무관한 플레이 명령은 불법
게임 종료 후 상태 변경 명령은 불법
```

ECHO/144에는 이미 `deck_total()`과 CACHE 중복 방지 테스트가 있다. 이를 카드별 특수 테스트에만 두지 말고 `game_assert_invariants()`로 모아 모든 selftest 시나리오 뒤 실행하는 편이 효과적이다.

---

## 5. 턴 상태 기계와 합법 행동

### 5-1. 단계는 UI 탭이 아니라 규칙 상태다

기본 도미니언은 대략 `Action → Treasure/Buy → Clean-up → next player`다. 확장은 시작 턴 trigger, Night, 반응 창, 특수 추가 턴을 끼운다. 단계 전환은 화면 버튼이 아니라 코어 함수가 결정해야 한다.

```text
TURN_START_TRIGGERS
  → ACTION
  → TREASURE_OR_BUY
  → BUY
  → NIGHT(optional)
  → CLEANUP_TRIGGERS
  → DRAW_NEXT_HAND
  → END_CHECK
  → NEXT_PLAYER
```

Paul Batum의 BDD에는 “마지막 Province가 사라졌더라도 현재 턴이 끝날 때까지 게임이 끝나지 않는다”는 시나리오가 있다. 구현에서 `supply[Province]==0`을 본 즉시 결과 화면으로 바꾸면 카드의 남은 효과와 동점용 턴 수가 어긋날 수 있다. `end_pending`과 실제 `GAME_OVER`를 구분하는 이유다.

### 5-2. 합법 행동 생성이 단일 진실이어야 한다

`nlonz/dominion-engine`의 가장 좋은 부분은 단계별 `legal_moves()`가 `PlayCard`, `BuyCard`, `EndActionPhase`, `EndBuyPhase`를 만들고, Agent가 그 목록에서 선택한다는 점이다.

```c
MoveList game_legal_moves(const GameState *s);
bool game_apply_move(GameState *s, Move move, EventBuffer *out);
```

이 구조의 효과:

- UI가 비활성 버튼 조건을 별도로 재구현하지 않는다.
- AI가 불법 구매나 액션 부족 상태의 플레이를 만들지 않는다.
- 리플레이 입력 검증과 네트워크 서버 검증이 같은 함수를 쓴다.
- 퍼징은 `legal_moves`에서 무작위 하나를 골라 종료까지 진행할 수 있다.
- 튜토리얼/힌트는 “가능한 행동 중 왜 이것이 낫나”에 집중한다.

ECHO/144는 실시간 이동 때문에 매 60Hz 프레임의 모든 좌표를 `LegalMove[]`로 만들 필요는 없다. 경계는 이중으로 잡는다.

- 연속 입력: `InputFrame`을 결정론 tick에 적용.
- 의미 있는 덱 명령: `CMD_CUE_PROGRAM`, `CMD_SEEK_CARD`, `CMD_BUY_CARD`, `CMD_OPEN_CHANNEL`을 검증 후 적용.

### 5-3. 선택은 타입이어야 한다

카드 게임은 한 명령이 즉시 끝나지 않고 중간 선택을 요구한다. 최소 모델:

```c
typedef struct ChoiceRequest {
    ChoiceKind kind;       /* CHOOSE_HAND, CHOOSE_SUPPLY, YES_NO, ORDER_TRIGGERS */
    uint8_t actor;
    uint8_t min_count, max_count;
    CardFilter filter;     /* cost<=4, ACTION, not_this_instance ... */
    ChoiceReason reason;   /* TRASH_FOR_CHAPEL, GAIN_FOR_WORKSHOP, REACT_TO_ATTACK */
    CandidateId candidates[MAX_CHOICES];
} ChoiceRequest;
```

`shane-riley`의 봇은 일부 결정을 UI prompt 문자열과 카드 이름 검색으로 구분한다. 이는 번역이나 문구 변경만으로 AI가 깨지는 반면교사다. 봇과 UI에는 `reason=REACT_TO_ATTACK`, `source_card=MOAT` 같은 기계 정보를 주고, 표시 문자열은 UI가 만든다.

---

## 6. 카드 효과 엔진: 데이터와 코드의 경계

### 6-1. 세 구현 방식

| 방식 | 예 | 장점 | 실패 방식 |
|---|---|---|---|
| 카드별 imperative 코드 | Androminion, DominionSim | 예외를 곧바로 표현, 디버깅 위치가 명확 | 파일·Player 상태·분기 폭발, 공통 효과 중복 |
| 문자열+reflection | dostjh/deck-builder-game | XML에 새 조합을 적기 쉬움 | 오타가 런타임까지 숨음, 함수 시그니처 결합, 정적 검사 약함 |
| 타입 있는 원자 효과+hook | shane-riley C++ | 공통 동작 테스트·데이터화, 특수 카드 탈출구 | 원자어가 너무 많아지면 VM이 되고 hook이 무제한이면 다시 분기 폭발 |

가장 실용적인 답은 세 번째다. C++ 구현은 `DrawCards`, `GainCoins`, `GainActions`, `GainBuys`, `GainCard`, `TrashFromHand`, `DiscardToN`, `AttackEach`, `ChooseEffect`, `ScriptedEffect`를 `std::variant`로 두고 일반 resolver가 방문한다. 단순 카드는 JSON 효과 배열, 복잡한 카드는 handler 이름을 가진 scripted escape hatch다.

### 6-2. 원자 효과 후보

도미니언형 코어의 작은 어휘:

```text
DRAW n                 GAIN_ACTIONS n       GAIN_BUYS n
GAIN_COINS n           GAIN_CARD filter     TRASH_CARD filter
DISCARD_CARD filter    TOPDECK_CARD filter  REVEAL n/until
ATTACK effect_id       REACT window         CHOOSE choice_id
REPEAT effect_id n     SET_ASIDE             RETURN_SET_ASIDE
ADD_TOKEN target,n     EMIT_EVENT type,value
CALL_HOOK hook_id
```

모든 카드 문장을 범용 opcode로 번역하지 않는다. 다음 조건 중 둘 이상이면 hook이 낫다.

- 여러 플레이어와 공급을 반복해서 조회한다.
- 나중 턴에 복잡한 상태를 기억한다.
- 다른 카드의 텍스트/유형/비용을 복제하거나 바꾼다.
- 추가 턴·교환 더미·명명 카드처럼 게임 흐름을 크게 바꾼다.
- 원자 효과로 표현하려면 카드 하나 때문에 새 opcode가 2개 이상 생긴다.

### 6-3. resolver의 규칙

효과 스택/큐는 애니메이션 큐와 다르다.

1. 카드 플레이 Command를 검증한다.
2. 카드를 손에서 플레이 영역으로 옮기고 비용(액션)을 지불한다.
3. 카드 효과를 선언 순서로 pending effect에 넣는다.
4. 선택이 필요 없는 효과는 즉시 해결하고 Event를 낸다.
5. 선택이 필요하면 `pending_choice`를 세우고 입력을 기다린다.
6. 선택 응답 Command가 오면 검증하고 이어서 해결한다.
7. 반응/trigger 창이 생기면 정해진 우선순위나 선택 순서로 중첩한다.
8. effect queue가 비면 다음 일반 행동을 받는다.

Slay the Web의 action manager는 enqueue/dequeue와 Undo/Redo를 단순하게 보여 주지만, 도미니언의 규칙 효과와 화면 연출을 같은 queue에 넣으면 안 된다. 규칙은 즉시 결정론적으로 끝내고, UI는 나온 Event를 원하는 속도로 재생한다. “애니메이션이 끝나지 않아 규칙 상태가 아직 옛값”인 상황을 피한다.

### 6-4. 데이터 버전과 판본

감사한 C++ 구현의 `cards.json`에는 Woodcutter, Feast, Spy, Thief, Adventurer 등 기본판 1판 카드가 포함되어 있다. 최신 기본판 2판 규칙과 이름 목록을 기대하면 틀린다. 카드 데이터에는 최소한 다음 메타가 필요하다.

```text
ruleset_id = dominion_base_2e
content_revision = 2026-07-19-local
card_id = stable internal ID
display_name_key = localized text key
types/tags/cost/effect_program/hook
```

표시 이름을 저장/리플레이의 ID로 쓰지 않는다. 판본 교체, 번역, 정오표가 저장 파일과 봇을 깨뜨리기 때문이다.

---

## 7. RNG, 셔플, 결정론

### 7-1. RNG는 상태의 일부다

`new Random()`을 셔플할 때마다 만드는 구현은 같은 게임을 재현하기 어렵고 빠른 연속 생성에서 상관된 결과가 생길 수 있다. RNG는 `GameState`가 소유하고 seed를 명시한다.

```c
game_init(&state, seed, ruleset);
shuffle(&state.deck_rng, player->discard, n);
```

확장성이 필요하면 스트림을 분리한다.

- rules/deck RNG: 셔플, 무작위 카드 선택
- setup RNG: kingdom, Daily setup
- AI RNG: 동가 행동 선택
- cosmetic RNG: 파티클·음향 변주

연출을 추가해도 덱 순서가 바뀌지 않아야 한다. ECHO/144는 이미 `deck_rng`, `encounter_rng`, `reward_rng`를 분리한다. `cosmetic_rng`를 플랫폼/렌더 쪽에 별도로 두거나 무상태 hash로 처리하면 된다.

### 7-2. 올바른 드로우 경계

가장 자주 틀리는 알고리즘이다.

```text
draw up to N:
  repeat N times:
    if draw pile empty:
      if discard empty: stop successfully
      shuffle discard into draw using deck RNG
    move one draw card to hand
```

`nlonz/dominion-engine`의 감사 커밋은 덱과 버림이 모두 비었을 때 reshuffle 후 빈 목록에서 `pop()`할 수 있다. 반면 C++ 구현 테스트는 빈 덱+빈 버림에서 “가능한 만큼만 뽑고 실패하지 않음”을 확인한다. 단순 함수도 경계 테스트가 규칙 품질을 가른다.

### 7-3. 재현 레코드

버그 신고와 Daily에 필요한 최소 정보:

```text
build/ruleset version
initial seed + selected setup
ordered semantic commands
optional periodic state checksum
final result and metrics
```

매 프레임 전체 상태를 저장할 필요가 없다. 고정 틱 게임은 `seed + tick별 InputFrame/semantic command`로 재생하고, 300~600틱마다 checksum을 두면 divergence 위치를 찾기 쉽다.

---

## 8. AI와 전략 시뮬레이터

### 8-1. 공통 Agent 인터페이스

사람, 봇, 리플레이는 코어 입장에서 모두 다음 결정 제공자다.

```text
observe(public/private state) → legal moves/choice request → choose one response
```

AI가 GameState를 직접 수정하거나 UI 함수를 호출하게 하지 않는다. `nlonz`의 `Agent Protocol`은 이 최소 형태의 좋은 예다. 공격 대상의 선택, 카드 폐기, trigger 순서도 같은 typed request로 보낸다.

### 8-2. 먼저 만들 다섯 기준선

| 봇 | 규칙 | 무엇을 검증하나 |
|---|---|---|
| RandomLegal | 합법 행동 중 무작위 | 크래시·교착·불변식 퍼징 |
| BigMoney | Province→Gold→Silver 우선, 종료 근처 Estate/Duchy | 순수 경제 기준선, 게임 길이 |
| BigMoney+Terminal | 좋은 terminal 1~2장만 섞음 | 카드 한 장의 평균 가치 |
| ThinEngine | 폐기→village/draw 균형→payload→greening | 엔진이 실제로 순환·성장하는지 |
| Rush/Ender | 값싼 더미와 승점/종료를 우선 | 종료 통제·3더미 취약성 |

DominionSim은 구매 규칙을 카드 우선순위와 조건들의 conjunction으로 표현하고, Dominiate는 필요하면 행동 선택 함수를 override한다. 아이디어는 좋지만 ECHO/144에서는 XML 편집기나 범용 비교식 언어가 필요 없다. C 함수 4~6개로 정책을 명시하는 편이 작고 디버깅 가능하다.

### 8-3. 조건부 구매 규칙의 최소 문법

```text
BUY VOICE if cost_ok and turn>=5 and count(VOICE)<3
BUY CHAT  if cost_ok and archive_density<target
BUY PROGRAM_X if cost_ok and count(PROGRAM_X)<2
otherwise BUY CARRIER
```

중요한 것은 조건 문법의 화려함이 아니라 정책이 **합법 행동 목록을 필터링한 뒤 점수화**한다는 점이다. 공급이 비었거나 비용이 달라졌을 때 불법 행동을 반환해서는 안 된다.

### 8-4. 수집할 지표

승률 하나로는 왜 강한지 모른다.

- 평균/중앙/10·90백분위 게임 턴 수
- 첫 핵심 카드 구매 턴과 첫 재등장 턴
- 셔플 횟수, 평균 덱 크기, 핵심 카드 출현률
- 턴당 액션·드로우·구매·생산량
- terminal collision/막힌 CUE 비율
- 승리 자원 투입 시작 턴(greening)
- 종료를 직접 만든 비율과 종료 시 점수차
- ECHO/144: 생존률, 피해, 미사용 CUE, LINK 실효율, OPEN 진입 턴, 최종 echo

DominionSim의 다회전 평균·승률·게임 길이 차트는 이 철학을 보여 준다. 단, 시뮬레이터 자체의 전략 휴리스틱과 카드 구현이 틀리면 정밀한 그래프도 틀린 결론을 낸다. 먼저 작은 손계산 fixture로 엔진을 검증한다.

### 8-5. 학습형 AI가 나중인 이유

- 행동 공간이 카드와 kingdom에 따라 바뀐다.
- 숨은 정보와 선택 순서 때문에 단순 상태 벡터가 충분하지 않다.
- 보상 설계가 승리만 보면 장기 credit assignment가 어렵다.
- 규칙 엔진 버그를 AI가 이상한 정책으로 흡수해 감춘다.
- ECHO/144의 목적은 강한 상대가 아니라 밸런스 회귀와 설명 가능한 추천이다.

따라서 우선순위 봇들이 명백한 exploit을 찾고, seed 회귀가 안정된 뒤에만 MCTS/RL을 검토한다.

---

## 9. Command, Event, 로그, Undo, 저장

### 9-1. Command와 Event의 차이

```text
Command = 플레이어/봇이 하려는 것
  PLAY_CARD(instance), BUY_CARD(pile), ANSWER_CHOICE(ids), END_PHASE

Event = 검증된 명령을 해결하며 실제로 일어난 것
  CARD_MOVED, CARD_DRAWN(private), COINS_CHANGED, PILE_EMPTIED,
  ATTACK_STARTED, REACTION_REVEALED, TURN_ENDED, GAME_ENDED
```

Command는 거부될 수 있다. Event는 정본 결과다. 화면, 사운드, 텍스트 로그, 통계 수집은 Event를 소비하고 GameState를 바꾸지 않는다. Androminion의 `GameEvent`와 통신용 `GameStatus`, Slay the Web의 action manager가 이 분리의 서로 다른 형태를 보여 준다.

### 9-2. 공개 로그와 비공개 로그

온라인/관전까지 가면 Event에 가시성 정책이 필요하다.

| 사건 | 본인 | 상대 | 관전자/리플레이 |
|---|---|---|---|
| 손으로 카드 드로우 | 카드 ID | “N장 드로우” | 권한에 따라 masked/full |
| 공개/reveal | 카드 ID | 카드 ID | 공개 |
| 덱 셔플 | 발생 사실 | 발생 사실 | 공개 |
| 비공개 선택 후보 | 전체 | 없음 | masked |

싱글 ECHO/144에서도 로그는 개발용 full log와 플레이어용 간결 event log를 분리하는 편이 좋다. DEV 문자열을 무한 누적하지 말고 고정 크기 ring buffer나 파일 스트리밍을 쓴다.

### 9-3. Undo의 세 방식

1. **전체 snapshot:** 매 의미 행동 전 상태 복사. 단순하지만 상태가 크면 비용 증가.
2. **Command replay:** 초기 seed부터 해당 지점 직전까지 다시 실행. 결정론이 필요하고 긴 게임은 checkpoint가 유리.
3. **역연산:** 각 Event를 거꾸로 적용. 가장 복잡하고 카드 예외가 많을수록 위험.

Slay the Web은 직렬화 가능한 단일 상태와 action history로 브라우저 Undo/Redo를 간단히 구현한다. 도미니언 온라인의 Undo에는 상대 승인과 숨은 정보 노출 문제가 추가된다. 예컨대 카드를 뽑아 내용을 본 뒤 되돌리면 완전한 정보 복원이 아니다.

ECHO/144는 게임 내 자유 Undo가 필요 없다. 개발용으로 `checkpoint snapshot + command replay`, 사용자에게는 `같은 seed 즉시 재시작`이면 충분하다.

### 9-4. 저장과 URL/리플레이

Slay the Web은 상태를 인코딩해 URL hash에 넣어 공유/복원을 쉽게 한다. 웹 디버깅에는 훌륭하지만, 긴 상태·버전 변경·민감 정보에는 부적합하다. 제품 저장에는 다음 헤더가 필요하다.

```text
magic / schema_version / ruleset_version / build_id
payload_length / checksum
seed / setup / checkpoint state / commands after checkpoint
```

저장 로더는 이름 기반으로 임의의 현재 카드를 찾지 말고 stable ID와 명시적 migration을 쓴다. ECHO/144의 작은 영구 저장은 [30_TECH.md](30_TECH.md) §8처럼 해금/기록만 저장하고, 진행 중 런 저장이 실제 요구가 생길 때 checkpoint를 추가한다.

---

## 10. 자동 테스트 설계

### 10-1. 구현체에서 배울 점

- Paul Batum: `Given/When/Then`으로 준비, 턴, 종료, 점수, 로그를 사람이 읽을 수 있게 명세한다.
- shane-riley C++: 고정 `mt19937(42)`와 선택 stub으로 드로우, 공급 종료, Smithy/Village, Militia/Moat, Gardens 점수를 검사한다.
- nlonz: legal moves와 Agent 구매 우선순위를 작게 검사하지만 빈 덱 드로우·공격 등 공백이 남는다.
- DominionSim: 넓은 카드 범위에 비해 테스트 파일이 매우 적어 “카드가 많다”와 “신뢰 가능하다”가 다름을 보여 준다.
- Dominiate README: 이상 상황 회귀 테스트가 roadmap에 남아 있어 오래된 시뮬레이터 결과를 정본으로 쓰면 안 됨을 스스로 경고한다.

### 10-2. 테스트 피라미드

#### A. 원자 효과 단위 테스트

- draw가 덱 경계에서 정확히 한 번 섞는다.
- 덱+버림이 부족하면 가능한 수만 뽑는다.
- gain은 기본적으로 공급→버림이며 빈 더미에서는 아무 카드도 생성하지 않는다.
- trash는 소유 영역→공용 폐기이며 공급으로 돌아가지 않는다.
- 비용 감소와 debt/potion을 포함한 구매 가능 여부.
- 공격은 각 상대에게 한 번, 반응은 적법한 window에서만.

#### B. 카드 fixture

- 입력 상태를 손으로 구성하고 명령 1~3개 뒤 상태와 Event열을 비교한다.
- 단순 카드마다 정상 경로 1개, 경계/선택 1개.
- 복잡한 hook마다 취소 불가, 후보 없음, 최대/최소 선택, 중첩 trigger를 포함한다.

#### C. 턴·게임 시나리오

- Action/Buy/Cleanup 자원 초기화와 영역 이동.
- Province/3더미 종료는 정확한 시점에 확정.
- 동점의 턴 수 규칙.
- 추가 턴, 시작/종료 trigger 순서.
- 게임 종료 뒤 명령 거부.

#### D. 결정론/리플레이

- 동일 build+seed+commands → 동일 state checksum/event digest.
- cosmetic 설정 변경 → rules checksum 동일.
- save/load 중간 checkpoint → 끝 결과 동일.

#### E. 생성/퍼즈/시뮬레이션

- 100~10,000개의 seed에서 RandomLegal이 종료 또는 명시적 턴 제한 안에 도달.
- 매 move 뒤 카드 보존·범위 불변식.
- 봇 정책별 지표가 승인된 허용 구간을 벗어나면 회귀 경고.

### 10-3. ECHO/144에 즉시 추가할 회귀 항목

현재 `src/game.c` selftest에 이미 턴 흐름, CACHE 중복, OPEN scheduler, kingdom 유효성, 여러 카드/적 fixture와 전략 simulation이 있다. 조사에서 보강할 최소 항목:

1. `game_start(seed)` 후 모든 덱 영역 카드 합과 카드별 개수를 단언.
2. 매 `draw_one`, CACHE, PREFETCH, SEEK, DEFRAG, theft/return 뒤 카드 보존 불변식.
3. 동일 seed와 입력 기록을 두 번 실행해 결과 구조체 digest 비교.
4. `cosmetic/low_fx/muted` 변경이 gameplay digest를 바꾸지 않음.
5. 의미 명령별 기대 Event열 비교 — UI 문자열이 아니라 타입/값.
6. RandomLegal에 해당하는 편성·구매 봇으로 100 seed 무교착 실행.
7. 전략 봇별 생존/OPEN 성공/평균 echo의 넓은 회귀 구간.

이는 새 프레임워크 없이 기존 `assert` selftest와 작은 helper로 가능하다.

---

## 11. 저장소별 상세 판독

### 11-1. Androminion — 규칙 범위와 프로토콜의 참고서

README는 Android 클라이언트와 VDOM 서버를 분리하며, 싱글플레이도 로컬 서버 경로를 쓴다고 설명한다. 코드에서 확인한 핵심:

- `Game.java`: setup, 턴 진행, 종료, 이벤트 broadcast 등 대형 orchestrator.
- `Player.java`: hand/deck/discard/play, gain/trash/shuffle, 플레이어별 각종 확장 상태.
- `MoveContext.java`: 현재 턴의 actions, buys, coins와 임시 modifier.
- `Cards.java`: builder 형태의 카드 메타데이터.
- `CardImpl*.java`: 세트별 카드 특수 행동과 switch/분기.
- `GameEvent.java`: 영역 이동, 셔플, 획득 등 UI/로그가 소비할 사건.
- `GameStatus`, `SelectCardOptions`, `RemotePlayer`: 엔진과 원격 UI 사이 상태/선택 경계.

채택할 것:

- 규칙 코어와 UI/네트워크 선택 인터페이스 분리.
- 턴성 값은 MoveContext처럼 런 전체 상태와 구분.
- 영역 이동을 Event로 방송.
- 대형 확장 지원 시 “기본 상태만으로 설명되지 않는 매트/토큰/지속”을 명시적으로 추적.

채택하지 않을 것:

- 수천 줄 mutable 클래스 한곳에 규칙 집중.
- 카드 추가마다 Player field와 중앙 switch가 늘어나는 구조.
- 라이선스가 없는 코드를 ECHO/144로 복사.

### 11-2. DominionSim — 설명 가능한 봇과 대량 실험

`DomBuyRule`은 살 카드, 플레이 전략, 조건 목록을 가진다. `DomBuyCondition`은 덱의 카드 수, 턴 수, 남은 pile, 현재 돈, VP, 빈 pile 등 상태 함수를 비교한다. `DomEngine`은 시스템/사용자 봇을 XML에서 읽고 여러 게임을 돌려 승률·평균 턴·빈 더미 종료 등을 집계한다.

강점은 디자이너가 “VOICE는 3장 미만이고 5턴 이후일 때”처럼 정책을 읽고 수정할 수 있다는 점이다. 약점은 카드와 확장 상태가 늘며 `DomPlayer`가 5천 줄대로 커지고, 일부 카드 로직이 human GUI에 직접 질문하는 경로와 봇 휴리스틱 경로를 각각 가진다는 점이다. 선택 요청을 하나의 typed interface로 통합했다면 중복이 줄었을 것이다.

### 11-3. Dominiate — 전략은 코드로 짧게, 코어는 오래됨

Dominiate는 카드 구매를 우선순위 목록과 조건으로 정의하고, 행동 선호는 필요할 때 override한다. `BigMoney`, `ChapelWitch`, `BankWharf`, 여러 `Rebuild`/공격 전략 파일이 있어 정책 비교 자료로 좋다. 문서와 소스가 나란한 literate docs도 읽기 편하다.

그러나 README가 주 개발 시점을 2014년이라 명시하고 여러 후속 확장을 다루지 못하며 이상 상황 테스트도 계획 상태라고 밝힌다. 따라서 수치 결과를 현대 도미니언의 진실로 인용하지 않고 **“작은 설명 가능한 전략 봇을 많이 둔다”는 철학만** 가져온다.

### 11-4. Paul Batum Dominion — 코드보다 BDD 규칙 계약

이 구현은 `Hand`, `DrawDeck`, `DiscardPile`, `PlayArea`, `TrashPile`, `CardBank`, `TurnContext` 등 도메인 이름을 코드 구조로 옮긴다. 특히 `Dominion.Specs/*.feature`는 다음을 사람 문장으로 고정한다.

- 시작 덱과 시작 손.
- 플레이어 수에 따른 Province/Curse 수.
- Action 사용과 Cleanup.
- 종료 조건과 종료 확정 시점.
- 모든 영역의 점수 합산.
- 로그에 무엇이 기록되는가.

현대 도미니언 전체 구현으로 쓰기에는 오래됐지만, 기획 문서의 규칙 문장을 실행 가능한 회귀 계약으로 바꾸는 예로 좋다. ECHO/144도 Gherkin 도구를 도입할 필요는 없고, `test_turn_flow`, `test_open_scheduler` 이름과 fixture를 기획 용어로 유지하면 같은 이득을 얻는다.

### 11-5. nlonz/dominion-engine — 좋은 뼈대, 미완성 규칙

128줄 안팎의 `game.py`가 단계별 합법 move 생성과 적용을 보여 준다. frozen move dataclass와 `Agent.choose(state, moves)`는 AI 연구용 최소 경계로 훌륭하다.

그러나 감사 커밋에서 action 효과는 Village/Smithy를 identity 비교로 hardcode하고, 카드 정의에 Moat가 있어도 효과/반응이 연결되지 않는다. Player draw는 양쪽 pile이 빈 경계를 안전하게 처리하지 못한다. README의 제한된 카드 목록과 테스트 범위를 넘어 일반 엔진으로 간주하면 안 된다. **작은 코드는 이해하기 쉽지만, 작다는 사실이 정확성을 증명하지 않는다.**

### 11-6. shane-riley C++ — ECHO/144와 가장 가까운 효과 구조

`PlayerState`는 영역을 분리하고 `GameState`가 RNG를 소유한다. `Effect`의 `std::variant`와 `std::visit` resolver는 원자 효과를 타입 안전하게 처리한다. JSON은 단순 카드를 조립하고 복잡한 카드는 scripted handler로 빠진다. 고정 seed와 선택 stub 테스트는 C 코어에도 그대로 번안할 수 있다.

주의점:

- 루트 라이선스가 없으므로 코드·JSON을 복사하지 않는다.
- 카드 목록이 기본판 1판 중심이다.
- 봇의 prompt 문자열 검색은 typed choice로 교체해야 한다.
- scripted handler가 긴 if-chain이 되면 데이터화의 이득이 줄어든다.

ECHO/144의 `EffectOp + hook` 설계가 이 저장소와 같은 결론에 독립적으로 도달했음을 확인하는 참고 자료로 쓴다.

### 11-7. dostjh/deck-builder-game — 과도한 범용화의 비용

게임 규칙과 카드 단계를 XML로 읽고, 단계 이름으로 C# `Actions` 메서드를 reflection 조회해 런타임 인자를 주입한다. 원자 효과 데이터화의 의도는 좋지만 다음 문제가 있다.

- 문자열 오타·메서드 이름 변경이 컴파일 타임에 잡히지 않는다.
- reflection과 object 배열로 타입/호출 관계가 숨는다.
- 공격, 폐기, 비용 기반 획득 등 핵심 메서드가 `NotImplementedException`이다.
- README가 WIP/unplayable 및 멀티플레이 부재를 명시한다.
- 셔플마다 새 `Random`을 만든다.
- 라이선스가 없다.

ECHO/144가 런타임 XML, reflection, 범용 VM을 피하고 빌드 타임 `content → generated .inc`를 쓰기로 한 판단을 뒷받침한다.

### 11-8. Slay the Web — 유사 장르의 상태/액션 도구

도미니언 복제는 아니지만 단일 직렬화 상태, 동기 action, action manager의 queue/Undo/Redo, URL hash 저장, UI 분리, 적 intents, debug 화면과 테스트가 있다. 덱빌딩 로그라이크에서 다음 기능이 같은 토대에서 나오는 모습을 볼 수 있다.

- 상태를 저장·공유해 특정 버그 장면을 바로 연다.
- action history로 Undo/Redo와 UI 갱신을 통일한다.
- 적 intent를 상태 데이터로 두어 UI가 예고한다.
- 카드/몬스터 콘텐츠와 게임 action을 분리한다.

AGPL-3.0이므로 네트워크로 수정판을 제공할 때도 소스 제공 의무가 관련될 수 있다. 법률 자문은 아니지만 ECHO/144의 비공개/별도 라이선스 가능성을 지키려면 코드를 섞지 않고 구조 개념만 새로 작성한다.

---

## 12. 반드시 피할 구현 패턴

| 패턴 | 실제 징후 | 왜 위험한가 | 작은 대안 |
|---|---|---|---|
| UI가 합법성을 계산 | human/AI 경로가 각각 후보 구성 | 규칙이 세 군데로 갈라짐 | 코어 `legal_moves/choice_request` |
| prompt 문자열을 AI API로 사용 | “Moat” 포함 여부 검색 | 번역·문구 변경에 깨짐 | enum reason/source ID |
| 카드 이름을 영구 ID로 사용 | JSON/XML name 기반 분기 | 판본·번역·rename에 깨짐 | stable integer ID+display key |
| 셔플 때마다 새 RNG | `new Random()` | 재현 불가·seed 상관 | state-owned seeded RNG |
| 카드마다 Player field 추가 | 수백 boolean/counter | 조합·초기화·저장 폭발 | effect-owned typed state/소수 명시 슬롯 |
| 모든 카드 imperative switch | 대형 `CardImpl` 분기 | 공통 효과 중복·테스트 표면 증가 | 원자 EffectOp+hook |
| 모든 것을 데이터/VM화 | reflection step 이름 | 정적 검사 약화·파서/VM 비대 | 빌드 타임 검증된 packed data |
| 규칙과 애니메이션을 같은 queue | UI 완료가 규칙 진행 조건 | 빠른 모드·AI·headless가 어려움 | 즉시 코어 해결+Event 재생 |
| Undo를 무조건 허용 | 숨은 카드 확인 뒤 rewind | 정보 이득·온라인 악용 | 정책+snapshot/replay, 또는 미지원 |
| 카드 수로 완성도 판단 | 광범위 구현, 테스트 3개 | 조용한 규칙 오차가 시뮬레이션 왜곡 | 경계 fixture+불변식+seed 회귀 |

---

## 13. ECHO/144에 적용하는 최소 설계

### 13-1. 현재 코드와의 대응

| 조사에서 필요한 경계 | 현재/정본 | 판정 |
|---|---|---|
| 정본 GameState | 현재 전역 `g`, 장기 구조는 `src/core` 분리 예정 | 공모전판은 유지 가능, 새 기능은 영역 helper 경유 |
| 단계 상태 기계 | `g.mode = EDIT/ON_AIR/BREAK/OPEN_CHANNEL/RESULT` | 이미 명확. 강제 전환 뒤 return 계약 유지 |
| 분리 RNG | `deck_rng/encounter_rng/reward_rng` | 채택 완료. 연출 RNG 분리 확인 |
| 카드 영역 | draw/hand/discard+cached/stolen | 카드 보존 불변식 추가 |
| 합법 semantic command | 키 입력이 `game_tick` 분기에 직접 연결 | V2 core 분리 때 `game_apply_command` 도입 |
| 효과 데이터+hook | `CARD_DEF`+`execute_program` 분기 | [30] §6의 `EffectOp`로 반복 효과만 이동 |
| Event | 렌더가 `g.effect_*`, message flag 직접 읽음 | V2에서 bounded `GameEventBuffer` 추가 |
| 전략 봇 | `src/game.c` 후반 simulation policy | 별도 `strategy_bots.c`가 목표, 우선 정책 4~6개 유지 |
| 테스트 | assert selftest 다수 | invariants, deterministic digest, event stream 추가 |

### 13-2. 최소 C API

범용 카드 엔진을 새로 만드는 대신 정본의 세 함수만 먼저 세운다.

```c
void game_init(GameState *s, const RunConfig *cfg);
bool game_apply_command(GameState *s, const GameCommand *cmd, GameEventBuffer *events);
void game_tick(GameState *s, const InputFrame *input, GameEventBuffer *events);
```

`GameCommand`는 EDIT/BREAK/OPEN의 의미 행동만 담고, ON AIR 이동은 `InputFrame`에 남긴다. `GameEventBuffer`는 한 명령/틱에서 생긴 사건을 고정 배열에 담는다. 동적 할당, reflection, string ID가 필요 없다.

### 13-3. 효과 op의 현실적 범위

ECHO/144에서 반복되는 것만 우선 op로 만든다.

```text
DRAW, GAIN_CUE, ADD_ECHO, CONVERT_ECHO,
SPAWN_RECIPE, DAMAGE_AREA, MARK_TARGET, LINK_MARKS,
PUSH_ENEMIES, DELETE_PROJECTILES, CLEAN_NOISE,
CHANGE_SYNC, EMIT_FEEDBACK, CALL_HOOK
```

CACHE, MACRO, PREFETCH, DEFRAG, TREND, 최종 protocol compile은 hook으로 남긴다. op interpreter가 100줄을 크게 넘거나 카드 하나 때문에 opcode가 늘어나면 데이터화 경계를 다시 검토한다.

### 13-4. Event의 첫 도입 범위

한 번에 렌더 전체를 바꾸지 않는다. 먼저 테스트·플레이 피드백 가치가 큰 사건만:

```text
EV_CARD_CUED, EV_CARD_FIRED, EV_CARD_RETURNED, EV_SHUFFLE,
EV_ECHO_ADDED, EV_ECHO_CONVERTED, EV_DAMAGE, EV_ENEMY_KILLED,
EV_SYNC_CHANGED, EV_OPEN_CHANNEL, EV_RESULT
```

이 event열로 다음을 할 수 있어야 한다.

- 카드 발동 tick 타임라인 테스트.
- “새 카드가 언제 돌아왔는가” HUD.
- 전략별 LINK/echo/피해 통계.
- 같은 seed replay digest.
- 시크의 이전 방송/노아의 행동 모방에 사용할 의미 로그.

### 13-5. 구현 우선순위와 완료 기준

#### P0 — 정확성 기반

1. 카드 보존 불변식 helper.
2. 동일 seed+입력의 gameplay digest 테스트.
3. gameplay RNG와 cosmetic 경로 분리 확인.
4. 선택/이동 helper가 실패할 때 상태를 반쯤 바꾸지 않는지 fixture.

완료 기준: 100 seed 전략 simulation에서 assert/교착/카드 수 불일치 0, 동일 입력 digest 100% 일치.

#### P1 — Command/Event 얇은 경계

1. CUE/SEEK/BUY/OPEN을 `game_apply_command`로 이동.
2. 위 10종 Event를 고정 buffer로 배출.
3. 키 처리와 전략 봇이 같은 명령 함수를 사용.

완료 기준: UI 키와 봇이 같은 fixture에서 같은 Command/Event 결과를 내고, 불법 명령은 상태 무변경.

#### P2 — 반복 효과 데이터화

1. 반복되는 프로그램 3~5개만 EffectOp로 옮김.
2. 기존 fixture와 event digest가 동일함을 확인.
3. 복잡한 카드는 hook 유지.

완료 기준: 전용 분기가 실제로 줄고, 새 VM/파서/동적 할당 없이 EXE 크기·selftest 통과. 줄 수가 늘고 이해가 어려워지면 이 단계는 철회한다.

#### 보류

- 전체 도미니언 호환 엔진.
- 온라인 authoritative server, 관전, 상대 승인 Undo.
- 런타임 mod/card scripting.
- 강화학습/MCTS.
- 외부 저장소 코드 vendor.

---

## 14. 라이선스·저작권 경계

### 14-1. 저장소 코드

| 상태 | 할 수 있는 일 | 이 프로젝트의 처리 |
|---|---|---|
| MIT | 고지·라이선스 포함 조건으로 사용/수정/배포 가능 | 현재는 링크·구조 분석만. 실제 복사 시 원 저작권·LICENSE를 배포물에 포함 |
| AGPL-3.0 | 수정/결합·네트워크 제공 시 강한 소스 제공 조건 검토 필요 | Slay the Web 코드는 복사하지 않고 개념만 독립 구현 |
| 라이선스 없음 | 기본 저작권이 유지되어 복사·수정·재배포 권한을 추정할 수 없음 | Androminion, shane-riley, dostjh 코드는 열람만 |

라이선스 판단은 법률 자문이 아니다. 실제 코드를 가져올 필요가 생기면 해당 커밋의 LICENSE, 파일별 헤더, 의존 자산 라이선스를 다시 감사하고 `THIRD_PARTY_NOTICES`를 만든다.

### 14-2. Dominion 지식재산

규칙 아이디어와 소프트웨어 구조를 연구하는 것과 카드 텍스트·이름·미술·프레임·상표를 복제해 배포하는 것은 다르다. ECHO/144가 가져올 것은 덱 순환, 지연된 구매, 액션 경제, 승리 자원 오염 같은 **추상 메커니즘과 새로 작성한 코드**다. 원작 카드 데이터·번역문·이미지·UI를 포함하지 않는다.

### 14-3. 왜 소스를 docs 안에 복제하지 않았는가

- Git 링크를 커밋에 고정하면 원 저작권과 문맥을 보존한다.
- 저장소 전체를 vendor하면 프로젝트 크기·검색 노이즈·보안/라이선스 관리가 늘어난다.
- 일부 후보는 라이선스가 없어 복제할 권한이 확인되지 않는다.
- 사용자 요구인 “참고하게 넣기”에는 감사표, 핵심 파일 permalink, 적용/비적용 판단이 더 유용하다.

---

## 15. 구현 체크리스트

다른 개발자가 이 문서만 보고 설계를 검토할 때 다음에 답할 수 있어야 한다.

### 규칙 코어

- 카드 한 장이 어느 영역에 있는지 단일 정본으로 알 수 있는가?
- 턴 단계와 pending choice가 명시적인가?
- UI/AI/리플레이가 같은 합법 행동/명령 검증을 쓰는가?
- 선택 이유와 후보가 문자열이 아니라 타입인가?
- 효과 해결과 애니메이션 재생이 분리되었는가?
- 공급 종료와 실제 게임 종료 시점이 구분되는가?

### 결정론·저장

- RNG를 GameState가 소유하고 seed를 기록하는가?
- 연출 난수가 덱/전투 결과를 바꾸지 않는가?
- 동일 seed+명령열로 같은 checksum이 나오는가?
- 저장에 schema/ruleset/build/checksum이 있는가?
- Undo가 숨은 정보와 승인 정책을 고려하는가, 아니면 명시적으로 미지원인가?

### 콘텐츠

- 표시 이름과 stable card ID가 분리됐는가?
- 단순 효과는 공용 op, 복잡한 것은 제한된 hook인가?
- 카드 하나 때문에 범용 opcode/Player field가 계속 늘지 않는가?
- 판본과 정오표 revision을 기록하는가?

### AI·밸런스

- RandomLegal과 Big Money류 기준선이 있는가?
- AI가 상태를 직접 수정하지 않는가?
- 승률 외에 턴 길이, 순환, 충돌, 종료 통제 지표가 있는가?
- 작은 손계산 fixture가 시뮬레이션보다 먼저 통과하는가?

### 테스트

- 빈 덱+빈 버림 draw가 안전한가?
- 카드 보존 불변식을 매 시나리오에서 검사하는가?
- 반응·공격·중첩 trigger·후보 없음·최소/최대 선택을 다루는가?
- 게임 종료 후 명령을 거부하는가?
- 100개 이상 seed의 무교착 회귀가 있는가?

---

## 16. 출처 인덱스

### 공식·1차 제품/연구 자료

- [Temple Gates Games — Dominion 공식 제품 페이지](https://templegatesgames.com/gamepages/dominion.html)
- [Steam — Dominion](https://store.steampowered.com/app/1131620/Dominion/)
- [Dominion Online](https://dominion.games/)
- [Dominion Online — Changelog](https://dominion.games/changelog.html)
- [Shuffle iT Forum — Dominion Online 클라이언트 기능 안내](https://forum.shuffleit.nl/index.php?topic=2245.0)
- [Dominion: A New Frontier for AI Research](https://arxiv.org/abs/2405.06846)
- 기본 규칙·카드·전략·솔로/비교작 자료는 [36_DOMINION_DEEP_RESEARCH.md](36_DOMINION_DEEP_RESEARCH.md) §9 참조.

### 감사한 Git 저장소

- [mehtank/androminion @ `bf7cf3c400f5b4a552ef13ec127cf1946a1f5eac`](https://github.com/mehtank/androminion/tree/bf7cf3c400f5b4a552ef13ec127cf1946a1f5eac)
- [Geronimoo/DominionSim @ `c8a391594a6cb182bdaafe60bcc9f5a50d124d16`](https://github.com/Geronimoo/DominionSim/tree/c8a391594a6cb182bdaafe60bcc9f5a50d124d16)
- [rspeer/dominiate @ `edc75b4e8c9162d0679d4d03a1a5837396273734`](https://github.com/rspeer/dominiate/tree/edc75b4e8c9162d0679d4d03a1a5837396273734)
- [paulbatum/Dominion @ `28daf2a366332fbd176b4c06f43feb6851fe5f4d`](https://github.com/paulbatum/Dominion/tree/28daf2a366332fbd176b4c06f43feb6851fe5f4d)
- [nlonz/dominion-engine @ `1455f770422eb0612a51ea096e3b951d528c2a25`](https://github.com/nlonz/dominion-engine/tree/1455f770422eb0612a51ea096e3b951d528c2a25)
- [shane-riley/dominion-card-game @ `869396422c9d0568a7bca8a6a14750051a6f5155`](https://github.com/shane-riley/dominion-card-game/tree/869396422c9d0568a7bca8a6a14750051a6f5155)
- [dostjh/deck-builder-game @ `1beb54723dd4140ad469a1d869ef0d79a8093a36`](https://github.com/dostjh/deck-builder-game/tree/1beb54723dd4140ad469a1d869ef0d79a8093a36)
- [oskarrough/slaytheweb @ `a59c1303421240785ce12ff3886710c83d21d01a`](https://github.com/oskarrough/slaytheweb/tree/a59c1303421240785ce12ff3886710c83d21d01a)

### 최종 판정

이 저장소들 가운데 ECHO/144에 통째로 도입할 대상은 없다. 참고 가치의 조합은 다음과 같다.

```text
nlonz의 legal move/Agent 경계
+ shane-riley의 typed 원자 효과+hook
+ Androminion의 영역·turn context·event/protocol에서 발견한 예외
+ DominionSim/Dominiate의 설명 가능한 우선순위 봇과 다회전 통계
+ Paul Batum의 사람이 읽는 규칙 시나리오
+ Slay the Web의 action history·직렬화·intent
= ECHO/144의 작은 결정론 C 코어, Command/Event, EffectOp, 전략 selftest
```

핵심은 외부 구현의 클래스 구조를 복사하는 것이 아니라, **하나의 규칙 정본을 UI·AI·테스트·리플레이가 함께 쓰게 만드는 것**이다.
