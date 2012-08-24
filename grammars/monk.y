%{
#include <stdio.h>
#include <string.h>
#include <assert.h>
#define YYDEBUG 1
#define YYERROR_VERBOSE
int yylex (void);
// void yyerror (char const *);

typedef struct YYLTYPE {
     int first_line;
     int first_column;
     int last_line;
     int last_column;
    } YYLTYPE;

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
%token <text>TITLE
%token <text>LINE
%token IN
%token IS

%token HASH
%token WS

%start testcase


%%

testcase: /* do nothing: test should contain title, description, commands, and tags */
  | testcase title 
  | testcase description
  | testcase command
  | testcase tag
  | testcase option
 ;

/*| TITLE { printf("Title: %s \n> ", $1); }*/
title: /*optional*/
  |  TITLE { printf("Title: %s \n> ", $1); }
 ;

/*|  error { yyerrok;                  }*/


description: /*optional*/
 ;  


command:  
  |  fetch_command
  |  click_command
  |  text_command
  |  verify_command
  |  command
 ;


fetch_command: 
  | FETCH WS TARGET { printf("Command: Fetch URL = %s\n> ", $3);  } 
  | command
  ;

click_command: /**/
  | CLICK WS TARGET { printf("Command: %s = %s\n> ", $1, $3); }
  | command
  ;

text_command: /*optional*/
  | TYPE WS TEXT WS IN WS TARGET { printf("Command: %s %s Into %s \n> ", $1, $3, $7); }
  | command
  ;


verify_command: /*optional*/
  | ASSERT WS TARGET WS IS WS TEXT { printf("Command: %s %s Equals %s \n> ", $1, $3, $7); }
  | command
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

