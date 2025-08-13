%{
#include <stdio.h>
#include <string.h>
#include "cal.tab.h"

// Define the same constants as in cal.y
#define INT_TYPE 1
#define DOUBLE_TYPE 2
#define CHAR_TYPE 3
#define STRING_TYPE 4
#define UNDEF_TYPE -1

extern int line_no;
%}

%%
"#include"          { return INCLUDE; }
"<stdio.h>"         { return HEADER; }
"int"               { return INT; }
"double"            { return DOUBLE; }
"char"              { return CHAR; }
"for"               { return FOR; }
"if"                { return IF; }
"else"              { return ELSE; }
"return"            { return RETURN; }
"printf"            { return PRINTF; }
"main"              { return MAIN; }

[0-9]+              { yylval.int_val = atoi(yytext); return NUMBER; }
[0-9]+\.[0-9]+      { yylval.int_val = atoi(yytext); return FLOAT_NUM; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str_val = strdup(yytext); return IDENTIFIER; }
\"([^\\\"]|\\.)*\"  { yylval.str_val = strdup(yytext); return STRING; }

"("                 { return LPAREN; }
")"                 { return RPAREN; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }
"["                 { return LBRACK; }
"]"                 { return RBRACK; }
";"                 { return SEMICOLON; }
","                 { return COMMA; }
"="                 { return ASSIGN; }
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return TIMES; }
"/"                 { return DIV; }
"<"                 { return LT; }
">"                 { return GT; }
"=="                { return EQ; }
"!="                { return NE; }
"&&"                { return AND; }
"||"                { return OR; }
"++"                { return INC; }
"+="                { return PLUSEQ; }

[ \t]+              ; /* Skip whitespace */
\n                  { line_no++; }
"//"[^\n]*          ; /* Skip comments */

.                   ; /* Ignore any other characters */
%%

int yywrap() {
    return 1;
}