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
    # 볼 터치(모니터 광 홍조): 눈(y27 종료) 아래로 충분히 떨어진 작은 뭉치, 대각 스트릭 금지
    for cx0 in (15, 31):
        px(g, cx0, 30, "2"); px(g, cx0 + 1, 31, "2"); px(g, cx0 + 2, 30, "2")
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
    # 인물·모에화: "외눈"을 '머리가 한쪽 눈을 덮는' 트로프로 — 파스텔 광 얼굴 +
    # 드러난 큰 호박 ∧-스머그 눈. 정체성(호박·깨진 링·둥근 실루엣·리본 케이블) 유지.
    g = blank()
    # 낮고 둥근 어깨(다크)
    ellipse(g, 24, 54, 21, 13, "1")
    # 헤어 뒷실루엣(큰 둥근 머리) → 그 위에 큰 얼굴 → 다시 앞머리로 이마를 덮는다
    ellipse(g, 24, 22, 16, 15, "1")
    ellipse(g, 24, 26, 12, 12, "3")        # 얼굴(광), 크게 — 얼굴이 지배
    # 사이드 헤어: 얼굴 양옆을 감싸는 다크 록(오른쪽이 길게=비대칭)
    rect(g, 9, 16, 13, 36, "1"); rect(g, 35, 16, 40, 41, "1")
    # 앞머리 뱅: 이마를 덮되 가운데 가르마 + 오른쪽 눈에 살짝 걸치는 사이드 스윕
    for x in range(12, 37):
        base_b = 19 - abs(x - 24) // 4        # 가운데가 살짝 낮게(가르마 느낌)
        for y in range(8, base_b):
            if g[y][x] == "3":
                g[y][x] = "1"
    for x in range(30, 36):                   # 오른쪽 사이드 스윕: 오른눈 바깥을 살짝 덮음
        for y in range(8, 26 - (35 - x)):
            if g[y][x] == "3":
                g[y][x] = "1"
    # 두 눈(호박, 크게, ∧ 스머그 반개) — 오른쪽 눈은 사이드 스윕에 살짝 가림
    for ex in (15, 27):
        hline(g, ex, ex + 5, 22, "1")          # 위 꺼풀
        rect(g, ex, 23, ex + 5, 27, "2")       # 호박 홍채
        rect(g, ex + 2, 24, ex + 3, 27, "1")   # 동공
        px(g, ex + 1, 23, "3")                 # 하이라이트
        hline(g, ex + 1, ex + 4, 28, "1")      # 아래 라인
    px(g, 14, 21, "1"); px(g, 33, 21, "1")     # ∧ 바깥 눈꼬리 올림(양쪽, 스머그)
    px(g, 20, 23, "1"); px(g, 27, 23, "1")     # 안쪽 눈꼬리(눈 사이 간격)
    # 눈썹(살짝 치켜, 얇게)
    hline(g, 16, 19, 19, "1"); hline(g, 28, 31, 19, "1")
    # 코/입: 작은 스머그 미소 + 송곳니(광)
    px(g, 24, 31, "1")
    hline(g, 21, 27, 33, "1")
    px(g, 22, 34, "1"); px(g, 26, 34, "3")     # 송곳니
    # 볼 홍조(호박 = 모니터 광), 양볼
    px(g, 13, 30, "2"); px(g, 14, 31, "2")
    px(g, 34, 30, "2"); px(g, 33, 31, "2")
    # 깨진 버퍼 링: 머리 위 광배(호박, 우상단 끊김) — 정체성 모티프
    ellipse_band(g, 32, 6, 7, 5, "2", inner=0.72)
    for yy in range(1, 6):                      # 우상단 끊김
        for xx in range(34, 42):
            if g[yy][xx] == "2":
                g[yy][xx] = "."
    # 헤어 클립(호박, 왼쪽 사이드록)
    px(g, 11, 18, "2"); px(g, 12, 18, "2"); px(g, 11, 19, "2")
    # 리본 케이블: 오른쪽 사이드헤어에서 흘러내리다 끊김
    px(g, 39, 34, "2"); px(g, 40, 37, "2"); px(g, 39, 40, "2"); px(g, 40, 43, "2")
    # 어깨 데이터 밴드(호박 디더 1줄)
    dither(g, 14, 48, 33, 48, "2", base="1")
    save("assets/px/portrait_seek_48.px",
         g, "1=1a1626 2=e5a84b 3=f2f0e6",
         "portrait_seek_48 - 시크 웜 초상 (인물·모에화)")


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
    ellipse(g, 24, 26, 12, 12, "3")            # 얼굴(광), 크게 — 얼굴이 지배
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
    # 볼 자홍 홍조(모니터 광)
    px(g, 13, 30, "2"); px(g, 14, 31, "2")
    px(g, 34, 30, "2"); px(g, 33, 31, "2")
    # 얼굴 우측 휴시프트 그림자(볼륨)
    dither(g, 34, 23, 35, 33, "2", base="3")
    # 하이칼라 진행 막대(자홍, 75% 채움) — 베일 정체성을 칼라로 이동
    rect(g, 16, 40, 32, 43, "1")
    hline(g, 16, 32, 40, "2"); hline(g, 16, 32, 43, "2")
    vline(g, 16, 40, 43, "2"); vline(g, 32, 40, 43, "2")
    rect(g, 17, 41, 28, 42, "2")               # 75% 채움
    # 히메 사이드록 자홍 팁(염색 끝) + 좌측 실루엣 역광 림(비대칭)
    px(g, 11, 41, "2"); px(g, 12, 42, "2")
    px(g, 37, 41, "2"); px(g, 36, 42, "2")
    vline(g, 9, 14, 44, "2")
    save("assets/px/portrait_format_48.px",
         g, "1=1a1626 2=ed4f9a 3=f2f0e6",
         "portrait_format_48 - 포맷 제로 초상 (인물·모에화, 차가운 격식 미소녀)")


if __name__ == "__main__":
    os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
    portrait_echo()
    portrait_seek()
    portrait_format()
