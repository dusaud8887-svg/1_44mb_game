# 에코/144 (ECHO144.EXE)

Windows 10/11용 1.44MB 덱빌딩 서바이버. 현재 빌드는 문서의 **V2 P1 + 코드 통합 아트 패스**를 구현한다. 상태와 남은 범위는 [docs/90_STATUS.md](docs/90_STATUS.md)가 정본이다.

- [docs/00_VISION.md](docs/00_VISION.md) — 비전·장르·약속·기둥 (문서군 입구)
- [docs/05_WORLD.md](docs/05_WORLD.md) — 세계관 정본
- [docs/06_CHARACTERS.md](docs/06_CHARACTERS.md) — 캐릭터 바이블 (에코·시크·노아)
- [docs/10_MECHANICS.md](docs/10_MECHANICS.md) — 규칙 명세
- [docs/15_CARDS.md](docs/15_CARDS.md) — 카드 설계
- [docs/20_BALANCE.md](docs/20_BALANCE.md) — 모든 튜닝 수치의 단일 정본
- [docs/24_DESIGN_METHOD.md](docs/24_DESIGN_METHOD.md) — 고전·현대 게임 디자인 이론의 프로젝트 적용·인과 지도
- [docs/25_DDD.md](docs/25_DDD.md) — DDD 제품 가설·증거 루프·반복 개선 절차
- [docs/30_TECH.md](docs/30_TECH.md) — 기술 설계 (P0 결함·아키텍처·파이프라인)
- [docs/35_REFERENCES.md](docs/35_REFERENCES.md) — 레퍼런스 분석·차용 원칙
- [docs/40_ART_AUDIO_TEXT.md](docs/40_ART_AUDIO_TEXT.md) — V2 아트 바이블 (팔레트·캐릭터·사운드·텍스트)
- [docs/41_PIXEL_ART.md](docs/41_PIXEL_ART.md) — 픽셀 제작 규격·파이프라인·작화 매뉴얼
- [docs/42_VISUAL_HOOK.md](docs/42_VISUAL_HOOK.md) — 비주얼 후킹·마케팅
- [docs/43_ART_COMPETITIVE_RESEARCH.md](docs/43_ART_COMPETITIVE_RESEARCH.md) — 2026 도구·커뮤니티 조사, 아트 감정·재설계·AI-slop 검수
- [docs/45_UI_UX.md](docs/45_UI_UX.md) — UI/UX·화면 연출
- [docs/46_UX_EVALUATION.md](docs/46_UX_EVALUATION.md) — UX 휴리스틱 평가·정보 설계 감사 (매직 넘버 7 등 UX 법칙 기준)
- [docs/50_PRODUCTION.md](docs/50_PRODUCTION.md) — 일정·게이트·리스크
- [docs/90_STATUS.md](docs/90_STATUS.md) — 구현 상태 (SPEC/STATUS 분리)
- [docs/adr/](docs/adr/) — 설계 결정 기록
- [docs/CHANGELOG.md](docs/CHANGELOG.md) — 변경 이력
- 동결 원문: [docs/archive/](docs/archive/) — V2 설계 통합본, 아트·비주얼 리팩터링, 1.44MB 레퍼런스 분석, V1 정본(v1-last-live/), 구 단일 스펙

## 빌드

Visual Studio Build Tools 2022의 Desktop C++ 워크로드와 Python 3이 필요하다. 빌드가 [art/](art/)의 PNG·내장 자산을 먼저 재생성한다.

```bat
build.bat test
build.bat sim1000
build.bat
```

릴리스는 `out/ECHO144.EXE` 하나이며, 빌드가 전체 제출 용량·허용 DLL·결정론 SHA-256을 검사한다. `build.bat test`는 이동·덱·링·턴 경계, P1 카드·의도·시크 개입·최종 방송/엔딩, 무적 처리량과 실제 피격 7정책×30 seed SIM을 검사한다. `build.bat sim1000`은 처리량 SIM을 1,000시드로 확장한다. `build.bat package`는 DEV 실행 파일과 안내문을 플레이테스트 zip으로 만든다. 디버그 빌드는 실행 파일 옆 `playtest_v2.csv`, 일반 빌드는 60B `ECHO144.SAV`를 사용하며 쓰기 실패 시에도 플레이를 계속한다.

## 조작 (V2 P1)

- 타이틀: `Enter` 일반 채널, `F2` 오늘의 채널, `Esc` 종료
- 공통: `WASD`·방향키 이동/선택, `M` 음소거, `F1` 저자극, `Esc` 일시정지
- 편성: `Enter` 송신/수신 또는 프로그램 편성, `Space` 탐색, `Tab` 송출
- 송출: `Space` 다음 편성 발동
- 휴식: `Enter` 구매/정리, `Tab` 넘김, 8턴부터 `O` 열린 채널
- 열린 채널: `Space` 최종 방송 프로토콜
