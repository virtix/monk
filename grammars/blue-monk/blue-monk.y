

%{
#include <stdio.h>
%}


%union {
  struct ast *a;
  char * prefix;
  char * target;
  char * fetch;
  char * action;
}

/* declare tokens */
%token <prefix>PREFIX
%token <target>TARGET
%token <fetch>FETCH
%token <fetch>POST
%token <action>ACTION
%token WS


%%

test: /* do nothing: test should contain title, description, commands, and tags */
 | test FETCH WS TARGET { printf("Command: Fetch URL = %s\n> ", $4); }
 | test ACTION WS TARGET { printf("Command: %s = %s\n> ", $2, $4); }
 ;



%%
main() {
  printf("> "); 
  yyparse();
}

yyerror(char *s) {
  fprintf(stderr, "error: %s, \n", s);
}
