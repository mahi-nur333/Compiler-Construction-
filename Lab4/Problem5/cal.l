%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cal.tab.h"
%}

digit [0-9]
number {digit}+
id [a-zA-Z_][a-zA-Z0-9_]*
ws [ \t\n]+

%%

"int"       { return INT_TYPE; }
"switch"    { return SWITCH; }
"case"      { return CASE; }
"default"   { return DEFAULT; }
"break"     { return BREAK; }

{number}    { yylval.ival = atoi(yytext); return INT_NUM; }
{id}        { yylval.sval = strdup(yytext); return ID; }

"="         { return ASSIGN; }
":"         { return COLON; }
";"         { return SEMI; }

"("         { return LPREN; }
")"         { return RPREN; }
"{"         { return LCB; }
"}"         { return RCB; }

"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MUL; }
"/"         { return DIV; }
"%"         { return MOD; }

{ws}        ; /* skip whitespace */
.           ; /* ignore unrecognized characters */

%%
