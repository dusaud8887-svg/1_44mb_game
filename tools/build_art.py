"""Hand-authored V2 pixel assets: indexed PNG previews plus embedded C data.

V3 art pass (2026-07): characters are no longer assembled from polygon
primitives. Faces, hair and bodies are designed as explicit pixel rows/grids
(the same discipline as docs/41 section 4: silhouette -> value mass -> face
anchors -> cluster shading), then reviewed at 1x/4x/8x. Per-character eye
grammar is canon: Echo round+open, Seek sanpaku slant, NOA half-lidded
symmetric with profile-dot highlights."""
from __future__ import annotations

import math
import struct
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PAL = [
    (9, 7, 15), (18, 14, 26), (33, 24, 42), (50, 37, 59),
    (242, 235, 221), (133, 128, 141), (23, 108, 105), (78, 219, 201),
    (118, 80, 31), (231, 170, 75), (108, 32, 74), (239, 79, 158),
    (230, 91, 91), (106, 170, 232), (184, 166, 217), (0, 0, 0),
]
V, B, P, S, W, D, CD, C, AD, A, MD, M, R, U, L, T = range(16)
CH = {
    'V': V, 'B': B, 'P': P, 'S': S, 'W': W, 'D': D,
    'c': CD, 'C': C, 'a': AD, 'A': A, 'm': MD, 'M': M,
    'R': R, 'U': U, 'L': L, '.': T,
}


class Canvas:
    def __init__(self, w: int, h: int, fill: int = T):
        self.w, self.h, self.p = w, h, bytearray([fill]) * (w * h)

    def px(self, x: int, y: int, c: int) -> None:
        if 0 <= x < self.w and 0 <= y < self.h:
            self.p[y * self.w + x] = c

    def get(self, x: int, y: int) -> int:
        return self.p[y * self.w + x] if (0 <= x < self.w and 0 <= y < self.h) else T

    def rect(self, x: int, y: int, w: int, h: int, c: int) -> None:
        for yy in range(max(0, y), min(self.h, y + h)):
            for xx in range(max(0, x), min(self.w, x + w)):
                self.p[yy * self.w + xx] = c

    def frame(self, x: int, y: int, w: int, h: int, c: int) -> None:
        self.rect(x, y, w, 1, c); self.rect(x, y + h - 1, w, 1, c)
        self.rect(x, y, 1, h, c); self.rect(x + w - 1, y, 1, h, c)

    def line(self, x0: int, y0: int, x1: int, y1: int, c: int) -> None:
        dx, sx, dy, sy = abs(x1-x0), 1 if x0 < x1 else -1, -abs(y1-y0), 1 if y0 < y1 else -1
        err = dx + dy
        while True:
            self.px(x0, y0, c)
            if x0 == x1 and y0 == y1: break
            e2 = err * 2
            if e2 >= dy: err += dy; x0 += sx
            if e2 <= dx: err += dx; y0 += sy

    def blit(self, other: "Canvas", x: int, y: int, scale: int = 1) -> None:
        for yy in range(other.h):
            for xx in range(other.w):
                c = other.p[yy * other.w + xx]
                if c != T: self.rect(x + xx * scale, y + yy * scale, scale, scale, c)


def grid(text: str) -> Canvas:
    rows = text.strip("\n").split("\n")
    cv = Canvas(max(len(r) for r in rows), len(rows))
    for y, r in enumerate(rows):
        for x, ch in enumerate(r):
            cv.px(x, y, CH[ch])
    return cv


def runs(cv: Canvas, y: int, spans) -> None:
    for x0, x1, c in spans:
        cv.rect(x0, y, x1 - x0 + 1, 1, c)


def resized(src: Canvas, w: int, h: int) -> Canvas:
    out = Canvas(w, h)
    for y in range(h):
        sy = y * src.h // h
        for x in range(w): out.p[y*w+x] = src.p[sy*src.w + x*src.w//w]
    return out


def ring_arc(cv: Canvas, cx: int, cy: int, r: int, c: int, gap_from: int, gap_to: int) -> None:
    """Clustered 2px ring; gap angles in degrees (0=east, CCW)."""
    for i in range(64):
        deg = i * 360 / 64
        if gap_from <= deg <= gap_to:
            continue
        x = cx + round(math.cos(math.radians(deg)) * r)
        y = cy - round(math.sin(math.radians(deg)) * r)
        cv.rect(x, y, 2, 2, c)


# ---------------------------------------------------------------- portraits

def echo_portrait(expression: int = 0) -> Canvas:
    q = Canvas(64, 64)
    ring_arc(q, 31, 30, 29, CD, 20, 75)
    for a in (100, 140, 180, 220, 260, 300, 340):
        x = 31 + round(math.cos(math.radians(a)) * 29)
        y = 30 - round(math.sin(math.radians(a)) * 29)
        q.rect(x, y, 2, 2, C)

    hair_back = [
        (5, 24, 40), (6, 21, 43), (7, 19, 45), (8, 17, 47), (9, 16, 48),
        (10, 15, 49), (11, 14, 50), (12, 13, 51), (13, 13, 51), (14, 12, 52),
        (15, 12, 52), (16, 11, 52), (17, 11, 52), (18, 11, 52), (19, 10, 52),
        (20, 10, 52), (21, 10, 52), (22, 10, 52), (23, 10, 52), (24, 10, 52),
        (25, 10, 52), (26, 10, 51), (27, 10, 51), (28, 10, 51), (29, 10, 51),
        (30, 10, 51), (31, 10, 51), (32, 10, 51), (33, 10, 51), (34, 10, 51),
        (35, 10, 50), (36, 10, 50), (37, 11, 50), (38, 11, 50), (39, 11, 49),
        (40, 11, 49), (41, 11, 48), (42, 12, 47), (43, 12, 46), (44, 12, 45),
        (45, 12, 44),
    ]
    for y, x0, x1 in hair_back:
        runs(q, y, [(x0, x1, B)])
    lock = [(46, 11, 19), (47, 11, 19), (48, 10, 18), (49, 10, 18), (50, 10, 17),
            (51, 9, 17), (52, 9, 16), (53, 9, 16), (54, 9, 15), (55, 8, 15),
            (56, 8, 14), (57, 8, 14), (58, 8, 13), (59, 9, 13), (60, 9, 12),
            (61, 10, 12), (62, 10, 12), (63, 11, 12)]
    for y, x0, x1 in lock:
        runs(q, y, [(x0, x1, B)])
    for y, x0, x1 in [(46, 44, 48), (47, 45, 49), (48, 46, 49), (49, 46, 50), (50, 47, 50), (51, 47, 49), (52, 48, 49)]:
        runs(q, y, [(x0, x1, B)])

    # ahoge: one clean antenna strand curving right
    q.px(32, 3, B); q.px(33, 2, B); q.px(34, 1, B); q.px(35, 1, B); q.px(36, 2, B)

    # Sculpted modern face: wide cheekbone, slimmer cheek, straight V jaw, soft chin.
    face = [
        (16, 22, 41), (17, 21, 43), (18, 20, 44), (19, 19, 45),
        (20, 18, 46), (21, 18, 46), (22, 17, 47), (23, 17, 47), (24, 17, 47),
        (25, 17, 47), (26, 18, 46), (27, 18, 46), (28, 18, 46), (29, 18, 46),
        (30, 18, 46), (31, 18, 46), (32, 18, 46), (33, 18, 46), (34, 18, 46),
        (35, 19, 46), (36, 19, 45), (37, 20, 45), (38, 20, 44), (39, 21, 44),
        (40, 23, 43), (41, 24, 42), (42, 26, 41), (43, 27, 39),
        (44, 29, 38), (45, 31, 36), (46, 32, 35),
    ]
    for y, x0, x1 in face:
        runs(q, y, [(x0, x1, W)])
    # cheekbone planes: one soft shadow under each outer eye gives the face structure
    q.px(21, 37, D); q.px(43, 37, D)
    # jaw-corner accent: a 1px shadow where cheek turns into the angular jaw
    q.px(18, 36, D); q.px(46, 36, D)

    # Sharp layered fringe: a spiky lower edge above the eyes + a center strand
    # between them + pointed side locks. This kills the smooth-helmet read.
    bang_rows = [
        (13, [(13, 51, B)]), (14, [(12, 52, B)]), (15, [(12, 52, B)]),
        (16, [(11, 52, B)]), (17, [(11, 52, B)]), (18, [(11, 51, B)]),
        (19, [(10, 51, B)]), (20, [(10, 50, B)]), (21, [(10, 50, B)]),
        (22, [(10, 50, B)]), (23, [(10, 50, B)]), (24, [(10, 50, B)]),
        # forehead stays covered; only a sharp center strand + side locks drop between the eyes
        (25, [(10, 18, B), (31, 34, B), (45, 48, B)]),
        (26, [(10, 17, B), (31, 33, B), (45, 48, B)]),
        (27, [(10, 18, B), (45, 48, B)]), (28, [(10, 18, B), (45, 48, B)]),
        (29, [(10, 18, B), (45, 47, B)]), (30, [(10, 18, B), (45, 47, B)]),
        (31, [(10, 17, B), (45, 47, B)]), (32, [(10, 17, B), (45, 47, B)]),
        (33, [(10, 17, B), (45, 47, B)]), (34, [(10, 17, B), (45, 47, B)]),
        (35, [(10, 16, B), (45, 47, B)]), (36, [(10, 16, B), (46, 47, B)]),
        (37, [(11, 16, B), (46, 47, B)]), (38, [(11, 15, B), (46, 46, B)]),
        (39, [(11, 15, B), (46, 46, B)]), (40, [(11, 14, B)]),
        (41, [(12, 14, B)]), (42, [(12, 13, B)]),
    ]
    for y, spans in bang_rows:
        runs(q, y, spans)
    # sharp cowlick spikes on the crown (modern anime silhouette, not a dome)
    q.px(19, 5, B); q.px(20, 4, B); q.px(21, 3, B); q.px(22, 4, B)
    q.px(43, 5, B); q.px(44, 4, B); q.px(45, 5, B)
    # angular streaked sheen instead of a smooth highlight band
    for y, x0, x1 in [(8, 24, 33), (9, 21, 30), (10, 18, 26), (11, 16, 22)]:
        runs(q, y, [(x0, x1, S)])
    q.line(34, 10, 43, 12, S); q.line(37, 9, 44, 10, S)

    def eye(x0, y0, w_, mode="open", dx=0, side="L"):
        outer = x0 - 1 if side == "L" else x0 + w_          # corner away from nose
        if mode == "closed":
            q.rect(x0, y0 + 4, 2, 1, B); q.rect(x0 + 1, y0 + 3, 2, 1, B)
            q.rect(x0 + 3, y0 + 2, w_ - 6, 1, B)
            q.rect(x0 + w_ - 3, y0 + 3, 2, 1, B); q.rect(x0 + w_ - 2, y0 + 4, 2, 1, B)
            q.px(outer, y0 + 1, B)                          # tiny upturned outer flick
            return
        lid = 1 if mode == "wide" else 2
        half = mode == "half"
        q.rect(x0, y0, w_, lid, B)
        q.px(x0 - 1, y0, B); q.px(x0 + w_, y0, B)
        q.px(x0 - 1, y0 + 1, B); q.px(x0 + w_, y0 + 1, B)
        # upturned outer corner flick — the single biggest "sharp/modern" eye cue
        q.px(outer + (-1 if side == "L" else 1), y0 - 1, B)
        q.px(outer, y0 - 1, B)
        q.rect(x0 + 1, y0 + lid, w_ - 2, 11 - lid, C)
        # compact reception-dial iris: soft limbal shading + a tight pupil ring
        # (not a big square frame — that read as goggles).
        cx, cy = x0 + w_ // 2 - 1 + dx, y0 + (7 if half else 6)
        q.rect(x0 + 1, y0 + lid, w_ - 2, 2, CD)        # top limbal shadow
        q.rect(x0 + 2, y0 + 10, w_ - 4, 1, CD)         # bottom limbal
        q.px(x0 + 1, cy, CD); q.px(x0 + w_ - 2, cy, CD)  # side limbal ticks
        q.rect(cx - 1, cy - 1, 3, 3, CD)               # tight dial ring
        q.rect(cx - 1, cy - 1, 2, 2, B)                # pupil, offset to hold a glint
        q.px(cx + 1, cy + 1, C)                         # inner reception glow
        if half:
            q.rect(x0, y0, w_, 4, B)
            q.rect(x0 + 1, y0 + 4, w_ - 2, 1, CD)
        if mode == "wide":                    # surprise: pupil shrinks, dial wide open
            q.px(cx, cy, B); q.px(cx - 1, cy - 1, B)
            q.rect(x0 + 2, y0 + 2, 3, 3, W); q.px(x0 + 1, y0 + 2, W)
            q.rect(x0 + w_ - 4, y0 + 7, 3, 3, W)
        else:
            q.rect(x0 + 2 + dx, y0 + 2, 2, 2, W)      # main catch-light
            q.px(x0 + 1 + dx, y0 + 3, W)              # +1 for a sparkle glint
            q.px(x0 + w_ - 3 + dx, y0 + 8, W)         # lower sparkle
        q.rect(x0 + 2, y0 + 11, w_ - 4, 1, CD)
        # almond taper: clip the inner-nose corner into skin so it isn't a box
        inner_top = (x0 + w_ - 2, y0 + lid) if side == "L" else (x0 + 1, y0 + lid)
        q.px(*inner_top, W)
        inr = x0 + w_ - 2 if side == "L" else x0 + 1
        q.px(inr, y0 + 10, W)                     # clip inner-bottom too
        q.px(x0 + 1 if side == "L" else x0 + w_ - 2, y0 + 10, W)  # soften outer-bottom

    emap = {
        0: ("open", 0), 1: ("wide", 0), 2: ("closed", 0), 3: ("open", 0),
        4: ("open", 2), 5: ("half", 0), 6: ("open", 0), 7: ("wide", 0),
    }
    mode, dx = emap[expression]
    eye(20, 25, 10, mode, dx, "L")
    eye(35, 25, 10, mode, dx, "R")
    # sharp angular brows, viewer-left 1px higher (canon asymmetry)
    q.line(21, 23, 27, 22, B); q.px(20, 24, B)
    q.line(38, 23, 44, 24, B); q.px(45, 25, B)

    q.px(32, 37, D)
    if expression == 1:      # surprised o
        q.frame(31, 40, 4, 3, B)
    elif expression == 2:    # broadcast laugh
        q.rect(30, 40, 6, 1, B); q.rect(29, 41, 8, 1, B)
        q.rect(30, 42, 6, 1, B); q.rect(31, 43, 4, 1, B)
        q.rect(30, 41, 6, 1, W)
    elif expression == 3:    # connection anxiety
        q.px(29, 41, B); q.rect(30, 42, 2, 1, B); q.rect(32, 41, 2, 1, B)
        q.rect(34, 42, 2, 1, B)
        q.px(48, 22, U); q.px(49, 24, U)
    elif expression == 4:    # guarded
        q.rect(30, 41, 6, 1, B)
    elif expression == 5:    # frustrated pout
        q.rect(29, 42, 4, 1, B); q.px(33, 41, B)
    elif expression == 6:    # resolve
        q.line(29, 41, 32, 42, B); q.line(32, 42, 35, 41, B)
    elif expression == 7:    # first real voice
        q.frame(30, 40, 5, 4, B); q.rect(31, 41, 3, 2, R)
        q.px(46, 34, U)
    else:
        q.line(30, 41, 33, 42, B)
        q.line(33, 42, 36, 40, B)
    q.rect(19, 38, 2, 1, R); q.rect(43, 38, 2, 1, R)
    if expression == 7:
        q.rect(19, 39, 3, 1, R); q.rect(42, 39, 3, 1, R)

    # cool duotone shade on the shadow side (right, away from the ring's key light)
    for y in range(24, 42):
        if q.get(45, y) == W:
            q.px(45, y, D)
    q.px(44, 40, D); q.px(43, 41, D)   # jaw turn
    q.px(31, 36, D)                     # under-nose ambient

    # headset over viewer-right side lock — a signal-meter screen (Jigen Tsuushin cue)
    q.rect(47, 27, 6, 9, B)
    q.rect(48, 28, 4, 6, CD)           # dark screen
    q.px(48, 30, C); q.px(49, 31, C); q.px(50, 29, C); q.px(51, 30, C)  # tiny waveform tick
    q.rect(48, 34, 4, 1, C)            # screen base glow
    q.px(53, 31, R)                    # standby light: still waiting to hear

    # neck + body
    for y, x0, x1 in [(45, 28, 35), (46, 28, 35), (47, 28, 35), (48, 29, 35)]:
        runs(q, y, [(x0, x1, W)])
    runs(q, 45, [(28, 35, D)])
    body = [
        (49, 22, 42, P), (50, 18, 46, P), (51, 15, 49, P), (52, 13, 51, P),
        (53, 12, 52, P), (54, 12, 53, P), (55, 11, 54, P), (56, 11, 55, P),
        (57, 10, 56, P), (58, 10, 56, P), (59, 10, 57, P), (60, 10, 57, P),
        (61, 10, 57, P), (62, 10, 57, P), (63, 10, 57, P),
    ]
    for y, x0, x1, c in body:
        runs(q, y, [(x0, x1, c)])
    for y, x0, x1 in [(50, 18, 25), (51, 15, 26), (52, 13, 26), (53, 12, 27),
                      (54, 12, 27), (55, 11, 27), (56, 11, 27), (57, 10, 27),
                      (58, 10, 27), (59, 10, 27), (60, 10, 27), (61, 10, 27),
                      (62, 10, 27), (63, 10, 27)]:
        runs(q, y, [(x0, x1, W)])
    for y, x0, x1 in [(50, 39, 46), (51, 38, 49), (52, 38, 51), (53, 37, 52),
                      (54, 37, 53), (55, 37, 54), (56, 36, 55), (57, 36, 56),
                      (58, 36, 56), (59, 36, 57), (60, 36, 57), (61, 36, 57),
                      (62, 36, 57), (63, 36, 57)]:
        runs(q, y, [(x0, x1, W)])
    for y, x0, x1 in [(49, 29, 35), (50, 28, 36), (51, 28, 36), (52, 28, 36),
                      (53, 28, 36), (54, 28, 36), (55, 28, 36), (56, 28, 35),
                      (57, 28, 35), (58, 28, 35), (59, 28, 35), (60, 28, 35),
                      (61, 28, 35), (62, 28, 35), (63, 28, 35)]:
        runs(q, y, [(x0, x1, B)])
    q.line(27, 50, 27, 63, S)
    for y, x in [(51, 38), (53, 39), (55, 40), (58, 40), (60, 41), (62, 41)]:
        q.px(x, y, S)
    for y, x0, x1 in [(52, 47, 51), (53, 46, 52), (54, 46, 53), (55, 46, 54),
                      (56, 45, 55), (57, 45, 56), (58, 45, 56), (59, 45, 57),
                      (60, 45, 57), (61, 45, 57), (62, 45, 57), (63, 45, 57)]:
        runs(q, y, [(x0, x1, C)])
    q.line(45, 55, 45, 63, CD)
    for y, x0, x1 in [(60, 50, 57), (61, 48, 57), (62, 47, 57), (63, 46, 57)]:
        runs(q, y, [(x0, x1, CD)])
    # LIVE pin (single red focus)
    q.frame(20, 50, 5, 5, B)
    q.rect(21, 51, 3, 3, R); q.px(21, 51, W)

    # rim light: ring glow catches the outer hair edge
    for y in range(1, 50):
        for x in range(64):
            if q.get(x, y) == B and q.get(x - 1, y) == T:
                q.px(x, y, S)
                break
    for x in range(10, 54):
        for y in range(64):
            c = q.get(x, y)
            if c == T:
                continue
            if c == B:
                q.px(x, y, S)
            break
    for x, y in ((20, 8), (21, 8), (16, 12), (15, 16), (13, 22)):
        if q.get(x, y) == S:
            q.px(x, y, CD)
    return q


def seek_portrait(expression: int = 0) -> Canvas:
    q = Canvas(64, 64)
    ring_arc(q, 32, 30, 29, AD, 190, 250)
    for a in (20, 60, 320):
        x = 32 + round(math.cos(math.radians(a)) * 29)
        y = 30 - round(math.sin(math.radians(a)) * 29)
        q.rect(x, y, 2, 2, A)

    hood = [
        (6, 27, 38), (7, 23, 42), (8, 20, 45), (9, 18, 47),
        (10, 16, 49), (11, 15, 50), (12, 14, 51), (13, 13, 52),
        (14, 12, 53), (15, 12, 53), (16, 11, 54), (17, 11, 54),
        (18, 10, 55), (19, 10, 55), (20, 9, 55), (21, 9, 56),
        (22, 9, 56), (23, 9, 56), (24, 8, 56), (25, 8, 56),
        (26, 8, 56), (27, 8, 56), (28, 8, 56), (29, 8, 56),
        (30, 8, 56), (31, 8, 56), (32, 8, 56), (33, 8, 56),
        (34, 8, 56), (35, 9, 56), (36, 9, 56), (37, 9, 55),
        (38, 9, 55), (39, 10, 55), (40, 10, 54), (41, 11, 54),
        (42, 11, 53), (43, 12, 53), (44, 12, 52), (45, 13, 52),
        (46, 13, 51), (47, 14, 51), (48, 14, 50), (49, 15, 50),
    ]
    for y, x0, x1 in hood:
        runs(q, y, [(x0, x1, AD)])
    # connector tabs on hood corners (the almost-ears)
    q.rect(20, 3, 4, 6, AD); q.rect(21, 4, 2, 2, A)
    q.rect(40, 3, 4, 6, AD); q.rect(41, 4, 2, 2, A)

    shadow = [
        (13, 18, 47), (14, 17, 48), (15, 16, 49), (16, 16, 49),
        (17, 15, 50), (18, 15, 50), (19, 14, 50), (20, 14, 50),
        (21, 14, 50), (22, 14, 50), (23, 14, 50), (24, 14, 50),
        (25, 14, 50), (26, 14, 50), (27, 14, 50), (28, 14, 50),
        (29, 14, 50), (30, 14, 50), (31, 14, 50), (32, 14, 50),
        (33, 14, 50), (34, 14, 50), (35, 14, 50), (36, 15, 50),
        (37, 15, 49), (38, 15, 49), (39, 16, 49), (40, 16, 48),
        (41, 17, 48), (42, 18, 47), (43, 20, 46), (44, 22, 44),
        (45, 25, 41),
    ]
    for y, x0, x1 in shadow:
        runs(q, y, [(x0, x1, B)])
    face = [
        (16, 22, 42), (17, 21, 44), (18, 20, 45), (19, 19, 46),
        (20, 19, 46), (21, 18, 47), (22, 18, 47), (23, 18, 47),
        (24, 17, 47), (25, 17, 47), (26, 17, 47), (27, 17, 47),
        (28, 17, 47), (29, 17, 47), (30, 17, 47), (31, 17, 47),
        (32, 17, 47), (33, 17, 47), (34, 17, 47), (35, 18, 47),
        (36, 18, 46), (37, 19, 46), (38, 20, 45), (39, 21, 45),
        (40, 22, 44), (41, 24, 43), (42, 25, 42), (43, 27, 40),
        (44, 29, 38), (45, 31, 37), (46, 33, 36),
    ]
    for y, x0, x1 in face:
        runs(q, y, [(x0, x1, W)])
    q.px(18, 36, D); q.px(46, 36, D)   # jaw-corner accents

    fr = [
        (13, 15, 50), (14, 14, 51), (15, 14, 51), (16, 14, 50),
        (17, 14, 50), (18, 14, 49), (19, 14, 47),
        (20, 14, 33), (21, 14, 32), (22, 14, 32), (23, 14, 31),
        (24, 14, 31), (25, 15, 31), (26, 15, 31), (27, 15, 30),
        (28, 15, 30), (29, 16, 30), (30, 16, 30), (31, 16, 29),
        (32, 16, 29), (33, 17, 28), (34, 17, 27), (35, 17, 26),
        (36, 18, 24), (37, 18, 22), (38, 19, 20),
    ]
    for y, x0, x1 in fr:
        runs(q, y, [(x0, x1, A)])
    for y, x0, x1 in [(20, 36, 44), (21, 38, 42), (22, 39, 40), (20, 46, 47), (21, 47, 47)]:
        runs(q, y, [(x0, x1, A)])
    for y, x0, x1 in [(33, 17, 28), (34, 17, 27), (35, 17, 26), (36, 18, 24), (37, 18, 22), (38, 19, 20)]:
        runs(q, y, [(x0, x1, AD)])
    for y, x in [(29, 30), (30, 30), (31, 29), (32, 29)]:
        q.px(x, y, AD)
    runs(q, 12, [(15, 50, A)])
    runs(q, 11, [(16, 49, AD)])

    ex, ey = 36, 27
    if expression == 2:                    # archive mode: slit
        q.rect(ex - 1, ey + 1, 10, 2, B)
        q.rect(ex + 2, ey + 3, 5, 1, A)
        q.rect(ex + 2, ey + 4, 5, 1, D)
    else:
        wide = expression == 1
        q.rect(ex, ey, 8, 1, B)
        if not wide:
            q.rect(ex + 6, ey - 1, 3, 1, B)
        q.px(ex - 1, ey + 1, B); q.px(ex + 8, ey + 1, B)
        h = 5 if wide else 4
        q.rect(ex, ey + 1, 8, h + 1, W)
        q.rect(ex + 1, ey + 1, 6, h, A)            # amber iris
        q.frame(ex + 2, ey + 1, 4, 3, AD)         # dark reception ring (dial)
        q.rect(ex + 3, ey + 2, 2, 1, B)           # pupil
        q.px(ex + 2, ey + 1, W)                    # single glint on the ring
        if wide:
            q.px(ex + 6, ey + 3, C)               # a live cyan reflection
        q.rect(ex + 2, ey + 2 + h, 5, 1, D)
        q.px(ex + 7, ey + 2 + h, B)

    if expression == 1:
        q.rect(29, 40, 8, 1, B); q.rect(30, 41, 6, 2, B)
        q.rect(31, 41, 4, 1, R)
        q.px(34, 41, W); q.px(34, 42, W)
    elif expression == 3:
        q.rect(30, 41, 6, 1, B)
    else:
        q.line(29, 40, 33, 41, B)
        q.line(33, 41, 36, 40, B)
        q.px(35, 41, W); q.px(35, 42, W)
    runs(q, 45, [(30, 35, D)])

    body = [
        (50, 16, 49, P), (51, 14, 51, P), (52, 13, 52, P), (53, 12, 53, P),
        (54, 11, 54, P), (55, 11, 55, P), (56, 10, 55, P), (57, 10, 56, P),
        (58, 9, 56, P), (59, 9, 57, P), (60, 9, 57, P), (61, 9, 57, P),
        (62, 9, 57, P), (63, 9, 57, P),
    ]
    for y, x0, x1, c in body:
        runs(q, y, [(x0, x1, c)])
    for y, x0, x1 in [(46, 27, 38), (47, 27, 38), (48, 27, 38), (49, 27, 38)]:
        runs(q, y, [(x0, x1, B)])
    q.line(28, 50, 27, 57, A); q.line(37, 50, 38, 57, A)
    q.px(27, 58, AD); q.px(38, 58, AD)
    for y, x0, x1 in [(50, 16, 22), (50, 43, 49), (51, 14, 20), (51, 45, 51)]:
        runs(q, y, [(x0, x1, S)])
    cable = [(52, 50), (53, 52), (54, 53), (55, 54), (56, 55), (57, 55), (58, 56),
             (59, 56), (60, 55), (61, 54), (62, 53)]
    for y, x in cable:
        q.rect(x, y, 2, 1, A)
    q.rect(49, 51, 3, 2, AD)
    q.rect(45, 56, 9, 6, W); q.frame(45, 56, 9, 6, AD)
    q.rect(47, 58, 5, 1, B); q.rect(47, 60, 3, 1, B)
    q.px(54, 55, A)

    for y in range(2, 50):
        for x in range(64):
            if q.get(x, y) == AD and q.get(x - 1, y) == T:
                if y % 5 == 0:
                    q.px(x, y, A)
                break
    return q


def noa_portrait(expression: int = 0) -> Canvas:
    q = Canvas(64, 64)
    for x, c in ((2, MD), (6, M), (57, M), (61, MD)):
        q.line(x, 1, x, 62, c)
    for x, ys in ((1, (6, 22, 40)), (56, (12, 30, 48))):
        for y in ys:
            q.rect(x, y, 4, 3, MD); q.px(x + 1, y + 1, M)
    for x, y in ((12, 8), (32, 3), (52, 8), (10, 30), (54, 30), (12, 47), (52, 44)):
        q.frame(x, y, 4, 4, M); q.px(x + 1, y + 1, W)

    for y in range(6, 62):
        w0 = 14 if y > 12 else 14 + (12 - y)
        runs(q, y, [(w0, 63 - w0, B)])
    for y in range(16, 56, 2):
        q.px(16, y, MD); q.px(47, y, MD)

    face = [
        (16, 24, 39), (17, 23, 40), (18, 22, 41), (19, 21, 42),
        (20, 21, 42), (21, 20, 43), (22, 20, 43), (23, 20, 43),
        (24, 20, 43), (25, 20, 43), (26, 20, 43), (27, 20, 43),
        (28, 20, 43), (29, 20, 43), (30, 20, 43), (31, 20, 43),
        (32, 20, 43), (33, 20, 43), (34, 20, 43), (35, 20, 43),
        (36, 20, 43), (37, 21, 42), (38, 22, 42), (39, 23, 41),
        (40, 24, 40), (41, 25, 39), (42, 26, 38), (43, 28, 37),
        (44, 29, 35), (45, 31, 34), (46, 32, 33),
    ]
    for y, x0, x1 in face:
        runs(q, y, [(x0, x1, W)])
    q.px(19, 36, D); q.px(44, 36, D)   # sharp jaw-corner accents

    for y, x0, x1 in [(10, 17, 46), (11, 16, 47), (12, 16, 47), (13, 15, 48),
                      (14, 15, 48), (15, 15, 48), (16, 15, 48), (17, 15, 48),
                      (18, 15, 48), (19, 15, 48), (20, 15, 48), (21, 15, 48),
                      (22, 15, 48), (23, 15, 48), (24, 15, 48)]:
        runs(q, y, [(x0, x1, B)])
    for y in range(23, 46):
        runs(q, y, [(15, 18, B), (45, 48, B)])
    for y in range(46, 50):
        runs(q, y, [(15, 17, B), (46, 48, B)])
    runs(q, 12, [(18, 30, S), (33, 45, S)])

    def eye(x0):
        y0 = 28
        q.rect(x0, y0, 9, 2, B)
        q.px(x0 - 1, y0 + 1, B); q.px(x0 + 9, y0 + 1, B)
        q.rect(x0, y0 + 2, 9, 5, W)
        q.rect(x0 + 1, y0 + 2, 7, 4, MD)          # iris
        # aperture-lens iris: a perfectly concentric magenta ring (she is the observer).
        q.frame(x0 + 2, y0 + 2, 5, 4, M)          # exact ring — too precise to be human
        q.rect(x0 + 3, y0 + 3, 3, 2, B)           # pupil
        q.px(x0 + 4, y0 + 3, MD)                   # aperture center
        q.px(x0 + 2, y0 + 2, W); q.px(x0 + 6, y0 + 2, W)   # profile dots on the ring
        q.px(x0 + 2, y0 + 5, W); q.px(x0 + 6, y0 + 5, W)
        if expression == 2:                        # anomaly: two more viewers appear
            q.px(x0 + 4, y0 + 2, W); q.px(x0 + 4, y0 + 5, W)
        q.rect(x0 + 3, y0 + 7, 4, 1, MD)
    eye(21); eye(34)
    if expression == 1:
        q.rect(21, 30, 9, 1, B); q.rect(34, 30, 9, 1, B)
    # sharp angled brows — cold, precise, mirrored exactly (unlike Echo's asymmetry)
    q.line(22, 24, 28, 25, S); q.line(35, 25, 41, 24, S)

    q.px(31, 38, D)
    if expression == 1:
        runs(q, 41, [(28, 35, MD)])
        q.px(27, 40, MD); q.px(36, 40, MD)
        q.px(28, 42, MD); q.px(35, 42, MD)
    elif expression == 2:
        q.rect(29, 40, 6, 1, MD)
        q.rect(29, 42, 4, 1, MD)
    else:
        runs(q, 41, [(29, 34, MD)])
        q.px(28, 40, MD); q.px(35, 40, MD)

    body = [
        (50, 20, 43, P), (51, 17, 46, P), (52, 15, 48, P), (53, 14, 49, P),
        (54, 13, 50, P), (55, 12, 51, P), (56, 12, 51, P), (57, 11, 52, P),
        (58, 11, 52, P), (59, 11, 52, P), (60, 11, 52, P), (61, 11, 52, P),
        (62, 11, 52, P), (63, 11, 52, P),
    ]
    for y, x0, x1, c in body:
        runs(q, y, [(x0, x1, c)])
    for y, x0, x1 in [(46, 29, 34), (47, 29, 34), (48, 29, 34)]:
        runs(q, y, [(x0, x1, W)])
    runs(q, 46, [(29, 34, D)])
    for y, x0, x1 in [(49, 27, 36), (50, 26, 37), (51, 26, 37), (52, 26, 37)]:
        runs(q, y, [(x0, x1, B)])
    for y, x0, x1 in [(53, 14, 24), (54, 13, 24), (55, 12, 24), (56, 12, 24),
                      (57, 11, 24), (58, 11, 24), (59, 11, 24), (60, 11, 24),
                      (61, 11, 24), (62, 11, 24), (63, 11, 24)]:
        runs(q, y, [(x0, x1, B)])
    for y, x0, x1 in [(53, 39, 49), (54, 39, 50), (55, 39, 51), (56, 39, 51),
                      (57, 39, 52), (58, 39, 52), (59, 39, 52), (60, 39, 52),
                      (61, 39, 52), (62, 39, 52), (63, 39, 52)]:
        runs(q, y, [(x0, x1, B)])
    q.line(31, 53, 31, 63, M); q.line(32, 53, 32, 63, MD)
    q.rect(30, 53, 4, 2, M); q.px(31, 53, W)
    q.line(24, 53, 24, 63, S); q.line(39, 53, 39, 63, S)

    for y, x0, x1 in [(54, 42, 47), (55, 41, 49), (56, 41, 50), (57, 41, 51),
                      (58, 42, 51), (59, 43, 51), (60, 44, 51)]:
        runs(q, y, [(x0, x1, W)])
    q.line(45, 56, 45, 59, D); q.line(48, 56, 48, 59, D)
    q.px(42, 56, D)
    q.rect(41, 61, 11, 2, B)
    q.rect(41, 61, 11, 1, M)
    return q


# ---------------------------------------------------------------- battlefield

ECHO_BASE = """
............S...........
...........SB..........
........BBBBBBBB........
......BBBBBBBBBBBB......
.....BBBBBBBBBBBBBB.....
....BSSBBBBBBBBBBBB.....
....BSBBBBBBBBBBBBB.....
...BBBWWWWWWWWBBBBB.....
...BBWWWWWWWWWWWWBBB....
...BBWccWWWWWccWWBCC....
...BBWCWWWWWWCWWWBCC....
...BBWCCWWWWWCCWWBCC....
...BBWCCWWWWWCCWWBB.....
...BBWWWWWccWWWWWBB.....
....BWWWWWWWWWWWWB......
....BWWWWBBBBBBWWWCC....
...BWWWWWBBBBBBWWWCCC...
...BWRRWWBBBBBBWWWCCC...
...BWRRWWBBBBBBWWWCCC...
...BWWWWWBBBBBBWWWCC....
....BWWWWBBBBBBWWWCC....
.....BPPPBBBBBPPPBB.....
.....BPPB.....BPPB......
.....BBB.......BBB......
"""


def echo_frame(pose: int) -> Canvas:
    q = Canvas(24, 24)
    bob = pose & 1
    base = grid(ECHO_BASE)
    for a in (130, 170, 210, 250, 290):
        x = 11 + round(math.cos(math.radians(a)) * 11)
        y = 10 - bob - round(math.sin(math.radians(a)) * 10)
        q.rect(x, y, 2, 2, C if a == 210 else CD)
    # rim light on the hair crown so the dark silhouette lifts off the VOID arena
    for x in (4, 5, 6, 17, 18):
        yy = 5 - bob if x < 8 else 4 - bob
        if q.get(x, yy) == T:
            q.px(x, yy, S)
    q.blit(base, 0, -bob if bob else 0)
    q.px(5, 17 - bob, W)
    # eye catch-lights: tiny reception dots keep her cute and alive at 1x (Jigen chibi cue)
    q.px(6, 10 - bob, W); q.px(13, 10 - bob, W)
    if pose == 2:
        q.px(2, 18, C); q.px(1, 19, CD)
    if pose == 3:
        q.rect(19, 12 - bob, 2, 2, W); q.px(22, 9 - bob, C); q.px(22, 8 - bob, C)
    if pose == 4:
        q.rect(19, 14 - bob, 3, 2, W); q.rect(22, 12 - bob, 2, 4, C); q.px(23, 11 - bob, W)
    if pose == 5:
        q.rect(19, 13 - bob, 2, 3, W); q.rect(21, 12 - bob, 3, 4, C)
        q.px(22, 13 - bob, W); q.px(23, 16 - bob, CD)
    if pose == 6:
        q.rect(5, 15, 3, 3, W); q.px(4, 18, R); q.px(0, 10, R); q.px(23, 13, R)
    if pose == 7:
        q.rect(5, 15, 3, 3, W); q.rect(0, 8, 2, 2, R)
        q.px(3, 22, R); q.px(20, 4, R); q.px(23, 20, R)
    if pose == 8:
        q.rect(2, 9, 2, 3, C); q.px(1, 10, W)
        q.rect(19, 12, 2, 2, W); q.rect(21, 8, 2, 6, C); q.px(22, 9, W)
    if pose == 9:
        q.rect(2, 9, 2, 3, C); q.px(1, 10, U); q.px(0, 8, U)
        q.px(21, 6, C); q.px(23, 10, C)
    return q


SEEK_SHELL_BASE = """
....aaaaaaaaa...
...aAAAAAAAAaa..
..aAAAAAAAAAAa..
.aAAABBBBBBAAa..
.aAABBBBBBBBAa..
.aAABAABBBBBAa..
.aAABAABBWBBAa..
.aAABBBBBBBBAa..
.aAAABBBBBBAAa..
.aAAAAAAAAAAAa..
..aAAAAAAAAAa...
..aaAAAAAAAaa...
....aWWaaWWa....
....aWBaaWBa....
"""


def seek_shell_frame(pose: int) -> Canvas:
    q = Canvas(16, 16)
    bob = pose & 1
    q.blit(grid(SEEK_SHELL_BASE), 0, 1 - bob)
    q.line(0, 14, 3, 12 - bob, A); q.rect(0, 13, 2, 2, AD)
    if pose == 2:
        q.line(12, 9 - bob, 15, 5 - bob, A); q.px(15, 4 - bob, C)
    if pose == 3:
        q.rect(4, 12, 8, 3, AD); q.rect(6, 13, 4, 1, A); q.px(11, 13, W)
    return q


SEEK_AVATAR_BASE = """
........aaaaaaa.........
......aaaAAAAAaa........
.....aaAAAAAAAAaa.......
....aaAAAAAAAAAAa.......
....aAAAAAAAAAAAAa......
...aaAAAABWWWWWBAa......
...aAAAABAWWWWWWBa......
...aAAAABAWWWWWWBa......
...aAAAABAWBBBWWBa......
...aAAAABAWABAWWBa......
...aAAAABAWWWWWWBa......
...aAAAABAWWWWWWBa......
...aAAAABAWBBBWWBa......
...aAAAABAWWWWWWBa......
....aAAAABBBBBBBAa......
.....aABBBBBBBBAa.......
....BBBBBBBBBBBBBB......
...BBPPPPBBBPPPPBB......
...BPPPPPBBBPPPPPBB.....
...BPPPPaBBBaPPPPPB.....
...BPPPPaBBBaPPPPPB.....
...BPPPPPBBBPPPPPPB.....
....BPPPPPBPPPPPPB......
.....BBPPPPPPPPBB.......
"""


def seek_avatar_frame(pose: int) -> Canvas:
    q = Canvas(24, 24)
    q.blit(grid(SEEK_AVATAR_BASE), 0, 0)
    q.px(11, 8, W)              # iris glint on the one visible eye
    q.px(14, 13, W)             # small fang at the mouth corner
    q.line(18, 20, 22, 22, A); q.rect(21, 21, 2, 2, AD)
    if pose & 1:
        q.rect(11, 8, 3, 1, B); q.rect(11, 9, 3, 1, A)   # sleepy half-blink
    if pose == 2:
        q.line(18, 17, 23, 12, A); q.rect(21, 10, 3, 3, A); q.px(22, 11, C)
    if pose == 3:
        q.frame(17, 16, 6, 5, A); q.rect(19, 18, 3, 1, W)
    if pose == 4:
        q.rect(11, 9, 6, 2, B); q.rect(12, 11, 4, 1, A)
    if pose == 5:
        q.line(17, 19, 22, 17, A); q.rect(20, 14, 4, 4, AD); q.rect(21, 15, 2, 1, W)
    if pose == 6:
        q.frame(0, 0, 8, 7, A); q.rect(2, 2, 4, 3, AD); q.px(3, 3, W)
    if pose == 7:
        q.line(4, 18, 0, 14, A); q.rect(0, 12, 2, 2, AD); q.px(1, 13, C)
    return q


NOA_PROXY_BASE = """
.........BBBBB..........
.......BBBBBBBBB........
......BBBBBBBBBBB.......
......BBBBBBBBBBB.......
......BBBBBBBBBBB.......
......BWWWWWWWWWB.......
......BWWWWWWWWWB.......
......BWBBBWBBBWB.......
......BWBmmWBmmWB.......
......BWWWWWWWWWB.......
......BWWWmmWWWWB.......
......BWWWWWWWWWB.......
.......BWWWWWWWB........
......BBBBBBBBBBB.......
.....BBBPPmmPPBBB.......
.....BBPPPmmPPPBB.......
.....BBPPPmmPPPWW.......
.....BBPPPmmPPWWWW......
.....BBPPPmmPPPWW.......
......BPPPmmPPPBB.......
......BPPPmmPPPB........
......BPPPmmPPPB........
......BPPPmmPPPB........
.......BPPmmPPB.........
"""


def noa_proxy_frame(pose: int) -> Canvas:
    q = Canvas(24, 24)
    for x in (2, 21):
        q.line(x, 2, x, 22, MD if pose != 5 else M)
    q.blit(grid(NOA_PROXY_BASE), 0, 0)
    q.px(8, 8, W); q.px(13, 8, W)
    if pose == 1:
        q.rect(17, 10, 3, 3, W); q.px(18, 9, W); q.line(17, 13, 18, 16, W)
    if pose == 2:
        q.frame(4, 1, 17, 22, M)
    if pose == 3:
        q.rect(10, 10, 4, 1, MD)
    if pose == 4:
        q.line(17, 15, 22, 9, W); q.rect(21, 6, 3, 3, M); q.px(22, 7, W)
    if pose == 5:
        for y in range(2, 23, 5):
            q.rect(0, y, 3, 2, MD); q.rect(21, y + 2, 3, 2, M)
    return q


def noa_frame(stage: int) -> Canvas:
    q = Canvas(48, 64)
    step = (9, 7, 5)[stage]
    for x in range(4, 46, step):
        q.line(x, 2, x, 61, MD if x % 2 else M)
    count = (6, 14, 24)[stage]
    for i in range(count):
        x = 2 + (i * 11) % 42
        y = 3 + (i * 17) % 56
        q.frame(x, y, 4, 4, M if i % 3 else MD)
        q.px(x + 1, y + 1, W if i % 4 else MD)
    for y in range(6, 58):
        w0 = 13 if y > 10 else 13 + (10 - y)
        runs(q, y, [(w0, 45 - w0, B)])
    face = [(12, 19, 28), (13, 18, 29), (14, 18, 29), (15, 18, 29), (16, 18, 29),
            (17, 18, 29), (18, 18, 29), (19, 18, 29), (20, 19, 28), (21, 20, 27),
            (22, 21, 26)]
    for y, x0, x1 in face:
        runs(q, y, [(x0, x1, W)])
    for y, x0, x1 in [(8, 16, 31), (9, 15, 32), (10, 15, 32), (11, 15, 32)]:
        runs(q, y, [(x0, x1, B)])
    runs(q, 12, [(15, 17, B), (30, 32, B)])
    for y in range(12, 24):
        runs(q, y, [(14, 16, B), (31, 33, B)])
    for x0 in (18, 25):
        q.rect(x0, 14, 4, 1, B)
        q.rect(x0, 15, 4, 2, MD)
        q.px(x0 + 1, 15, W); q.px(x0 + 2, 16, W)
    q.rect(22, 19, 3, 1, MD)
    for y in range(24, 58):
        runs(q, y, [(16, 31, B)])
    for y in range(26, 58):
        runs(q, y, [(23, 24, M)])
    q.rect(21, 25, 6, 2, M); q.px(23, 25, W)
    for y, x0, x1 in [(26, 13, 34), (27, 12, 35), (28, 11, 36), (29, 11, 36), (30, 11, 36)]:
        runs(q, y, [(x0, x1, B)])
    for y, x0, x1 in [(34, 29, 33), (35, 28, 34), (36, 28, 35), (37, 28, 35), (38, 29, 35), (39, 30, 34)]:
        runs(q, y, [(x0, x1, W)])
    q.px(30, 36, D); q.px(32, 36, D)
    q.rect(28, 40, 8, 1, M)
    if stage >= 1:
        q.frame(8, 3, 32, 58, M)
    if stage == 2:
        for y in range(46, 63, 4):
            for x in range(1, 46, 5):
                q.rect(x, y, 3, 2, MD)
        for x0 in (18, 25):
            q.px(x0 + 2, 15, W); q.px(x0 + 2, 16, W)
    return q


ENEMY_CHAT = """
..RR......RRC...
..RR......RR.C..
.RRRRRRRRRRRR...
.RWWWWWWWWWWR...
.RWWWWWWWWWWR...
.RWBBWWWWBBWR...
.RWBBWWWWBBWR...
.RWWWWWWWWWWR...
.RWRRRRRRRWWR...
.RWWWWWWWRWWR...
.RRWWWWWWWRR....
..RRRRRRRR......
...RWW..........
..RWW...........
"""

ENEMY_AD = """
RRRRRRRRRRRRRRRR
RPPPPPPPPPPBWBR.
RPPPPPPPPPPWBWR.
RRRRRRRRRRRRRRR.
RWWWWWWWWWWWWWR.
RWBBWWWWWWBBWWR.
RWBBWWWWWWBBWWR.
RWWWWWWWWWWWWWR.
RWWWRRRRRRWWWWR.
RWWWWWWWWWWWWWR.
RRRRRRRRRRRRRRR.
...RR....RR.....
..RR......RR....
"""

ENEMY_GIFT = """
...MM......MM...
..MMMM....MMMM..
...MMMMMMMMMM...
....PPPRRPPP....
...PPPPRRPPPP...
..PPPPPRRPPPPP..
..PWWPPRRPPWWP..
..PWBPPRRPPBWP..
..PPPPPRRPPPPP..
..PPWWWRRWWWPP..
..PPPWWWWWWPPP..
..PPPPPPPPPPPP..
...PPPPPPPPPP...
....RR....RR....
"""

ENEMY_MOD = """
..MMMMMMMMMMMM..
.MMMMMMMMMMMMMM.
.MMBBBBBBBBBBMM.
.MBBWWWWWWWWBBM.
.MBWWWWWWWWWWBM.
.MBVVVVVVWWWWBM.
.MBVVVVVVWmmWBM.
.MBWWWWWWWWWWBM.
.MBWWWmmmmWWWBM.
.MBBWWWWWWWWBBM.
.MMBBBBBBBBBBMM.
..MMMMMMMMMMMM..
...M......M.....
"""

ENEMY_WORM = """
...aa......aa...
...aWa....aWa...
..aaaaaaaaaaaa..
..aAAAAAAAAAAa..
.aAAAAAAAAAAAAa.
.aAABBAAAABBAAa.
.aAABWAAAABWAAa.
.aAAAAAAAAAAAAa.
.aAAAAaaaaAAAAa.
..aAAAAAAAAAAa..
..aaAAAAAAAAaa..
...aaaaaaaaaa...
.aa....WWWa.....
aa.....WBWa.....
"""


def enemy(kind: int, pose: int = 0) -> Canvas:
    q = Canvas(16, 16)
    bob = pose & 1
    src = (ENEMY_CHAT, ENEMY_AD, ENEMY_GIFT, ENEMY_MOD, ENEMY_WORM)[kind]
    q.blit(grid(src), 0, 1 - bob)
    if kind == 4:
        q.line(0, 14, 3, 13 - bob, A)
    return q


def icon(kind: int) -> Canvas:
    q = Canvas(16, 16); c = (C, U, C, A, C, W, C, C, U, C, D, A, R)[kind]
    base = AD if kind in (3, 11) else MD if kind == 10 else P
    q.rect(3, 1, 10, 14, base)
    q.rect(1, 3, 14, 10, base)
    q.rect(2, 2, 2, 2, base); q.rect(12, 2, 2, 2, base)
    q.rect(2, 12, 2, 2, base); q.rect(12, 12, 2, 2, base)
    q.rect(4, 2, 8, 1, S); q.px(13, 4, W)
    if kind == 0: q.frame(3, 6, 10, 6, c); q.rect(1, 8, 3, 2, c); q.rect(12, 8, 3, 2, c); q.rect(6, 8, 4, 2, W)
    elif kind == 1: q.rect(3, 9, 2, 3, c); q.rect(7, 6, 2, 6, c); q.rect(11, 3, 2, 9, c); q.px(12, 3, W)
    elif kind == 2: q.frame(3, 4, 7, 8, c); q.frame(7, 6, 6, 7, c); q.px(5, 6, W)
    elif kind == 3: q.rect(3, 9, 10, 4, c); q.rect(4, 5, 8, 4, A); q.line(5, 4, 11, 4, W); q.rect(6, 10, 4, 1, W)
    elif kind == 4:
        q.rect(5, 3, 6, 11, c); q.rect(3, 5, 10, 7, c)
        q.line(6, 8, 8, 10, W); q.line(8, 10, 11, 6, W)
    elif kind == 5:                          # send / forward: a bold double chevron
        q.line(3, 4, 7, 8, c); q.line(7, 8, 3, 12, c)
        q.line(4, 4, 8, 8, c); q.line(8, 8, 4, 12, c)
        q.line(8, 4, 12, 8, c); q.line(12, 8, 8, 12, c)
        q.line(9, 4, 13, 8, c); q.line(13, 8, 9, 12, c)
        q.px(4, 5, W); q.px(9, 5, W)
    elif kind == 6: q.frame(3, 7, 6, 6, c); q.frame(6, 5, 6, 6, c); q.frame(9, 3, 4, 6, c); q.px(11, 4, W)
    elif kind == 7:
        q.rect(5, 3, 6, 8, c); q.rect(4, 4, 8, 6, c)
        q.rect(6, 5, 4, 4, B); q.px(8, 6, W); q.line(8, 10, 8, 14, c)
    elif kind == 8:
        q.line(8, 2, 4, 9, c); q.rect(4, 9, 4, 1, c)
        q.line(7, 9, 5, 14, c); q.line(5, 14, 12, 7, c)
        q.rect(9, 7, 3, 1, c); q.line(12, 7, 12, 2, c); q.px(9, 3, W)
    elif kind == 9: q.frame(3, 3, 10, 10, c); q.line(4, 9, 7, 12, W); q.line(7, 12, 12, 6, W); q.px(5, 4, W)
    elif kind == 10:
        q.rect(3, 4, 11, 7, c); q.rect(5, 11, 3, 3, c)
        q.rect(5, 6, 2, 2, W); q.rect(10, 6, 2, 2, W)
    elif kind == 11: q.rect(6, 3, 4, 8, c); q.rect(5, 8, 6, 4, c); q.line(3, 12, 13, 12, A); q.px(8, 4, W)
    else: q.line(3, 3, 12, 12, c); q.line(12, 3, 3, 12, c); q.rect(7, 2, 2, 12, W); q.rect(2, 7, 12, 2, R)
    return q


# ---------------------------------------------------------------- keyart

def big_ring(cv, cx, cy, rx, ry, c_dark, lit=(), gap=(15, 80), n=64, lit_c=None):
    for i in range(n):
        a = i * 360 / n
        if gap[0] <= a <= gap[1]:
            continue
        x = cx + round(math.cos(math.radians(a)) * rx)
        y = cy - round(math.sin(math.radians(a)) * ry)
        cv.rect(x, y, 2, 2, (lit_c or c_dark) if i in lit else c_dark)


def era_edges(q, left=True, right=True):
    if left:
        for i, w in enumerate((16, 11, 14, 8)):
            q.rect(3, 8 + i * 6, w, 1, S)
            q.px(2, 8 + i * 6, D)
        q.frame(3, 38, 14, 10, S); q.rect(5, 41, 8, 1, D); q.rect(5, 44, 6, 1, S)
    if right:
        for i in range(3):
            q.frame(176, 10 + i * 14, 12, 10, S)
            q.rect(178, 12 + i * 14, 8, 4, P)
            q.px(178, 18 + i * 14, D)


def antenna_tower(q, cx, top, bottom, c=U):
    """Lattice broadcast tower (Jigen Tsuushin cue). Network towers read SIGNAL BLUE."""
    h = max(1, bottom - top)
    topw, botw = 2, 7
    def w(i):
        return topw + (botw - topw) * (i / h)
    for i in range(h + 1):
        y = top + i
        lx, rx = round(cx - w(i)), round(cx + w(i))
        q.px(lx, y, c); q.px(rx, y, c)
    step = 8
    for b in range(top, bottom - step, step):
        l0, r0 = round(cx - w(b - top)), round(cx + w(b - top))
        l1, r1 = round(cx - w(b + step - top)), round(cx + w(b + step - top))
        q.line(l0, b, r1, b + step, c); q.line(r0, b, l1, b + step, c)
    q.line(cx, top - 5, cx, top, c)   # mast
    q.px(cx, top - 6, R)              # aircraft beacon: one red blink


def tally_marks(q, x, y, count, c=C):
    """正-style count strokes: how many of the 64 have answered."""
    gx = x
    for _ in range(count // 5):
        for k in range(4):
            q.line(gx + k * 2, y, gx + k * 2, y + 6, c)
        q.line(gx - 1, y + 6, gx + 7, y, c)
        gx += 12
    for k in range(count % 5):
        q.line(gx + k * 2, y, gx + k * 2, y + 6, c)


def echo_hand(q, x, y):
    for i, (x0, x1) in enumerate(((0, 8), (1, 10), (2, 12), (4, 13), (6, 14))):
        runs(q, y + i, [(x + x0, x + x1, C)])
    q.rect(x + 2, y + 4, 3, 1, CD)
    for i, (x0, x1) in enumerate(((10, 16), (9, 18), (9, 19), (10, 18), (11, 16))):
        runs(q, y + i, [(x + x0, x + x1, W)])
    runs(q, y - 1, [(x + 13, x + 16, W)])
    runs(q, y + 1, [(x + 19, x + 21, W)])
    runs(q, y + 2, [(x + 19, x + 22, W)])
    runs(q, y + 5, [(x + 12, x + 15, W)])
    q.px(x + 11, y - 1, D)


def keyart(kind: int) -> Canvas:
    q = Canvas(192, 108, V)
    q.rect(0, 0, 192, 3, B); q.rect(0, 105, 192, 3, B)

    if kind == 0:  # ENSEMBLE: Echo reaches out; Seek pulls; NOA has already answered.
        era_edges(q)
        antenna_tower(q, 122, 20, 96, U)   # a lone broadcast tower behind the incident
        q.blit(noa_portrait(0), 142, 8)
        for x in (140, 148, 158, 168, 178, 186):
            q.line(x, 4, x, 103, MD if x % 16 else M)
        for y in range(84, 104, 5):
            for x in range(128, 190, 7):
                q.rect(x, y, 4, 2, MD)
        q.rect(4, 78, 40, 26, B)
        for y, x0, x1 in [(80, 10, 34), (81, 8, 37), (82, 7, 39), (88, 7, 39), (89, 9, 36), (90, 12, 32)]:
            runs(q, y, [(x0, x1, S)])
        q.rect(14, 83, 12, 5, B)
        q.rect(17, 83, 6, 5, A); q.rect(19, 84, 3, 3, B); q.px(18, 84, W)
        q.rect(30, 79, 2, 2, AD); q.rect(35, 90, 2, 2, AD)
        cable = [(6, 96), (14, 97), (24, 98), (36, 98), (50, 97), (64, 95), (78, 92),
                 (90, 88), (100, 84), (108, 80)]
        for i in range(len(cable) - 1):
            q.line(cable[i][0], cable[i][1], cable[i + 1][0], cable[i + 1][1], A)
        q.rect(107, 76, 3, 3, AD)
        q.rect(10, 99, 8, 5, W); q.frame(10, 99, 8, 5, AD); q.rect(12, 101, 4, 1, B)
        big_ring(q, 62, 50, 44, 40, CD, lit={34, 35, 40, 46, 52}, gap=(10, 70), lit_c=C)
        tally_marks(q, 12, 30, 12, C)     # how many of the 64 have answered so far
        q.blit(echo_portrait(0), 30, 16)
        echo_hand(q, 92, 68)
        q.rect(118, 70, 4, 4, C); q.rect(119, 71, 2, 2, W)
        q.px(115, 74, CD); q.px(124, 68, CD)
        q.rect(132, 56, 4, 4, M); q.rect(133, 57, 2, 2, MD)
    elif kind == 1:  # ECHO WAITING: the audience that is not there.
        for y in range(20, 96, 9):
            for x in range(20, 78, 11):
                q.frame(x, y, 7, 5, S)
        antenna_tower(q, 12, 16, 98, U)   # she broadcasts from a tower into the empty seats
        q.rect(34, 8, 30, 1, S)
        big_ring(q, 128, 52, 46, 42, CD, lit={38}, gap=(10, 70), lit_c=C)
        tally_marks(q, 150, 84, 3, C)     # almost nobody has answered yet
        q.blit(echo_portrait(0), 96, 18)
        q.rect(88, 70, 3, 3, C)
        for i, x in enumerate((80, 71, 61, 50)):
            q.px(x, 71 + i, CD)
        q.px(38, 78, C)
    elif kind == 2:  # SEEK FIRST LIVE x3: same clip, different dates.
        q.blit(seek_portrait(0), 116, 12)
        for i, (x, y) in enumerate(((22, 18), (30, 42), (22, 66))):
            q.frame(x, y, 30, 20, AD)
            q.rect(x + 2, y + 2, 26, 16, B)
            q.rect(x + 4, y + 4, 10, 8, CD)
            q.rect(x + 6, y + 6, 4, 3, C)
            q.rect(x + 17, y + 5, 9, 1, A)
            q.rect(x + 17, y + 8, 6 + i, 1, D)
            q.rect(x + 17, y + 14, 8, 3, W); q.rect(x + 18, y + 15, 5, 1, B)
        q.line(120, 60, 84, 30, A); q.line(84, 30, 54, 26, A)
        q.line(120, 66, 88, 52, A); q.line(88, 52, 62, 50, A)
        q.line(120, 72, 86, 76, A); q.line(86, 76, 54, 74, A)
        q.rect(52, 24, 3, 3, AD); q.rect(60, 48, 3, 3, AD); q.rect(52, 72, 3, 3, AD)
    elif kind == 3:  # NOA PERFECT AUDIENCE: the wall is even; she is beautiful.
        for yy in range(4):
            for xx in range(12):
                x, y = 8 + xx * 15, 8 + yy * 15
                q.frame(x, y, 6, 6, MD)
                q.px(x + 2, y + 2, S)
        q.blit(noa_portrait(1), 64, 14)
        for y in range(84, 104, 5):
            q.rect(10, y, 5, 2, D)
            q.rect(18, y, 44, 2, MD)
            q.rect(130, y, 5, 2, D)
            q.rect(138, y, 44, 2, MD)
        q.rect(88, 86, 16, 2, M); q.rect(88, 92, 16, 2, M)
    elif kind == 4:  # OPEN CHANNEL: three colors own the 64 ring.
        n = 64
        for i in range(n):
            a = i * 360 / n
            x = 96 + round(math.cos(math.radians(a)) * 78)
            y = 54 - round(math.sin(math.radians(a)) * 44)
            c = C if i % 8 < 5 else (A if i % 8 < 7 else M)
            q.rect(x, y, 2, 2, c)
        for i in range(n):
            a = i * 360 / n
            x = 96 + round(math.cos(math.radians(a)) * 60)
            y = 54 - round(math.sin(math.radians(a)) * 33)
            if i % 4 == 0:
                q.rect(x, y, 2, 2, CD)
        for i, x in enumerate(range(28, 168, 18)):
            h = (10, 16, 8, 20, 12, 18, 9, 15)[i]
            q.rect(x, 84 - h, 4, h, CD if i % 3 else C)
            q.px(x + 1, 84 - h - 2, C)
        q.blit(echo_frame(8), 72, 32, scale=2)
        q.rect(64, 82, 64, 1, S)
        for x, y in ((52, 30), (140, 26), (36, 60), (156, 58)):
            q.rect(x, y, 3, 3, C); q.px(x + 4, y - 1, CD)
    else:  # NO CARRIER: three residues on a dead monitor.
        q.frame(30, 14, 132, 80, S)
        q.rect(32, 16, 128, 76, B)
        for a in (140, 160, 180, 200, 220, 240):
            x = 96 + round(math.cos(math.radians(a)) * 26)
            y = 52 - round(math.sin(math.radians(a)) * 22)
            q.rect(x, y, 2, 2, CD)
        q.rect(96, 30, 2, 2, C)
        q.rect(34, 52, 124, 1, P)
        q.rect(70, 66, 10, 6, W); q.frame(70, 66, 10, 6, AD); q.rect(72, 68, 6, 1, B)
        q.rect(118, 44, 3, 3, M)
        q.px(96, 88, L)
        q.rect(40, 22, 20, 1, CD); q.rect(40, 26, 12, 1, S)
    return q


# ---------------------------------------------------------------- output

def png(path: Path, cv: Canvas, scale: int = 1) -> None:
    w, h = cv.w * scale, cv.h * scale
    raw = bytearray()
    for y in range(h):
        raw.append(0)
        sy = y // scale
        for x in range(w): raw.append(cv.p[sy * cv.w + x // scale])
    def chunk(name: bytes, data: bytes) -> bytes:
        return struct.pack(">I", len(data)) + name + data + struct.pack(">I", zlib.crc32(name + data) & 0xffffffff)
    plte = b"".join(bytes(c) for c in PAL)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 3, 0, 0, 0)) + chunk(b"PLTE", plte) + chunk(b"tRNS", bytes([255] * 15 + [0])) + chunk(b"IDAT", zlib.compress(bytes(raw), 9)) + chunk(b"IEND", b""))


def sheet(frames: list[Canvas]) -> Canvas:
    out = Canvas(sum(f.w for f in frames), max(f.h for f in frames))
    x = 0
    for f in frames: out.blit(f, x, 0); x += f.w
    return out


GLYPH = {
    "E": (31,16,30,16,31), "C": (15,16,16,16,15), "H": (17,17,31,17,17),
    "O": (14,17,17,17,14), "/": (1,2,4,8,16), "1": (4,12,4,4,14),
    "4": (10,18,31,2,2),
}


def logo(accent: int = C) -> Canvas:
    q = Canvas(92, 18)
    x = 2
    for ch in "ECHO/144":
        rows = GLYPH[ch]
        for y, bits in enumerate(rows):
            for xx in range(5):
                if bits & (1 << (4-xx)): q.rect(x+xx*2, 3+y*2, 2, 2, R if ch == "/" else W)
        x += 11
    q.rect(2,14,50,2,accent); q.rect(58,14,26,2,R); q.rect(87,2,3,3,R)
    return q


def capsule(source: Canvas, w: int, h: int, vertical: bool = False) -> Canvas:
    q = Canvas(w, h, V)
    if vertical:
        q.blit(resized(source, w, max(1, h*5//9)), 0, 0)
        q.rect(0, h*5//9-2, w, h-h*5//9+2, B)
        hero = resized(echo_portrait(0), w*2//5, w*2//5)
        q.blit(hero, w//12, h*4//9)
        mark = resized(logo(), w*4//5, max(12, h//11)); q.blit(mark, w//10, h*4//5)
        q.rect(w//10, h*9//10, w*3//5, max(2,h//150), C); q.rect(w*3//4,h*9//10,max(3,w//90),max(3,w//90),R)
    else:
        q.blit(resized(source, w, h), 0, 0)
        panel = max(34, w*9//20); q.rect(0, 0, panel, h, B)
        for yy in range(h):
            x1 = panel - yy * (w // 12) // max(1, h)
            q.rect(x1, yy, 1, 1, B)
        hero_size = h*4//5; q.blit(resized(echo_portrait(0), hero_size, hero_size), panel-h//8, h//10)
        mark = resized(logo(), min(panel-6, w*2//5), max(8,h//3)); q.blit(mark, max(3,w//40), max(2,h//8))
        q.rect(max(3,w//40), h*4//5, max(12,panel*2//3), max(1,h//80), C)
    q.frame(0,0,w,h,P)
    return q


def c_array(name: str, cv: Canvas) -> str:
    rows = []
    for y in range(cv.h):
        src = cv.p[y*cv.w:(y+1)*cv.w]
        packed = [(src[x] << 4) | src[x + 1] for x in range(0, cv.w, 2)]
        rows.append("    " + ",".join(f"0x{v:02x}" for v in packed) + ",")
    return f"static const uint8_t {name}[{cv.w * cv.h // 2}]={{\n" + "\n".join(rows) + "\n};\n"


def validate(echo: Canvas, seek: Canvas, seek_shell: Canvas, seek_avatar: Canvas, noa: Canvas, noa_proxy: Canvas, portraits: Canvas, expressions: Canvas, foes: Canvas, cards: Canvas, keys: list[Canvas]) -> None:
    assert (echo.w, echo.h) == (240, 24) and (seek.w, seek.h) == (96, 24)
    assert (seek_shell.w, seek_shell.h) == (64, 16) and (seek_avatar.w, seek_avatar.h) == (192, 24)
    assert (noa.w, noa.h) == (144, 64) and (noa_proxy.w, noa_proxy.h) == (144, 24)
    assert (portraits.w, portraits.h) == (192, 64) and (expressions.w, expressions.h) == (960, 64)
    assert (foes.w, foes.h) == (160, 16) and (cards.w, cards.h) == (208, 16)
    assert all((q.w, q.h) == (192, 108) for q in keys)
    assert all(v < 16 for cv in (echo, seek, seek_shell, seek_avatar, noa, noa_proxy, portraits, expressions, foes, cards, *keys) for v in cv.p)
    # Identity anchors: every Echo frame keeps a red LIVE pin; each Noa stage keeps the white glove.
    for i in range(10): assert sum(echo.p[y*echo.w+i*24:y*echo.w+(i+1)*24].count(R) for y in range(24)) >= 3
    for i in range(3): assert sum(noa.p[y*noa.w+i*48:y*noa.w+(i+1)*48].count(W) for y in range(64)) >= 30
    for i in range(4): assert any(seek_shell.p[y*seek_shell.w+i*16] in (AD, A) for y in range(16))
    for i in range(6): assert sum(noa_proxy.p[y*noa_proxy.w+i*24:y*noa_proxy.w+(i+1)*24].count(W) for y in range(24)) >= 8
    assert len({bytes(enemy(i, p).p) for i in range(5) for p in range(2)}) == 10
    assert len({bytes(icon(i).p) for i in range(13)}) == 13
    # Marketing originals must be fully painted (no transparency holes).
    assert all(q.p.count(T) == 0 for q in keys)


def build() -> None:
    echo = sheet([echo_frame(i) for i in range(10)])
    seek = sheet([seek_avatar_frame(i) for i in range(4)])
    seek_shell = sheet([seek_shell_frame(i) for i in range(4)])
    seek_avatar = sheet([seek_avatar_frame(i) for i in range(8)])
    noa = sheet([noa_frame(i) for i in range(3)])
    noa_proxy = sheet([noa_proxy_frame(i) for i in range(6)])
    foes = sheet([enemy(i, p) for i in range(5) for p in range(2)])
    cards = sheet([icon(i) for i in range(13)])
    portraits = sheet([echo_portrait(), seek_portrait(), noa_portrait()])
    result_portraits = sheet([echo_portrait(7), noa_portrait(2)])
    echo_expressions = [echo_portrait(i) for i in range(8)]
    assert len({bytes(q.p) for q in echo_expressions}) == 8
    seek_expressions = [seek_portrait(i) for i in range(4)]
    assert len({bytes(q.p) for q in seek_expressions}) == 4
    expressions = sheet(echo_expressions + seek_expressions + [noa_portrait(i) for i in range(3)])
    exports = ROOT / "art" / "export"
    for name, cv in (("chr_echo_sheet", echo), ("chr_seek_sheet", seek), ("chr_seek_shell", seek_shell), ("chr_seek_avatar", seek_avatar), ("chr_noa_stages", noa), ("chr_noa_proxy", noa_proxy), ("character_portraits", portraits), ("enemy_sheet", foes), ("card_icon_sheet", cards)):
        png(exports / f"{name}.png", cv); png(ROOT / "art" / "review" / f"{name}_8x.png", cv, 8)
    png(exports / "character_expression_sheet.png", expressions); png(ROOT / "art" / "review" / "character_expression_sheet_4x.png", expressions, 4)
    keys = [keyart(i) for i in range(6)]
    validate(echo, seek, seek_shell, seek_avatar, noa, noa_proxy, portraits, expressions, foes, cards, keys)
    names = ("ensemble", "echo_waiting", "seek_first_live", "noa_audience", "open_channel", "no_carrier")
    for name, cv in zip(names, keys):
        png(exports / f"keyart_{name}_192x108.png", cv); png(exports / f"keyart_{name}_576x324.png", cv, 3)
    marketing = exports / "marketing"
    png(marketing / "logo_echo144_light.png", logo())
    png(marketing / "logo_echo144_signal.png", logo(M))
    for name, w, h, vertical in (("micro_120x45",120,45,False),("capsule_184x69",184,69,False),("feature_300x168",300,168,False),("steam_small_462x174",462,174,False),("steam_header_920x430",920,430,False),("steam_main_1232x706",1232,706,False),("steam_vertical_748x896",748,896,True)):
        png(marketing / f"{name}.png", capsule(keys[0], w, h, vertical))
    contact = Canvas(192 * 3, 108 * 2, V)
    for i, cv in enumerate(keys): contact.blit(cv, i % 3 * 192, i // 3 * 108)
    png(ROOT / "art" / "review" / "keyart_contact.png", contact)
    generated = ROOT / "src" / "generated"; generated.mkdir(parents=True, exist_ok=True)
    text = "/* Generated by tools/build_art.py from V2 pixel sources. */\n"
    text += c_array("ART_ECHO", echo) + c_array("ART_SEEK_SHELL", seek_shell) + c_array("ART_SEEK_AVATAR", seek_avatar)
    text += c_array("ART_NOA", noa) + c_array("ART_NOA_PROXY", noa_proxy)
    text += c_array("ART_RESULT_PORTRAIT", result_portraits)
    text += c_array("ART_ENEMY", foes) + c_array("ART_CARD", cards) + c_array("ART_KEYART", keys[0])
    (generated / "art.inc").write_text(text, encoding="ascii")


if __name__ == "__main__": build()
