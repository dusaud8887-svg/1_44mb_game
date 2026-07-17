#!/usr/bin/env python3
# keyart_main_192.py — V2 메인 키아트 "UNLISTED LIVE" 192×108 (docs/42 §2 정본 구도)
# 한 사건: 에코가 화면 밖 관객에게 손을 뻗어 대답을 기다린다. 시크의 케이블은 돌아오는
# 진짜 신호 하나를 감으려 하고, 에코 뒤의 노아는 완벽한 대답으로 빈 공간을 먼저 채운다.
# 시각 무게: 에코 50~55 / 노아 25~30 / 시크 10~15. 면적 60%+는 VOID 계열.
# 빨간 LIVE 핀 1점 / 라벤더 1픽셀 / 로고는 굽지 않음(별도 레이어).
import sys, os, math
sys.path.insert(0, os.path.dirname(__file__))
from pxlib import Grid

W, H = 192, 108
g = Grid(W, H)
g.rect(0, 0, W - 1, H - 1, "1")                           # VOID

# ---------- 시대 조각 (가장자리·발견 보상 레이어) ----------
# 좌상: 1997 파일보드 프레임 조각 + 잘못 찍힌 타임스탬프
g.run(4, 44, 4, "3"); g.vrun(4, 4, 26, "3"); g.run(4, 20, 26, "3")
for y in (9, 14, 19):
    g.run(8, 26, y, "4"); g.run(28, 34, y, "4")           # 파일 목록 행
# '1997' 3×5 비트맵 (DIM — 자세히 봐야 보임)
digits = {"1": ["01", "11", "01", "01", "01"],
          "9": ["111", "101", "111", "001", "111"],
          "7": ["111", "001", "010", "010", "010"]}
tx = 8
for ch in "1997":
    for dy, row in enumerate(digits[ch]):
        for dx, v in enumerate(row):
            if v == "1":
                g.set(tx + dx, 30 + dy, "6")
    tx += len(digits[ch][0]) + 1
# 우하: 추천 피드 카드 조각 (2026 층)
for i, y0 in enumerate((84, 94)):
    g.rect(168, y0, 188, y0 + 7, "3")
    g.run(170, 180, y0 + 2, "4"); g.run(170, 176, y0 + 4, "4")

# ---------- 노아의 그림자 — 빈 좌석 수백 개 (본체보다 거대, 우하단으로 갈수록 밀집) ----------
for y in range(58, 104, 5):
    for x in range(132 + (y // 5 % 2) * 3, 190, 6):
        g.rect(x, y, x + 2, y + 1, "3")
        if (x + y) % 3 == 0:
            g.set(x + 1, y + 2, "4")

# (64링은 에코 본체를 그린 뒤 VOID 위에만 그린다 — 아래 참조)

# ---------- 노아의 댓글 베일 (수직 — 링 오른쪽 원호를 가림) ----------
chat = [(3, "5"), (2, "6"), (4, "6"), (0, "c"), (3, "6"), (2, "5")]
for sx, y_end in ((134, 104), (172, 98), (122, 48)):
    g.rect(sx, 0, sx + 6, y_end, "3")
    g.vrun(sx + 6, 0, y_end, "4")                          # 에지는 한쪽만 — 창살 느낌 방지
    y = 3
    i = 0
    while y < y_end - 3:
        ln, col = chat[i % len(chat)]
        if col == "c":
            g.rect(sx + 1, y, sx + 2, y + 1, "c")
        else:
            g.set(sx + 1, y, "c")
            g.run(sx + 2, sx + 2 + ln, y, col)
        y += 6
        i += 1

# ---------- 완벽한 대답들 (전부 같은 길이·같은 형태 — 빈 공간을 먼저 채움) ----------
for y in (28, 40, 52, 64):
    g.set(112, y, "c"); g.run(114, 121, y, "b")
    g.set(112, y + 1, "b")

# ---------- 노아 본체 (우상단 후경 — 베일 위에, 얼굴은 가장 평온하고 아름답게) ----------
NX, NY = 142, 6                                            # 머리 좌상 기준 (폭 24)
g.rect(NX + 2, NY + 24, NX + 21, NY + 60, "2")             # 뒷머리 몸판 (하단까지)
# 얼굴 (폭 14)
for y in range(NY + 9, NY + 22):
    g.run(NX + 5, NX + 18, y, "5")
g.run(NX + 6, NX + 17, NY + 22, "5"); g.run(NX + 7, NX + 16, NY + 23, "5")
g.run(NX + 8, NX + 15, NY + 24, "5"); g.run(NX + 9, NX + 14, NY + 25, "5")
g.run(NX + 10, NX + 13, NY + 26, "5")
# 히메컷 앞머리 — 일직선 절단 + 사이드락 기둥
g.rect(NX + 3, NY + 1, NX + 20, NY + 8, "2")
g.run(NX + 4, NX + 19, NY, "2")
g.rect(NX + 1, NY + 3, NX + 4, NY + 28, "2"); g.rect(NX + 19, NY + 3, NX + 22, NY + 28, "2")
g.run(NX + 1, NX + 4, NY + 28, "3"); g.run(NX + 19, NX + 22, NY + 28, "3")
g.run(NX + 7, NX + 9, NY + 3, "b"); g.run(NX + 14, NX + 16, NY + 3, "b")
g.vrun(NX + 2, NY + 6, NY + 24, "b"); g.vrun(NX + 21, NY + 6, NY + 24, "b")
# 눈썹 — 완만하고 완전 대칭
g.run(NX + 7, NX + 10, NY + 11, "2"); g.run(NX + 13, NX + 16, NY + 11, "2")
# 반개한 눈 (경청) — 완전 대칭, 홍채 자홍
g.run(NX + 7, NX + 10, NY + 13, "2"); g.run(NX + 13, NX + 16, NY + 13, "2")
g.run(NX + 7, NX + 10, NY + 14, "2"); g.run(NX + 13, NX + 16, NY + 14, "2")
g.run(NX + 8, NX + 9, NY + 15, "c"); g.run(NX + 14, NX + 15, NY + 15, "c")
g.set(NX + 8, NY + 15, "5"); g.set(NX + 14, NY + 15, "5")
# 정돈된 미소 (양쪽 입꼬리 동일)
g.run(NX + 11, NX + 12, NY + 20, "2")
g.set(NX + 10, NY + 19, "2"); g.set(NX + 13, NY + 19, "2")
# 목·수직 포멀웨어 + 자홍 수직선
g.rect(NX + 9, NY + 27, NX + 14, NY + 29, "5")
g.rect(NX + 5, NY + 30, NX + 18, NY + 60, "2")
g.run(NX + 6, NX + 17, NY + 30, "3")
g.vrun(NX + 11, NY + 32, NY + 60, "b"); g.set(NX + 11, NY + 34, "c"); g.set(NX + 11, NY + 40, "c")
# 흰 장갑 — 화면(에코 쪽)을 향해 내민 한 손 (팔 라인으로 몸과 연결)
g.run(NX + 1, NX + 5, NY + 33, "2"); g.run(NX - 1, NX + 3, NY + 34, "2")
g.blit(NX - 4, NY + 34, [
    ".5.5.",
    "55555",
    "55555",
    ".555.",
])
# 프로필 아이콘 환 (기계적 등간격 원호 — 머리 위)
for a in (205, 232, 259, 286, 313, 340):
    x = round(NX + 11 + 18 * math.cos(math.radians(a)))
    y = round(NY + 16 + 16 * math.sin(math.radians(a)))
    g.rect(x, y, x + 1, y + 1, "c"); g.set(x + 1, y + 1, "b")

# ---------- 시크 (좌하단 어둠 — 눈 하나와 깨진 링 조각만, 몸은 그리지 않는다) ----------
# 모서리를 감싸는 부드러운 사분원 어둠 (형태 단서를 남기지 않음)
for y in range(68, 108):
    ext = round(math.sqrt(max(0.0, 1 - ((y - 108) / 40.0) ** 2)) * 22)
    g.run(0, ext, y, "3")
# 외눈 (호박 삼백안 — 돌아온 신호를 응시, 어둠 속 최고 대비점)
g.blit(8, 78, [
    ".222222.",
    "22999922",
    "29aaaa92",
    "25555552",
    ".222222.",
])
g.set(11, 80, "5")                                         # 렌즈 하이라이트
# 깨진 버퍼 링 조각 (눈 주위 2~3px 원호 — '둥근 무언가'의 유일한 단서)
g.arc(12, 81, 12, 210, 245, "9", thick=1)
g.arc(12, 81, 12, 315, 345, "9", thick=1)
g.arc(12, 81, 12, 30, 55, "9", thick=1)

# ---------- 에코 (중앙-좌 전경, 최대 무게 — 손은 프레임 밖 관객에게) ----------
EX = 72                                                    # 머리 중심 x
# 긴 머리채 (뷰어-좌, 어깨 너머 하단까지)
lock = {y: (56 + (y - 30) // 14, 63 + (y - 30) // 18) for y in range(30, 100)}
for y, (x0, x1) in lock.items():
    g.run(x0, x1, y, "8")
    g.run(x0, x0 + 1, y, "7")
# 두상
head = {16: (66, 80), 17: (64, 82), 18: (62, 84), 19: (61, 85), 20: (60, 86)}
for y, (x0, x1) in head.items():
    g.run(x0, x1, y, "8")
for y in range(21, 32):
    g.run(59, 86, y, "8")
# 얼굴
for y in range(30, 44):
    g.run(63, 81, y, "5")
face_taper = {44: (64, 80), 45: (65, 79), 46: (66, 78), 47: (68, 76)}
for y, (x0, x1) in face_taper.items():
    g.run(x0, x1, y, "5")
# 앞머리 프린지 (우→좌 스윕)
fr = [(59, 64, 31), (59, 62, 32), (59, 61, 33), (60, 60, 34),
      (65, 69, 30), (65, 67, 31), (66, 66, 32),
      (70, 74, 29), (71, 73, 30), (72, 72, 31),
      (75, 78, 28), (76, 77, 29),
      (79, 83, 27), (80, 81, 28), (84, 86, 26)]
for x0, x1, y in fr:
    g.run(x0, x1, y, "8")
# 프린지 밑 피부 그림자 (가장 긴 갈래 아래만)
for x, y in ((60, 35), (61, 34), (66, 33), (72, 32), (76, 30), (80, 29)):
    if g.get(x, y) == "5":
        g.set(x, y, "6")
for y in range(26, 31):
    g.run(84, 86, y, "7")                                  # 우측 그림자 머리
# 눈 (7폭 — 근안이 1px 큼)
g.run(64, 68, 33, "7")                                     # 눈썹 좌
g.run(73, 78, 32, "7")                                     # 눈썹 우 (1px 높음)
g.blit(64, 35, [
    ".2222.",
    "222222",
    "258882",
    "252882",
    "277772",
    ".6666.",
])
g.blit(72, 34, [
    ".22222.",
    "2222222",
    "2558882",
    "2528822",
    "2728872",
    ".66666.",
])
# 코·입 (1px 오프셋 미소 — 기다리면서 진행을 놓치지 않는)
g.set(71, 40, "6")
g.run(69, 72, 43, "2"); g.set(73, 42, "2")
g.run(70, 72, 44, "6")
# 헤드셋 (한쪽 수신기)
g.blit(83, 33, [
    ".22",
    "222",
    "282",
    "222",
])
g.vrun(82, 34, 36, "6")
# 목·칼라
g.rect(69, 47, 76, 50, "5"); g.run(70, 75, 47, "6")
g.rect(66, 50, 79, 52, "2")
# 어깨·재킷 (흰색 — VOID 배경 위만 칠해 머리채·라인을 보존)
def paint_void(x0, x1, y, c):
    for x in range(x0, x1 + 1):
        if g.get(x, y) in ("1", "3"):
            g.set(x, y, c)

sh = {52: (60, 84), 53: (57, 87), 54: (55, 89), 55: (53, 91)}
for y, (x0, x1) in sh.items():
    paint_void(x0, x1, y, "5")
for y in range(56, 108):
    paint_void(52, 92, y, "5")
# 안감 V (하이넥 아래로 넓게 벌어졌다 좁아지는 이너)
for y in range(53, 74):
    w2 = max(1, 7 - (y - 53) // 3)
    g.run(72 - w2 // 2, 72 + (w2 - w2 // 2) - 1, y, "2")
g.vrun(72, 74, 107, "2"); g.vrun(71, 74, 107, "2")
# 재킷 주름 (DIM — 어깨선·팔 접합)
g.run(56, 60, 58, "6"); g.run(84, 88, 57, "6")
g.vrun(88, 60, 72, "6")
# 라펠 — 좌 직선 / 우 끊긴 원호 + CUE 탭 5
for i, y in enumerate(range(53, 108)):
    g.set(68 - i // 6, y, "6")
arcx = {53: 76, 56: 78, 60: 80, 64: 81, 68: 82, 76: 83, 82: 83, 90: 82, 98: 81, 106: 80}
ks = sorted(arcx)
for j in range(len(ks) - 1):
    y0, y1 = ks[j], ks[j + 1]
    if y0 == 68:                                           # y72~75 갭 — 끊긴 원호
        y1 = 71
        for y in range(y0, y1):
            x = round(arcx[ks[j]] + (arcx[ks[j + 1]] - arcx[ks[j]]) * (y - y0) / (ks[j + 1] - y0))
            g.set(x, y, "6")
        continue
    for y in range(y0, y1):
        x = round(arcx[y0] + (arcx[y1] - arcx[y0]) * (y - y0) / (y1 - y0))
        g.set(x, y, "6")
for y in (57, 62, 67, 78, 84):
    g.set(arcx.get(y, 82) + 3 if y in arcx else 85, y, "8")
    g.set(86, y, "7")
# LIVE 핀 — 유일한 빨강
g.rect(64, 58, 65, 59, "d")
# 뻗은 팔 (좌하단 프레임 밖으로) — 흰 소매
for t in range(22):
    x = 58 - t; y = 56 + t
    g.run(x, x + 6 - t // 8, y, "5")
    g.set(x + 6 - t // 8 + 1, y, "6")
# 소매 끝 청록 커프
g.run(37, 41, 77, "8"); g.run(36, 40, 78, "7")
# 손 (열린 손바닥 — 관객 쪽, 손가락이 하늘을 향해 벌어짐)
g.blit(28, 77, [
    ".5.5.5.",
    ".5.5.55",
    "5555555",
    "5555555",
    "5555555",
    ".55555.",
])
g.set(30, 80, "6"); g.set(32, 80, "6"); g.set(34, 80, "6")
# 손끝에서 나가는 신호 (프레임 밖으로)
g.run(24, 26, 86, "8"); g.run(19, 20, 90, "8"); g.set(14, 94, "8")
g.set(28, 84, "5")

# ---------- 64링 (에코 뒤 — VOID 위에만, 우상단 끊김, 일부 점등) ----------
def ring_arc(cx, cy, r, a0, a1, c, dash=(360, 0), thick=2):
    period, gap = dash
    steps = max(int(r * 8), 64)
    for i in range(steps + 1):
        a = a0 + (a1 - a0) * i / steps
        if gap and (a % period) >= (period - gap):
            continue
        for t in range(thick):
            x = round(cx + (r - t) * math.cos(math.radians(a)))
            y = round(cy + (r - t) * math.sin(math.radians(a)))
            if g.get(x, y) in ("1", "3", "4"):
                g.set(x, y, c)

ring_arc(76, 40, 34, -12, 262, "7", dash=(10, 4))
for a0 in (95, 122, 206, 234):
    ring_arc(76, 40, 34, a0, a0 + 6, "8")                  # 이미 돌아온 실제 메아리들
g.set(101, 10, "f")                                        # 라벤더 1픽셀 — 끊긴 자리의 미확인 신호

# ---------- 시크의 케이블 — 에코 아래를 지나 진짜 신호 하나를 향해 ----------
path = [(20, 92), (30, 96), (42, 100), (56, 103), (72, 104), (86, 102), (96, 98), (102, 93)]
pts = []
for i in range(len(path) - 1):
    x0, y0 = path[i]; x1, y1 = path[i + 1]
    steps = max(abs(x1 - x0), abs(y1 - y0))
    for s in range(steps + 1):
        p = (round(x0 + (x1 - x0) * s / steps), round(y0 + (y1 - y0) * s / steps))
        if p not in pts:
            pts.append(p)
for j, (x, y) in enumerate(pts):
    g.set(x, y, "9"); g.set(x, y + 1, "9")
    if j % 8 in (0, 1):
        g.set(x, y, "a")
# 케이블 갈고리 끝 — 신호를 감으려는 곡선 (호박이 청록에 1px 접촉)
g.set(103, 91, "9"); g.set(104, 89, "9"); g.set(104, 87, "9"); g.set(104, 85, "a")
# 날짜 태그
g.set(56, 105, "9")
g.rect(52, 105, 58, 107, "a"); g.run(53, 56, 106, "9")

# ---------- 진짜 청록 메아리 하나 (케이블과 완벽한 대답들 사이에서 당겨짐) ----------
g.rect(105, 82, 106, 83, "8"); g.set(105, 82, "5")
g.set(107, 80, "8"); g.set(109, 77, "7")                   # 노아 쪽으로 끌리는 잔상
g.set(103, 85, "7")                                        # 케이블 쪽 잔상

g.save(os.path.join(os.path.dirname(__file__), "..", "..", "assets", "px_v2", "keyart_main_192.px"),
       "keyart_main_192 — V2 메인 키아트 UNLISTED LIVE (192×108, 마케팅 원본)")
