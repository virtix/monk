UNAME=$(shell uname)

CCFLAGS=-Wall -Wextra -Wno-unused-parameter -O3
ifdef CTEST_COLOR_OK
CCFLAGS+=-DCOLOR_OK
endif

ifeq ($(UNAME), Darwin)
LDFLAGS=-Wl,-flat_namespace,-undefined,dynamic_lookup
endif

all: alltests

remake: clean all test

%.o: %.c ctest.h
	gcc $(CCFLAGS) -c -o $@ $<

alltests: main.o ctest.h monk_tests.o
	gcc $(LDFLAGS) main.o monk_tests.o -o alltests

clean:
	rm -f alltests *.o

test:
	./alltests


