VERSION=1.1
default:
	./generate.pe Gubbi.sfd; echo "Gubbi.ttf file generated, copy to ~/.fonts/ and run fc-cache"
fedora:
	rm -rf /tmp/gubbi-ttf-${VERSION}
	mkdir /tmp/gubbi-ttf-${VERSION}
	cp ChangeLog COPYING Gubbi.ttf README /tmp/gubbi-ttf-${VERSION}/

	rm -rf /tmp/gubbi-${VERSION}
	mkdir /tmp/gubbi-${VERSION}
	cp ChangeLog COPYING Gubbi.sfd generate.pe README /tmp/gubbi-${VERSION}/
	cp fedora_makefile /tmp/gubbi-${VERSION}/Makefile

	cd /tmp/; \
	tar -cvzf gubbi-ttf-${VERSION}.tar.gz gubbi-ttf-${VERSION}/; \
	tar -cvzf gubbi-${VERSION}.tar.gz gubbi-${VERSION}/; \
	rm -rf gubbi-ttf-${VERSION}; \
	rm -rf gubbi-${VERSION}; 
clean:
	rm -rf /tmp/gubbi-ttf-${VERSION}
	rm -rf /tmp/gubbi-${VERSION}
	rm -rf /tmp/gubbi-ttf-${VERSION}.tar.gz
	rm -rf /tmp/gubbi-${VERSION}.tar.gz
