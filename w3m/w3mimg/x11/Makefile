#
# w3mimg/x11/Makefile
#
#

SHELL=/bin/sh
srcdir = .
top_srcdir = ../..
VPATH = .
CFLAGS=$(OPTS) -I../.. -I$(top_srcdir) -I$(srcdir) -g -O2 -I$(srcdir)/libwc    -DHAVE_CONFIG_H $(IMGCFLAGS)
RM=rm

IMGCFLAGS=-D_REENTRANT -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng15 -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/gtk-2.0 -I/usr/lib/gtk-2.0/include -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/harfbuzz  
OBJS=x11_w3mimg.o

all: x11_w3mimg.o

x11_w3mimg.o: x11_w3mimg.c
	$(CC) $(CFLAGS) -c $<

clean:
	@-$(RM) -f *.o

distclean: clean
	-$(RM) -f Makefile

#


