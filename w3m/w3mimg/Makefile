#
# w3mimg/Makefile
#

SHELL=/bin/sh
srcdir = .
top_srcdir = ..
VPATH = .
CFLAGS=$(OPTS) -I.. -I$(top_srcdir) -I$(srcdir) -g -O2 -I$(srcdir)/libwc    -DHAVE_CONFIG_H $(IMGCFLAGS)
AR=ar
RANLIB=ranlib
RM=rm

SUBDIRS=fb x11 win
IMGCFLAGS=-D_REENTRANT -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng15 -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/gtk-2.0 -I/usr/lib/gtk-2.0/include -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/harfbuzz    -I/usr/include/w32api
IMGOBJS=w3mimg.o x11/x11_w3mimg.o win/win_w3mimg.o

.PHONY: $(SUBDIRS)
all: x11 win w3mimg.a

w3mimg.a: $(IMGOBJS)
	$(AR) rv $@ $(IMGOBJS)
	$(RANLIB) $@

w3mimg.o: w3mimg.c
	$(CC) $(CFLAGS) -c $<

$(SUBDIRS):
	cd $@ && $(MAKE) CC="$(CC)" OPTS="$(OPTS)"

clean:
	@-$(RM) -f *.o
	@for dir in $(SUBDIRS); do \
		(cd $$dir && $(MAKE) clean RM=$(RM)); \
	 done
	-$(RM) -f w3mimg.a

distclean: clean
	for subdir in $(SUBDIRS); \
	do \
		(cd $$subdir && $(MAKE) distclean); \
	done
	-$(RM) -f Makefile


#
