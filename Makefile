# Copyright (C) 2012, Aravinda VK <mail@aravindavk.in>
#                          http://aravindavk.in

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

VERSION=1.1
CURDIR = $(shell pwd)
TMPDIR := $(shell mktemp -d gubbi.XXX)

GUBBI_TTF = gubbi-ttf-${VERSION}
GUBBI_SOURCE = gubbi-source-${VERSION}

default:
	./generate.pe Gubbi.sfd; echo "Gubbi.ttf file generated, copy to ~/.fonts/ and run fc-cache"
dist:
	mkdir ${TMPDIR}/${GUBBI_TTF}
	cp ChangeLog COPYING Gubbi.ttf README ${TMPDIR}/${GUBBI_TTF}

	mkdir ${TMPDIR}/${GUBBI_SOURCE}
	cp Makefile ChangeLog COPYING Gubbi.sfd generate.pe README ${TMPDIR}/${GUBBI_SOURCE}

	tar --owner root --group root --mode a+rX -C ${TMPDIR} -cvf - ${GUBBI_TTF} | xz -9 > ${CURDIR}/${GUBBI_TTF}.tar.xz
	tar --owner root --group root --mode a+rX -C ${TMPDIR} -cvf - ${GUBBI_SOURCE} | xz -9 > ${CURDIR}/${GUBBI_SOURCE}.tar.xz
	rm -rf ${TMPDIR}
clean:
	rm -rf *.ttf

distclean:
	rm -rf ${GUBBI_TTF}.tar.xz
	rm -rf ${GUBBI_SOURCE}.tar.xz
