%option noyywrap

%{
#include <stdio.h>
%}

/* Definitions */
digit       [0-9]
letter      [a-zA-Z]
under       [_]
ident       {letter}({letter}|{digit}|{under})*

/* Numeric constants */
exp_const   [-+]?[0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)?
float_const [0-9]+\.[0-9]+([eE][-+]?[0-9]+)?
int_const   [0-9]+

char_lit    \'(\\.|[^\\'])\'
string_lit  \"(\\.|[^\\"])*\"
ws          [ \t\r\n]+

%%


"#include"   { printf("%s -> PREPROCESSOR (include)\n", yytext); }
"<stdio.h>"  { printf("%s -> HEADER\n", yytext); }
"#"          { printf("%s -> PREPROCESSOR SYMBOL\n", yytext); }


"int"           { printf("%s -> KEYWORD (int)\n", yytext); }
"float"         { printf("%s -> KEYWORD (float)\n", yytext); }
"double"        { printf("%s -> KEYWORD (double)\n", yytext); }
"char"          { printf("%s -> KEYWORD (char)\n", yytext); }
"void"          { printf("%s -> KEYWORD (void)\n", yytext); }
"return"        { printf("%s -> KEYWORD (return)\n", yytext); }
"for"           { printf("%s -> LOOP (for)\n", yytext); }
"while"         { printf("%s -> LOOP (while)\n", yytext); }
"if"            { printf("%s -> CONDITIONAL (if)\n", yytext); }
"else"          { printf("%s -> CONDITIONAL (else)\n", yytext); }


"scanf"         { printf("%s -> FUNCTION (scanf)\n", yytext); }
"printf"        { printf("%s -> FUNCTION (printf)\n", yytext); }


"="             { printf("%s -> OPERATOR (assignment)\n", yytext); }
"=="            { printf("%s -> OPERATOR (equal)\n", yytext); }
"!="            { printf("%s -> OPERATOR (not equal)\n", yytext); }
"<="            { printf("%s -> OPERATOR (less or equal)\n", yytext); }
">="            { printf("%s -> OPERATOR (greater or equal)\n", yytext); }
"<"             { printf("%s -> OPERATOR (less than)\n", yytext); }
">"             { printf("%s -> OPERATOR (greater than)\n", yytext); }

"++"            { printf("%s -> OPERATOR (increment)\n", yytext); }
"--"            { printf("%s -> OPERATOR (decrement)\n", yytext); }
"+"             { printf("%s -> OPERATOR (plus)\n", yytext); }
"-"             { printf("%s -> OPERATOR (minus)\n", yytext); }
"*"             { printf("%s -> OPERATOR (multiplication)\n", yytext); }
"/"             { printf("%s -> OPERATOR (division)\n", yytext); }

"&&"            { printf("%s -> LOGICAL AND\n", yytext); }
"||"            { printf("%s -> LOGICAL OR\n", yytext); }
"!"             { printf("%s -> LOGICAL NOT\n", yytext); }


"("             { printf("%s -> PAREN (open)\n", yytext); }
")"             { printf("%s -> PAREN (close)\n", yytext); }
"{"             { printf("%s -> BRACE (open)\n", yytext); }
"}"             { printf("%s -> BRACE (close)\n", yytext); }
";"             { printf("%s -> SEMICOLON\n", yytext); }
","             { printf("%s -> COMMA\n", yytext); }


{string_lit}    { printf("%s -> STRING LITERAL\n", yytext); }
{char_lit}      { printf("%s -> CHAR LITERAL\n", yytext); }

{float_const}   { printf("%s -> FLOAT CONSTANT\n", yytext); }
{int_const}     { printf("%s -> INTEGER CONSTANT\n", yytext); }
{exp_const}     { printf("%s -> FLOAT/EXP CONSTANT\n", yytext); }

{ident}         { printf("%s -> IDENTIFIER\n", yytext); }

{ws}            { /* skip whitespace */ }
.               { printf("%s -> UNKNOWN\n", yytext); }

%%

int main() {
    yylex();
    return 0;
}
