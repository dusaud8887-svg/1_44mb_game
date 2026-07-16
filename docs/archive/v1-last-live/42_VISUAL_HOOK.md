# 42 — 비주얼 후킹·마케팅·AI 프롬프트

[40_ART_AUDIO_TEXT.md](40_ART_AUDIO_TEXT.md)의 아트 방향과 [41_PIXEL_ART.md](41_PIXEL_ART.md)의 제작 규격을 전제로, **어떻게 보는 이를 붙잡고 파고들게 만들 것인가**를 정의한다. 대상: 스팀 캡슐·itch 커버·소셜 썸네일 같은 마케팅 표면, 그리고 그 경쟁력을 낳는 기법. 인게임 자산은 여전히 인하우스 픽셀(41)로 제작하며, 이 문서의 AI 프롬프트는 **마케팅 키아트 착상·무드 탐색 전용**이다(§5 경계 참조).

## 1. 후킹의 핵심 — 채우지 말고 비워라

이 게임의 무기는 화려함이 아니라 **미스터리**다. 확정 사실 4개와 답하지 않을 질문 3개(40 §5)가 서사의 뼈대이고, "시청자는 1이고 곧 NO CARRIER"라는 공백이 사람을 파고들게 한다. 비주얼도 같은 원리를 따른다.

- **네거티브 스페이스가 상상력을 고용한다**: 보이지 않을 때 더 무섭고 더 궁금하다. 관객의 상상은 어떤 작가보다 강력하다 — 몬스터는 안 보일 때 가장 무섭다. 화면을 채우는 대신 **전략적으로 지운다**: 상세 환경을 먼저 세우고 → 감정을 나르는 핵심만 남기고 → 나머지를 조명·그림자로 가린다([Wayline: Negative Space in Game Design](https://www.wayline.io/blog/negative-space-game-design), [Into The Spine: In Praise of Negative Space](https://intothespine.com/2021/03/27/in-praise-of-negative-space-in-video-game-storytelling/)).
- **본작의 실행**: 키아트에서 **SEEK는 어둠 속 눈 하나로만** 존재한다. 몸은 그리지 않는다. 깨진 버퍼 링 조각 2~3px만이 "둥근 무언가가 거기 있다"는 유일한 단서다. 시청자 1이 누구인지 — 악성 팬인가, 유일한 시청자인가, 이전 ECHO인가(40 §5 불답) — 를 **이미지가 답하지 않고 질문으로 남긴다.**
- **대비가 시선을 수술한다**: 인간 지각은 대비를 좇는다. 어둠 속 빛점, 단순함 속 디테일. 어두운 배경(`100d18`) 위 청록 히어로 하나, 그 반대편 어둠 속 호박 눈 하나 — 시선 동선이 ECHO→빔→눈으로 자동으로 흐른다.

## 2. 갭모에 — 모에 요소의 조합과 그 사이의 틈

오타쿠 어필은 요소를 **쌓는** 것이 아니라 **어긋내는** 것에서 나온다. 요소 조합 + 그 사이의 공백이 캐릭터를 입체로 만든다.

| 캐릭터 | 조합되는 모에 요소 | 의도적 갭(틈) |
|---|---|---|
| 에코 | 큰 둥근 눈·비대칭 롱헤어·당당한 미소·라이브 텐션 | 밝고 명랑한데 "시청자 1"·곧 끊김 — 명랑함 아래 소멸의 예감 |
| 시크 | 낮고 둥근 실루엣·외눈 삼백안·송곳니 미소·반개 시선 | 붙잡는 자인데 지켜보기만 — 애정인지 집착인지 미확정 |
| 포맷 | 히메컷 수직 제복·자홍 발광 눈·과잉 정중한 존댓말 | 종료를 집행하는데 "불편을 드려 유감" — 사무적 다정함의 오싹함 |

- **눈이 갭의 무대**: 41 §7의 눈 문법(에코 둥글게 / 시크 삼백안 / 포맷 발광 반개)이 각 캐릭터의 "읽히지 않는 한 겹"을 만든다. **무표정·반개·발광**은 한국 커뮤니티에서 갭모에의 핵심 장치로 통용된다 — 감정을 다 보여주지 않아 관객이 채운다.
- **머리카락이 정체성의 절반**(41 §1): 실루엣 차별화는 헤어 셰이프로. 조합은 명료하게, 사이는 비워서.
- **"한 프레임의 잘못된 연도"**(40 §1): 조각 속 글리치 1px, 1997이라는 틀린 시간 — 완벽한 그림에 낸 한 틈이 서사 전체를 암시한다.

## 3. 마케팅 비주얼 경쟁력 — 키아트 규격

정본 키아트: [keyart_last_live.px](../assets/px/keyart_last_live.px)(3인 앙상블) + 캐릭터 단독 컷 [keyart_seek.px](../assets/px/keyart_seek.px)·[keyart_format.px](../assets/px/keyart_format.px). 생성기 `tools/px_keyart.py`, 렌더 `python3 tools/px_render.py assets/px/keyart_seek.px --scale 3`. 192×108 저해상 원본 → 정수배 업스케일로 각 표면에 대응.

**메인 키아트** [keyart_main.px](../assets/px/keyart_main.px)(256×160): 3인·관계·배경·컨셉·상황을 한 장에. **FORMAT**이 위에서 종료 75% 카운트다운과 함께 강림(위협) / **ECHO**가 중앙에서 SIGNAL 64 게이지로 송출 빔을 쏘아 올림(LAST LIVE) / **SEEK**이 우하단 어둠에서 지켜보며 점선 시선이 ECHO로 이어짐(유일한 시청자). 무대는 거대한 A:\ 플로피 원반, 1997 글리치·표류 조각·A:\> 프롬프트. 세 초상을 재사용하되 위치·시선·빔으로 **관계와 상황**을 만든다(위=종결 위협, 중앙=송출 주체, 아래=관찰자).

**캐릭터 단독 컷 — 정체성 = 구도**: 앙상블 키아트를 나눈 게 아니라 캐릭터의 동사(40 §1)를 구도로 번역한다.
- **에코("송출한다")**: 좌측 히어로 + 우측 어둠의 SEEK 눈. 신호가 어둠으로 나간다.
- **시크("지켜본다")**: 우측 거대한 외눈이 **왼쪽 어둠의 작은 청록 신호 하나를 응시**. 신호가 시크 왼쪽 실루엣을 청록으로 물들이는 역광. "저는 세 번째부터 봤습니다"를 눈의 방향으로 말한다 — 무엇을 보는지는 프레임 밖.
- **포맷("닫는다")**: 감금실 같은 수직 실루엣 + 우측 **종료 진행 75% 막대**(FORMAT 경고 임계와 같은 숫자, 상단 25%는 비어 있는 카운트다운) + 떠 있는 글리치된 `1997`. 최대 네거티브 스페이스·최냉색.

- **캔버스와 스케일**: 192×108(16:9)에서 3×=576×324 ≈ 스팀 헤더/메인 캡슐 근사, 정수배라 뭉개짐 없음. 소셜 OG는 크롭. **저해상에서 완성하고 확대**하는 것이 픽셀 마케팅의 정석(축소가 아니라 확대라야 격자가 산다).
- **썸네일 생존 법칙**: 1× 썸네일에서도 (a) 청록 히어로 실루엣 (b) 반대편 빛 하나 (c) 대각 빔 — 3요소가 읽혀야 통과. 검수는 1×·3× 동시 렌더로 한다(41 §5 실크기 검증의 마케팅판).
- **구도**: 좌측 1/3 히어로(에코 초상 2×) + 역광 글로우, 중앙은 **비운다**(로고 자리 + 네거티브 스페이스), 우측 어둠에 SEEK 눈. A:\ 플로피 원반은 희미한 대형 링 1개로만 암시. 좌하단 `A:\>` 커서로 1997·플로피 톤 고정.
- **로고는 별 레이어**: 키아트는 로고 없이 넘긴다. `에코/144 — LAST LIVE` 워드마크는 중앙 상단 또는 하단 네거티브 스페이스에 레이아웃 단계에서 얹는다 — 키아트에 텍스트를 굽지 않아 다국어·비율 대응이 자유롭다.
- **브랜드 일관성**: 마케팅 확장 팔레트도 40 §2의 논리 9색에서만 뽑는다(+글로우 중간톤 2). 인게임 3색 규율과 시각적으로 한 몸.
- **모션 파생 `[구현 ✅]`**: 정지 키아트에서 커서 깜빡임·글로우 맥동·조각 표류만 애니메이트해 소셜용 루프 GIF를 만든다(6프레임, 40 §1 모션 문법 재사용). 생성 `python3 tools/px_gif.py` → `assets/px/keyart_loop.gif`. GIF 인코더 `tools/px_gif.py`는 stdlib만으로 GIF89a·LZW·NETSCAPE 루프를 직접 쓰며, LZW 라운드트립 자기검증(`--selftest`)으로 정확성을 보장한다. `.px`가 이미 인덱스 컬러라 GIF가 자연스러운 포맷. (렌더 산출물이므로 `.gitignore`, 재생성 가능.)

## 4. 픽셀 기법 — 3색 제약 안에서 아름다움을 뽑는 법

- **휴시프트 램프**(이미 적용, 41 §3): 그림자를 그냥 어둡게 하지 않고 **색상을 함께 돌린다**. 본작 램프 `1a1626`(차가운 퍼플 그림자) → 캐릭터 강조색(채도 정점) → `f2f0e6`(따뜻한 흰 광)은 3스텝 휴·채도 시프트 그 자체다. "차가운 그림자 / 따뜻한 광"이 원칙([Pedro Medeiros, Pixel Grimoire](https://medium.com/pixel-grimoire/how-to-start-making-pixel-art-6-a74f562a4056), [Lightcube: Color Ramps](https://www.lightcube.art/documentation/palettes/color-ramps/)). 100% 채도 금지, 넓은 저채도 면 + 작은 고채도 디테일.
- **림라이트(역광)**: 주광 반대쪽 가장자리에 밝은 테. 코어는 어둡게 유지해야 앰비언트 필과 구분된다. 키아트에서 ECHO 오른쪽·아래 실루엣에 청록/흰 1px 역광을 실루엣 **바깥** 배경 픽셀에 얹어 "채널 불빛에 물든" 인물을 만든다(41 §1 CRT 듀오톤의 확장).
- **세컨더리 모션**(40 §1 이미 명세, 도구화): 머리·케이블·베일이 몸보다 **늦게** 따라온다. 에코 대기 A/B의 링 1px 지연이 최소 구현. 32×32 여유가 없는 16×16에선 **1px 지연 한 곳**이 살아 있음의 전부다([Sprite-AI: 12 principles](https://www.sprite-ai.art/guides/animation-principles), [Tiny Warrior: Sub-Pixel Animation](https://tinywarriorgames.com/2019/01/04/game-development-pixel-art-sub-pixel-animation/)).
- **서브픽셀·스미어**: 느린 인/아웃과 가장 미묘한 움직임에만 서브픽셀. 빠른 전환엔 스미어(모션블러 흉내 인비트윈)로 픽셀을 늘였다 줄인다. 포맷의 수직 1px 슬라이드가 서브픽셀 계열.
- **디더 규율**(41 §1): 2×1 체커는 **면에만**. 얼굴 윤곽·눈에는 금지(뭉개짐). 초상에서 재킷 음영·베일 하단·글로우 페이드가 디더 대상. 16×16 스프라이트는 디더 전면 금지.
- **셀렉티브 아웃라인**: 전면 윤곽선 금지. 배경과 닿는 밝은 면에만 어둠 1px. 어두운 배경 위에선 어둠(1)이 실루엣 역할을 겸한다.

## 5. AI 프롬프트 부록 — 마케팅 착상 전용

> **경계(반드시 지킨다).** 인게임 자산은 41의 인하우스 루프로만 만든다. AI는 **키아트 무드·구도 착상, 색 시험, 포즈 레퍼런스**에만 쓴다. 산출 이미지를 그대로 제출물에 넣지 않는다. 40 §1의 금지(실제 작품·서비스·OS 재현, 교복·메이드·고양이귀 등)와 생존 작가 화풍 카피 금지를 AI 출력에도 동일 적용한다 — 착상은 훔쳐도 픽셀은 손으로 찍는다.

한국 커뮤니티(아카라이브 AI그림 채널, 디시 등)의 실전 문법은 미드저니 자연어보다 **danbooru 태그 기반**이 주류다: NovelAI v4/v4.5, Illustrious·NoobAI·Pony 계열 체크포인트. 태그를 콤마로 쌓아 장면을 조립한다.

**태그 배치 순서**(커뮤니티 통용): 품질 → 작가 → 캐릭터 수 → 외형(헤어·눈) → 의상 → 표정 → 포즈·구도 → 배경 → 조명·분위기. 몸/구도는 앞, 채색/분위기는 중간, 눈/디테일은 뒤에 둔다.

**품질 태그 스택**(모델별):
- NovelAI v4.5: `masterpiece, best quality, amazing quality, very aesthetic, absurdres`
- Illustrious/NoobAI: `masterpiece, best quality, newest, absurdres, highres`
- 가중치: NAI는 `{tag}`(1.05×/중괄호)·`[tag]`(감소), SD 계열은 `(tag:1.2)`. 작가 블렌딩은 `artist:A, artist:B`를 섞고 비중은 가중치로 — 특정 화풍이 과하면 `(artist:A:0.7)`로 눌러 **여러 작가의 평균**을 낸다(카피 회피에도 유효).

**부정 프롬프트(undesired) 기본값**: `lowres, worst quality, low quality, bad anatomy, bad hands, extra digits, fewer digits, text, signature, watermark, username, jpeg artifacts, blurry`. 노출은 40 §1 준수로 원천 배제.

**본작 무드용 개념 태그**(갭모에·미스터리·CRT):
- 갭·시선: `expressionless, half-closed eyes, empty eyes, sanpaku, looking at viewer, backlighting, rim lighting`
- 레트로·글리치: `retro artstyle, pc-98, limited palette, dithering, chromatic aberration, scanlines, crt screen, glitch`
- 구도·분위기: `dutch angle, from below, dramatic shadow, cinematic lighting, dark background, lens flare (약하게)`

**본작 캐릭터 레시피 예시**(그대로 제출 금지, 착상용):

```text
# 에코 키아트 무드 (Illustrious 계열)
masterpiece, best quality, newest, absurdres,
(artist:A:0.8), (artist:B:0.6),
1girl, solo, teal hair, asymmetrical hair, long side strand, broken ring hair ornament,
white asymmetrical jacket, teal accent, big round eyes, gentle open smile,
upper body, looking at viewer, backlighting, rim lighting, teal glow,
dark background, crt screen, scanlines, retro artstyle, limited palette,
floating magenta data fragments, cinematic lighting
Negative: lowres, worst quality, bad hands, text, watermark, nsfw, school uniform, cat ears

# 시크 — 네거티브 스페이스(눈만)
..., 1girl, hidden body, single visible eye, amber eye, sanpaku, half-closed eyes,
looking at viewer, mostly dark, broken buffer ring fragment, extreme negative space,
dark background, dramatic shadow, backlighting
```

**착상 → 픽셀 이행**: AI 출력에서 취하는 것은 **구도·명암 배치·색 온도**뿐. 그 위에서 41 §5의 5단계 루프(실루엣→램프→렌더 검수→실크기→emit)로 손 제작한다. AI가 준 것이 "무엇을 그릴지"라면, 41이 정하는 것은 "어떻게 읽히게 찍을지"다.

- 참고: [NovelAI Quality Tags 공식 문서](https://docs.novelai.net/en/image/qualitytags/), [니지저니 OC 만들기](https://nijijourney.com/ko/blog/how-to-make-your-oc-in-niji-journey-midjourney), 아카라이브 AI그림 채널 작가태그·세팅 공유글(로그인 벽으로 직접 링크 대신 커뮤니티 관행만 요약).

## 6. 수용 기준 (마케팅 표면)

- 1× 썸네일에서 히어로 실루엣 + 반대편 빛 + 대각 동선 3요소가 읽힌다.
- SEEK는 몸이 보이지 않는다 — 눈과 링 조각만. "누가 보고 있나"가 이미지로 답해지지 않는다.
- 확장 팔레트가 40 §2 논리 9색(+글로우 2)을 벗어나지 않는다.
- 로고·텍스트는 키아트에 굽지 않고 레이어로 얹을 여백이 확보된다.
- AI 산출물이 제출물·인게임에 직접 들어가지 않는다(§5 경계).
