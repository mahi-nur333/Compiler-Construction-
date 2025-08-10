%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INT_TYPE 1
#define CHAR_TYPE 2
#define DOUBLE_TYPE 3
#define UNDEF_TYPE -1

int line_no = 1;  // Define line_no here ONLY

struct symbol {
    char *name;
    int type;
} symtab[100];

int sym_count = 0;

void insert_symbol(char *name, int type);
int lookup_symbol(char *name);

int yylex(void);
int yyerror(char *s);
%}

%union {
    int int_val;
    double float_val;
    char char_val;
    char *str_val;
}

%token INT CHAR DOUBLE WHILE IF ELSE RETURN MAIN
%token <int_val> NUM
%token <float_val> DOUBLE_NUM
%token <char_val> CHAR_CONST
%token <str_val> ID
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON GT LT PLUS ASSIGN

%type <int_val> expr type_spec

%%

program:
    INT MAIN LPAREN RPAREN compound_stmt
;

compound_stmt:
    LBRACE decl_list stmt_list RBRACE
;

decl_list:
    decl_list decl
    | /* empty */
;

decl:
    type_spec ID SEMICOLON {
        if (lookup_symbol($2) != UNDEF_TYPE) {
            printf("In line no %d, Same variable %s is declared more than once.\n", line_no, $2);
        } else {
            insert_symbol($2, $1);
            printf("In line no %d, Inserting %s with type %d in symbol table.\n", line_no, $2, $1);
        }
    }
;

type_spec:
    INT     { $$ = INT_TYPE; }
    | CHAR  { $$ = CHAR_TYPE; }
    | DOUBLE{ $$ = DOUBLE_TYPE; }
;

stmt_list:
    stmt_list stmt
    | /* empty */
;

stmt:
    assign_stmt
    | if_stmt
    | while_stmt
    | RETURN expr SEMICOLON
    | compound_stmt
;

assign_stmt:
    ID ASSIGN expr SEMICOLON {
        int id_type = lookup_symbol($1);
        if (id_type == UNDEF_TYPE) {
            printf("In line no %d, ID %s is not declared.\n", line_no, $1);
        } else if (id_type != $3) {
            printf("In line no %d, Data type %d is not matched with Data type %d.\n", line_no, id_type, $3);
        }
    }
;

if_stmt:
    IF LPAREN expr RPAREN stmt else_part
;

else_part:
    ELSE stmt
    | /* empty */
;

while_stmt:
    WHILE LPAREN expr RPAREN stmt
;

expr:
    expr GT expr {
        if ($1 != $3) {
            printf("In line no %d, Data type %d is not matched with Data type %d.\n", line_no, $1, $3);
        }
        $$ = INT_TYPE; /* comparison result */
    }
    | expr LT expr {
        if ($1 != $3) {
            printf("In line no %d, Data type %d is not matched with Data type %d.\n", line_no, $1, $3);
        }
        $$ = INT_TYPE;
    }
    | NUM           { $$ = INT_TYPE; }
    | DOUBLE_NUM    { $$ = DOUBLE_TYPE; }
    | CHAR_CONST    { $$ = CHAR_TYPE; }
    | ID {
        int id_type = lookup_symbol($1);
        if (id_type == UNDEF_TYPE) {
            printf("In line no %d, ID %s is not declared.\n", line_no, $1);
        }
        $$ = id_type;
    }
;

%%

void insert_symbol(char *name, int type) {
    symtab[sym_count].name = strdup(name);
    symtab[sym_count].type = type;
    sym_count++;
}

int lookup_symbol(char *name) {
    for (int i = 0; i < sym_count; i++) {
        if (strcmp(symtab[i].name, name) == 0) {
            return symtab[i].type;
        }
    }
    return UNDEF_TYPE;
}

int main() {
    yyparse();
    printf("Parsing finished!\n");
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "syntax error at line %d\n", line_no);
    return 0;
}
