%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char *s);
    int yylex(void);
%}

%union {
    int ival;
    float fval;
    char *sval;
}

%token <ival> INT_NUM
%token <fval> FLOAT_NUM
%token <sval> ID
%token ADD SUB MUL DIV
%token LPAREN RPAREN
%token EOL

%left ADD SUB
%left MUL DIV

%type <ival> expr
%type <ival> calclist

%%

calclist: /* nothing */    { $$ = 0; }
        | calclist expr EOL { $$ = $2; }
        ;

expr: INT_NUM           { $$ = $1; }
    | expr ADD expr     { $$ = $1 + $3; }
    | expr SUB expr     { $$ = $1 - $3; }
    | expr MUL expr     { $$ = $1 * $3; }
    | expr DIV expr     { $$ = $1 / $3; }
    | LPAREN expr RPAREN { $$ = $2; }
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
