%option noyywrap

%{

%}

letter [a-zA-Z]
digit [0-9]
delim [ \t]
under [_]
num {digit}{digit}*
float_num {num}*[.]{num}
ident       {letter}({letter}|{digit})*
int_const   {digit}+
ws          [ \t\r\n]+
string_lit  \"(\\.|[^\\"])*\"

%%
"int"       { printf("%s -> KEYWORD (int)\n", yytext); }
"void"      { printf("%s -> KEYWORD (void)\n", yytext); }
"for"       { printf("%s -> LOOP (for)\n", yytext); }
"return"    { printf("%s -> KEYWORD (return)\n", yytext); }
"include"   { printf("%s -> PREPROCESSOR (include)\n", yytext); }
<stdio\.h>  { printf("%s -> HEADER\n", yytext); }

"="         { printf("%s -> OPERATOR (assignment)\n", yytext); }
"<="        { printf("%s -> OPERATOR (less or equal)\n", yytext); }
"++"        { printf("%s -> OPERATOR (increment)\n", yytext); }
"+"         { printf("%s -> OPERATOR (plus)\n", yytext); }
"*"         { printf("%s -> OPERATOR (multiplication)\n", yytext); }

"("         { printf("%s -> PAREN (open)\n", yytext); }
")"         { printf("%s -> PAREN (close)\n", yytext); }
"{"         { printf("%s -> BRACE (open)\n", yytext); }
"}"         { printf("%s -> BRACE (close)\n", yytext); }
";"         { printf("%s -> SEMICOLON\n", yytext); }

{string_lit}    { printf("%s -> STRING\n", yytext); }
{int_const}     { printf("%s -> INTEGER CONSTANT\n", yytext); }
{ident}         { printf("%s -> IDENTIFIER\n", yytext); }
{ws}            { /* skip */ }
.               { printf("%s -> UNKNOWN\n", yytext); }

%%

int main()
{
  yylex();
  return 0;
}
