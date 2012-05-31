%option noyywrap case-insensitive yylineno outfile="monk-lexer.c" 
%array

%{
#include <stdio.h>
#include <string.h>
int yylex (void);
void yyerror (char const *);
%}

PREFIX	^([ \t]*\-[ \t]*)
HTTP (http[s]?://)
FETCH	("Open"|"Go"|"Go to"|"Goto"|"Fetch"|"Get")
POST	("Put"|"Post")
CLICK   ("Click")
TYPE    ("Type")
WS	[ \t]+
ANY .+
WS_ANY {WS}{ANY} 

%%
{PREFIX}{FETCH}{WS_ANY} { 
		char * cmd = "http://127.0.0.1/wd/hub/session/$essionId:12345678910/url";
		char *stuff = strtok (yytext," \t");
		char * url = strtok (NULL, " \t");
		url = strtok (NULL, " \t");
		printf( "\t This should run the Selenium command:%s - with params: {url:%s}\n", cmd, url);
	}

{PREFIX}{POST}{WS_ANY}  { puts( yytext ); }

{PREFIX}{WS_ANY}  { 
		char * cmd = "http://127.0.0.1/wd/hub/session/$essionId:12345678910/click";
		char *stuff = strtok (yytext," \t");
		char * elem = strtok (NULL, " \t");
		elem = strtok (NULL, " \t");
		printf( "\t This should run the Selenium command:%s - with params: {url:%s}\n", cmd, elem);
	}

/* Splitting on the space doesn't work here. */
{PREFIX}{TYPE}{WS}[\"\']{ANY}[\"\'] { 
		char * cmd = "http://127.0.0.1/wd/hub/session/$essionId:12345678910/send_keys";
		char *stuff = strtok (yytext," \t");
		char * elem = strtok (NULL, " \t");
		elem = strtok (NULL, " \t");
		printf( "\t This should run the Selenium command:%s - with params: {url:%s}\n", cmd, elem);
	}

.|\n     /* eat up any unmatched character */


%%

main()
{
  yylex();
 
}
