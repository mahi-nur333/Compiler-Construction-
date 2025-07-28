%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char *s);
    int yylex(void);
%}

%union {
    int ival;
    char *sval;
}

%token <ival> INT_NUM
%token <sval> ID
%token WHILE IF ELSE
%token INT_TYPE
%token ASSIGN
%token GE LE EQ NE
%token LPAREN RPAREN
%token LBRACE RBRACE
%token SEMI
%token DEC    /* -- operator */
%token EOL

%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/'

%type <ival> expr
%type <ival> condition

%%

program: stmts    { /* empty action */ }
       ;

stmts: /* nothing */
     | stmts stmt
     ;

stmt: decl_stmt
    | while_stmt
    | expr_stmt
    ;

decl_stmt: INT_TYPE ID ASSIGN expr SEMI    { /* handle declaration */ }
         ;

while_stmt: WHILE LPAREN condition RPAREN LBRACE stmts RBRACE    { /* handle while */ }
          ;

expr_stmt: expr SEMI    { /* handle expression */ }
         | ID DEC SEMI  { /* handle decrement */ }
         ;

condition: expr GE expr    { /* handle condition */ }
        | expr LE expr    { /* handle condition */ }
        | expr EQ expr    { /* handle condition */ }
        | expr NE expr    { /* handle condition */ }
        | expr '>' expr   { /* handle condition */ }
        | expr '<' expr   { /* handle condition */ }
        ;

expr: INT_NUM          { $$ = $1; }
    | ID              { $$ = 0; }  /* simplified for demonstration */
    | expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { $$ = $1 / $3; }
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
