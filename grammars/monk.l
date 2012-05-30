%option noyywrap case-insensitive yylineno

%{
#include <stdio.h>
#include <string.h>
int yylex (void);
void yyerror (char const *);
%}


%%
("Open"|"Go"|"Go to"|"Goto"|"Fetch"|"Get"|"Put"|"Post")([ \t]+)(.+) { 
		char * cmd = "http://127.0.0.1/wd/hub/session/$essionId:12345678910/url";
		char *stuff = strtok (yytext," ");
		char * url = strtok (NULL, " ");
		printf( "Run command:%s - with params: {url:%s}\n", cmd, url);
	}

("Put"|"Post")([ \t]+)(.+) { printf( "placeholder for PUT and POST operations" ); }

("Click")([ \t]+)(.+) { printf( "placeholder for Click events" ); }

("Type") { printf( "placeholder for Key events events" ); }

.|\n     /* eat up any unmatched character */


%%

main()
{
  yylex();
 
}
