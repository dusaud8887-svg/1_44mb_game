"""Hand-authored V2 pixel assets: indexed PNG previews plus embedded C data."""
from __future__ import annotations

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


class Canvas:
    def __init__(self, w: int, h: int, fill: int = T):
        self.w, self.h, self.p = w, h, bytearray([fill]) * (w * h)

    def px(self, x: int, y: int, c: int) -> None:
        if 0 <= x < self.w and 0 <= y < self.h:
            self.p[y * self.w + x] = c

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

    def ellipse(self, x: int, y: int, w: int, h: int, c: int) -> None:
        # Pixel-cluster ellipse. Integer coverage keeps every edge hard.
        rx, ry = w / 2, h / 2
        for yy in range(y, y + h):
            for xx in range(x, x + w):
                dx, dy = (xx + .5 - x) / rx - 1, (yy + .5 - y) / ry - 1
                if dx * dx + dy * dy <= 1: self.px(xx, yy, c)

    def poly(self, points: list[tuple[int, int]], c: int) -> None:
        ymin, ymax = min(y for _, y in points), max(y for _, y in points)
        for y in range(ymin, ymax + 1):
            hits = []
            for i, (x0, y0) in enumerate(points):
                x1, y1 = points[(i + 1) % len(points)]
                if y0 == y1 or not (min(y0, y1) <= y < max(y0, y1)): continue
                hits.append(round(x0 + (y - y0) * (x1 - x0) / (y1 - y0)))
            hits.sort()
            for i in range(0, len(hits) - 1, 2): self.rect(hits[i], y, hits[i + 1] - hits[i] + 1, 1, c)

    def blit(self, other: "Canvas", x: int, y: int, scale: int = 1) -> None:
        for yy in range(other.h):
            for xx in range(other.w):
                c = other.p[yy * other.w + xx]
                if c != T: self.rect(x + xx * scale, y + yy * scale, scale, scale, c)


def ring(cv: Canvas, cx: int, cy: int, rx: int, ry: int, c: int, gap=(5, 8), blocks=32) -> None:
    # Deliberately clustered ellipse: every sample is a 2px segment, never antialiased.
    import math
    for i in range(blocks):
        if gap[0] <= i <= gap[1]: continue
        a = i * 2 * math.pi / blocks
        x, y = cx + round(math.cos(a) * rx), cy + round(math.sin(a) * ry)
        cv.rect(x, y, 2, 2, c)


def echo_frame(pose: int) -> Canvas:
    q = Canvas(24, 24)
    bob = pose & 1
    # Broken receiver ring, then a compact chibi silhouette with a long right sidelock.
    q.rect(3, 5-bob, 2, 6, CD); q.rect(4, 3-bob, 5, 2, C); q.rect(17, 4-bob, 3, 2, C)
    q.ellipse(6, 3-bob, 13, 12, B); q.rect(16, 8-bob, 3, 9, B); q.px(19, 15-bob, B)
    q.ellipse(8, 6-bob, 9, 8, W); q.rect(8, 6-bob, 4, 2, B); q.px(11, 9-bob, B); q.px(15, 9-bob, B)
    q.px(10, 8-bob, B); q.line(13, 12-bob, 15, 11-bob, CD)  # crooked smile.
    q.poly([(8,13-bob),(16,13-bob),(18,21),(6,21)],P); q.rect(10, 14-bob, 4, 7, W)
    q.poly([(6,14-bob),(9,14-bob),(8,21),(3,20)],C); q.rect(4, 16-bob, 4, 3, CD)
    q.poly([(16,14-bob),(18,14-bob),(20,20),(16,20)],S); q.rect(16, 14-bob, 2, 2, R)
    q.rect(7, 21, 3, 3, B); q.rect(14, 21-bob, 3, 3+bob, B)
    if pose == 2: q.line(5, 16, 1, 12, C); q.ellipse(0, 10, 4, 4, W)
    if pose == 3: q.line(17, 16, 22, 11, W); q.ellipse(20, 8, 4, 5, C); q.px(23, 9, W)
    if pose == 4: q.rect(15, 11, 4, 4, W); q.rect(17, 11, 2, 2, R); q.rect(3, 5, 2, 7, R)
    if pose == 5: q.line(18, 14, 21, 7, C); q.ellipse(19, 4, 4, 5, C); q.px(21, 6, W)
    if pose == 6: q.line(5, 17, 1, 14, C); q.px(0, 13, W); q.rect(1, 11, 2, 2, C)
    if pose == 7: q.line(5, 17, 1, 18, C); q.line(18, 16, 22, 17, W); q.rect(22, 15, 2, 4, C)
    if pose == 8: q.rect(14, 11, 5, 4, W); q.rect(16, 11, 3, 2, R); q.line(4, 4, 2, 9, R)
    if pose == 9: q.rect(20, 5, 3, 5, U); q.px(21, 6, W); q.line(18, 14, 21, 10, W)
    return q


def seek_frame(pose: int) -> Canvas:
    q = Canvas(24, 24)
    bob = pose & 1
    # The only cable visibly begins at the rear socket.
    q.line(1, 20, 7, 18, A); q.line(1, 20, 0, 17+bob, A); q.rect(0, 16+bob, 2, 2, AD)
    q.poly([(6,10-bob),(9,7-bob),(17,7-bob),(21,12-bob),(20,19),(7,19)],AD)
    q.poly([(8,11-bob),(11,9-bob),(17,10-bob),(19,14-bob),(17,18),(8,17)],A)
    q.rect(10, 11-bob, 7, 5, B); q.px(12, 13-bob, W); q.px(15, 13-bob, W); q.px(16, 15-bob, W)
    q.rect(7, 12-bob, 2, 3, B); q.rect(18, 14-bob, 3, 2, A); q.px(21, 15-bob, AD)
    q.frame(5, 5-bob, 7, 7, A); q.rect(5, 8-bob, 2, 2, T); q.px(8, 8-bob, A)
    q.rect(8, 19, 3, 2, AD); q.rect(16, 18, 3, 3, AD); q.px(12, 18, W)  # date label.
    if pose == 2: q.line(19, 14, 23, 9, A); q.ellipse(21, 7, 3, 4, A); q.px(22, 8, C)
    if pose == 3: q.rect(9, 14, 9, 4, AD); q.line(2, 20, 8, 22, A)
    return q


def seek_shell_frame(pose: int) -> Canvas:
    q = Canvas(16, 16)
    bob = pose & 1
    q.line(0, 14, 4, 12, A); q.rect(0, 13, 2, 2, AD)  # cable leads.
    q.poly([(3,8-bob),(6,5-bob),(12,6-bob),(15,10),(13,14),(4,14)],AD)
    q.poly([(5,8-bob),(8,7-bob),(13,9-bob),(12,12),(5,12)],A)
    q.rect(7, 8-bob, 4, 3, B); q.px(8, 9-bob, W); q.px(10, 10-bob, W)
    q.frame(2, 3-bob, 6, 6, A); q.rect(2, 5-bob, 2, 2, T)
    if pose == 2: q.line(13, 10, 15, 6, A); q.px(15, 5, C)
    if pose == 3: q.rect(5, 11, 8, 3, AD); q.line(0, 14, 5, 15, A)
    return q


def seek_avatar_frame(pose: int) -> Canvas:
    q = Canvas(24, 24)
    q.poly([(5,8),(8,3),(15,3),(20,8),(20,21),(4,21)],AD)
    q.poly([(7,9),(10,6),(17,7),(19,12),(17,19),(6,18)],A)
    q.ellipse(9, 7, 9, 9, W); q.poly([(7,7),(14,4),(13,17),(6,16)],B)
    q.line(14, 10, 17, 10, AD); q.px(16, 11, B); q.px(15, 14, AD); q.px(17, 15, W)
    q.rect(6, 17, 12, 5, B); q.rect(17, 17, 3, 4, AD)
    q.rect(5, 17, 2, 2, AD); q.line(5, 18, 1, 22, A); q.rect(0, 21, 3, 2, AD)
    if pose & 1: q.px(17, 10, W); q.line(14, 14, 17, 14, AD)
    if pose == 2: q.line(18, 18, 23, 14, A); q.rect(21, 12, 3, 3, A)
    if pose == 3: q.frame(17, 16, 6, 5, A); q.rect(19, 18, 3, 1, W)
    return q


def noa_frame(stage: int) -> Canvas:
    q = Canvas(48, 64)
    # Profile ring and vertical comment veil are separate, mechanically exact layers.
    count = (6, 14, 24)[stage]
    for i in range(count):
        x = 3 + (i * 7) % 42; y = 4 + (i * 11) % 54
        q.frame(x, y, 3, 3, M if i % 3 else MD)
    for x in range(5 + stage, 47, 7): q.line(x, 2, x, 61, MD if x % 2 else M)
    q.ellipse(14, 7, 21, 23, B); q.ellipse(18, 11, 13, 16, W)
    q.rect(14, 8, 21, 8, B); q.rect(15, 13, 3, 15, B); q.rect(31, 12, 4, 16, B)
    q.rect(19, 16, 4, 1, MD); q.rect(27, 16, 3, 1, MD)
    q.line(20, 18, 23, 18, MD); q.line(27, 18, 30, 18, MD); q.rect(21, 19, 2, 2, MD); q.rect(28, 19, 2, 2, MD); q.px(22, 19, W); q.px(29, 19, W)
    q.line(24, 23, 28, 23, MD); q.px(28, 22, MD)
    q.poly([(15,29),(33,29),(38,57),(10,57)],B); q.poly([(18,30),(30,30),(32,56),(16,56)],P)
    q.line(24, 31, 24, 55, M); q.rect(11, 34, 5, 19, B); q.rect(33, 33, 5, 17, B)
    q.line(36, 47, 39, 31, W); q.ellipse(36, 27, 6, 7, W); q.px(39, 28, S)  # connected white glove.
    if stage: q.frame(10, 5, 28, 55, M)
    if stage == 2:
        for y in range(45, 63, 4):
            for x in range(2, 46, 5): q.rect(x, y, 3, 2, MD)
    return q


def noa_proxy_frame(pose: int) -> Canvas:
    q = Canvas(24, 24)
    for x in (2, 21): q.line(x, 2, x, 22, M)
    q.ellipse(7, 3, 11, 12, B); q.ellipse(9, 6, 7, 8, W); q.rect(7, 4, 11, 5, B)
    q.line(9, 10, 12, 10, MD); q.line(14, 10, 16, 10, MD); q.px(11, 11, MD); q.px(15, 11, MD)
    q.poly([(7,15),(17,15),(20,23),(4,23)],B); q.rect(10, 16, 5, 7, P); q.line(12, 16, 12, 22, M)
    q.line(18, 21, 19, 15, W); q.ellipse(17, 13, 4, 4, W)
    if pose == 1: q.line(18, 15, 22, 11, W); q.px(22, 10, M)
    if pose == 2: q.frame(3, 1, 18, 22, M)
    return q


def echo_portrait(expression: int = 0) -> Canvas:
    q = Canvas(64, 64)
    ring(q, 31, 31, 27, 26, CD, (4, 9), 40)
    # Long asymmetric broadcast hair: short left sweep, long right tail.
    q.ellipse(11, 4, 42, 48, B); q.poly([(39,14),(54,18),(58,64),(43,60)],B)
    q.poly([(14,28),(22,39),(20,60),(10,55)],B); q.line(15, 20, 20, 10, P); q.line(45, 17, 52, 49, P)
    q.ellipse(19, 13, 29, 36, W); q.poly([(19,13),(32,7),(29,24),(17,29)],B)
    q.poly([(30,9),(47,15),(45,25),(39,21),(35,25)],B); q.rect(18, 18, 3, 13, C)
    q.rect(44, 20, 4, 13, CD); q.rect(46, 23, 3, 7, C)  # one receiver only.
    # Eyes use different widths and eyebrow heights; expression is a small delta.
    q.line(24, 26-(expression==3), 30, 24-(expression==3), B); q.line(36, 25 if expression==5 else 26, 42, 27, B)
    if expression in (1, 7):
        q.ellipse(25, 29, 6, 7, B); q.ellipse(37, 29, 6, 7, B); q.rect(27, 30, 2, 3, C); q.rect(39, 30, 2, 3, C); q.px(28, 30, W); q.px(40, 30, W)
    elif expression == 4:
        q.line(25, 31, 30, 32, B); q.line(37, 32, 42, 31, B)
    else:
        q.ellipse(25, 29, 6, 6, B); q.ellipse(37, 29, 5, 6, B); q.rect(27, 30, 2, 3, C); q.rect(39, 30, 2, 3, C); q.px(28, 30, W); q.px(40, 30, W)
    q.px(22, 37, M); q.rect(23, 38, 2, 1, M); q.px(43, 37, M)
    if expression == 7: q.rect(21, 37, 3, 2, M); q.rect(43, 37, 2, 2, M)
    if expression in (1, 7): q.ellipse(31, 39, 7, 6, CD); q.rect(33, 40, 4, 2, W)
    elif expression == 2: q.line(30, 41, 38, 38, CD); q.px(30, 40, CD)
    elif expression == 5: q.line(31, 40, 37, 40, CD); q.px(37, 39, CD)
    elif expression in (3, 4, 6): q.line(31, 41, 38, 41, CD); q.px(31, 40, CD)
    else: q.line(31, 41, 38, 39, CD); q.px(38, 40, CD)
    # High-neck asymmetric presenter jacket, five cue tabs, and the one red pin.
    q.poly([(12,55),(22,46),(43,46),(58,59),(58,64),(7,64)],P); q.rect(27, 47, 11, 17, B)
    q.poly([(8,59),(17,48),(26,52),(21,64),(3,64)],C); q.rect(14, 55, 9, 5, CD)
    q.poly([(41,48),(51,50),(59,64),(40,64)],S); q.rect(45, 49, 4, 4, R)
    for i in range(5): q.rect(9+i*3, 61-(i&1), 2, 2, W)
    q.ellipse(49, 42, 7, 8, W); q.line(51, 47, 56, 37, W); q.ellipse(54, 33, 5, 6, C)
    return q


def seek_portrait() -> Canvas:
    q = Canvas(64, 64)
    # Hood antennae can be mistaken for ears at first glance, but terminate as connectors.
    q.poly([(13,18),(18,4),(27,17)],AD); q.rect(17, 3, 3, 5, A)
    q.poly([(38,16),(49,4),(52,21)],AD); q.rect(48, 3, 4, 5, A)
    q.ellipse(7, 10, 50, 53, AD); q.ellipse(12, 16, 41, 43, A); q.ellipse(17, 20, 31, 35, B)
    q.poly([(16,20),(34,14),(53,25),(46,57),(12,57)],AD)
    q.poly([(22,23),(43,24),(46,43),(37,53),(20,47)],W)
    q.poly([(17,21),(35,18),(30,54),(14,51)],B)  # half the face stays unreadable.
    q.line(33, 31, 40, 30, AD); q.ellipse(35, 33, 5, 4, B); q.px(38, 33, A)
    q.line(34, 43, 42, 43, AD); q.poly([(39,43),(43,43),(41,48)],W)
    q.rect(10, 53, 45, 11, AD); q.frame(45, 50, 12, 8, A); q.rect(48, 53, 6, 2, W)
    q.rect(6, 47, 4, 5, AD); q.line(8, 51, 1, 60, A); q.rect(0, 59, 4, 3, AD)
    return q


def noa_portrait(expression: int = 0) -> Canvas:
    q = Canvas(64, 64)
    for x in (5, 12, 51, 58): q.line(x, 2+(x&1), x, 61, M if x & 1 else MD)
    q.ellipse(12, 5, 41, 48, B); q.ellipse(20, 13, 27, 34, W)
    q.rect(13, 7, 39, 14, B); q.rect(13, 17, 7, 35, B); q.rect(46, 18, 7, 36, B)
    q.poly([(16,8),(27,6),(24,22),(18,27)],B); q.poly([(29,6),(48,10),(46,24),(39,18),(35,23)],B)
    q.line(16, 15, 19, 41, M); q.line(49, 15, 47, 43, MD)
    q.line(21, 25, 28, 24, MD); q.line(37, 24, 43, 25, MD)
    if expression == 1:
        q.line(22, 30, 29, 31, MD); q.line(37, 31, 43, 30, MD)
    else:
        q.line(22, 29, 29, 29, MD); q.line(37, 29, 43, 29, MD)
        q.rect(24, 30, 3, 2, MD); q.rect(39, 30, 3, 2, MD); q.px(25, 30, W); q.px(40, 30, W)
    # Four tiny profile highlights inside the listening gaze.
    q.px(23, 29, M); q.px(27, 29, M); q.px(38, 29, M); q.px(42, 29, M)
    q.px(19, 36, L)
    if expression == 2: q.line(30, 39, 40, 39, MD)
    else: q.line(31, 39, 39, 38, MD); q.px(39, 39, MD)
    q.poly([(12,54),(21,45),(46,46),(58,62),(58,64),(7,64)],B)
    q.poly([(24,47),(42,47),(45,64),(20,64)],P); q.line(33, 48, 33, 63, M)
    # One hand crosses the portrait as if tidying the viewer's frame.
    q.line(51, 61, 47, 45, W); q.ellipse(44, 39, 8, 10, W); q.rect(47, 36, 2, 7, W); q.px(48, 37, S)
    q.frame(3, 9, 56, 51, M)
    return q


def enemy(kind: int) -> Canvas:
    q = Canvas(16, 16)
    if kind == 0:  # heckler: speech bubble with biting tail.
        q.poly([(2,4),(12,3),(14,6),(12,11),(8,11),(5,15),(5,11),(2,10)],R); q.rect(4, 6, 2, 2, W); q.rect(9, 6, 2, 2, W); q.line(5, 9, 10, 9, B)
    elif kind == 1:  # popup: tilted close box.
        q.frame(1, 2, 14, 12, R); q.frame(3, 4, 10, 8, P); q.line(9, 4, 12, 7, W); q.line(12, 4, 9, 7, W)
    elif kind == 2:  # clip: predatory scissors.
        q.ellipse(1, 8, 5, 6, M); q.ellipse(10, 8, 5, 6, M); q.line(4, 10, 9, 3, W); q.line(11, 10, 6, 3, W); q.rect(7, 2, 2, 3, M)
    elif kind == 3:  # bot: censored profile tile.
        q.frame(2, 1, 12, 14, M); q.ellipse(5, 3, 6, 6, MD); q.rect(4, 10, 8, 3, MD); q.rect(7, 2, 2, 12, V)
    else:  # cache mite: low triangular crawler.
        q.line(0, 12, 5, 11, A); q.poly([(4,10),(7,5),(12,7),(15,13),(5,13)],AD); q.ellipse(7, 7, 5, 5, A); q.px(9, 8, W); q.rect(13, 11, 3, 2, A)
    return q


def icon(kind: int) -> Canvas:
    q = Canvas(16, 16); c = (C, U, C, A, C, W, C, C, U, C, D, A, R)[kind]
    if kind == 0: q.frame(3, 5, 10, 7, c); q.rect(1, 7, 3, 3, c); q.rect(12, 7, 3, 3, c)
    elif kind == 1: q.rect(2, 9, 3, 4, c); q.rect(6, 6, 3, 7, c); q.rect(10, 3, 3, 10, c)
    elif kind == 2: q.frame(2, 3, 8, 9, c); q.frame(6, 5, 8, 9, c)
    elif kind == 3: q.rect(2, 3, 11, 3, c); q.rect(4, 7, 9, 3, c); q.rect(6, 11, 7, 2, c)
    elif kind == 4: q.line(2, 13, 2, 3, c); q.line(2, 3, 13, 3, c); q.line(13, 3, 13, 9, c)
    elif kind == 5: q.frame(2, 3, 7, 8, c); q.frame(7, 5, 7, 8, c); q.line(10, 2, 13, 4, c)
    elif kind == 6: q.frame(2, 5, 5, 7, c); q.frame(6, 4, 5, 7, c); q.frame(10, 3, 4, 7, c)
    elif kind == 7:
        for x in (2, 7, 12): q.frame(x, 4, 3, 5, c); q.rect(x, 11, 2, 2, c)
    elif kind == 8: q.line(2, 13, 6, 4, c); q.line(6, 4, 10, 12, c); q.line(10, 12, 14, 3, c)
    elif kind == 9: q.frame(2, 3, 12, 10, c); q.line(3, 10, 6, 13, c); q.line(6, 13, 13, 5, c)
    elif kind == 10: q.frame(2, 3, 12, 9, c); q.rect(4, 12, 3, 2, c); q.rect(4, 6, 2, 2, c); q.rect(9, 6, 2, 2, c)
    elif kind == 11:
        for r in (3, 5, 7): q.frame(8-r, 8-r, r*2, r*2, c)
    else: q.line(2, 2, 13, 13, c); q.line(13, 2, 2, 13, c)
    return q


def keyart(kind: int) -> Canvas:
    q = Canvas(192, 108, V)
    q.rect(5, 7, 182, 94, B); q.frame(5, 7, 182, 94, P)
    # Interface fragments frame the incident instead of filling the focal area.
    for y, w in ((15,24),(22,14),(84,20),(91,32)): q.rect(10, y, w, 1, S)
    for x in (168, 176, 183): q.line(x, 11, x, 96, MD)

    if kind == 0:  # ensemble: Echo pulls forward; the other two observe from incompatible layers.
        ring(q, 81, 55, 48, 42, C, (4, 9), 44)
        q.blit(echo_portrait(), 43, 18)
        q.blit(noa_portrait(), 123, 24)
        # Echo reaches toward the undrawn viewer; the hand is the nearest and brightest shape.
        q.line(53, 72, 31, 82, W); q.poly([(29,78),(35,80),(32,88),(25,91),(20,87)],W); q.line(24, 84, 16, 81, C)
        # Seek remains a watching trace, not a mascot body.
        q.ellipse(9, 76, 19, 13, AD); q.ellipse(15, 79, 7, 6, B); q.px(18, 80, A)
        q.line(21, 88, 56, 75, A); q.rect(53, 72, 6, 5, A); q.px(57, 73, C)
        q.rect(113, 25, 2, 66, M); q.frame(121, 20, 65, 77, MD)
        for x in (132, 145, 172, 181): q.line(x, 24+(x&3), x, 93, M)
        for x, y in ((127,30),(176,33),(130,81),(179,74)): q.frame(x, y, 4, 4, M)
        q.px(117, 59, L)  # unexplained fourth response, deliberately not connected.
    elif kind == 1:  # waiting: the missing audience occupies the dark left half.
        q.rect(12, 26, 48, 55, V); q.frame(19, 36, 25, 31, S)
        q.blit(echo_portrait(), 78, 20); ring(q, 110, 51, 43, 39, C, (4, 10), 44)
        q.line(85, 69, 56, 60, W); q.ellipse(51, 56, 7, 7, W); q.line(49, 60, 37, 70, C)
        q.px(34, 72, C)  # the answer never reaches a drawn listener.
    elif kind == 2:  # first live: Seek discovers a cyan reflection inside an amber archive.
        q.blit(seek_portrait(), 74, 18); q.frame(29, 28, 35, 45, A); q.frame(35, 35, 23, 27, AD)
        q.ellipse(40, 42, 12, 12, C); q.px(45, 46, W)
        q.line(31, 75, 72, 68, A); q.line(31, 75, 15, 91, A); q.rect(13, 89, 5, 4, AD)
        for x, y in ((141,30),(151,43),(144,58),(157,70)): q.frame(x, y, 18, 8, A)
    elif kind == 3:  # audience: Noa keeps smiling while profiles multiply below.
        q.blit(noa_portrait(), 91, 17); q.frame(83, 13, 80, 80, M)
        for y in range(72, 98, 7):
            for x in range(15, 82, 9): q.rect(x, y, 5, 3, MD if (x+y)&1 else M)
        q.line(138, 64, 82, 76, W); q.ellipse(78, 73, 7, 7, W)
        q.rect(29, 37, 32, 2, M); q.rect(29, 43, 20, 2, M)
    elif kind == 4:  # open channel: intimacy in front, administrative gaze behind.
        ring(q, 95, 55, 75, 48, A, (12, 15), 64); ring(q, 95, 55, 62, 40, M, (23, 26), 64)
        q.blit(echo_portrait(), 30, 25); q.blit(noa_portrait(), 112, 22)
        q.line(91, 58, 118, 54, C); q.rect(91, 56, 3, 3, R)
        q.rect(102, 19, 1, 70, MD)
    else:  # no carrier: an abandoned microphone leaves room for the absent speaker.
        q.rect(17, 22, 57, 1, C); q.rect(17, 28, 34, 1, CD)
        q.ellipse(76, 34, 23, 29, P); q.ellipse(81, 39, 13, 18, V); q.rect(86, 60, 3, 17, W)
        q.line(87, 76, 68, 91, W); q.line(87, 76, 109, 91, W)
        q.line(87, 49, 129, 58, C); q.px(132, 59, C)
        for y in (28,43,58,73): q.frame(145, y, 10, 8, M)
        q.frame(139, 22, 24, 68, MD); q.rect(95, 88, 2, 2, L)
    if kind not in (0, 1, 4): q.rect(95, 9, 2, 2, R)
    return q


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


def c_array(name: str, cv: Canvas) -> str:
    rows = []
    for y in range(cv.h):
        src = cv.p[y*cv.w:(y+1)*cv.w]
        packed = [(src[x] << 4) | src[x + 1] for x in range(0, cv.w, 2)]
        rows.append("    " + ",".join(f"0x{v:02x}" for v in packed) + ",")
    return f"static const uint8_t {name}[{cv.w * cv.h // 2}]={{\n" + "\n".join(rows) + "\n};\n"


def validate(echo: Canvas, seek: Canvas, seek_shell: Canvas, seek_avatar: Canvas, noa: Canvas, noa_proxy: Canvas, portraits: Canvas, expressions: Canvas, foes: Canvas, cards: Canvas, keys: list[Canvas]) -> None:
    assert (echo.w, echo.h) == (240, 24) and (seek.w, seek.h) == (96, 24)
    assert (seek_shell.w, seek_shell.h) == (64, 16) and (seek_avatar.w, seek_avatar.h) == (96, 24)
    assert (noa.w, noa.h) == (144, 64) and (noa_proxy.w, noa_proxy.h) == (72, 24)
    assert (portraits.w, portraits.h) == (192, 64) and (expressions.w, expressions.h) == (960, 64)
    assert (foes.w, foes.h) == (80, 16) and (cards.w, cards.h) == (208, 16)
    assert all((q.w, q.h) == (192, 108) for q in keys)
    assert all(v < 16 for cv in (echo, seek, seek_shell, seek_avatar, noa, noa_proxy, portraits, expressions, foes, cards, *keys) for v in cv.p)
    # Identity anchors: every Echo frame has a red LIVE pin; each Noa stage has one white glove.
    for i in range(10): assert sum(echo.p[y*echo.w+i*24:y*echo.w+(i+1)*24].count(R) for y in range(24)) >= 4
    for i in range(3): assert sum(noa.p[y*noa.w+i*48:y*noa.w+(i+1)*48].count(W) for y in range(64)) >= 30
    for i in range(4): assert any(seek_shell.p[y*seek_shell.w+i*16] in (AD, A) for y in range(16))
    for i in range(3): assert sum(noa_proxy.p[y*noa_proxy.w+i*24:y*noa_proxy.w+(i+1)*24].count(W) for y in range(24)) >= 8
    # Marketing originals must contain meaningful transparency-free framing and no out-of-palette pixels.
    assert all(q.p.count(T) == 0 for q in keys)


def build() -> None:
    echo = sheet([echo_frame(i) for i in range(10)])
    seek = sheet([seek_frame(i) for i in range(4)])
    seek_shell = sheet([seek_shell_frame(i) for i in range(4)])
    seek_avatar = sheet([seek_avatar_frame(i) for i in range(4)])
    noa = sheet([noa_frame(i) for i in range(3)])
    noa_proxy = sheet([noa_proxy_frame(i) for i in range(3)])
    foes = sheet([enemy(i) for i in range(5)])
    cards = sheet([icon(i) for i in range(13)])
    portraits = sheet([echo_portrait(), seek_portrait(), noa_portrait()])
    result_portraits = sheet([echo_portrait(7), noa_portrait(2)])
    echo_expressions = [echo_portrait(i) for i in range(8)]
    assert len({bytes(q.p) for q in echo_expressions}) == 8
    expressions = sheet(echo_expressions + [seek_portrait() for _ in range(4)] + [noa_portrait(i) for i in range(3)])
    exports = ROOT / "art" / "export"
    for name, cv in (("chr_echo_sheet", echo), ("chr_seek_sheet", seek), ("chr_seek_shell", seek_shell), ("chr_seek_avatar", seek_avatar), ("chr_noa_stages", noa), ("chr_noa_proxy", noa_proxy), ("character_portraits", portraits), ("enemy_sheet", foes), ("card_icon_sheet", cards)):
        png(exports / f"{name}.png", cv); png(ROOT / "art" / "review" / f"{name}_8x.png", cv, 8)
    png(exports / "character_expression_sheet.png", expressions); png(ROOT / "art" / "review" / "character_expression_sheet_4x.png", expressions, 4)
    keys = [keyart(i) for i in range(6)]
    validate(echo, seek, seek_shell, seek_avatar, noa, noa_proxy, portraits, expressions, foes, cards, keys)
    names = ("ensemble", "echo_waiting", "seek_first_live", "noa_audience", "open_channel", "no_carrier")
    for name, cv in zip(names, keys):
        png(exports / f"keyart_{name}_192x108.png", cv); png(exports / f"keyart_{name}_576x324.png", cv, 3)
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
