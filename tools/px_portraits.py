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
    g = blank()
    # 몸: 낮고 둥근 다크, 프레임 하단을 가득 채움
    ellipse(g, 24, 34, 21, 17, "1")
    # 깨진 버퍼 링(호박): 몸 둘레, 우상단/좌하단 끊김
    ellipse_band(g, 24, 34, 21, 17, "2", inner=0.90)

    def body_restore(x0, y0, x1, y1):
        for y in range(y0, y1 + 1):
            for x in range(x0, x1 + 1):
                dx = (x - 24) / 21
                dy = (y - 34) / 17
                if dx * dx + dy * dy <= 1.0:
                    g[y][x] = "1"
                elif g[y][x] == "2":
                    g[y][x] = "."
    body_restore(32, 15, 47, 25)   # 우상단 끊김
    body_restore(4, 42, 12, 47)    # 좌하단 끊김
    # 몸 상단 좌측 스페큘러(호박) — 곡면을 따라 이어지는 2px 하이라이트
    px(g, 12, 26, "2"); px(g, 13, 25, "2")
    # 큰 외눈: 흰 타원 + 호박 홍채 테 + 다크 동공 + 광 하이라이트 2x2
    ellipse(g, 22, 32, 7, 8, "3")
    ellipse_band(g, 22, 32, 7, 8, "2", inner=0.78)
    ellipse(g, 23, 33, 3, 4, "1")
    rect(g, 19, 29, 20, 30, "3")
    # 반개 눈꺼풀: ∧ 곡선(가장자리를 더 덮는다)
    for x in range(14, 31):
        lid = 22 + abs(x - 22) // 2
        for y in range(18, lid + 1):
            if g[y][x] in ("3", "2") and y < 40:
                g[y][x] = "1"
    # 입: 호박 미소 + 아래로 삐친 송곳니(광)
    hline(g, 27, 33, 42, "2")
    px(g, 34, 41, "2")
    px(g, 29, 43, "3")
    # 리본 케이블: 몸 오른쪽에서 나와 아래로 끊기며 흐르는 분절(떠 있지 않게 연결)
    px(g, 41, 30, "2"); px(g, 42, 31, "2"); px(g, 43, 32, "2")   # 몸에서 이어짐
    px(g, 45, 34, "2"); px(g, 46, 35, "2")                        # 1분절
    px(g, 45, 38, "2"); px(g, 44, 39, "2")                        # 2분절(끊김)
    # 배 데이터 밴드(호박 디더 1줄)
    dither(g, 16, 44, 32, 44, "2", base="1")
    save("assets/px/portrait_seek_48.px",
         g, "1=1a1626 2=e5a84b 3=f2f0e6",
         "portrait_seek_48 - 시크 웜 초상 (생성 베이스 + 손 튜닝)")


def portrait_format():
    g = blank()
    # 긴 수직 다크 헤어 커튼 + 정수리
    rect(g, 12, 6, 35, 46, "1")
    ellipse(g, 24, 11, 13, 8, "1")
    # 얼굴(광): 좁은 세로 타원
    ellipse(g, 24, 24, 8, 11, "3")
    # 앞머리: 히메컷 일직선(이마 축소) + 비대칭(왼쪽 관자놀이 한 단 더 김)
    rect(g, 13, 4, 34, 16, "1")
    rect(g, 14, 17, 18, 18, "1")
    # 좌측 실루엣 역광 림(자홍): 어두운 머리를 배경에서 분리 + 비대칭(오른쪽은 순수 어둠)
    # 얇은 세로 셰인은 어두운 머리 위에서 '떠 있는 선'으로 읽히므로, 실루엣 경계에 붙인다.
    vline(g, 12, 6, 40, "2")
    # 반개 자홍 눈: 가로 슬릿 + 위 꺼풀 다크 + 광 하이라이트
    for ex in (17, 27):
        hline(g, ex, ex + 4, 22, "1")
        hline(g, ex, ex + 4, 23, "2")
        hline(g, ex + 1, ex + 3, 24, "2")
        px(g, ex + 1, 23, "3")
    px(g, 16, 23, "1")   # 속눈썹 포인트
    px(g, 32, 23, "1")
    # 베일: 자홍 밴드가 코·입을 덮는다(눈금 없음, 하단 디더만)
    rect(g, 17, 29, 31, 34, "2")
    dither(g, 17, 34, 31, 34, "1", base="2")
    dither(g, 17, 35, 31, 35, "2", base="1")
    # 베일 아래는 전부 제복(다크) - 흰 목 노출 없음
    # 칼라의 진행 막대: 채워진 구간(자홍) + 빈 구간(다크, 자홍 테두리)
    rect(g, 16, 41, 32, 44, "1")
    hline(g, 16, 32, 41, "2")
    hline(g, 16, 32, 44, "2")
    vline(g, 16, 41, 44, "2")
    vline(g, 32, 41, 44, "2")
    rect(g, 17, 42, 26, 43, "2")   # 75% 채움
    # 왼쪽 제복 자홍 엣지(비대칭)
    vline(g, 12, 40, 46, "2")
    # 상단 모서리 라운딩
    for i, wcut in enumerate((3, 2, 1)):
        rect(g, 12, 4 + i, 12 + wcut - 1, 4 + i, ".")
        rect(g, 35 - wcut + 1, 4 + i, 35, 4 + i, ".")
    save("assets/px/portrait_format_48.px",
         g, "1=1a1626 2=ed4f9a 3=f2f0e6",
         "portrait_format_48 - 포맷 제로 초상 (생성 베이스 + 손 튜닝)")


if __name__ == "__main__":
    os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
    portrait_echo()
    portrait_seek()
    portrait_format()
