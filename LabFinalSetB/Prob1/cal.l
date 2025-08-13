%{
#include <stdio.h>
#include "cal.tab.h"
%}

%%
"#include"          { return INCLUDE; }
"<stdio.h>"         { return HEADER; }
"int"               { return INT; }
"char"              { return CHAR; }
"for"               { return FOR; }
"if"                { return IF; }
"else"              { return ELSE; }
"return"            { return RETURN; }
"printf"            { return PRINTF; }
"scanf"             { return SCANF; }
"factorial"         { return FACTORIAL; }
"main"              { return MAIN; }

[0-9]+              { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
\"([^\\\"]|\\.)*\"  { return STRING; }

"*="                { return IDENTIFIER; /* Treat as identifier for simplicity */ } 
"{"                 { return '{'; }
"}"                 { return '}'; }
"("                 { return '('; }
")"                 { return ')'; }
"["                 { return '['; }
"]"                 { return ']'; }
";"                 { return ';'; }
","                 { return ','; }
"="                 { return '='; }
"+"                 { return '+'; }
"-"                 { return '-'; }
"*"                 { return '*'; }
"/"                 { return '/'; }
"%"                 { return '%'; }
"<"                 { return '<'; }
">"                 { return '>'; }
"<="                { return LE; }
">="                { return GE; }
"=="                { return EQ; }
"!="                { return NE; }
"&&"                { return AND; }
"||"                { return OR; }
"!"                 { return '!'; }
"?"                 { return '?'; }
":"                 { return ':'; }
"++"                { return INC; }
"&"                 { return '&'; }

[ \t\n]+            ; /* Skip whitespace */
"//"[^\n]*          ; /* Skip comments */

.                   ; /* Ignore any other characters */
%%

int yywrap() {
    return 1;
}