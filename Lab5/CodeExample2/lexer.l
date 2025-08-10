%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>

extern int line_no;  /* defined in parser.y */
%}

%%

"int"               { return INT; }
"while"             { return WHILE; }
"return"            { return RETURN; }
"main"              { return MAIN; }

[0-9]+              { yylval.int_val = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str_val = strdup(yytext); return ID; }

"("                 { return LPAREN; }
")"                 { return RPAREN; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }
";"                 { return SEMICOLON; }
">"                 { return GT; }
"+"                 { return PLUS; }

[ \t\r]+            ;    /* skip whitespace */
\n                  { line_no++; }

.                   { /* ignore unknown char */ }

%%

int yywrap() { return 1; }
