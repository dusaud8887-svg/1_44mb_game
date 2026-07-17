#!/usr/bin/env python3
# pxlib.py - V2 아트 빌더 공용 모듈.
# 원본은 각 빌더 스크립트(tools/v2/*.py)이고 .px는 검수용 덤프다(ADR-0008).
# 팔레트: docs/40_ART_AUDIO_TEXT.md §3 16색 논리 팔레트의 고정 문자 매핑.
import math
import os

PALETTE = {
    "1": "09070F",  # VOID
    "2": "120E1A",  # BROADCAST BLACK
    "3": "21182A",  # PANEL
    "4": "32253B",  # DEEP SLATE
    "5": "F2EBDD",  # PAPER
    "6": "85808D",  # DIM
    "7": "176C69",  # CYAN DARK
    "8": "4EDBC9",  # CYAN
    "9": "76501F",  # AMBER DARK
    "a": "E7AA4B",  # AMBER
    "b": "6C204A",  # MAGENTA DARK
    "c": "EF4F9E",  # MAGENTA
    "d": "E65B5B",  # DANGER RED
    "e": "6AAAE8",  # SIGNAL BLUE
    "f": "B8A6D9",  # PHANTOM LAVENDER
}


class Grid:
    def __init__(self, w, h, fill="."):
        self.w, self.h = w, h
        self.g = [[fill] * w for _ in range(h)]

    def set(self, x, y, c, over=True):
        if 0 <= x < self.w and 0 <= y < self.h:
            if over or self.g[y][x] == ".":
                self.g[y][x] = c

    def get(self, x, y):
        if 0 <= x < self.w and 0 <= y < self.h:
            return self.g[y][x]
        return "."

    def run(self, x0, x1, y, c, over=True):
        for x in range(min(x0, x1), max(x0, x1) + 1):
            self.set(x, y, c, over)

    def vrun(self, x, y0, y1, c, over=True):
        for y in range(min(y0, y1), max(y0, y1) + 1):
            self.set(x, y, c, over)

    def rect(self, x0, y0, x1, y1, c, over=True):
        for y in range(y0, y1 + 1):
            self.run(x0, x1, y, c, over)

    def blit(self, x0, y0, rows, over=True):
        """리터럴 텍스트 블록을 (x0,y0)에 얹는다. ' '와 '.'는 건너뛰고 '!'는 투명으로 지운다."""
        for dy, row in enumerate(rows):
            for dx, ch in enumerate(row):
                if ch in " .":
                    continue
                if ch == "!":
                    self.set(x0 + dx, y0 + dy, ".")
                else:
                    self.set(x0 + dx, y0 + dy, ch, over)

    def arc(self, cx, cy, r, a0, a1, c, dash=(360, 0), thick=1, under=False):
        """각도 a0..a1(도, 0=오른쪽, 시계방향=아래) 원호. dash=(주기, 공백)."""
        period, gap = dash
        steps = max(int(r * 8), 64)
        for i in range(steps + 1):
            a = a0 + (a1 - a0) * i / steps
            if gap and (a % period) >= (period - gap):
                continue
            for t in range(thick):
                x = round(cx + (r - t) * math.cos(math.radians(a)))
                y = round(cy + (r - t) * math.sin(math.radians(a)))
                self.set(x, y, c, over=not under)

    def outline_selout(self, target, edge, bg="."):
        """bg와 접한 target색 픽셀을 edge색으로 — 셀아웃 보조."""
        out = []
        for y in range(self.h):
            for x in range(self.w):
                if self.g[y][x] == target:
                    for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                        if self.get(x + dx, y + dy) == bg:
                            out.append((x, y))
                            break
        for x, y in out:
            self.g[y][x] = edge

    def save(self, path, title, palette=None):
        pal = palette or PALETTE
        used = sorted({c for row in self.g for c in row if c != "."})
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w", encoding="utf-8") as f:
            f.write(f"# {title}\n")
            f.write("# V2 16색 논리 팔레트(docs/40 §3) — 원본: tools/v2/, .px는 검수 덤프(ADR-0008)\n")
            f.write("# palette: " + " ".join(f"{c}={pal[c]}" for c in used) + "\n")
            for row in self.g:
                f.write("".join(row) + "\n")
        print(f"wrote {path} ({self.w}x{self.h}, {len(used)} colors)")
