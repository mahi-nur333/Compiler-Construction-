%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

extern int line_no;  // Declare line_no from parser.y

#define DEBUG_TOKEN(t) //printf("TOKEN: %s, yytext='%s' at line %d\n", t, yytext, line_no);
%}

%%

"int"           { DEBUG_TOKEN("INT"); return INT; }
"char"          { DEBUG_TOKEN("CHAR"); return CHAR; }
"double"        { DEBUG_TOKEN("DOUBLE"); return DOUBLE; }
"while"         { DEBUG_TOKEN("WHILE"); return WHILE; }
"if"            { DEBUG_TOKEN("IF"); return IF; }
"else"          { DEBUG_TOKEN("ELSE"); return ELSE; }
"return"        { DEBUG_TOKEN("RETURN"); return RETURN; }
"main"          { DEBUG_TOKEN("MAIN"); return MAIN; }

[0-9]+\.[0-9]+  { yylval.float_val = atof(yytext); DEBUG_TOKEN("DOUBLE_NUM"); return DOUBLE_NUM; }
[0-9]+          { yylval.int_val = atoi(yytext); DEBUG_TOKEN("NUM"); return NUM; }
\'[^\']\'       { yylval.char_val = yytext[1]; DEBUG_TOKEN("CHAR_CONST"); return CHAR_CONST; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str_val = strdup(yytext); DEBUG_TOKEN("ID"); return ID; }

"("             { DEBUG_TOKEN("LPAREN"); return LPAREN; }
")"             { DEBUG_TOKEN("RPAREN"); return RPAREN; }
"{"             { DEBUG_TOKEN("LBRACE"); return LBRACE; }
"}"             { DEBUG_TOKEN("RBRACE"); return RBRACE; }
";"             { DEBUG_TOKEN("SEMICOLON"); return SEMICOLON; }
">"             { DEBUG_TOKEN("GT"); return GT; }
"<"             { DEBUG_TOKEN("LT"); return LT; }
"="             { DEBUG_TOKEN("ASSIGN"); return ASSIGN; }
"+"             { DEBUG_TOKEN("PLUS"); return PLUS; }

[ \t\r]+        ;  /* ignore whitespace */
\n              { line_no++; }

.               ;  /* ignore other chars */

%%

int yywrap() { return 1; }
