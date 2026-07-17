#!/usr/bin/env python3
# px_portraits.py - 48x48 초상 3장의 베이스 지오메트리 생성기.
# 산출물 assets/px/portrait_*.px 가 정본이며, 생성 후 손 튜닝이 들어갈 수 있다.
# 재생성 시 기존 파일을 덮어쓰므로 주의. 규격: docs/41_PIXEL_ART.md (디더는 면에만, 눈·윤곽 금지)
import math
import os

W = H = 48


def blank():
    return [["." for _ in range(W)] for _ in range(H)]


def px(g, x, y, c):
    if 0 <= x < W and 0 <= y < H:
        g[y][x] = c


def ellipse(g, cx, cy, rx, ry, c):
    for y in range(H):
        for x in range(W):
            dx = (x - cx) / rx
            dy = (y - cy) / ry
            if dx * dx + dy * dy <= 1.0:
                g[y][x] = c


def ellipse_band(g, cx, cy, rx, ry, c, inner=0.0):
    # inner<r<=1 링 영역만 칠한다
    for y in range(H):
        for x in range(W):
            dx = (x - cx) / rx
            dy = (y - cy) / ry
            r = dx * dx + dy * dy
            if inner * inner < r <= 1.0:
                g[y][x] = c


def dither(g, x0, y0, x1, y1, c, base=None, phase=0):
    # 2x1 체커: (x+y+phase)%2==0 인 픽셀만 c로. base가 지정되면 그 색 위에만.
    for y in range(y0, y1 + 1):
        for x in range(x0, x1 + 1):
            if 0 <= x < W and 0 <= y < H and (x + y + phase) % 2 == 0:
                if base is None or g[y][x] == base:
                    g[y][x] = c


def rect(g, x0, y0, x1, y1, c):
    for y in range(y0, y1 + 1):
        for x in range(x0, x1 + 1):
            px(g, x, y, c)


def hline(g, x0, x1, y, c):
    for x in range(x0, x1 + 1):
        px(g, x, y, c)


def vline(g, x, y0, y1, c):
    for y in range(y0, y1 + 1):
        px(g, x, y, c)


def save(path, g, palette, title):
    lines = [f"# {title}", f"# palette: {palette}"]
    lines += ["".join(row) for row in g]
    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    print("wrote", path)


def portrait_echo():
    g = blank()
    # 어깨/재킷: 흰 재킷 + 오른쪽 청록 패널
    ellipse(g, 24, 56, 22, 16, "3")
    rect(g, 30, 42, 45, 47, "2")             # 오른쪽 청록 패널
    dither(g, 4, 42, 14, 47, "1", base="3")  # 왼쪽 재킷 음영 디더
    hline(g, 17, 33, 41, "1")                # 재킷 칼라 라인
    # 뒷머리(청록 큰 덩어리)
    ellipse(g, 24, 18, 17, 16, "2")
    rect(g, 8, 18, 14, 34, "2")              # 왼쪽 머리 커튼
    rect(g, 36, 18, 42, 30, "2")             # 오른쪽 머리 커튼(짧게)
    # 왼쪽 롱 스트랜드
    for i, (sx, w) in enumerate([(8, 4), (7, 4), (7, 3), (6, 3), (6, 3), (5, 3), (5, 2), (5, 2), (6, 2)]):
        rect(g, sx, 34 + i, sx + w - 1, 34 + i, "2")
    # 얼굴(광)
    ellipse(g, 25, 22, 11, 12, "3")
    # 앞머리: 이마를 덮는 청록 뱅, 오른쪽으로 비스듬
    for x in range(14, 37):
        yb = 14 + (x - 14) // 6 - (2 if 22 <= x <= 25 else 0)
        for y in range(8, yb + 1):
            if g[y][x] == "3":
                g[y][x] = "2"
    # 머리 하이라이트(광): 정수리 좌측 사선 셰인 두 조각 — 이마 밴드 금지(노이즈 방지)
    dither(g, 13, 5, 19, 6, "3", base="2")
    dither(g, 21, 4, 24, 5, "3", base="2")
    # 머리 음영(어둠 디더, 커튼 안쪽)
    dither(g, 9, 26, 11, 34, "1", base="2")
    dither(g, 39, 24, 42, 30, "1", base="2")
    # 눈: 크고 둥글게 - 위 속눈썹 2px, 청록 홍채, 다크 동공, 광 하이라이트 1px
    for ex in (17, 29):
        hline(g, ex, ex + 5, 20, "1")
        hline(g, ex, ex + 5, 21, "1")
        rect(g, ex, 22, ex + 5, 26, "2")      # 홍채
        rect(g, ex + 2, 23, ex + 3, 26, "1")  # 동공
        px(g, ex + 1, 22, "3")                # 하이라이트
        hline(g, ex + 1, ex + 4, 27, "1")     # 아래 라인
    # 눈썹
    hline(g, 17, 21, 17, "1")
    hline(g, 30, 34, 17, "1")
    # 코 / 입(열린 미소 곡선)
    px(g, 26, 28, "1")
    px(g, 22, 30, "1")
    hline(g, 23, 27, 31, "1")
    px(g, 28, 30, "1")
    # 턱 라인(선택적 아웃라인: 얼굴-목 분리)
    for x in range(21, 30):
        yy = 22 + int(12 * math.sqrt(max(0.0, 1 - ((x - 25) / 11) ** 2)))
        px(g, x, min(yy, 34), "1")
    # 얼굴 볼륨(광원 좌상 가정): 우측 엣지 청록 휴시프트 그림자 + 턱 아래 반사
    dither(g, 34, 20, 35, 31, "2", base="3")
    dither(g, 20, 32, 30, 33, "2", base="3")
    # (절제 패스: 볼 홍조 제거 — 장식 밀도 후킹 금지, 40 §1)
    # 끊긴 링 헤어 액세서리(우상단, 광) - 끊김은 작은 노치 1개
    ellipse_band(g, 39, 8, 5, 5, "3", inner=0.80)
    rect(g, 43, 7, 44, 9, ".")
    # 목
    rect(g, 22, 35, 28, 40, "3")
    dither(g, 22, 38, 28, 40, "1", base="3")
    save("assets/px/portrait_echo_48.px",
         g, "1=1a1626 2=4ddbc8 3=f2f0e6",
         "portrait_echo_48 - 에코 일사사 초상 (생성 베이스 + 손 튜닝)")


def portrait_seek():
    # 원점 재설계(40 §1 "낮고 둥근 검정"): 웅크린 둥근 다크 실루엣에서 강렬한 호박
    # 눈이 내다본다. 데드팬 — 애교·홍조·클립·송곳니 제거. 손상까지 붙잡는 관찰자.
    # 반복 도형=깨진 버퍼 링(세그먼트=로딩), 비대칭=오른쪽 케이블이 김.
    g = blank()
    ellipse(g, 24, 44, 23, 20, "1")            # 큰 둥근 다크 몸(낮게, 하단을 채움)
    ellipse(g, 23, 30, 11, 10, "3")            # 얼굴(광): 다크 안에서 내다봄
    for x in range(11, 37):                     # 후드/앞머리로 이마를 깊게 덮음(웅크림)
        for y in range(20, 26):
            if g[y][x] == "3":
                g[y][x] = "1"
    for y in range(26, 42):                     # 볼 양옆을 어둠이 감싸 얼굴을 좁게 + 부드러운 턱
        for x in range(11, 37):
            if g[y][x] == "3" and abs(x - 23) > max(3, 9 - (y - 26) // 2):
                g[y][x] = "1"
    # 호박 반개 눈(강렬·데드팬): 낮은 꺼풀, 캐치라이트 최소
    for ex in (16, 25):
        hline(g, ex, ex + 5, 27, "1")           # 위 반개 꺼풀(깊게)
        rect(g, ex, 28, ex + 5, 30, "2")        # 호박 홍채(가늘게)
        vline(g, ex + 2, 28, 30, "1")           # 동공
        px(g, ex + 1, 28, "3")                  # 캐치라이트 1px
        hline(g, ex + 1, ex + 4, 31, "1")       # 아래 라인
    hline(g, 21, 26, 34, "1")                   # 입: 작고 평평(데드팬)
    # 깨진 버퍼 링: 다크 돔 둘레 세그먼트(로딩), 2곳 끊김 — 반복 도형
    for a in range(0, 360, 15):
        if 18 < a < 66 or 200 < a < 248:        # 우상단·좌하단 끊김
            continue
        rad = math.radians(a)
        x = int(round(24 + 20 * math.cos(rad)))
        y = int(round(39 - 17 * math.sin(rad)))
        if 0 <= x < 48 and 0 <= y < 48 and g[y][x] in (".", "1"):
            px(g, x, y, "2")
    # 리본 케이블: 끊긴 분절 (비대칭 — 오른쪽이 길게)
    px(g, 43, 34, "2"); px(g, 44, 37, "2"); px(g, 43, 40, "2"); px(g, 44, 43, "2")
    px(g, 4, 41, "2"); px(g, 3, 44, "2")
    save("assets/px/portrait_seek_48.px",
         g, "1=1a1626 2=e5a84b 3=f2f0e6",
         "portrait_seek_48 - 시크 웜 초상 (원점 재설계: 낮고 둥근 검정, 데드팬)")


def portrait_format():
    # 전면 재설계(인물·모에화): 차가운 격식 미소녀(쿠데레/영애). 얼굴을 크게 드러내고
    # 입을 보이며(마스크 느낌 제거), 베일=진행 막대는 하이칼라로 이동. 히메컷·자홍 반개
    # 눈·흰 장갑·수직 제복 정체성 유지.
    g = blank()
    # 어깨 + 세운 하이칼라(다크)
    ellipse(g, 24, 55, 20, 12, "1")
    rect(g, 16, 39, 32, 48, "1")
    # 긴 히메 뒷머리(수직 커튼) + 정수리 → 그 위에 큰 얼굴
    rect(g, 9, 13, 39, 47, "1")
    ellipse(g, 24, 21, 16, 15, "1")
    ellipse(g, 24, 25, 11, 13, "3")            # 얼굴(광): 세로 오벌(자연스러운 슬림)
    for y in range(32, 40):                     # 턱: 부드러운 V — 뾰족하지도 통통하지도 않게
        halfw = max(4, 10 - (y - 31))
        for x in range(48):
            if g[y][x] == "3" and abs(x - 24) > halfw:
                g[y][x] = "1"
    # 히메 앞머리: 일자 블런트 뱅(이마를 곧게 덮음)
    for x in range(12, 37):
        for y in range(6, 18):
            if g[y][x] == "3":
                g[y][x] = "1"
    # 히메 사이드록: 얼굴 양옆 곧은 다크 록(어깨까지, 히메컷 특유)
    rect(g, 10, 16, 14, 43, "1")
    rect(g, 34, 16, 38, 43, "1")
    # 자홍 반개 눈(차갑고 우아): 낮은 반개 꺼풀 + 캐치라이트 + 바깥 속눈썹
    for ex in (16, 26):
        hline(g, ex, ex + 5, 23, "1")          # 반개 꺼풀(낮게 = 도도)
        rect(g, ex, 24, ex + 5, 26, "2")       # 자홍 홍채
        vline(g, ex + 2, 24, 26, "1")          # 동공
        vline(g, ex + 3, 24, 26, "1")
        px(g, ex + 1, 24, "3")                 # 캐치라이트
        hline(g, ex + 1, ex + 4, 27, "1")      # 아래 라인
    px(g, 14, 22, "1"); px(g, 15, 22, "1")     # 왼눈 바깥 속눈썹
    px(g, 32, 22, "1"); px(g, 33, 22, "1")     # 오른눈 바깥 속눈썹
    # 눈썹(곧고 가늘게 — 도도한 냉정)
    hline(g, 16, 20, 21, "1"); hline(g, 27, 31, 21, "1")
    # 코 점 + 작은 무표정 입(한쪽만 살짝 올린 냉소)
    px(g, 24, 29, "1")
    hline(g, 22, 25, 31, "1"); px(g, 26, 30, "1")
    # 냉정 캐릭터 — 볼 홍조·뺨 얼룩 생략, 깔끔한 창백 얼굴 유지
    # 하이칼라 진행 막대(자홍, 75% 채움) — 베일 정체성을 칼라로 이동
    rect(g, 16, 40, 32, 43, "1")
    hline(g, 16, 32, 40, "2"); hline(g, 16, 32, 43, "2")
    vline(g, 16, 40, 43, "2"); vline(g, 32, 40, 43, "2")
    rect(g, 17, 41, 28, 42, "2")               # 75% 채움
    # 좌측 실루엣 역광 림(비대칭) — (절제: 염색 팁 제거, 장식 밀도 금지)
    vline(g, 9, 14, 44, "2")
    save("assets/px/portrait_format_48.px",
         g, "1=1a1626 2=ed4f9a 3=f2f0e6",
         "portrait_format_48 - 포맷 제로 초상 (원점 재설계: 차가운 격식·데드팬, 절제)")


if __name__ == "__main__":
    os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
    portrait_echo()
    portrait_seek()
    portrait_format()
