%{
#include <stdio.h>
#include <string.h>
#define YYDEBUG 1
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

testcase: /* do nothing: test should contain title, description, commands, and tags */
  | title 
  | description
  | command
  | tag
  | option
  | testcase
 ;


title: /*optional*/
  | TITLE { printf("Title: %s \n> ", $1); assertEquals("asd","asd"); }
 ;


description: /*optional*/
 ;  


command:  testcase
  | testcase fetch_command
  | testcase click_command
  | command 
 ;


fetch_command: /**/
  | FETCH WS TARGET { printf("Command: Fetch URL = %s\n> ", $3); }
  | fetch_command
  ;

click_command: /**/
  | ACTION WS TARGET { printf("Command: %s = %s\n> ", $1, $3); }
  ;

text_command: /*optional*/
  ;

option: /*optional*/
 ;


tag: /*optional*/
 ;

/*
 | ACTION WS TEXT 'into' WS TARGET { printf("Command: %s %s into %s\n> ", $1, $3, $6) ;}

| testcase FETCH WS TARGET { printf("Command: Fetch URL = %s\n> ", $4); }
 | testcase ACTION WS TARGET { printf("Command: %s = %s\n> ", $2, $4); }
 | testcase ACTION WS TEXT 'into' WS TARGET { printf("Command: %s %s into %s\n> ", $2, $4, $7) ;}
 | testcase 
*/


%%
main() {
  yydebug=1;
  printf("> "); 
  yyparse();
}

yyerror(char *s) {
  fprintf (stderr, "error: %s, \n", s);

  /*fprintf("%d: %s at %s in this line:\n%s\n", lineno, s, yytext, "?");*/
}




/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  To Do: Unit test helpers. Use this to test the parser prior to adding
  actions.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
void assert(char *expression){
  
}


void assertEquals(char *expected, char *actual){
  if( strcmp(expected, actual) != 0 ){
    printf ("\n> FAIL: %s != %$ \n", expected,actual);
  }
  else {
    printf ("\n> Test OK.\n");
  }
}

