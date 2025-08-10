%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INT_TYPE 1
#define UNDEF_TYPE -1

int line_no = 1;   /* global line counter */

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
    char *str_val;
}

%token INT WHILE RETURN MAIN
%token <int_val> NUM
%token <str_val> ID
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON GT PLUS

%type <int_val> expr

%%

program:
    INT MAIN LPAREN RPAREN LBRACE stmt_list RBRACE
;

stmt_list:
    stmt_list stmt
    | /* empty */
;

stmt:
    WHILE LPAREN expr RPAREN LBRACE stmt_list RBRACE
    | RETURN expr SEMICOLON
    | /* empty */
;

expr:
    expr GT expr {
        if ($1 != INT_TYPE || $3 != INT_TYPE) {
            printf("In line no %d, Data type UNDEF_TYPE is not matched with Data type INT_TYPE.\n", line_no);
        }
        $$ = INT_TYPE;
    }
    | ID {
        int id_type = lookup_symbol($1);
        if (id_type == UNDEF_TYPE) {
            printf("In line no %d, ID %s is not declared.\n", line_no, $1);
        }
        $$ = id_type;
    }
    | PLUS NUM {
        $$ = INT_TYPE;
    }
    | NUM {
        $$ = INT_TYPE;
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
    fprintf(stderr, "%s at line %d\n", s, line_no);
    return 0;
}
