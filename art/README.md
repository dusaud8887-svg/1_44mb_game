# V2 픽셀 자산

`docs/40_ART_AUDIO_TEXT.md`~`docs/45_UI_UX.md`를 기준으로 다시 설계한 자산이다. `assets/px/`의 V1 파일은 사용하지 않는다.

- `export/`: 게임·배포에 쓰는 인덱스 PNG. 키아트 원본은 192×108, 확대판은 최근접 3배다.
- `review/`: 8배 캐릭터·아이콘 시트, A~F 키아트 접촉 시트, 한글 글리프 시트다.
- `tools/build_art.py`: 16색 팔레트 PNG와 `src/generated/art.inc`를 함께 생성한다.
- `tools/build_font.py`: 화면에 쓰인 한글 음절만 12×12 비트맵으로 고정한다.

## 출처 메타데이터

- artist: Claude 수작업 픽셀 설계(행 단위 런·문자 그리드) + stdlib 생성기
- concept_sources: `docs/06_CHARACTERS.md`, `40_ART_AUDIO_TEXT.md`, `41_PIXEL_ART.md`, `42_VISUAL_HOOK.md`, `45_UI_UX.md`, `43_ART_COMPETITIVE_RESEARCH.md` §11
- ai_assistance: 조사·구도/명암 아이데이션·비전 검수 루프에 사용, 생성 이미지 픽셀은 사용하지 않음
- manual_redraw: true — 캐릭터는 전부 행 단위 런/그리드 수작업, 프리미티브는 링·베일 등 기계 요소만
- source_file: `tools/build_art.py`
- approved_at: 2026-07-17 V3, 1×/4×/8× 비전 검수(초상 3~5회 반복 수렴), art.inc 계약 불변 + gcc 신택스 체크

런타임은 PNG 디코더나 시스템 글꼴을 포함하지 않는다. 빌드 때 생성한 4bpp 인덱스 배열만 사용한다.
