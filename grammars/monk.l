%option noyywrap case-insensitive yylineno  stack
%option outfile="monk.lex.c"

%{
#include "monk.tab.h"
%}

%x TITLE_STATE GET_COMMAND CLICK_COMMAND TYPE_COMMAND EXPECTATION

/**
  This lexeme needs to be in the form of: -<WS>, *<WS>, 1.<WS>
*/
LIST_MARKER ^([ \t]{0,3}(([\-|\*])|([0-9]{1,}\.))[ \t]+)
HASH ^(#[ \t]+)
BLANK_LINE ^([ \t]+)$
WS ([ \t]+)
MD_STRING_LITERAL ([\"|\'|_].+[\"|\'|_])

%%


^(#[ \t]+) { yy_push_state(TITLE_STATE); }
<TITLE_STATE>{ 
	(.*) {yylval.text=strdup(yytext); return TITLE;}
	\n { yy_pop_state();}
}


{LIST_MARKER}("Open"|"Go"|"Go to"|"Goto"|"Fetch"|"Get")  { 
	yy_push_state(GET_COMMAND); yylval.fetch=strdup(yytext); return FETCH;  }
<GET_COMMAND>{ 
	((http[s]?\:\/\/)?[\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
	([ \t]+)	{return WS;}
	\n { yy_pop_state();}
}


{LIST_MARKER}("Click"|"Click on") {
	yy_push_state(CLICK_COMMAND); yylval.action=strdup(yytext); return CLICK;  }
<CLICK_COMMAND>{
	([\$\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
    ([ \t]+)	{return WS;}
    \n { yy_pop_state();}
}


{LIST_MARKER}("Type"|"Enter") {
	yy_push_state(TYPE_COMMAND); yylval.action=strdup(yytext); return TYPE;  }
<TYPE_COMMAND>{
	{MD_STRING_LITERAL} { yylval.text=strdup(yytext); return TEXT; }
	("INTO"|"IN") { return IN; }
	([\$\-\_0-9a-zA-Z\.]+) { yylval.target=strdup(yytext); return TARGET;  }
	([ \t]+)	{return WS;}
	\n { yy_pop_state();}
}



{LIST_MARKER}("Expect"|"Expect that"|"Assert"|"Assert that"|"Verify"|"Verify that") {
	yy_push_state(EXPECTATION); yylval.action=strdup(yytext); return ASSERT;  }
<EXPECTATION>{
	("Title"|"URL"|"Body") { yylval.target=strdup(yytext); return TARGET;  }
	("Is"|"Equals"|"Is Equal to") { return IS; }
	{MD_STRING_LITERAL} { yylval.target=strdup(yytext); return TEXT;  }
	([ \t]+)	{return WS;}
	\n { yy_pop_state(); }
}

.|\n     /* eat up any unmatched character */


%%



