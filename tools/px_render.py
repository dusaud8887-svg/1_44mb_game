#!/usr/bin/env python3
# px_render.py - .px 텍스트 그리드를 PNG로 렌더(검수용)하고 C 배열(2bpp)로 내보낸다.
# tools/px_render.ps1과 동일 포맷의 크로스플랫폼(리눅스/맥) 판. 외부 의존성 없음(stdlib만).
# 사용법:
#   python3 tools/px_render.py assets/px/echo_16.px                # PNG 렌더 (기본 12배, 체커 배경)
#   python3 tools/px_render.py assets/px/echo_16.px --scale 3      # 실크기 감각 확인
#   python3 tools/px_render.py assets/px/echo_16.px --bg 100d18    # 게임 배경색 위 시뮬레이션
#   python3 tools/px_render.py assets/px/*.px --sheet out.png      # 여러 장을 한 PNG에 나란히
#   python3 tools/px_render.py assets/px/echo_16.px --emit-c       # C 배열 출력
# .px 포맷:
#   '#'로 시작하는 줄은 메타데이터. 팔레트 줄: "# palette: 1=RRGGBB 2=RRGGBB 3=RRGGBB"
#   그리드 문자: '.'=0(투명), '1','2','3'=팔레트 인덱스. 모든 행은 같은 길이.
import argparse
import os
import struct
import sys
import zlib


def parse_px(path):
    palette = {}
    grid = []
    with open(path, encoding="utf-8") as f:
        for ln in f:
            ln = ln.rstrip("\n")
            if ln.lstrip().startswith("#"):
                if "palette:" in ln:
                    for tok in ln.split("palette:", 1)[1].split():
                        if "=" in tok:
                            k, v = tok.split("=", 1)
                            if k in "123" and len(v) == 6:
                                palette[k] = v
            elif ln.strip():
                grid.append(ln.rstrip())
    if not grid:
        raise SystemExit(f"no grid rows in {path}")
    w = len(grid[0])
    for row in grid:
        if len(row) != w:
            raise SystemExit(f"{path}: row length mismatch: '{row}' ({len(row)} != {w})")
    for row in grid:
        for c in row:
            if c != "." and c not in palette:
                raise SystemExit(f"{path}: grid char '{c}' has no palette entry")
    return palette, grid, w, len(grid)


def hex_rgb(h):
    return (int(h[0:2], 16), int(h[2:4], 16), int(h[4:6], 16))


def write_png(path, pix, w, h):
    # pix: rows of (r,g,b) tuples
    raw = b"".join(b"\x00" + bytes(v for px in row for v in px) for row in pix)
    def chunk(tag, data):
        c = tag + data
        return struct.pack(">I", len(data)) + c + struct.pack(">I", zlib.crc32(c))
    png = (b"\x89PNG\r\n\x1a\n"
           + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0))
           + chunk(b"IDAT", zlib.compress(raw, 9))
           + chunk(b"IEND", b""))
    with open(path, "wb") as f:
        f.write(png)


def render(palette, grid, w, h, scale, bg):
    checker = (hex_rgb("2a2a34"), hex_rgb("1e1e26"))
    bg_rgb = hex_rgb(bg) if bg else None
    out = []
    for y in range(h):
        row = []
        for x in range(w):
            c = grid[y][x]
            if c == ".":
                col = bg_rgb if bg_rgb else checker[(x + y) % 2]
            else:
                col = hex_rgb(palette[c])
            row.extend([col] * scale)
        for _ in range(scale):
            out.append(row)
    return out


def emit_c(path, grid, w, h):
    name = "".join(ch if ch.isalnum() or ch == "_" else "_"
                   for ch in os.path.splitext(os.path.basename(path))[0])
    stride = (w + 3) // 4
    lines = []
    for y in range(h):
        row = []
        for x in range(0, w, 4):
            b = 0
            for k in range(4):
                c = grid[y][x + k] if x + k < w else "."
                b = (b << 2) | (0 if c == "." else int(c))
            row.append(b)
        lines.append(row)
    total = stride * h
    print(f"/* {name}  {w}x{h}  2bpp MSB-first, {total} bytes */")
    print(f"static const uint8_t PX_{name.upper()}[{total}] = {{")
    for row in lines:
        print("    " + "".join(f"0x{b:02X}," for b in row))
    print("};")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("paths", nargs="+")
    ap.add_argument("--scale", type=int, default=12)
    ap.add_argument("--bg", help="RRGGBB 배경색 (기본: 체커보드)")
    ap.add_argument("--out")
    ap.add_argument("--sheet", help="여러 .px를 한 PNG에 가로로 나란히 렌더")
    ap.add_argument("--emit-c", action="store_true")
    a = ap.parse_args()

    if a.emit_c:
        for p in a.paths:
            _, grid, w, h = parse_px(p)
            emit_c(p, grid, w, h)
        return

    if a.sheet:
        gap = a.scale  # 1픽셀 폭 간격
        imgs = []
        for p in a.paths:
            pal, grid, w, h = parse_px(p)
            imgs.append(render(pal, grid, w, h, a.scale, a.bg))
        hmax = max(len(im) for im in imgs)
        gap_col = hex_rgb(a.bg) if a.bg else hex_rgb("000000")
        rows = []
        for y in range(hmax):
            row = []
            for i, im in enumerate(imgs):
                if i:
                    row.extend([gap_col] * gap)
                row.extend(im[y] if y < len(im) else [gap_col] * len(im[0]))
            rows.append(row)
        write_png(a.sheet, rows, len(rows[0]), hmax)
        print(f"rendered {a.sheet} ({len(a.paths)} sprites @ {a.scale}x)")
        return

    for p in a.paths:
        pal, grid, w, h = parse_px(p)
        out = a.out if a.out and len(a.paths) == 1 else os.path.splitext(p)[0] + ".png"
        write_png(out, render(pal, grid, w, h, a.scale, a.bg), w * a.scale, h * a.scale)
        print(f"rendered {out} ({w}x{h} @ {a.scale}x)")


if __name__ == "__main__":
    main()
