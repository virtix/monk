#Libs
__LINKFLAGS = -Wl,-Bsymbolic-functions -Wl,-z,relro 
LINKFLAGS = -Wl,-z,relro 
LDFLAGS = -L/usr/lib/x86_64-linux-gnu/
LDLIBS = -lcurl

#Output
OUT = monk
SRC = monk.tab.c monk.lex.c

all:	  monk

monk:	monk.l monk.y
	bison -d monk.y
	flex -v monk.l
	gcc -o $(OUT) $(SRC) $(LDFLAGS) $(LDLIBS) $(LINKFLAGS) 

clean:
	rm -f monk \
	monk.tab.c monk.lex.c monk.tab.h	