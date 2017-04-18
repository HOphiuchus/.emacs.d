#
# w3mimg/win/Makefile
#
#

SHELL=/bin/sh
srcdir = .
top_srcdir = ../..
VPATH = .
CFLAGS=$(OPTS) -I../.. -I$(top_srcdir) -I$(srcdir) -g -O2 -I$(srcdir)/libwc    -DHAVE_CONFIG_H $(IMGCFLAGS)
RM=rm
CC=gcc
CXX=g++

IMGCFLAGS=-I/usr/include/w32api
OBJS=win_w3mimg.o

all: win_w3mimg.o

win_w3mimg.o: win_w3mimg.cpp
	$(CXX) $(CFLAGS) -c $<

clean:
	@-$(RM) -f *.o

distclean: clean
	-$(RM) -f Makefile

#


