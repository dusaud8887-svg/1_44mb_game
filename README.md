# 에코/144 (ECHO144.EXE)

Windows 10/11용 1.44MB 덱빌딩 서바이버. **문서는 V2 재설계 정본이고, 현재 코드는 V1을 구현하고 있다** — 상태는 [docs/90_STATUS.md](docs/90_STATUS.md)가 정본, 경로 결정은 [docs/50_PRODUCTION.md](docs/50_PRODUCTION.md)의 go/no-go 게이트.

- [docs/00_VISION.md](docs/00_VISION.md) — 비전·장르·약속·기둥 (문서군 입구)
- [docs/05_WORLD.md](docs/05_WORLD.md) — 세계관 정본
- [docs/06_CHARACTERS.md](docs/06_CHARACTERS.md) — 캐릭터 바이블 (에코·시크·노아)
- [docs/10_MECHANICS.md](docs/10_MECHANICS.md) — 규칙 명세
- [docs/15_CARDS.md](docs/15_CARDS.md) — 카드 설계
- [docs/20_BALANCE.md](docs/20_BALANCE.md) — 모든 튜닝 수치의 단일 정본
- [docs/30_TECH.md](docs/30_TECH.md) — 기술 설계 (P0 결함·아키텍처·파이프라인)
- [docs/35_REFERENCES.md](docs/35_REFERENCES.md) — 레퍼런스 분석·차용 원칙
- [docs/40_ART_AUDIO_TEXT.md](docs/40_ART_AUDIO_TEXT.md) — V2 아트 바이블 (팔레트·캐릭터·사운드·텍스트)
- [docs/41_PIXEL_ART.md](docs/41_PIXEL_ART.md) — 픽셀 제작 규격·파이프라인·작화 매뉴얼
- [docs/42_VISUAL_HOOK.md](docs/42_VISUAL_HOOK.md) — 비주얼 후킹·마케팅
- [docs/45_UI_UX.md](docs/45_UI_UX.md) — UI/UX·화면 연출
- [docs/50_PRODUCTION.md](docs/50_PRODUCTION.md) — 일정·게이트·리스크
- [docs/90_STATUS.md](docs/90_STATUS.md) — 구현 상태 (SPEC/STATUS 분리)
- [docs/adr/](docs/adr/) — 설계 결정 기록
- [docs/CHANGELOG.md](docs/CHANGELOG.md) — 변경 이력
- 동결 원문: [docs/archive/](docs/archive/) — V2 설계 통합본, 아트·비주얼 리팩터링, 1.44MB 레퍼런스 분석, V1 정본(v1-last-live/), 구 단일 스펙

## 빌드

Visual Studio Build Tools 2022의 Desktop C++ 워크로드가 필요하다.

```bat
build.bat test
build.bat
```

릴리스는 `out/ECHO144.EXE` 하나이며, 빌드가 전체 제출 용량·의존 DLL·SHA-256을 출력한다. `build.bat test`는 결정론, 덱·카드 경계값, 전체 런, 승패·재초기화, 최악 충돌 부하, SIM 몬테카를로를 검사한다.

## 조작 (현행 V1 빌드 기준)

- `Enter`: 시작·구매·다음 런 / `WASD`·방향키: 이동·선택 / `Space`: SEEK
- `F`: 4:30 이후 NODE에서 GO LIVE / `Esc`: 일시정지·패스 / `M`: 음소거 / `F1`: 저자극 / `F2`: TODAY 시드

V2 조작 계획(EDIT 편성, Space 수동 발동)은 [docs/10_MECHANICS.md](docs/10_MECHANICS.md) §2~4.
