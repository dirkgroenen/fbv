#
# Makefile
#
# Makefile for fbv

CONF=Make.conf
-include $(CONF)

CC	= gcc 
CFLAGS  = -O2 -Wall -D_GNU_SOURCE

SOURCES	= main.c jpeg.c gif.c png.c bmp.c fb_display.c transforms.c
OBJECTS	= ${SOURCES:.c=.o}

OUT	= fbv
#LIBS	= -lungif -L/usr/X11R6/lib -ljpeg -lpng

all: $(OUT)
	@echo Build DONE.

$(OUT): $(OBJECTS) $(CONF)
	$(CC) $(LDFLAGS) -o $(OUT) $(OBJECTS) $(LIBS)

$(CONF):
	$(error Please run ./configure first...)

clean:
	rm -f $(OBJECTS) *~ $$$$~* *.bak core config.log $(OUT)

distclean: clean
	rm -f $(OUT) $(CONF) config.h

install: $(OUT)
	cp $(OUT) $(DESTDIR)$(bindir)
	gzip -9c $(OUT).1 > $(DESTDIR)$(mandir)/man1/$(OUT).1.gz

uninstall: $(DESTDIR)$(bindir)/$(OUT)
	rm -f $(DESTDIR)$(bindir)/$(OUT)
	rm -f $(DESTDIR)$(mandir)/man1/$(OUT).1.gz
