#!/usr/bin/env python3
"""
Build a cover image for Reproducible Research for the Health
Sciences, in the visual idiom of the rgtlab Curriculum
Project series: two-zone composition with a watercolour top
zone and a solid bottom zone, clean sans-serif typography.

Palette: anchored on a verification teal (#14746f) moving
through sage into gold and cream, distinct from the sister
covers.

Usage:
    python3 build-cover.py
Output:
    cover.png     (1200 x 1800, the book cover)
    favicon.png   (128 x 128, the tab icon)
"""

import random
from PIL import Image, ImageDraw, ImageFilter, ImageFont

W, H        = 1200, 1800
SPLIT_Y     = int(H * 0.36)

TEAL        = (20, 116, 111)          # #14746f brand teal
TEAL_DEEP   = (12, 74, 71)
CREAM       = (248, 244, 233)
GOLD        = (201, 180, 95)
WHITE       = (255, 255, 255)

WATERCOLOUR = [
    (10,  60,  58),    # deep teal
    (20,  116, 111),   # teal (brand)
    (110, 178, 168),   # sage / mint
    (201, 180, 95),    # warm gold
    (233, 231, 222),   # pale cream
]


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))


def palette_at(t, palette=WATERCOLOUR):
    n = len(palette) - 1
    pos = t * n
    i = int(pos)
    if i >= n:
        return palette[-1]
    return lerp(palette[i], palette[i + 1], pos - i)


def watercolour_zone(width, height, seed=53):
    rng = random.Random(seed)
    base = Image.new('RGB', (width, height), (240, 240, 240))
    px = base.load()
    for y in range(height):
        for x in range(width):
            t = (x / width * 0.55 + y / height * 0.45)
            t = max(0.0, min(1.0, t))
            px[x, y] = palette_at(t)
    overlay = Image.new('RGB', (width, height), (0, 0, 0))
    odraw = ImageDraw.Draw(overlay)
    mask = Image.new('L', (width, height), 0)
    mdraw = ImageDraw.Draw(mask)
    for _ in range(28):
        cx = rng.randint(-100, width + 100)
        cy = rng.randint(-50, height + 50)
        r = rng.randint(180, 480)
        col = palette_at(rng.uniform(0, 1))
        odraw.ellipse((cx - r, cy - r, cx + r, cy + r), fill=col)
        mdraw.ellipse((cx - r, cy - r, cx + r, cy + r), fill=70)
    overlay = overlay.filter(ImageFilter.GaussianBlur(radius=120))
    mask = mask.filter(ImageFilter.GaussianBlur(radius=80))
    base = Image.composite(overlay, base, mask)
    base = base.filter(ImageFilter.GaussianBlur(radius=2))
    return base


def add_paper_grain(img, strength=8, seed=11):
    rng = random.Random(seed)
    grain = Image.new('L', img.size, 128)
    gpx = grain.load()
    for y in range(img.size[1]):
        for x in range(img.size[0]):
            gpx[x, y] = max(0, min(255, 128 + rng.randint(-strength, strength)))
    grain = grain.filter(ImageFilter.GaussianBlur(radius=0.5))
    img.paste(Image.blend(
        img.convert('RGB'),
        Image.merge('RGB', (grain, grain, grain)),
        0.05,
    ))
    return img


def font(name, size):
    candidates = {
        'avenir-medium':  ('/System/Library/Fonts/Avenir.ttc', 2),
        'avenir-heavy':   ('/System/Library/Fonts/Avenir.ttc', 6),
        'avenir-black':   ('/System/Library/Fonts/Avenir.ttc', 7),
        'avenir-light':   ('/System/Library/Fonts/Avenir.ttc', 0),
    }
    path, idx = candidates[name]
    return ImageFont.truetype(path, size, index=idx)


def draw_text(draw, xy, text, fnt, fill, anchor='lt'):
    draw.text(xy, text, font=fnt, fill=fill, anchor=anchor)


def draw_layers(draw, x, y, colour):
    # three nested rounded rectangles, evoking the levels ladder
    for i in range(3):
        off = i * 24
        draw.rounded_rectangle(
            (x + off, y + off, x + 160 - off, y + 120 - off),
            radius=8, outline=colour, width=4)


def build():
    canvas = Image.new('RGB', (W, H), TEAL)
    top = watercolour_zone(W, SPLIT_Y, seed=53)
    canvas.paste(top, (0, 0))
    draw = ImageDraw.Draw(canvas)

    draw.rectangle((0, SPLIT_Y, W, SPLIT_Y + 3), fill=CREAM)
    draw.rectangle((0, 0, 14, SPLIT_Y), fill=TEAL_DEEP)
    draw.rectangle((14, 0, 17, SPLIT_Y), fill=CREAM)

    series_fnt = font('avenir-heavy', 36)
    draw_text(draw, (60, 90), 'GRADUATE BIOSTATISTICS SERIES',
              series_fnt, WHITE)

    author_fnt = font('avenir-medium', 64)
    draw_text(draw, (60, 240), 'rgtlab Curriculum Project',
              author_fnt, WHITE)

    draw_layers(draw, W - 300, SPLIT_Y - 210, GOLD)

    title_fnt = font('avenir-black', 92)
    title_lines = ['Reproducible', 'Research for the',
                   'Health Sciences']
    y = SPLIT_Y + 90
    for line in title_lines:
        draw_text(draw, (60, y), line, title_fnt, WHITE)
        y += 118

    sub_fnt = font('avenir-medium', 44)
    y += 24
    draw_text(draw, (62, y), 'A graduate textbook', sub_fnt, CREAM)

    edition_fnt = font('avenir-light', 42)
    draw_text(draw, (60, H - 180), 'First Edition  ·  2026',
              edition_fnt, CREAM)

    mark_fnt = font('avenir-heavy', 44)
    draw_text(draw, (W - 60, H - 80), 'rgtlab', mark_fnt, WHITE,
              anchor='rs')
    draw.rectangle((W - 240, H - 64, W - 60, H - 60), fill=GOLD)

    canvas = add_paper_grain(canvas)
    return canvas


def build_favicon():
    size = 128
    img = Image.new('RGB', (size, size), TEAL)
    draw = ImageDraw.Draw(img)
    for i in range(3):
        off = i * 16
        draw.rounded_rectangle(
            (24 + off, 24 + off, 104 - off, 104 - off),
            radius=6, outline=GOLD, width=5)
    return img


if __name__ == '__main__':
    img = build()
    img.save('cover.png', optimize=True)
    print(f'wrote cover.png ({img.size[0]} x {img.size[1]})')
    fav = build_favicon()
    fav.save('favicon.png', optimize=True)
    print(f'wrote favicon.png ({fav.size[0]} x {fav.size[1]})')
