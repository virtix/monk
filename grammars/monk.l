%option noyywrap case-insensitive yylineno outfile="monk.lex.c" 


%{
#include "monk.tab.h"
%}

%x COMMAND
%x GET_COMMAND
%x CLICK_COMMAND
%x TYPE_COMMAND
%x EXPECTATION
%x TITLE_STATE

/**
  This lexeme needs to be in the form of: -<WS>, *<WS>, 1.<WS>
*/
BULLET ([ \t]*(([\-|\*])|([0-9]{1,}\.))[ \t]+)

%%
^(#[ \t]+) {BEGIN TITLE_STATE; }
<TITLE_STATE>(.*) {yylval.text=strdup(yytext); return TITLE;}
<TITLE_STATE>\n { BEGIN INITIAL;}


^{BULLET}("Open"|"Go"|"Go to"|"Goto"|"Fetch"|"Get")  { 
	BEGIN GET_COMMAND; yylval.fetch=strdup(yytext); return FETCH;  }
<GET_COMMAND>((http[s]?\:\/\/)?[\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
<GET_COMMAND>([ \t]+)	{return WS;}
<GET_COMMAND>\n { BEGIN INITIAL;}


^{BULLET}("Click"|"Click on") {
	BEGIN CLICK_COMMAND; yylval.action=strdup(yytext); return CLICK;  }
<CLICK_COMMAND>([\$\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
<CLICK_COMMAND>([ \t]+)	{return WS;}
<CLICK_COMMAND>\n { BEGIN INITIAL;}


^{BULLET}("Type") {
	BEGIN TYPE_COMMAND; yylval.action=strdup(yytext); return TYPE;  }
<TYPE_COMMAND>([\"|\'|_].+[\"|\'|_]) { yylval.text=strdup(yytext); return TEXT; }
<TYPE_COMMAND>("INTO"|"IN") { yylval.text=strdup(yytext); return IN; }
<TYPE_COMMAND>([\$\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
<TYPE_COMMAND>([ \t]+)	{return WS;}
<TYPE_COMMAND>\n { BEGIN INITIAL;}

^{BULLET}("Expect"|"Expect that"|"Assert"|"Assert that"|"Verify"|"Verify that") {
	BEGIN EXPECTATION; yylval.action=strdup(yytext); return ASSERT;  }
<EXPECTATION>("Title"|"URL"|"Body") { yylval.target=strdup(yytext); return TARGET;  }	
<EXPECTATION>([\$\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
<EXPECTATION>([ \t]+)	{return WS;}
<EXPECTATION>\n { BEGIN INITIAL;}


.|\n     /* eat up any unmatched character */


%%

/*
<COMMAND>("Put"|"Post") 	{ yylval.fetch=strdup(yytext); return POST;  }
<COMMAND>("Click")  		{ yylval.action=strdup(yytext); return ACTION;  }
<COMMAND>("Type")   		{ yylval.action=strdup(yytext); return ACTION;  }
*/


