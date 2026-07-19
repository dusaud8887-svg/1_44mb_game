# 구현 참고 소스

조사 문서: [Dominion](../38_DOMINION_DIGITAL_IMPLEMENTATION_RESEARCH.md), [Vampire Survivors × HoloCure](../37_VAMPIRE_SURVIVORS_HOLOCURE_RESEARCH.md)

| 폴더 | 버전·출처 | 용도 | 라이선스 |
|---|---|---|---|
| [dominion-engine](dominion-engine/) | [`1455f770`](https://github.com/nlonz/dominion-engine/tree/1455f770422eb0612a51ea096e3b951d528c2a25) | 작은 `legal_moves → Agent → apply_move` 구조와 테스트 | MIT, 폴더의 `LICENSE` 참조 |
| [dominion-sim](dominion-sim/) | [`c8a39159`](https://github.com/Geronimoo/DominionSim/tree/c8a391594a6cb182bdaafe60bcc9f5a50d124d16) | 광범위한 카드 구현, 조건부 구매 봇, 대량 시뮬레이션 | MIT, 폴더의 `LICENSE.txt` 참조 |
| [HoloCure-0826-Export](HoloCure-0826-Export/) | 0.6 계열로 추정되는 추출·복원 코드 | 전투 판정, 레벨업, 콜라보, 경험치 흡수, 웨이브 구조 참고 | 별도 라이선스 없음 |
| [Vampire Survivors](Vampire%20Survivors/) | 비공식 Unity 클론 `Plant Survivor` | 장르의 웨이브, 경험치, 업그레이드, 풀링 구현 참고 | 프로젝트 전체 라이선스 없음 |

네 폴더 중 Dominion 두 폴더는 위 커밋의 얕은 Git 복제본이다. `dominion-sim`은 참고에 불필요한 배포 JAR·이미지를 제외하고 `src/`, README, LICENSE, `pom.xml`만 sparse-checkout했다. 원작 카드명·문구·자산을 ECHO/144에 복사하지 말고 구조와 테스트 사례만 참고한다. HoloCure 코드는 추출본이며, `Vampire Survivors`는 원작 소스가 아니라 비공식 클론이다.
