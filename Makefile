VERSION = 1.12.1.2
SHA256SUM = 273656adae309fb09ce8eb5d231cf0025252687d35dc501ee0edb8c949c067ea
PREFIX = $(DESTDIR)/usr

INSTALL_BINARIES = \
	install-bin \
	install-bin-doc \
	install-bin-doc-printable \

DESKTOP_FILES = \
	linux/desktop/pmmc-pte-sei.desktop \
	linux/desktop/pmmc-pte-sei-doc.desktop \
	linux/desktop/pmmc-pte-sei-doc-printable.desktop \

INSTALL_DESKTOP_FILES = \
	install-desktop \
	install-desktop-doc \
	install-desktop-doc-printable \

ICONS = \
	icons/sei-16.png \
	icons/sei-22.png \
	icons/sei-24.png \
	icons/sei-32.png \
	icons/sei-36.png \
	icons/sei-48.png \
	icons/sei-64.png \
	icons/sei-72.png \
	icons/sei-96.png \
	icons/sei-128.png \
	icons/sei-192.png \
	icons/sei-256.png

INSTALL_ICONS = \
	install-icon-16 \
	install-icon-22 \
	install-icon-24 \
	install-icon-32 \
	install-icon-36 \
	install-icon-48 \
	install-icon-64 \
	install-icon-72 \
	install-icon-96 \
	install-icon-128 \
	install-icon-192 \
	install-icon-256

build: $(ICONS) $(DESKTOP_FILES) linux/share/functions

install: $(INSTALL_BINARIES) $(INSTALL_ICONS) $(INSTALL_DESKTOP_FILES)
	install -D -m 644 icons/sei.svg $(PREFIX)/share/icons/hicolor/scalable/apps/pmmc-pte-sei.svg
	install -D -m 644 linux/share/functions $(PREFIX)/share/sei/functions

clean:
	rm -f icons/*.png linux/desktop/*.desktop linux/share/functions

install-icon-%: icons/sei-%.png
	install -D -m 644 $< $(PREFIX)/share/icons/hicolor/$(patsubst sei-%,%,$(*F))x$(patsubst sei-%,%,$(*F))/apps/pmmc-pte-sei.png

install-desktop: linux/desktop/pmmc-pte-sei.desktop
	install -D -m 644 $< $(PREFIX)/share/applications/$(<F)

install-desktop%: linux/desktop/pmmc-pte-sei%.desktop
	install -D -m 644 $< $(PREFIX)/share/applications/$(<F)

install-bin: linux/bin/sei
	install -D -m 755 $< $(PREFIX)/games/$(<F)

install-bin%: linux/bin/sei%
	install -D -m 755 $< $(PREFIX)/games/$(<F)

icons/%.png: icons/sei.svg
	rsvg-convert $< --width=$(patsubst sei-%,%,$(*F)) --height=$(patsubst sei-%,%,$(*F)) --format=png --output $@

linux/%: linux/%.in
	sed -e "s/@VERSION@/$(VERSION)/g" -e "s/@SHA256SUM@/$(SHA256SUM)/g" < $< > $@
