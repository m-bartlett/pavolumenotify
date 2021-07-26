CC      = g++
CFLAGS  += -std=c++17 -I$(PREFIX)/include
CFLAGS  += -D_POSIX_C_SOURCE=200112L
CFLAGS  += $(shell pkg-config --cflags libnotify)
LDFLAGS += -L$(PREFIX)/lib

LIBS     = -lm -lpulse
LIBS		 += $(shell pkg-config --libs libnotify)
TARGET   = pavolume

PREFIX    ?= /usr/local
BINPREFIX  = $(PREFIX)/bin

default: $(TARGET)
all: default

OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))

all: $(TARGET)

debug: CFLAGS += -O0 -g
debug: $(TARGET)

$(TARGET):
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $@.c $(LIBS)

install:
	mkdir -p "$(DESTDIR)$(BINPREFIX)"
	cp -p $(TARGET) "$(DESTDIR)$(BINPREFIX)"

uninstall:
	rm -f "$(DESTDIR)$(BINPREFIX)/$(TARGET)"

clean:
	rm -f $(TARGET) $(OBJECTS)

.PHONY: all debug default install uninstall clean
# .PRECIOUS: $(TARGET) $(OBJECTS)
