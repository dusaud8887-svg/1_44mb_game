#!/usr/bin/env python3
# px_keyart.py - 마케팅 키아트(스팀 캡슐·itch 커버·소셜) 컴포저.
# 인게임 자산이 아니다: 확장 9색 브랜드 팔레트를 렌더 전용으로 쓰며 .exe에 들어가지 않는다.
# 검증된 초상·스프라이트(assets/px/*.px)를 리매핑·업스케일해 재사용하고, CRT 분위기와
# 네거티브 스페이스("시청자 1" = 어둠 속 SEEK의 눈 하나)를 얹는다.
# 설계 근거: docs/42_VISUAL_HOOK.md. 산출물: assets/px/keyart_last_live.px (생성 소스).
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from px_render import parse_px  # noqa: E402

W, H = 192, 108

# 브랜드 9색 + 글로우 중간톤 (40 §2 논리 팔레트). 인게임 3색 규율과 무관, 렌더 전용.
PAL = {
    "1": "1a1626",  # 그림자 퍼플
    "2": "4ddbc8",  # 청록 (에코)
    "3": "e5a84b",  # 호박 (시크)
    "4": "ed4f9a",  # 자홍 (포맷/조각)
    "5": "f2f0e6",  # 광 (흰색)
    "6": "7b7b86",  # 무음/보조
    "7": "6da9e8",  # 청색
    "8": "e55b57",  # 빨강 (LIVE 핀)
    "9": "100d18",  # 배경 베이스
    "a": "130918",  # LIVE 딥 (비네트)
    "b": "2a6f68",  # 청록 글로우 중간톤
    "c": "6e3a5a",  # 자홍 글로우 중간톤
    "d": "080610",  # 최외곽 암부
    "e": "6b5326",  # 호박 글로우 중간톤
}
BG = "9"


def blank():
    return [[BG for _ in range(W)] for _ in range(H)]


def put(cv, x, y, c):
    if 0 <= x < W and 0 <= y < H:
        cv[y][x] = c


def blit(cv, path, ox, oy, scale, remap, skip=("0",)):
    """스프라이트를 remap(원본 인덱스→키아트 인덱스)으로 찍는다. 채운 좌표 집합 반환."""
    _, grid, w, h = parse_px(path)
    filled = set()
    for y in range(h):
        for x in range(w):
            c = grid[y][x]
            if c == "." or c in skip:
                continue
            tc = remap.get(c, c)
            if tc is None:
                continue
            for dy in range(scale):
                for dx in range(scale):
                    px, py = ox + x * scale + dx, oy + y * scale + dy
                    if 0 <= px < W and 0 <= py < H:
                        cv[py][px] = tc
                        filled.add((px, py))
    return filled


def rim(cv, filled, color, dirs, only=None):
    """filled 실루엣 바깥의 배경 픽셀에 1px 림라이트(역광). dirs: (dx,dy) 목록."""
    for (x, y) in filled:
        for dx, dy in dirs:
            nx, ny = x + dx, y + dy
            if (nx, ny) in filled:
                continue
            if 0 <= nx < W and 0 <= ny < H and cv[ny][nx] in (BG, "a", "d") + (only or ()):
                cv[ny][nx] = color


def glow(cv, cx, cy, r, mid, over=(BG, "a", "d")):
    """방사 글로우: 중심은 촘촘, 가장자리로 갈수록 성기게 페이드(배경 위에만)."""
    for y in range(cy - r, cy + r + 1):
        for x in range(cx - r, cx + r + 1):
            if not (0 <= x < W and 0 <= y < H):
                continue
            d2 = (x - cx) ** 2 + (y - cy) ** 2
            if d2 > r * r or cv[y][x] not in over:
                continue
            t = (d2 / (r * r)) ** 0.5    # 0 중심 ~ 1 가장자리
            if t < 0.5:
                keep = (x + y) % 2 == 0
            elif t < 0.8:
                keep = x % 2 == 0 and y % 2 == 0
            else:
                keep = False
            if keep:
                cv[y][x] = mid


def vignette(cv):
    """CRT 비네트: 가장자리로 갈수록 어둡게 (9→a→d)."""
    for y in range(H):
        for x in range(W):
            if cv[y][x] != BG:
                continue
            ex = max(0, abs(x - W / 2) / (W / 2) - 0.55)
            ey = max(0, abs(y - H / 2) / (H / 2) - 0.35)
            e = ex + ey
            if e > 0.45:
                cv[y][x] = "d"
            elif e > 0.18:
                cv[y][x] = "a"


def pcb_grid(cv):
    """희미한 PCB 격자 (배경 위에만, 아주 어둡게)."""
    for y in range(8, H, 14):
        for x in range(0, W, 2):
            if cv[y][x] == BG:
                cv[y][x] = "a"
    for x in range(10, W, 16):
        for y in range(0, H, 2):
            if cv[y][x] == BG:
                cv[y][x] = "a"


def disk_ring(cv, cx, cy, r, color):
    """A:\\ 플로피 원반 암시: 아주 희미한 큰 링 1개."""
    for y in range(H):
        for x in range(W):
            d = ((x - cx) ** 2 + (y - cy) ** 2) ** 0.5
            if r - 0.8 <= d <= r + 0.8 and cv[y][x] in (BG, "a"):
                if (x + y) % 2 == 0:
                    cv[y][x] = color


def dashed_beam(cv, x0, x1, y, colors, period=5, on=2):
    """송출 신호 빔: 대시 + 오른쪽으로 갈수록 조각으로 흩어진다."""
    n = x1 - x0
    for i, x in enumerate(range(x0, x1)):
        frac = i / n
        if (x % period) >= on:
            continue
        col = colors[min(len(colors) - 1, int(frac * len(colors)))]
        put(cv, x, y, col)
        if frac < 0.4:                       # 손 근처는 굵은 코어
            put(cv, x, y - 1, "5")
        if frac > 0.55 and (x % (period * 2) == 0):  # 흩어지는 조각
            put(cv, x, y - 1, col)
            put(cv, x + 1, y + 1, "4")


def seek_eye(cv, cx, cy):
    """네거티브 스페이스 훅: 어둠 속에 SEEK의 눈 하나 + 몸의 극소 힌트."""
    # 몸은 그리지 않는다 — 순수 네거티브 스페이스. 눈과 링 조각만 어둠에 뜬다.
    # 눈이 스스로 발광하는 듯한 호박 언더글로우(아주 성기게)
    for y in range(cy - 10, cy + 11):
        for x in range(cx - 11, cx + 12):
            d2 = (x - cx) ** 2 + ((y - cy) * 1.3) ** 2
            if 36 < d2 <= 100 and cv[y][x] in (BG, "a", "d"):
                if (x * 2 + y) % 5 == 0:
                    cv[y][x] = "c" if d2 > 70 else "3"
    # 깨진 버퍼 링 조각(우상단 호박) — "둥근 무언가"의 유일한 단서
    put(cv, cx + 11, cy - 7, "3"); put(cv, cx + 12, cy - 5, "3"); put(cv, cx + 12, cy - 3, "3")
    put(cv, cx - 12, cy + 8, "3"); put(cv, cx - 11, cy + 9, "6")   # 좌하단 대각 조각(끊긴 링)
    # 눈: 흰 타원 + 호박 홍채 링 + 다크 동공 + 광 하이라이트 (약간 확대)
    RX, RY = 5, 3.6
    for y in range(cy - 4, cy + 5):
        for x in range(cx - 5, cx + 6):
            if ((x - cx) / RX) ** 2 + ((y - cy) / RY) ** 2 <= 1.0:
                cv[y][x] = "5"
    for y in range(cy - 4, cy + 5):
        for x in range(cx - 5, cx + 6):
            d2 = ((x - cx) / RX) ** 2 + ((y - cy) / RY) ** 2
            if 0.5 < d2 <= 1.0:
                cv[y][x] = "3"              # 호박 테
    for y in range(cy - 3, cy + 4):
        for x in range(cx - 2, cx + 2):
            if ((x - cx + 0.5) / 2) ** 2 + ((y - cy) / 2.8) ** 2 <= 1.0:
                cv[y][x] = "1"             # 동공
    put(cv, cx - 2, cy - 2, "5")           # 하이라이트
    put(cv, cx + 2, cy + 1, "5")           # 아래 반사
    # 반개 눈꺼풀(위): ∧ — 삼백안으로 시선만 강조
    for x in range(cx - 5, cx + 6):
        lid = cy - 4 + abs(x - cx) // 4
        for y in range(cy - 5, lid):
            if cv[y][x] in ("5", "3"):
                cv[y][x] = "1"


# 3x5 마이크로 폰트 — 브랜드 모티프("A:\>")·연도·퍼센트용 최소 글리프.
FONT = {
    "A": [".#.", "#.#", "###", "#.#", "#.#"],
    ":": ["...", ".#.", "...", ".#.", "..."],
    "\\": ["#..", ".#.", ".#.", "..#", "..#"],
    ">": ["#..", ".#.", "..#", ".#.", "#.."],
    "%": ["#.#", "..#", ".#.", "#..", "#.#"],
    " ": ["...", "...", "...", "...", "..."],
    "0": ["###", "#.#", "#.#", "#.#", "###"],
    "1": [".#.", "##.", ".#.", ".#.", "###"],
    "2": ["###", "..#", "###", "#..", "###"],
    "3": ["###", "..#", ".##", "..#", "###"],
    "4": ["#.#", "#.#", "###", "..#", "..#"],
    "5": ["###", "#..", "###", "..#", "###"],
    "6": ["###", "#..", "###", "#.#", "###"],
    "7": ["###", "..#", ".#.", ".#.", ".#."],
    "8": ["###", "#.#", "###", "#.#", "###"],
    "9": ["###", "#.#", "###", "..#", "###"],
}


def stamp_text(cv, s, ox, oy, color):
    cx = ox
    for ch in s:
        g = FONT.get(ch, FONT[" "])
        for r in range(5):
            for c in range(3):
                if g[r][c] == "#":
                    put(cv, cx + c, oy + r, color)
        cx += 4
    return cx


def scene_base(disk_at, disk_col):
    cv = blank()
    vignette(cv)
    pcb_grid(cv)
    disk_ring(cv, disk_at[0], disk_at[1], disk_at[2], disk_col)
    return cv


def corner_prompt(cv, x, y, dim, cursor_col):
    cx = stamp_text(cv, "A:\\>", x, y, dim)
    for dy in range(5):
        put(cv, cx, y + dy, cursor_col); put(cv, cx + 1, y + dy, cursor_col)


def build_echo():
    cv = scene_base((150, 54, 44), "b")

    # ECHO 뒤 청록 역광 글로우 (머리 중심에 집중)
    glow(cv, 54, 34, 34, "b")

    # ECHO 히어로: 초상 2배 (96x96), 좌측 상단 포커스
    ex, ey = 6, 8
    ef = blit(cv, "assets/px/portrait_echo_48.px", ex, ey, 2,
              {"1": "1", "2": "2", "3": "5"})
    # 빨간 LIVE 핀 (재킷 좌상, 2배 스케일 위치)
    put(cv, ex + 8 * 2, ey + 38 * 2, "8"); put(cv, ex + 8 * 2 + 1, ey + 38 * 2, "8")
    put(cv, ex + 8 * 2, ey + 38 * 2 + 1, "8"); put(cv, ex + 8 * 2 + 1, ey + 38 * 2 + 1, "8")
    # 역광 림: 오른쪽·아래 실루엣에 청록/흰 1px
    rim(cv, ef, "2", [(1, 0), (1, 1), (0, 1)])
    rim(cv, ef, "5", [(1, -1)])

    # 송출 신호 빔: ECHO 손 높이에서 오른쪽 어둠으로, 조각으로 흩어짐
    dashed_beam(cv, 104, 176, 62, ["5", "2", "2", "4", "4"], period=6, on=2)

    # 떠 있는 조각(자홍) — 상단·빔 주변, 하나는 글리치 1px
    for (fx, fy) in [(120, 22), (140, 30), (96, 16), (168, 40), (150, 74)]:
        put(cv, fx, fy, "4"); put(cv, fx + 1, fy, "4")
        put(cv, fx, fy + 1, "4"); put(cv, fx + 1, fy + 1, "4")
    put(cv, 141, 30, "2")   # 조각 속 잘못된 픽셀(글리치)

    # SEEK: 어둠 속의 눈 하나 (네거티브 스페이스 미스터리)
    seek_eye(cv, 156, 58)

    # 좌하단 코너: A:\> 프롬프트 + 커서 블록 (1997·플로피 모티프)
    corner_prompt(cv, 8, 99, "6", "2")
    return cv


def build_seek():
    """시크 단독 — '지켜보는 자'. 어둠 속 멀리 청록 신호를 응시한다."""
    cv = scene_base((44, 56, 40), "e")     # 플로피 링을 왼쪽으로(시선 방향)

    # 시크가 응시하는 것: 왼쪽 어둠 속 작은 청록 신호 하나 (네거티브 스페이스)
    glow(cv, 26, 52, 16, "b")
    for (fx, fy) in [(24, 50), (25, 51), (27, 49)]:
        put(cv, fx, fy, "2")
    put(cv, 26, 52, "5")

    # SEEK 히어로: 초상 2배, 우측 배치 — 눈이 왼쪽(신호)을 향하도록
    glow(cv, 128, 64, 30, "e")
    ox, oy = 82, 14
    sf = blit(cv, "assets/px/portrait_seek_48.px", ox, oy, 2,
              {"1": "1", "2": "3", "3": "5"})
    # 역광 림: 신호(왼쪽)가 실루엣 왼쪽 가장자리를 청록으로 물들인다
    rim(cv, sf, "2", [(-1, 0), (-1, -1)])
    rim(cv, sf, "3", [(1, 0), (0, 1), (1, 1)])   # 반대쪽은 호박 자기광

    # 깨진 버퍼 링 조각이 시크 주위를 돈다(호박)
    for (fx, fy) in [(120, 18), (150, 26), (168, 60), (112, 84), (156, 90)]:
        put(cv, fx, fy, "3"); put(cv, fx + 1, fy, "3")
        put(cv, fx, fy + 1, "3"); put(cv, fx + 1, fy + 1, "3")
    put(cv, 151, 26, "5")   # 조각 광점

    # 리본 케이블: 시크 오른쪽에서 아래로 끊긴 분절
    for (bx, by) in [(174, 58), (178, 66), (176, 74), (180, 82)]:
        put(cv, bx, by, "3"); put(cv, bx + 1, by, "3"); put(cv, bx, by + 1, "3")

    corner_prompt(cv, 8, 99, "6", "3")
    return cv


def build_format():
    """포맷 단독 — '닫는 자'. 종료 진행 75% 막대 + 최대 네거티브 스페이스."""
    cv = scene_base((150, 54, 46), "c")

    # 포맷 뒤 자홍 냉광 (초상 뒤에 집중)
    glow(cv, 74, 46, 30, "c")

    # FORMAT 히어로: 초상 2배, 좌측-중앙 수직 배치
    ox, oy = 22, 6
    ff = blit(cv, "assets/px/portrait_format_48.px", ox, oy, 2,
              {"1": "1", "2": "4", "3": "5"})
    rim(cv, ff, "4", [(1, 0), (1, 1), (0, 1), (-1, 0)])

    # 종료 진행 막대: 우측 수직 컬럼, 75% 채움(FORMAT 경고 임계와 동일 숫자)
    bx0, by0, bw, bh = 150, 20, 10, 72
    frame_rect(cv, bx0, by0, bw, bh, "4")
    fill_h = int(bh * 0.75)
    for y in range(by0 + bh - fill_h, by0 + bh):          # 아래에서 위로 채움
        for x in range(bx0 + 1, bx0 + bw - 1):
            if (x + y) % 2 == 0 or y > by0 + bh - fill_h + 3:
                cv[y][x] = "4"
    for y in range(by0 + 4, by0 + bh, 6):                  # 눈금
        for x in range(bx0 + 1, bx0 + bw - 1):
            cv[y][x] = "1"
    stamp_text(cv, "75%", bx0 - 4, by0 - 8, "4")           # 라벨
    put(cv, bx0 + bw // 2, by0 - 2, "5")

    # 떠 있는 잘못된 연도 "1997" (희미, 한 글자만 자홍 글리치)
    tx = 120
    stamp_text(cv, "1997", tx, 30, "6")
    for dy in range(5):                                    # '9' 하나를 자홍으로 글리치
        for dx in range(3):
            if FONT["9"][dy][dx] == "#":
                put(cv, tx + 4 + dx, 30 + dy, "4")

    corner_prompt(cv, 8, 99, "6", "4")
    return cv


def frame_rect(cv, x, y, w, h, c):
    for i in range(w):
        put(cv, x + i, y, c); put(cv, x + i, y + h - 1, c)
    for j in range(h):
        put(cv, x, y + j, c); put(cv, x + w - 1, y + j, c)


def save_px(cv, path, title):
    palette = " ".join(f"{k}={v}" for k, v in PAL.items())
    lines = [
        f"# {title}",
        "# 설계: docs/42_VISUAL_HOOK.md / 재생성: python3 tools/px_keyart.py",
        "# 확장 9색 브랜드 팔레트(렌더 전용, emit-c 불가)",
        f"# palette: {palette}",
    ]
    lines += ["".join(row) for row in cv]
    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    print("wrote", path)


if __name__ == "__main__":
    os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
    save_px(build_echo(), "assets/px/keyart_last_live.px",
            "keyart_last_live - 에코/144 마케팅 키아트 (에코 중심, 인게임 자산 아님)")
    save_px(build_seek(), "assets/px/keyart_seek.px",
            "keyart_seek - 시크 웜 단독 키비주얼 '지켜보는 자' (인게임 자산 아님)")
    save_px(build_format(), "assets/px/keyart_format.px",
            "keyart_format - 포맷 제로 단독 키비주얼 '닫는 자' (인게임 자산 아님)")
