# 작업 노트 — 2026-07 픽셀 아트 리서치·V2 아트 제작 방법론

> **정본 아님.** [42_VISUAL_HOOK.md](../42_VISUAL_HOOK.md) §8의 규율("도구·레시피는 정본에 고정하지 않는다")에 따라
> 이 문서는 시점이 박힌 작업 노트다. 정책·경계는 40/41/42가 정본이고, 이 노트는 2026-07 시점의
> 기법 조사와 V2 자산 1차 제작의 근거 기록이다.

## 1. 조사 요약 (2026-07-17)

### 기법 — V2 제작에 채택

| 기법 | 내용 | 채택 방식 |
|---|---|---|
| **클러스터 이론** | 픽셀 1개가 아니라 2×2·2×3·L자 덩어리로 면을 설계. 소금·후추 고립 픽셀 금지 | [41](../41_PIXEL_ART.md) §4와 일치 — V1 초상의 흩어진 점 노이즈를 전량 제거 |
| **휴 시프팅** | 그림자 = 어두운 같은 색이 아니라 **색상을 한랭 쪽으로 이동** | 16색 논리 팔레트가 이미 세력별 DARK(한랭 이동)를 내장 — 피부 그림자는 DIM(한랭 회보라)으로 |
| **셀아웃(selout)** | 검은 일괄 외곽선 대신 접면 밝기에 따라 외곽선 색을 조정 | 밝은 배경 접면은 고유색 어두운 톤, 위험 접면만 BROADCAST BLACK ([41](../41_PIXEL_ART.md) §4 승계) |
| **저해상 모에 눈 문법** | **두꺼운 윗눈꺼풀 암선이 가장 강한 '애니메' 신호.** 흰자 최소·홍채 대면적, 하이라이트 1~2px, 눈꺼풀 1px 이동으로 감정 전환 | 64×64 초상 눈 높이 7~9px·홍채 4~5px, 표정 델타는 눈꺼풀·눈썹·입 1px 시프트 |
| **수동 AA 절제** | 곡선 계단에만 중간색 1~2px, 과용 시 블러 | 얼굴 윤곽·링 원호에만, 면 내부 금지 |
| **PC-98 보석색 듀오톤** | 16색·고해상 애니 초상·의도된 디더 질감·인물 클로즈업 중심 | [40](../40_ART_AUDIO_TEXT.md) §1 노스스타와 일치. 디더는 배경·그림자에만([41](../41_PIXEL_ART.md) §4 디더 규율) |
| **저해상 원본 → 정수 확대** | 마케팅 픽셀아트는 축소가 아니라 저해상 완성 후 확대라야 격자가 산다 | 키아트 192×108 원본 → 3×·4× 정수 업스케일 ([42](../42_VISUAL_HOOK.md) §3 그대로) |

### 도구 생태계 (2026-07 시점)

- **AI 픽셀 생성기**: Retro Diffusion(게임 특화 단일 모델), PixelLab(스프라이트·방향 변형·골격 애니 내장, 무료 티어) 등이 유행.
  → **본 프로젝트는 최종 자산 사용 금지**([41](../41_PIXEL_ART.md) §6, [42](../42_VISUAL_HOOK.md) §8). 구도 발산·클리셰 점검 용도로만 유효.
  이 리포지토리 환경에서는 실행 불가이므로 이번 제작에는 미사용 — **전 자산 수제(스크립트+수동 픽셀) 제작**.
- **한국 커뮤니티**: 디시 도트 마이너 갤러리에 셀아웃·기초 튜토리얼 번역이 상주. 2026년에도 라이브 픽셀 마켓(점집 등)
  오프라인 행사가 열릴 만큼 도트 신이 활황 — "도트 = 인디 감성 + 수공예 아우라"가 후킹 포인트로 유효.
- **후킹 관찰**: 모에 조합 자체보다 **"조합 사이의 틈"(갭모에)** 과 미스터리 공백이 파고들기를 만든다는 [42](../42_VISUAL_HOOK.md) §1
  원칙은 2026 커뮤니티 정서와도 부합(반개 눈·무표정·가려진 정보가 2차 창작을 부른다).

### 참고 링크

- 클러스터·AA: https://pixnote.net/en/learn/tips/ , https://lospec.com/pixel-art-tutorials/tags/antialiasing
- 휴 시프팅: https://lospec.com/pixel-art-tutorials/tags/hueshifting
- 기초 정본: https://www.derekyu.com/makegames/pixelart.html , https://pixeljoint.com/forum/forum_posts.asp?TID=11299
- 저해상 애니 눈: https://www.sandromaglione.com/articles/pixel-art-eyes-techniques-and-styles
- PC-98 분석: https://pixelglade.net.au/blog/posts/2025-08-31-Whats-unique-about-PC98-art.html , https://lospec.com/palette-list/tag/pc98
- 도구 동향: https://retrodiffusion.ai/ , https://www.sprite-ai.art/blog/best-pixel-art-generators-2026
- 한국 커뮤니티: https://m.dcinside.com/board/pixelart (도트 마이너 갤러리, [번역] 튜토리얼 시리즈)

## 2. V2 1차 제작 범위와 공정 (이 세션)

- 산출 위치: `assets/px_v2/` (V1 `assets/px/`는 현행 코드 자산이므로 불변 — [41](../41_PIXEL_ART.md) §1).
- 원본: `tools/v2/*.py` 빌더 스크립트(레이어·부위별 함수 + 수동 픽셀 리터럴). `.px`는 ADR-0008대로 **검수용 덤프**.
  이 환경에 Aseprite가 없으므로 스크립트가 원본 역할을 대행하고, 후속 작업자는 `.px`/PNG에서 Aseprite로 이관한다.
- 검수 루프: 렌더(1×·4×·8×) → 비전 검수(부위별: 실루엣/눈/입/소품 연결/노이즈) → 수정 — [41](../41_PIXEL_ART.md) §4
  "1×·3×·8× 동시 검수"의 이 세션 판.
- 팔레트: [40](../40_ART_AUDIO_TEXT.md) §3 16색 논리 팔레트를 `.px` 문자에 고정 매핑:
  `1=VOID 2=BROADCAST_BLACK 3=PANEL 4=DEEP_SLATE 5=PAPER 6=DIM 7=CYAN_DARK 8=CYAN 9=AMBER_DARK a=AMBER b=MAGENTA_DARK c=MAGENTA d=DANGER_RED e=SIGNAL_BLUE f=LAVENDER .=투명`

## 3. V1 자산 비전 검수 결과 (재설계 근거 — ADR-0008 진단의 실물 확인)

- `portrait_echo_48`: 빨간 LIVE 핀 부재(브리지 위반 — V1 3색 팔레트에 빨강 자체가 없음), 볼·배경에 소금·후추 디더,
  한쪽 수신기 부재, 링이 우상단 소형 원호로만 존재해 "끊긴 64링"으로 읽히지 않음.
- `portrait_seek_48`: 검은 덩어리+얼굴 부유. 호박 점이 물리 연결 없이 산포(=AI slop 징후 3번, [41](../41_PIXEL_ART.md) §6).
  "읽히지 않는 한쪽 눈"이 눈썹 오독. 케이블·릴·태그 부재.
- `portrait_format_48`: V2에서 캐릭터 자체가 대체됨(ADR-0003). 베일·장갑·프로필 환 부재.
- `keyart_main`: [42](../42_VISUAL_HOOK.md) §2 정본 구도(에코 최대 무게·손은 프레임 밖·노아 우상단·시크 좌하단 눈 하나)와
  불일치 — 3인 나열 구도. 시선 동선 없음.
