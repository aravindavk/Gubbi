#!/usr/bin/python

# Program reads the fontforge source file and generates otf font
# Copyright (C) 2011  Aravinda VK <hallimanearavind@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sys
import fontforge
    
font = fontforge.open(sys.argv[1])

flags  = ("opentype", "dummy-dsig", "round")
font_name = sys.argv[1].replace(".sfd",".otf")
font.generate(font_name, flags=flags)
font.close()
print "[OK]", font_name, " generated"
