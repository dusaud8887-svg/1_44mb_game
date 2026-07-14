# 에코/144 — LAST LIVE

Windows 10/11용 1.44MB 덱빌딩 서바이버다. 문서 정본은 다음과 같다.

- [docs/00_VISION.md](docs/00_VISION.md) — 비전·기둥·재미 명제 (문서군 입구)
- [docs/10_MECHANICS.md](docs/10_MECHANICS.md) — 규칙 명세
- [docs/20_BALANCE.md](docs/20_BALANCE.md) — 모든 튜닝 수치의 단일 정본
- [docs/30_TECH.md](docs/30_TECH.md) — 기술 설계·구현 현황·테스트
- [docs/40_ART_AUDIO_TEXT.md](docs/40_ART_AUDIO_TEXT.md) — 아트·사운드·텍스트
- [docs/50_PRODUCTION.md](docs/50_PRODUCTION.md) — 일정·게이트·리스크
- [docs/CHANGELOG.md](docs/CHANGELOG.md) — 변경 이력. 구 단일 스펙은 `docs/archive/`에 동결

## 빌드

Visual Studio Build Tools 2022의 Desktop C++ 워크로드가 필요하다.

```bat
build.bat test
build.bat
```

릴리스는 `out/ECHO144.EXE` 하나이며, 빌드가 전체 제출 용량·의존 DLL·SHA-256을 출력한다.

`build.bat test`는 결정론, 덱·카드·SIGNAL 경계값, 9회 NODE를 포함한 6+1분
전체 런, 승패·재초기화, 최악 충돌 부하를 검사한다. 외부 사람이 필요한 G1/G2
재미 테스트와 새 Windows PC·Defender·제출 폼 검증은
[docs/50_PRODUCTION.md](docs/50_PRODUCTION.md)의 게이트·체크리스트로 별도 수행해야 한다.

## 조작

- `Enter`: 시작·구매·다음 런
- `WASD` / 방향키: 이동·선택
- `Space`: 손패당 한 번 SEEK
- `F`: 4:30 이후 NODE에서 GO LIVE
- `Esc`: 일시정지·패스·뒤로
- `M`: 음소거
- `F1`: 저자극 모드
- `F2`: 타이틀에서 TODAY 시드
