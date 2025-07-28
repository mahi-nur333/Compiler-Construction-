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
%token <sval> ID STRING
%token COMMA
%token FOR INT MAIN INCLUDE PRINTF RETURN GE LE
%token ELSE EQ NEQ MOD AND OR DEC
%token LPREN RPREN LCB RCB
%token IF ASSIGN ADD SUB MUL DIV SEMI NOT_EQUAL

%left OR
%left AND
%left EQ NEQ GE LE '>' '<'
%left ADD SUB
%left MUL DIV MOD

%type <ival> expr
%type <ival> condition

%start program

%%

program: includes main    { /* empty action */ }
       | main
       ;

includes: INCLUDE
        ;

main: INT MAIN LPREN RPREN LCB stmts RCB
    ;

stmts: /* nothing */
     | stmts stmt
     ;

stmt: dec_stmt
    | ass_stmt
    | if_stmt
    | for_stmt
    | printf_stmt
    | return_stmt
    ;

dec_stmt: INT ID SEMI                    { /* handle declaration */ }
        | INT ID ASSIGN expr SEMI        { /* handle declaration with init */ }
        ;

ass_stmt: ID ASSIGN expr SEMI           { /* handle assignment */ }
        | ID DEC SEMI                   { /* handle decrement */ }
        ;

if_stmt: IF LPREN condition RPREN LCB stmts RCB           { /* handle if */ }
       | IF LPREN condition RPREN LCB stmts RCB ELSE LCB stmts RCB  { /* handle if-else */ }
       ;

for_stmt: FOR LPREN ass_stmt condition SEMI ID DEC RPREN LCB stmt RCB  { /* handle for loop */ }
        ;

printf_stmt: PRINTF LPREN STRING COMMA ID RPREN SEMI  { /* handle printf */ }
          ;

return_stmt: RETURN expr SEMI            { /* handle return */ }
           ;

condition: expr GE expr      { $$ = ($1 >= $3); }  /* This matches count >= 91 */
        | expr LE expr      { $$ = ($1 <= $3); }
        | expr '>' expr     { $$ = ($1 > $3); }
        | expr '<' expr     { $$ = ($1 < $3); }
        | expr EQ expr      { $$ = ($1 == $3); }
        | expr NEQ expr     { $$ = ($1 != $3); }
        | expr AND expr     { $$ = ($1 && $3); }
        | expr OR expr      { $$ = ($1 || $3); }
        | expr              { $$ = $1; }
        ;

expr: INT_NUM          { $$ = $1; }
    | FLOAT_NUM        { $$ = (int)$1; }
    | ID              { $$ = 0; }  /* simplified */
    | expr ADD expr   { $$ = $1 + $3; }
    | expr SUB expr   { $$ = $1 - $3; }
    | expr MUL expr   { $$ = $1 * $3; }
    | expr DIV expr   { $$ = $1 / $3; }
    | expr MOD expr   { $$ = $1 % $3; }
    | LPREN expr RPREN { $$ = $2; }
    ;

%%

void yyerror(char *s) {
    extern int yylineno;
    extern char* yytext;
    fprintf(stderr, "ERROR on line %d: %s at token '%s'\n", yylineno, s, yytext);
}

int main(void) {
    yyparse();
    printf("Parsing finished\n");
    fflush(stdout);
    return 0;
}