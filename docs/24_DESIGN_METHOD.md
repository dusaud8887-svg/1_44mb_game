# 24 — 게임 디자인 이론·방법론 적용 정본

이 문서는 고전 이론을 요약하는 독서 노트가 아니라, **에코/144의 경험 약속을 규칙·화면·검증으로 추적하는 작업 도구**다. 2026-07-17 현재 하나의 최신 이론이 고전을 대체하지 않는다. MDA로 인과를 적고, FADT·렌즈로 질문하며, GameFlow·자기결정성이 놓친 동기를 확인하고, DDD로 가장 위험한 가설부터 실기에서 반증한다.

## 1. 프로젝트가 채택한 최소 도구상자

| 도구 | 이 프로젝트에서 묻는 질문 | 산출물 |
|---|---|---|
| MDA | 이 규칙이 반복 플레이에서 어떤 행동을 만들고 어떤 감정을 남기는가 | 아래 인과 지도, [10](10_MECHANICS.md) 규칙 |
| FADT | 플레이어의 의도와 시스템의 결과가 지각 가능하며, 다음 선택을 설명하는가 | EDIT·ON AIR·BREAK 피드백 |
| Schell 렌즈 | 경험·핵심 동사·도전·경제·표현을 서로 다른 관점에서 다시 보면 무엇이 깨지는가 | 패스별 질문 한 개 |
| GameFlow | 목표·피드백·통제·도전이 현재 숙련도에 맞는가 | 첫 3구절 안내, 의도 공개, SYNC |
| 자기결정성이론 | 자율성·유능감·관계성이 실제 규칙으로 지지되는가 | TX/RX 선택, 읽히는 결과, NØA·시크 |
| 보상예측오차 | 예상과 결과의 차이가 학습 가능한가, 단순 변동 보상으로 가려지지 않는가 | 카드 귀환·TREND·OPEN 반전 피드백 |
| DDD | 지금 가장 먼저 깨지는 가설은 무엇이며 최소 수정으로 재검증 가능한가 | [25](25_DDD.md) 증거 사다리·중단 기준 |

MDA의 방향은 양쪽이다. 디자이너는 `경험 → 동역학 → 규칙`으로 역설계하고, 플레이어는 `규칙 → 반복 행동 → 경험` 순으로 만난다. 기능 목록만 늘리면 가운데 동역학이 보장되지 않는다.

## 2. 에코/144 인과 지도

| 경험 약속 | 메커니즘 | 실제로 생겨야 할 동역학 | 읽히는 결과 | 실패 신호 |
|---|---|---|---|---|
| 한 손패, 한 딜레마 | CARRIER TX/RX, CUE 제한, 다음 의도·공간 패턴 공개 | 생존과 다음 구매력 사이 재배분 | 카드 포트 방향, 전송량, 적 의도 | 항상 같은 TX/RX |
| 내가 만든 방송 | PROGRAM 수동 편성·Space 순차 발동 | 편성 순서와 이동이 전장 형태를 바꿈 | 큐 번호, 카드명 1초, 고유 효과 | Space를 눌러도 원인을 모름 |
| 약점의 회수 | ARCHIVE는 평시 무음, OPEN에서 탄약 | 초반 부담을 감수한 덱이 후반 형태를 결정 | 구매 귀환, 최종 형태·강도 | ARCHIVE 0장 또는 전부가 항상 정답 |
| 나를 학습하는 상대 | 최근 6구절·실제 발동 TREND | 반복한 습관이 NØA의 반격이 됨 | 학습 카드명, 자홍 복제 라벨·화음 | 복제를 일반 적탄으로 인식 |
| 플레이의 표현 | 64칸 실제/보관/모방 상태 | 선택 이력이 최종 색·관계·엔딩으로 수렴 | 상시 링, 임계 위상, 결과 초상 | 색과 결과를 연결하지 못함 |

정성적 재미 모델은 다음처럼 사용한다.

```text
재시도 욕구 = 의미 있는 선택 × 결과 가독성 × 학습 × 다음 선택의 변화
```

수치 공식이 아니라 **직렬 게이트**다. 어느 항이 0이면 이펙트나 보상량을 늘려도 코어 루프는 회복되지 않는다. 자동 SIM은 도달 가능성과 전략 분포를 검사하고, 사람은 이해·통제·기억·재시도 이유를 판정한다.

실패 화면도 다음 선택의 일부다. `죽었다`가 아니라 체력 고갈과 64 미달을 분리하고, 각각 공간 생존과 덱 투자 중 어느 축을 바꿀지 알려야 같은 시드 재시도가 학습 루프가 된다.

## 3. 한 구절의 설계 문법

```text
다음 의도 예고
→ EDIT: 손패 효과 확인, TX/RX·PROGRAM 편성
→ ON AIR: 이동하며 준비한 PROGRAM을 Space로 송출
→ BREAK: 결과·전송량 확인, 구매 또는 넘김
→ CLEANUP: 산 카드의 귀환을 기다리며 다음 의도에 재편성
```

각 화살표는 다음 세 조건을 만족해야 한다.

1. **의도**: 플레이어가 왜 그 입력을 하는지 화면에서 말할 수 있다.
2. **지각 가능한 결과**: 1초 안에 소유자·카드·전장 변화 중 둘 이상이 보인다.
3. **미래 정보**: 결과가 다음 EDIT의 선택을 바꿀 단서를 남긴다.

한 화면 레벨 디자인은 새 맵 수가 아니라 **의도별 진입 방향·정지 장애물·추적·보상 위치가 이동 결정을 바꾸는가**로 판정한다. BOT RAID는 한 방향 압력, COMMENT WALL은 내부 한 줄 장벽, GIFT DROP은 위험 지대의 유혹, MUTE는 이동하는 봉인으로 서로 다른 공간 질문을 만든다.

첫 구절의 정본 경로는 `MULTI 확인 → 자동으로 FIREWALL 포커스 → FIREWALL 확인 → Tab → Space → 전송량 2 → CHAT 구매`다. MULTI는 CUE만 늘리고 송출 큐에는 들어가지 않으므로, 두 번째 PROGRAM까지 안내하지 않으면 첫 Space가 무반응이 되는 것이 핵심 결함이다.

8턴 이후 BREAK의 정본 질문은 `이번에 더 구축할까, 지금 상환할까`다. 현재 덱의 `형태 / modifier / 강도`를 OPEN CHANNEL과 같은 계산으로 미리 보여 주고, 별도 진화 트리나 조합표는 추가하지 않는다. 플레이어가 결과를 예측한 뒤 개방해야 예측오차가 학습이 된다.

## 4. 동기와 재미를 다루는 경계

- **자율성**: 정답 자동 플레이가 아니라 안전한 기본값과 되돌릴 수 있는 포커스를 준다.
- **유능감**: 성공 보상보다 먼저 원인·결과·실패 이유를 읽게 한다.
- **관계성**: 대사량이 아니라 NØA의 학습·시크의 보관처럼 플레이어 선택에 반응하는 규칙으로 만든다.
- **도전/몰입**: 8초 전투의 명확한 목표와 즉시 피드백을 유지하되, CLEAN_SIGNAL처럼 SIM이 평가하지 못하는 생존 가치는 사람 테스트로 분리한다.
- **예측오차**: 산 카드 귀환, ARCHIVE 반전, TREND 복제는 예상의 수정이어야 한다. 유료 확률 보상·FOMO·결석 처벌로 변동성을 강제하지 않는다.

2024년 HCI 게임 연구의 SDT 비판처럼 이론 이름을 붙였다고 측정이 성립하지 않는다. 본작은 체류시간이나 입력 수를 대리 지표로 삼지 않고, `왜 그렇게 편성했는가`, `무엇이 달라졌는가`, `다음에는 무엇을 바꿀 것인가`라는 관찰·회상 문항으로 검증한다.

## 5. 패스 운영표

| 순서 | 해야 할 일 | 통과 증거 |
|---:|---|---|
| 1 | 목표 경험을 플레이어 문장 하나로 쓴다 | 기능명이 아닌 감정·판단으로 설명됨 |
| 2 | MDA 인과를 규칙까지 역추적한다 | 규칙 하나가 약속 하나에 연결됨 |
| 3 | 가장 이른 실패 지점을 실기에서 찾는다 | 첫 무반응·오해 시점과 입력 로그 |
| 4 | 정보 → 기본값 → 수치 → 상호작용 순으로 하나만 고친다 | 변경 전후 같은 경로 비교 |
| 5 | selftest·SIM·Windows 실기·사람 게이트를 분리한다 | 자동 결과로 재미 PASS를 선언하지 않음 |
| 6 | 실패면 되돌리고, 통과면 정본과 상태를 동기화한다 | 코드·[10](10_MECHANICS.md)·[25](25_DDD.md)·[90](90_STATUS.md) 일치 |

## 6. 참고 원전과 최신 보정

- Hunicke, LeBlanc, Zubek, [MDA: A Formal Approach to Game Design and Game Research](https://www.cs.northwestern.edu/~hunicke/MDA.pdf)
- Doug Church, [Formal Abstract Design Tools](https://www.gamedeveloper.com/design/formal-abstract-design-tools)
- Jesse Schell, [The Art of Game Design: A Book of Lenses](https://schellgames.com/art-of-game-design)
- Sweetser & Wyeth, [GameFlow: a model for evaluating player enjoyment in games](https://www.valuesatplay.org/wp-content/uploads/2007/09/sweetser.pdf)
- Przybylski, Rigby & Ryan, [A Motivational Model of Video Game Engagement](https://doi.org/10.1037/a0019440)
- Schultz, [Dopamine reward prediction-error signalling](https://pmc.ncbi.nlm.nih.gov/articles/PMC5549862/)
- Tyack & Mekler, [Self-Determination Theory in HCI Games Research: Unfulfilled Promises and Unquestioned Paradigms](https://arxiv.org/abs/2405.12639)
- FTC, [Video Game Loot Box Workshop Staff Perspective](https://www.ftc.gov/news-events/news/press-releases/2020/08/ftc-staff-issue-perspective-paper-video-game-loot-boxes-workshop)
