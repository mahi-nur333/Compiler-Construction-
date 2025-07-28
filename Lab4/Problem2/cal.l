%{
#include "cal.tab.h"
#include <stdlib.h>
#include <string.h>
%}
%option yylineno

digit   [0-9]+
float   {digit}"."{digit}
id      [a-zA-Z_][a-zA-Z0-9_]*
string  \"[^\"]*\"
comment "//".*

%%

"#include"   { return INCLUDE; }
"<stdio.h>" { /* ignore header name */ }
"int"       { return INT; }
"main"      { return MAIN; }
"if"        { return IF; }
"else"      { return ELSE; }
"for"       { return FOR; }
"printf"    { return PRINTF; }
"return"    { return RETURN; }

"="         { return ASSIGN; }
"=="        { return EQ; }
"!="        { return NOT_EQUAL; }
">="        { return GE; }
"<="        { return LE; }
">"         { return '>'; }
"<"         { return '<'; }
"%"         { return MOD; }
"&&"        { return AND; }
"\|\|"      { return OR; }
"--"        { return DEC; }

"("         { return LPREN; }
")"         { return RPREN; }
"{"         { return LCB; }
"}"         { return RCB; }
";"         { return SEMI; }
"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MUL; }
"/"         { return DIV; }

{digit}     { yylval.ival = atoi(yytext); return INT_NUM; }
{float}     { yylval.fval = atof(yytext); return FLOAT_NUM; }
{id}        { yylval.sval = strdup(yytext); return ID; }
{string}    { yylval.sval = strdup(yytext); return STRING; }
","         { return COMMA; }
{comment}   { /* ignore comments */ }

[ \t\n]+    ; /* skip whitespace */
.           { /* ignore unrecognized characters */ }

%%

int yywrap(void) { return 1; }