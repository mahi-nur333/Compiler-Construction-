%{
#include "cal.tab.h"
#include <stdlib.h>
#include <string.h>
%}

digit   [0-9]
number  {digit}+
id      [a-zA-Z_][a-zA-Z0-9_]*
ws      [ \t\n]+

%%

"int"       { return INT_TYPE; }
"while"     { return WHILE; }
"if"        { return IF; }
"else"      { return ELSE; }

{number}    { yylval.ival = atoi(yytext); return INT_NUM; }
{id}        { yylval.sval = strdup(yytext); return ID; }

"="         { return ASSIGN; }
">="        { return GE; }
"<="        { return LE; }
"=="        { return EQ; }
"!="        { return NE; }
"--"        { return DEC; }

"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
";"         { return SEMI; }

"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
">"         { return '>'; }
"<"         { return '<'; }

{ws}        ; /* skip whitespace */
.           ; /* ignore unrecognized characters */

%%

int yywrap(void) {
    return 1;
}
