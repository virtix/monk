all:	  monk

monk:	monk.l monk.y
	bison -d monk.y
	flex -v monk.l
	gcc -o$@ monk.tab.c monk.lex.c

clean:
	rm -f monk \
	monk.tab.c monk.lex.c monk.tab.h	