#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys
import fontforge

font = fontforge.open(sys.argv[1])

for i in font.glyphs():
    if i.unicode != -1:
        print "%s : %s" %(i.glyphname, "U" + hex(i.unicode).replace("0x", "").upper().zfill(4))
    else:
        print "%s : " %(i.glyphname)
