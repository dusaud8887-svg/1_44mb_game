#!/usr/bin/env python3
# px_gif.py - 팔레트 인덱스 프레임을 애니메이션 GIF89a로 인코딩(외부 의존성 없음).
# .px 아트가 이미 인덱스 컬러이므로 GIF가 자연스러운 소셜 루프 포맷이다.
# 마케팅 전용. LZW 인코더는 라운드트립 자기검증(--selftest)으로 정확성을 보장한다.
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


def lzw_encode(indexes, min_code_size):
    clear = 1 << min_code_size
    end = clear + 1
    bits = []

    def reset():
        return {(i,): i for i in range(clear)}, end + 1, min_code_size + 1

    table, next_code, code_size = reset()

    def out(code, size):
        for i in range(size):
            bits.append((code >> i) & 1)

    out(clear, code_size)
    buf = (indexes[0],)
    for idx in indexes[1:]:
        nb = buf + (idx,)
        if nb in table:
            buf = nb
        else:
            out(table[buf], code_size)
            table[nb] = next_code
            next_code += 1
            if next_code == (1 << code_size) and code_size < 12:
                code_size += 1
            if next_code == 4096:
                out(clear, code_size)
                table, next_code, code_size = reset()
            buf = (idx,)
    out(table[buf], code_size)
    out(end, code_size)
    data = bytearray()
    for i in range(0, len(bits), 8):
        b = 0
        for j, bit in enumerate(bits[i:i + 8]):
            b |= bit << j
        data.append(b)
    return bytes(data)


def lzw_decode(data, min_code_size):
    clear = 1 << min_code_size
    end = clear + 1
    bits = []
    for byte in data:
        for i in range(8):
            bits.append((byte >> i) & 1)
    pos = [0]

    def read(size):
        v = 0
        for i in range(size):
            v |= bits[pos[0]] << i
            pos[0] += 1
        return v

    def reset():
        return {i: (i,) for i in range(clear)}, end + 1, min_code_size + 1

    table, next_code, code_size = reset()
    out = []
    prev = None
    while pos[0] + code_size <= len(bits):
        code = read(code_size)
        if code == clear:
            table, next_code, code_size = reset()
            prev = None
            continue
        if code == end:
            break
        if code in table:
            entry = table[code]
        else:
            entry = table[prev] + (table[prev][0],)
        out.extend(entry)
        if prev is not None:
            table[next_code] = table[prev] + (entry[0],)
            next_code += 1
            # 디코더는 테이블 구성이 인코더보다 한 스텝 뒤지므로 -1에서 증가한다
            if next_code == (1 << code_size) - 1 and code_size < 12:
                code_size += 1
        prev = code
    return out


def write_gif(path, frames, palette, w, h, delay_cs=18, loop=0):
    """frames: 각 프레임은 인덱스(int) 1차원 시퀀스(길이 w*h). palette: (r,g,b) 목록."""
    n = len(palette)
    depth = max(1, (n - 1).bit_length())
    size = 1 << depth
    min_code_size = max(2, depth)
    pal = list(palette) + [(0, 0, 0)] * (size - n)

    out = bytearray()
    out += b"GIF89a"
    out += bytes([w & 255, w >> 8, h & 255, h >> 8])
    out += bytes([0xF0 | (depth - 1), 0, 0])       # GCT flag + depth
    for (r, g, b) in pal:
        out += bytes([r, g, b])
    # NETSCAPE2.0 루프
    out += b"\x21\xFF\x0BNETSCAPE2.0\x03\x01"
    out += bytes([loop & 255, loop >> 8, 0])
    for frame in frames:
        out += b"\x21\xF9\x04\x00"                  # GCE: no disposal, no transparency
        out += bytes([delay_cs & 255, delay_cs >> 8, 0, 0])
        out += b"\x2C\x00\x00\x00\x00"
        out += bytes([w & 255, w >> 8, h & 255, h >> 8, 0])
        out += bytes([min_code_size])
        comp = lzw_encode(list(frame), min_code_size)
        for i in range(0, len(comp), 255):
            block = comp[i:i + 255]
            out += bytes([len(block)]) + block
        out += b"\x00"
    out += b"\x3B"
    with open(path, "wb") as f:
        f.write(out)
    return len(out)


def grid_to_indexes(grid, char_index):
    return [char_index[c] for row in grid for c in row]


def selftest():
    import random
    for _ in range(200):
        n = random.randint(1, 30)
        mcs = max(2, (max(n - 1, 1)).bit_length())
        seq = [random.randrange(n) for _ in range(random.randint(1, 500))]
        enc = lzw_encode(seq, mcs)
        dec = lzw_decode(enc, mcs)
        assert dec == seq, f"roundtrip fail: n={n} len={len(seq)}"
    print("lzw selftest OK (200 cases)")


if __name__ == "__main__":
    if "--selftest" in sys.argv:
        selftest()
        sys.exit(0)

    os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
    selftest()
    import px_keyart as K
    from px_render import hex_rgb

    frames_grids = [K.build_echo(phase=p) for p in range(6)]
    # 등장하는 모든 문자 → 인덱스, 팔레트 RGB
    chars = sorted({c for g in frames_grids for row in g for c in row})
    char_index = {c: i for i, c in enumerate(chars)}
    palette = [hex_rgb(K.PAL[c]) if c in K.PAL else (0, 0, 0) for c in chars]
    frames = [grid_to_indexes(g, char_index) for g in frames_grids]

    # 3배 업스케일(소셜 가독)
    SC = 3
    W, H = K.W * SC, K.H * SC
    up = []
    for fr in frames:
        row2 = []
        rows = [fr[i * K.W:(i + 1) * K.W] for i in range(K.H)]
        for r in rows:
            big = [v for v in r for _ in range(SC)]
            for _ in range(SC):
                row2.extend(big)
        up.append(row2)

    sz = write_gif("assets/px/keyart_loop.gif", up, palette, W, H, delay_cs=18, loop=0)
    print(f"wrote assets/px/keyart_loop.gif ({W}x{H}, 6 frames, {sz} bytes)")
