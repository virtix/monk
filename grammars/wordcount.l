%option noyywrap

%{
int chars = 0;
int words = 0;
int lines = 0;
%}

%%

[a-zA-Z0-9]+	{ words++; chars += strlen(yytext); }
\n		{ chars++; lines++; }
.		{ chars++; }

%%

main()
{
  yylex();
  printf("\nLines:%d, Words:%d, Chars:%d\n", lines, words, chars);
}
