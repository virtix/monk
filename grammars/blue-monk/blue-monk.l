%option noyywrap case-insensitive yylineno outfile="blue-monk.lex.c" 


%{
#include "blue-monk.tab.h"
%}

%x COMMAND
%x GET_COMMAND
%x CLICK_COMMAND
%x TYPE_COMMAND
%x EXPECTATION
%x TITLE_STATE

%%
^(#[ \t]+) {BEGIN TITLE_STATE; }
<TITLE_STATE>(.*) {yylval.text=strdup(yytext); return TITLE;}
<TITLE_STATE>\n { BEGIN INITIAL;}

^([ \t]*(([\-|\*])|([0-9]{1,}\.))[ \t]*)("Open"|"Go"|"Go to"|"Goto"|"Fetch"|"Get")  { 
	BEGIN GET_COMMAND; yylval.fetch=strdup(yytext); return FETCH;  }
<GET_COMMAND>((http[s]?\:\/\/)?[\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
<GET_COMMAND>([ \t]+)	{return WS;}
<GET_COMMAND>\n { BEGIN INITIAL;}

^([ \t]*\-[ \t]*)("Click"|"Click on") {
	BEGIN CLICK_COMMAND; yylval.action=strdup(yytext); return ACTION;  }
<CLICK_COMMAND>([\$\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
<CLICK_COMMAND>([ \t]+)	{return WS;}	
<CLICK_COMMAND>\n { BEGIN INITIAL;}

^([ \t]*\-[ \t]*)("Type") {
	BEGIN TYPE_COMMAND; yylval.action=strdup(yytext); return ACTION;  }
<TYPE_COMMAND>(\"[.]*\") { yylval.text=strdup(yytext); return TEXT;  }
<TYPE_COMMAND>([\$\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
<TYPE_COMMAND>([ \t]+)	{return WS;}	
<TYPE_COMMAND>\n { BEGIN INITIAL;}

.|\n     /* eat up any unmatched character */


%%

/*
<COMMAND>("Put"|"Post") 	{ yylval.fetch=strdup(yytext); return POST;  }
<COMMAND>("Click")  		{ yylval.action=strdup(yytext); return ACTION;  }
<COMMAND>("Type")   		{ yylval.action=strdup(yytext); return ACTION;  }
*/


