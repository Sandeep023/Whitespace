%{
#include "y.tab.h"
%}
%option header-file="lex.yy.h"

%%
[ ]	{yylval.cmd = atoi(yytext); return space;}
[\t]	{yylval.cmd = atoi(yytext); return tab;}
[\n]	{yylval.cmd = atoi(yytext); return linefeed;}
[\n][\n][\n]	{return exit_command;}
.	{ECHO; yyerror ("unexpected character");}

%%
int yywrap (void) {return 1;}
