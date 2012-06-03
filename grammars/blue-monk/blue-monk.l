%option noyywrap case-insensitive yylineno outfile="blue-monk.lex.c" 


%{
#include "blue-monk.tab.h"
%}

%x COMMAND
%x GET_COMMAND
%x CLICK_COMMAND
%x TYPE_COMMAND

%%
^([ \t]*\-[ \t]*)("Open"|"Go"|"Go to"|"Goto"|"Fetch"|"Get")  { 
	BEGIN GET_COMMAND; yylval.fetch=strdup(yytext); return FETCH;  }
<GET_COMMAND>((http[s]?\:\/\/)?[\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
<GET_COMMAND>([ \t]+)	{return WS;}
<GET_COMMAND>\n { BEGIN INITIAL;}

^([ \t]*\-[ \t]*)("Click"|"Click on") {
	BEGIN CLICK_COMMAND; yylval.action=strdup(yytext); return ACTION;  }
<CLICK_COMMAND>([\$\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
<CLICK_COMMAND>([ \t]+)	{return WS;}	
<CLICK_COMMAND>\n { BEGIN INITIAL;}
.|\n     /* eat up any unmatched character */


%%

/*
<COMMAND>("Put"|"Post") 	{ yylval.fetch=strdup(yytext); return POST;  }
<COMMAND>("Click")  		{ yylval.action=strdup(yytext); return ACTION;  }
<COMMAND>("Type")   		{ yylval.action=strdup(yytext); return ACTION;  }
*/


