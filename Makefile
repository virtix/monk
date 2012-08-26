#Libs
__OLD_LINKFLAGS = -Wl,-Bsymbolic-functions -Wl,-z,relro 
LINKFLAGS = -Wl,-z,relro 
LDFLAGS = -L/usr/lib/x86_64-linux-gnu/
LDLIBS = -lcurl

VPATH = src/grammars/markdown/
OUT = bin/monk
SRC = $(VPATH)monk-markdown.tab.c $(VPATH)monk-markdown.lex.c $(VPATH)monkycurl.h

all:	  monk

monk:	monk-markdown.l monk-markdown.y
	bison -o $(VPATH)monk-markdown.tab.c -d $(VPATH)monk-markdown.y 
	flex -v -o $(VPATH)monk-markdown.lex.c $(VPATH)monk-markdown.l 
	gcc -o $(OUT) $(SRC) $(LDFLAGS) $(LDLIBS) $(LINKFLAGS) 

clean:
	rm -f bin/monk \
	$(VPATH)monk-markdown.tab.c $(VPATH)monk-markdown.lex.c $(VPATH)monk-markdown.tab.h $(VPATH)monk-markdown.lex.h	