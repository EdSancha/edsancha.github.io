# Canarina

Copyright (c) 2020-2025, Ariel Martín Pérez <contact@tainome.com>,
with Reserved Font Name "Canarina".

Licensed under the SIL Open Font License, Version 1.1. The full licence text
is in `OFL.txt` in this directory, which is what the licence requires: the
copyright notice and licence must travel with the font wherever it is
redistributed.

- Designer: Ariel Martín Pérez
- Foundry: Tunera Type Foundry — https://www.tunera.xyz/fonts/canarina/
- Canarina is a trademark of Ariel Martín Pérez (2020-2025).

Canarina is inspired by the Canary Islands and named after *Canarina
canariensis*, a vine with red bell-shaped flowers that is one of the symbols
of the islands. Its letterforms draw on the graphic work of Eduardo Millares
Sall and César Manrique rather than on any local metal-type tradition.

## What is here, and why only one file

The upstream release ships three static cuts and a variable font. Despite the
names reading like optical sizes, they are weights:

| File | Family name in the font | Weight |
|---|---|---|
| Canarina-Chica | Canarina Chica | 400 |
| Canarina-Mediana | Canarina Fina | 500 |
| Canarina-Grande | Canarina Grande | 800 |

The `canarion` theme sets headings at 800, so only `Canarina-Grande.woff2` is
here. Loading a cut nothing uses would cost a font fetch on first paint for
nothing. To use a different weight, add that `.woff2` from the upstream zip,
add an `@font-face` for it in `css/themes/canarion.css`, and point
`--title-font-weight` at it.

The variable font is not used: its `wght` axis runs 90 to 130 rather than the
usual 1 to 1000, which does not map cleanly onto CSS `font-weight`.

## Modifying it

The Reserved Font Name means a modified version may not be distributed under
the name "Canarina". This directory carries the font unmodified, exactly as
released.
