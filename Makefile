VERSION=1.3
CURDIR = $(shell pwd)
TMPDIR := $(shell mktemp -d gubbi.XXX)

GUBBI_TTF = gubbi-ttf-${VERSION}
GUBBI_SOURCE = gubbi-source-${VERSION}
GUBBI_DOWNLOAD = Gubbi-${VERSION}

default:
	./generate.pe Gubbi.sfd; echo "Gubbi.ttf file generated, copy to ~/.fonts/ and run fc-cache"
dist:
	mkdir ${TMPDIR}/${GUBBI_TTF}
	cp ChangeLog COPYING Gubbi.ttf README ${TMPDIR}/${GUBBI_TTF}

	mkdir ${TMPDIR}/${GUBBI_SOURCE}
	cp Makefile ChangeLog COPYING Gubbi.sfd generate.pe README ${TMPDIR}/${GUBBI_SOURCE}

	tar --owner root --group root --mode a+rX -C ${TMPDIR} -cvf - ${GUBBI_TTF} | xz -9 > ${CURDIR}/${GUBBI_TTF}.tar.xz
	tar --owner root --group root --mode a+rX -C ${TMPDIR} -cvf - ${GUBBI_SOURCE} | xz -9 > ${CURDIR}/${GUBBI_SOURCE}.tar.xz
	cd ${TMPDIR} && zip -r ${CURDIR}/${GUBBI_DOWNLOAD}.zip ${GUBBI_TTF}
	rm -rf ${TMPDIR}
clean:
	rm -rf *.ttf

distclean:
	rm -rf ${GUBBI_TTF}.tar.xz
	rm -rf ${GUBBI_SOURCE}.tar.xz
	rm -rf Gubbi-${VERSION}.zip
