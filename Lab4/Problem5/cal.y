%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern FILE* yyin;
    void yyerror(char *s);
    int yylex(void);
    int yywrap(void) { return 1; }
%}

%union {
    int ival;
    char *sval;
}

%token <ival> INT_NUM
%token <sval> ID
%token SWITCH CASE DEFAULT BREAK
%token COLON SEMI
%token INT_TYPE
%token ASSIGN
%token LPREN RPREN LCB RCB
%token IF ELSE

%left ADD SUB
%left MUL DIV MOD
%left EQUAL NOT_EQUAL GREATER

%type <ival> expr condition

%start program

%%

program: stmts    { /* empty action */ }
       ;

stmts: /* nothing */
     | stmts stmt
     ;

stmt: dec_stmt
    | ass_stmt
    | switch_stmt
    ;

dec_stmt: INT_TYPE ID ASSIGN expr SEMI    { /* handle declaration */ }
        ;

ass_stmt: ID ASSIGN expr SEMI    { /* handle assignment */ }
        ;

switch_stmt: SWITCH LPREN condition RPREN LCB case_list RCB    { /* handle switch */ }
          ;

case_list: case_stmt
         | case_list case_stmt
         ;

case_stmt: CASE INT_NUM COLON stmts BREAK SEMI    { /* handle case */ }
         | DEFAULT COLON stmts                     { /* handle default */ }
         ;

condition: expr    { $$ = $1; }
         ;

expr: INT_NUM             { $$ = $1; }
    | ID                  { $$ = 0; }  /* simplified */
    | expr ADD expr       { $$ = $1 + $3; }
    | expr SUB expr       { $$ = $1 - $3; }
    | expr MUL expr       { $$ = $1 * $3; }
    | expr DIV expr       { $$ = $1 / $3; }
    | expr MOD expr       { $$ = $1 % $3; }
    | LPREN expr RPREN    { $$ = $2; }
    ;

%%

void yyerror(char *s) {
    /* suppress error messages */
}

int main(void) {
    yyparse();
    printf("Parsing finished\n");
    fflush(stdout);
    return 0;
}