

%{
#include <stdio.h>
%}


%union {
  struct ast *a;
  char * prefix;
  char * target;
  char * fetch;
  char * action;
  char * text;
}

/* declare tokens */
%token <prefix>PREFIX
%token <target>TARGET
%token <text>TEXT
%token <fetch>FETCH
%token <fetch>POST
%token <action>ACTION
%token WS
%token <text>TITLE


%%

test: /* do nothing: test should contain title, description, commands, and tags */
 | test FETCH WS TARGET { printf("Command: Fetch URL = %s\n> ", $4); }
 | test ACTION WS TARGET { printf("Command: %s = %s\n> ", $2, $4); }
 | test ACTION WS TEXT 'into' WS TARGET { printf("Command: %s %s into %s\n> ", $2, $4, $7) ;}
 | test TITLE { printf("Title: %s \n> ", $2); }
 ;



%%
main() {
  printf("> "); 
  yyparse();
}

yyerror(char *s) {
  fprintf(stderr, "error: %s, \n", s);
  /*fprintf("%d: %s at %s in this line:\n%s\n", lineno, s, yytext, "?");*/
}
 