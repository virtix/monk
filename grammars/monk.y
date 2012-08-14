%{
#include <stdio.h>
#include <string.h>
#include <assert.h>
#define YYDEBUG 1
%}


%union {
  struct ast *a;
  char * prefix;
  char * target;
  char * fetch;
  char * action;
  char * taction;
  char * text;
}

/* declare tokens */
%token <prefix>PREFIX
%token <target>TARGET
%token <text>TEXT
%token <fetch>FETCH
%token <fetch>POST
%token <action>CLICK
%token <action>TYPE
%token <action>ASSERT
%token WS
%token <text>TITLE
%token <text>IN


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
  | TITLE { printf("Title: %s \n> ", $1); }
 ;


description: /*optional*/
 ;  


command:  testcase
  | testcase fetch_command
  | testcase click_command
  | testcase text_command
  | command 
 ;


fetch_command: /**/
  | FETCH WS TARGET { printf("Command: Fetch URL = %s\n> ", $3);  }
  | fetch_command
  ;

click_command: /**/
  | CLICK WS TARGET { printf("Command: %s = %s\n> ", $1, $3); }
  ;

text_command: /*optional*/
  | TYPE WS TEXT WS IN WS TARGET { printf("Command: %s %s %s %s \n> ", $1, $3, $5, $7); }
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



void assertEquals(char *expected, char *actual){
  assert( strcmp(expected, actual) != 0 );
  printf ("\n> Test OK.\n");
}

