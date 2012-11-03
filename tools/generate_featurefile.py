import fontforge
import sys

font = fontforge.open(sys.argv[1])
font.generateFeatureFile(sys.argv[2])
