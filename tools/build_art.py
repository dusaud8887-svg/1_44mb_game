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


def resized(src: Canvas, w: int, h: int) -> Canvas:
    out = Canvas(w, h)
    for y in range(h):
        sy = y * src.h // h
        for x in range(w): out.p[y*w+x] = src.p[sy*src.w + x*src.w//w]
    return out


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
    # Large head, tiny tailored body, one huge sleeve: cute at 1x without becoming a mascot blob.
    q.rect(2, 5-bob, 2, 7, CD); q.rect(3, 3-bob, 5, 2, C); q.rect(18, 4-bob, 3, 2, C)
    q.poly([(6,5-bob),(9,2-bob),(16,2-bob),(20,6-bob),(19,15-bob),(15,17-bob),(7,14-bob),(5,9-bob)],B)
    q.rect(17, 9-bob, 3, 9, B); q.px(20, 16-bob, B)
    q.poly([(8,6-bob),(12,4-bob),(17,6-bob),(18,11-bob),(15,15-bob),(10,15-bob),(7,11-bob)],W)
    q.poly([(7,6-bob),(12,3-bob),(11,8-bob),(14,6-bob),(16,8-bob),(19,6-bob),(18,4-bob),(9,3-bob)],B)
    q.rect(8, 9-bob, 4, 3, B); q.rect(14, 9-bob, 4, 3, B)
    for x in (8, 11, 14, 17): q.px(x, 9-bob, W); q.px(x, 11-bob, W)
    q.rect(9, 10-bob, 2, 1, W); q.rect(15, 10-bob, 2, 1, W); q.px(10, 10-bob, C); q.px(15, 10-bob, C)
    q.line(12, 13-bob, 15, 13-bob, B); q.px(13, 14-bob, W)  # bright, cocky tooth-smile.
    q.poly([(8,15-bob),(16,15-bob),(17,18-bob),(15,21-bob),(9,21-bob),(7,18-bob)],P)
    q.poly([(10,16-bob),(13,18-bob),(15,16-bob),(14,20-bob),(11,20-bob)],W); q.px(13, 18-bob, R)
    q.poly([(7,16-bob),(10,16-bob),(9,22),(2,21)],C); q.rect(3, 17-bob, 6, 3, CD); q.px(4, 18-bob, W)
    q.poly([(16,16-bob),(19,17-bob),(19,20-bob),(16,21-bob)],S); q.rect(16, 16-bob, 2, 2, R)
    q.poly([(8,20-bob),(12,20-bob),(11,24),(6,24)],P); q.poly([(13,20-bob),(17,20-bob),(19,24),(15,24)],S)
    q.rect(6, 23, 5, 1, B); q.rect(16, 23-bob, 4, 1+bob, B)
    if pose == 2: q.line(5, 17, 1, 12, C); q.rect(0, 10, 3, 4, W); q.px(0, 10, B)
    if pose == 3: q.line(18, 17, 22, 11, W); q.rect(20, 8, 4, 5, C); q.px(22, 9, W)
    if pose == 4: q.rect(15, 10, 4, 4, W); q.rect(17, 10, 2, 2, R); q.rect(2, 5, 2, 7, R)
    if pose == 5: q.line(18, 16, 21, 6, C); q.rect(19, 3, 4, 5, C); q.px(21, 4, W)
    if pose == 6: q.line(5, 18, 1, 14, C); q.rect(0, 11, 3, 3, C); q.px(1, 12, W)
    if pose == 7: q.line(5, 18, 1, 20, C); q.line(18, 17, 23, 18, W); q.rect(22, 16, 2, 4, C)
    if pose == 8: q.rect(14, 11, 5, 4, W); q.rect(16, 11, 3, 2, R); q.line(4, 4, 2, 9, R)
    if pose == 9: q.rect(20, 4, 3, 5, U); q.px(21, 5, W); q.line(18, 16, 21, 9, W)
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
    q.poly([(4,9),(7,3),(10,6),(16,3),(21,9),(20,22),(4,22)],AD)
    q.poly([(6,10),(10,5),(17,6),(20,12),(17,20),(6,19)],A)
    q.poly([(9,8),(15,7),(19,11),(18,16),(14,19),(9,16)],W)
    q.poly([(6,8),(13,4),(13,18),(7,18)],B)  # one eye stays under the hood.
    q.line(14, 10, 18, 10, AD); q.rect(15, 11, 3, 2, B); q.px(16, 11, A)
    q.line(13, 15, 18, 14, AD); q.px(17, 15, W)  # small fang breaks the sleepy face.
    q.poly([(6,18),(17,18),(18,20),(16,21),(7,21),(5,20)],B)
    q.poly([(11,18),(14,18),(15,21),(10,21)],AD); q.px(13, 19, A); q.rect(17, 18, 3, 4, AD)
    q.poly([(7,20),(12,20),(11,24),(5,24)],B); q.poly([(13,20),(17,20),(20,24),(15,24)],AD)
    q.line(5, 19, 1, 22, A); q.rect(0, 21, 3, 2, AD)
    if pose & 1: q.px(17, 11, W); q.line(14, 15, 18, 15, AD)
    if pose == 2: q.line(18, 19, 23, 13, A); q.rect(21, 11, 3, 3, A)
    if pose == 3: q.frame(17, 17, 6, 5, A); q.rect(19, 19, 3, 1, W)
    if pose == 4: q.line(14, 10, 18, 12, AD); q.rect(15, 12, 3, 2, B); q.px(16, 12, W)
    if pose == 5: q.line(18, 19, 23, 17, A); q.rect(21, 15, 3, 4, AD); q.px(22, 16, W)
    if pose == 6: q.frame(1, 1, 7, 6, A); q.rect(3, 3, 3, 2, W); q.line(7, 5, 12, 9, A)
    if pose == 7: q.line(4, 18, 1, 14, A); q.rect(0, 12, 3, 3, AD); q.px(1, 13, C)
    return q


def noa_frame(stage: int) -> Canvas:
    q = Canvas(48, 64)
    # Profile ring and vertical comment veil are separate, mechanically exact layers.
    count = (6, 14, 24)[stage]
    for i in range(count):
        x = 3 + (i * 7) % 42; y = 4 + (i * 11) % 54
        q.frame(x, y, 3, 3, M if i % 3 else MD)
    for x in range(5 + stage, 47, 7): q.line(x, 2, x, 61, MD if x % 2 else M)
    q.poly([(13,12),(18,5),(29,5),(36,11),(35,29),(30,33),(18,32),(13,25)],B)
    q.poly([(18,13),(23,9),(31,12),(33,20),(29,28),(23,30),(18,24)],W)
    q.rect(14,8,21,8,B); q.rect(14,13,4,17,B); q.rect(32,12,4,18,B)
    q.line(19,17,23,17,MD); q.line(27,17,31,17,MD); q.rect(20,18,4,3,MD); q.rect(27,18,4,3,MD)
    q.rect(21,18,2,1,W); q.rect(28,18,2,1,W); q.px(22,19,M); q.px(29,19,M)
    q.line(23,24,29,23,MD); q.px(29,24,MD)
    q.poly([(14,31),(34,31),(38,40),(33,45),(36,58),(27,58),(24,47),(21,58),(11,58),(15,44),(10,39)],B)
    q.poly([(18,31),(24,38),(30,31),(29,50),(20,50)],P); q.line(24,38,24,56,M); q.rect(11,35,5,18,B); q.rect(33,34,5,17,B)
    q.line(36, 47, 39, 31, W); q.ellipse(36, 27, 6, 7, W); q.px(39, 28, S)  # connected white glove.
    if stage: q.frame(10, 5, 28, 55, M)
    if stage == 2:
        for y in range(45, 63, 4):
            for x in range(2, 46, 5): q.rect(x, y, 3, 2, MD)
    return q


def noa_proxy_frame(pose: int) -> Canvas:
    q = Canvas(24, 24)
    for x in (2, 21): q.line(x, 2, x, 22, M)
    q.poly([(7,5),(10,2),(16,3),(19,6),(18,15),(15,17),(9,15),(6,11)],B)
    q.poly([(9,7),(12,5),(17,7),(17,12),(14,15),(10,14),(8,11)],W); q.rect(7, 4, 12, 5, B)
    q.line(9, 10, 12, 10, MD); q.line(14, 10, 17, 10, MD); q.px(11, 11, M); q.px(15, 11, M)
    q.line(12, 14, 16, 14, MD); q.px(16, 13, MD)
    q.poly([(7,16),(17,16),(18,19),(16,21),(8,21),(6,19)],B)
    q.poly([(10,16),(15,16),(15,20),(13,21),(10,20)],P); q.line(12, 17, 12, 20, M); q.px(14, 18, W)
    q.poly([(8,20),(12,20),(11,24),(6,24)],P); q.poly([(13,20),(17,20),(19,24),(15,24)],B)
    q.line(18, 22, 19, 15, W); q.rect(17, 13, 4, 4, W); q.px(19, 13, M)
    if pose == 1: q.line(18, 15, 22, 11, W); q.px(22, 10, M)
    if pose == 2: q.frame(3, 1, 18, 22, M)
    if pose == 3: q.line(9, 10, 12, 11, MD); q.line(14, 11, 17, 10, MD); q.px(16, 14, W)
    if pose == 4: q.line(18, 15, 23, 7, W); q.rect(21, 5, 3, 4, M); q.px(22, 5, W)
    if pose == 5:
        for y in range(2, 23, 4): q.rect(1, y, 3, 2, MD); q.rect(20, y + 1, 3, 2, M)
    return q


def echo_portrait(expression: int = 0) -> Canvas:
    q = Canvas(64, 64)
    ring(q, 31, 31, 28, 27, CD, (4, 9), 40)
    # Broad upper mass and a single long tail give Echo an instant, asymmetrical silhouette.
    q.poly([(10,22),(14,9),(25,3),(41,6),(53,17),(51,45),(59,64),(42,62),(37,48),(17,51),(8,41)],B)
    q.poly([(13,29),(20,42),(18,62),(8,57)],B); q.line(14, 22, 20, 9, P); q.line(47, 18, 54, 53, P)
    q.poly([(18,22),(23,13),(37,11),(47,19),(47,34),(41,45),(29,49),(19,41)],W)
    q.poly([(16,19),(25,8),(39,9),(49,17),(44,25),(38,20),(34,27),(28,19),(20,27)],B)
    q.rect(16, 21, 3, 13, C); q.rect(46, 21, 4, 13, CD); q.rect(48, 24, 2, 7, C)
    # Wide irises, hard brows and tiny highlights keep the face readable at game scale.
    q.line(22, 26-(expression==3), 29, 28-(expression==3), B); q.line(36, 28 if expression==5 else 28, 43, 26, B)
    if expression in (1, 7):
        q.ellipse(22, 29, 10, 10, B); q.ellipse(35, 29, 10, 10, B); q.ellipse(23, 30, 8, 8, W); q.ellipse(36, 30, 8, 8, W)
        q.ellipse(25, 30, 5, 7, C); q.ellipse(38, 30, 5, 7, C); q.rect(27, 33, 2, 3, B); q.rect(40, 33, 2, 3, B); q.px(27, 31, W); q.px(40, 31, W)
    elif expression == 4:
        q.line(23, 33, 30, 34, B); q.line(36, 34, 43, 33, B)
    else:
        q.ellipse(22, 29, 10, 9, B); q.ellipse(35, 29, 10, 9, B); q.ellipse(23, 30, 8, 7, W); q.ellipse(36, 30, 8, 7, W)
        q.ellipse(25, 30, 5, 7, C); q.ellipse(38, 30, 5, 7, C); q.rect(27, 33, 2, 3, B); q.rect(40, 33, 2, 3, B); q.px(27, 31, W); q.px(40, 31, W)
    q.rect(18, 39, 3, 2, M); q.rect(45, 39, 2, 2, M)
    if expression == 7: q.rect(20, 40, 3, 2, M); q.rect(43, 40, 3, 2, M)
    if expression in (1, 7): q.ellipse(29, 39, 11, 8, CD); q.rect(31, 40, 7, 3, W); q.rect(33, 45, 4, 1, R)
    elif expression == 2: q.line(29, 44, 39, 40, CD); q.px(29, 43, CD)
    elif expression == 5: q.line(30, 42, 39, 42, CD); q.px(39, 41, CD)
    elif expression in (3, 4, 6): q.line(29, 44, 39, 44, CD); q.px(29, 43, CD)
    else: q.line(29, 40, 34, 43, CD); q.line(34, 43, 40, 39, CD); q.rect(34, 41, 3, 2, W)
    # Sharp lapels, pinched waist and oversized sleeve: tailored rather than blocky.
    q.poly([(13,57),(22,47),(43,47),(55,55),(59,64),(43,64),(39,57),(27,57),(23,64),(6,64)],P)
    q.poly([(24,48),(33,55),(42,48),(39,64),(27,64)],B); q.poly([(27,48),(33,54),(38,48),(36,57),(30,57)],W)
    q.rect(32, 51, 3, 7, R); q.poly([(8,61),(17,49),(28,53),(22,64),(2,64)],C); q.rect(12, 56, 12, 5, CD)
    q.poly([(42,49),(52,52),(60,64),(41,64)],S); q.rect(45, 50, 5, 5, R)
    q.ellipse(50, 42, 8, 9, W); q.line(53, 47, 58, 35, W); q.rect(56, 31, 5, 7, C); q.px(59, 32, W)
    return q


def seek_portrait(expression: int = 0) -> Canvas:
    q = Canvas(64, 64)
    # Connector-tipped hood corners echo animal ears without becoming literal ears.
    q.poly([(9,23),(16,4),(27,19)],AD); q.rect(15, 2, 5, 6, A); q.rect(17, 3, 2, 2, W)
    q.poly([(37,18),(49,4),(55,25)],AD); q.rect(47, 2, 6, 6, A); q.rect(49, 3, 2, 2, W)
    q.poly([(6,27),(14,13),(31,8),(49,15),(58,29),(54,59),(8,59)],AD)
    q.poly([(11,27),(20,17),(38,14),(53,25),(49,53),(16,55)],A)
    q.poly([(21,25),(35,20),(48,27),(47,40),(39,51),(25,48),(18,39)],W)
    q.poly([(12,24),(33,13),(31,52),(13,53)],B)  # only one expressive eye is volunteered.
    q.line(33, 29-(expression==2), 43, 28, AD)
    if expression == 3: q.line(35, 34, 44, 33, B)
    else: q.ellipse(35, 31, 9, 8, B); q.rect(38, 32, 4, 4, A); q.rect(40, 32, 2, 2, W)
    if expression == 1: q.line(34, 43, 45, 43, AD); q.px(43, 44, W)
    elif expression == 2: q.line(34, 44, 45, 40, AD); q.poly([(41,41),(46,40),(43,47)],W)
    elif expression == 3: q.line(35, 43, 44, 43, AD)
    else: q.line(34, 43, 45, 41, AD); q.poly([(41,42),(46,41),(43,48)],W); q.px(46, 42, A)
    q.poly([(8,55),(23,48),(47,49),(57,56),(61,64),(43,64),(39,57),(27,57),(23,64),(3,64)],B)
    q.poly([(24,49),(33,55),(42,49),(40,64),(27,64)],AD); q.poly([(28,49),(33,54),(37,49)],W)
    q.poly([(43,51),(56,52),(61,64),(43,64)],AD)
    q.frame(47, 51, 12, 8, A); q.rect(50, 54, 6, 2, W)
    q.line(9, 52, 1, 62, A); q.rect(0, 59, 5, 4, AD)
    return q


def noa_portrait(expression: int = 0) -> Canvas:
    q = Canvas(64, 64)
    for x in (5, 12, 51, 58): q.line(x, 2+(x&1), x, 61, M if x & 1 else MD)
    # Narrow chin, blunt hime-cut and long side locks: a calm human face, not a mask.
    q.poly([(12,17),(18,6),(34,3),(49,9),(54,21),(51,57),(14,57)],B)
    q.poly([(20,19),(27,12),(41,13),(48,21),(46,38),(39,48),(28,49),(20,40)],W)
    q.rect(14, 9, 38, 13, B); q.rect(14, 18, 7, 38, B); q.rect(47, 18, 7, 39, B)
    q.poly([(17,9),(29,5),(26,23),(19,28)],B); q.poly([(31,5),(49,10),(47,24),(40,18),(35,24)],B)
    q.line(16, 15, 19, 41, M); q.line(49, 15, 47, 43, MD)
    q.line(21, 27, 29, 26, MD); q.line(37, 26, 45, 27, MD)
    if expression == 1:
        q.line(22, 32, 29, 33, MD); q.line(37, 33, 44, 32, MD)
    else:
        q.line(22, 31, 29, 31, MD); q.line(37, 31, 44, 31, MD)
        q.rect(24, 32, 4, 3, MD); q.rect(39, 32, 4, 3, MD); q.px(26, 32, W); q.px(41, 32, W)
    q.px(23, 31, M); q.px(28, 31, M); q.px(38, 31, M); q.px(43, 31, M)
    q.px(19, 36, L)
    if expression == 2: q.line(29, 42, 41, 42, MD)
    else: q.line(30, 42, 40, 40, MD); q.px(40, 41, MD)
    q.poly([(11,57),(22,47),(45,47),(55,55),(60,64),(44,64),(40,57),(27,57),(23,64),(6,64)],B)
    q.poly([(23,48),(33,55),(43,48),(41,64),(25,64)],P); q.line(33, 54, 33, 63, M); q.poly([(27,48),(33,54),(39,48)],W)
    q.rect(29, 57, 2, 2, M); q.rect(36, 57, 2, 2, M)
    # A precise white-gloved signal cuts across the otherwise controlled portrait.
    q.line(52, 62, 48, 46, W); q.ellipse(44, 39, 9, 10, W); q.rect(48, 34, 3, 9, W); q.px(50, 35, S)
    q.frame(3, 9, 56, 51, M)
    return q


def enemy(kind: int, pose: int = 0) -> Canvas:
    q = Canvas(16, 16)
    bob = pose & 1
    if kind == 0:  # CHAT: twin-tail comment imp; the missing hairpin is a tiny question mark.
        q.poly([(1,6-bob),(2,2-bob),(5,4-bob),(8,1-bob),(11,4-bob),(14,2-bob),(15,7-bob),(13,14),(3,14)],R)
        q.poly([(4,5-bob),(8,3-bob),(12,5-bob),(12,10),(8,13),(4,10)],W)
        q.rect(4,6-bob,3,3,B); q.rect(9,6-bob,3,3,B); q.px(5,7-bob,W); q.px(10,7-bob,W)
        q.line(6,11,11,10,B); q.px(10,11,W); q.px(14,1-bob,C)
    elif kind == 1:  # AD: too-polite sales clerk trapped inside a closing pop-up.
        q.frame(1,1-bob,14,14,R); q.rect(2,2-bob,12,2,P); q.px(12,2-bob,W)
        q.poly([(4,5-bob),(8,3-bob),(12,6-bob),(11,12),(5,12),(3,9-bob)],W); q.rect(4,4-bob,8,3,B)
        q.rect(5,7-bob,2,2,B); q.rect(9,7-bob,2,2,B); q.px(6,7-bob,W); q.line(6,10,10,10,R)
        q.rect(3 if pose else 11,13,2,2,R)
    elif kind == 2:  # GIFT: ribbon idol; the box smiles only while somebody is watching.
        q.ellipse(0,3-bob,6,7,M); q.ellipse(10,3-bob,6,7,M); q.line(4,7-bob,8,2-bob,W); q.line(12,7-bob,8,2-bob,W)
        q.rect(6,6-bob,5,7,P); q.rect(7,5-bob,3,9,R); q.rect(5,8-bob,7,2,R)
        q.rect(6,9-bob,2,2,W); q.rect(10,9-bob,2,2,W); q.px(7,10-bob,B); q.px(10,10-bob,B); q.px(8,12-bob,W)
    elif kind == 3:  # MOD: hime-cut moderator; one eye is hidden by her own censor strip.
        q.poly([(3,2-bob),(7,0-bob),(12,2-bob),(14,6-bob),(13,15),(3,15),(1,11),(2,4-bob)],M)
        q.poly([(4,5-bob),(8,3-bob),(12,5-bob),(12,11),(8,14),(4,10)],W); q.rect(3,2-bob,10,4,B); q.rect(3,4-bob,3,9,B); q.rect(11,4-bob,3,10,B)
        q.rect(4,7-bob,8,2,V); q.px(9,7-bob,M); q.line(6,11,10,11,MD); q.px(12,13,L)
    else:  # WORM: archive scavenger; connector ears and a date tag hint at Seek's discarded kin.
        q.line(0,14,5,12,A); q.poly([(3,7-bob),(5,2-bob),(8,5-bob),(12,2-bob),(15,8-bob),(14,15),(4,15)],AD)
        q.poly([(5,7-bob),(9,5-bob),(13,8-bob),(12,12),(7,13),(4,10-bob)],A); q.rect(6,6-bob,6,3,B)
        q.rect(7,8-bob,2,2,W); q.rect(10,8-bob,2,2,W); q.px(8,9-bob,B); q.px(10,9-bob,B); q.rect(10,12,3,2,W)
    return q


def icon(kind: int) -> Canvas:
    q = Canvas(16, 16); c = (C, U, C, A, C, W, C, C, U, C, D, A, R)[kind]
    base = AD if kind in (3,11) else MD if kind == 10 else P
    q.poly([(4,1),(12,1),(15,4),(15,12),(12,15),(4,15),(1,12),(1,4)],base); q.rect(4,2,8,1,S); q.px(13,4,W)
    if kind == 0: q.frame(3,6,10,6,c); q.rect(1,8,3,2,c); q.rect(12,8,3,2,c); q.rect(6,8,4,2,W)
    elif kind == 1: q.rect(3,9,2,3,c); q.rect(7,6,2,6,c); q.rect(11,3,2,9,c); q.px(12,3,W)
    elif kind == 2: q.frame(3,4,7,8,c); q.frame(7,6,6,7,c); q.px(5,6,W)
    elif kind == 3: q.rect(3,9,10,4,c); q.rect(4,5,8,4,A); q.line(5,4,11,4,W); q.rect(6,10,4,1,W)
    elif kind == 4: q.poly([(8,3),(13,5),(12,11),(8,14),(4,11),(3,5)],c); q.line(6,8,8,10,W); q.line(8,10,11,6,W)
    elif kind == 5: q.line(4,5,11,5,c); q.line(11,5,13,8,c); q.line(13,8,10,11,c); q.line(10,11,5,11,c); q.px(4,10,W); q.px(11,4,W)
    elif kind == 6: q.frame(3,7,6,6,c); q.frame(6,5,6,6,c); q.frame(9,3,4,6,c); q.px(11,4,W)
    elif kind == 7: q.ellipse(4,3,8,8,c); q.ellipse(6,5,4,4,B); q.px(8,6,W); q.line(8,10,8,14,c)
    elif kind == 8: q.poly([(8,2),(4,9),(7,9),(5,14),(12,7),(9,7),(12,2)],c); q.px(9,3,W)
    elif kind == 9: q.frame(3,3,10,10,c); q.line(4,9,7,12,W); q.line(7,12,12,6,W); q.px(5,4,W)
    elif kind == 10: q.poly([(3,4),(13,4),(13,11),(8,11),(5,14),(5,11),(3,10)],c); q.rect(5,6,2,2,W); q.rect(10,6,2,2,W)
    elif kind == 11: q.rect(6,3,4,8,c); q.ellipse(5,8,6,5,c); q.line(3,12,13,12,A); q.px(8,4,W)
    else: q.line(3,3,12,12,c); q.line(12,3,3,12,c); q.rect(7,2,2,12,W); q.rect(2,7,12,2,R)
    return q


def keyart(kind: int) -> Canvas:
    q = Canvas(192, 108, V)
    q.rect(5, 7, 182, 94, B); q.frame(5, 7, 182, 94, P)
    # Interface fragments frame the incident instead of filling the focal area.
    for y, w in ((15,24),(22,14),(84,20),(91,32)): q.rect(10, y, w, 1, S)
    for x in (168, 176, 183): q.line(x, 11, x, 96, MD)

    if kind == 0:  # canonical ensemble: Echo leads, Noa observes, Seek tugs at the unanswered gap.
        q.poly([(7,9),(127,9),(113,99),(7,99)],P); q.poly([(129,9),(185,9),(185,99),(119,99)],B)
        q.frame(10, 12, 108, 83, CD); q.frame(128, 16, 54, 70, M)
        ring(q, 66, 49, 50, 40, C, (4, 9), 44)
        q.blit(echo_portrait(), 34, 14)
        # Foreshortened sleeve and open palm break the frame toward the viewer.
        q.poly([(40,65),(61,59),(82,75),(66,99),(25,99),(19,88)],C); q.poly([(53,67),(68,63),(81,74),(69,88),(49,83)],W)
        q.rect(60,64,5,13,W); q.rect(66,62,4,14,W); q.rect(72,65,4,12,W); q.px(77,73,C)
        q.blit(resized(noa_portrait(), 48, 48), 133, 22)
        for x in (136,148,160,172): q.line(x,18,x,91,MD if x&8 else M)
        # Seek is only an eye, date-tag and cable: enough kinship to invite speculation.
        q.poly([(10,82),(18,73),(36,73),(46,81),(38,92),(18,93)],AD)
        q.ellipse(21,77,13,10,B); q.ellipse(25,79,5,6,A); q.px(28,79,W); q.rect(11,88,9,4,W)
        q.line(35,89,58,101,A); q.line(58,101,110,101,A); q.line(110,101,115,57,A)
        q.rect(113,52,4,8,V); q.px(115,55,L)  # one unexplained answer remains outside both owners.
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
        hero = resized(echo_portrait(1), w*2//5, w*2//5)
        q.blit(hero, w//12, h*4//9)
        mark = resized(logo(), w*4//5, max(12, h//11)); q.blit(mark, w//10, h*4//5)
        q.rect(w//10, h*9//10, w*3//5, max(2,h//150), C); q.rect(w*3//4,h*9//10,max(3,w//90),max(3,w//90),R)
    else:
        q.blit(resized(source, w, h), 0, 0)
        panel = max(34, w*9//20); q.poly([(0,0),(panel,0),(panel-w//12,h),(0,h)],B)
        hero_size = h*4//5; q.blit(resized(echo_portrait(1), hero_size, hero_size), panel-h//8, h//10)
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
    # Identity anchors: every Echo frame has a red LIVE pin; each Noa stage has one white glove.
    for i in range(10): assert sum(echo.p[y*echo.w+i*24:y*echo.w+(i+1)*24].count(R) for y in range(24)) >= 4
    for i in range(3): assert sum(noa.p[y*noa.w+i*48:y*noa.w+(i+1)*48].count(W) for y in range(64)) >= 30
    for i in range(4): assert any(seek_shell.p[y*seek_shell.w+i*16] in (AD, A) for y in range(16))
    for i in range(6): assert sum(noa_proxy.p[y*noa_proxy.w+i*24:y*noa_proxy.w+(i+1)*24].count(W) for y in range(24)) >= 8
    assert len({bytes(enemy(i, p).p) for i in range(5) for p in range(2)}) == 10
    assert len({bytes(icon(i).p) for i in range(13)}) == 13
    # Marketing originals must contain meaningful transparency-free framing and no out-of-palette pixels.
    assert all(q.p.count(T) == 0 for q in keys)


def build() -> None:
    echo = sheet([echo_frame(i) for i in range(10)])
    seek = sheet([seek_frame(i) for i in range(4)])
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
