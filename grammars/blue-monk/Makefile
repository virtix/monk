all:	  blue-monk

blue-monk:	blue-monk.l blue-monk.y
	bison -d blue-monk.y
	flex -v blue-monk.l
	gcc -o$@ blue-monk.tab.c blue-monk.lex.c

clean:
	rm -f blue-monk \
	blue-monk.tab.c blue-monk.lex.c blue-monk.tab.h	