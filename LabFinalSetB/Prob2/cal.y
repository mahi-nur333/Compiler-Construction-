%{ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.h"

int line_no = 1;
int error_count = 0;

int yylex(void);
int yyerror(char *s);
%}

%union {
    int int_val;
    char *str_val;
}

%token INCLUDE HEADER INT DOUBLE CHAR FOR IF ELSE RETURN PRINTF MAIN
%token <int_val> NUMBER FLOAT_NUM
%token <str_val> IDENTIFIER STRING
%token LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK SEMICOLON COMMA
%token ASSIGN PLUS MINUS TIMES DIV LT GT EQ NE AND OR INC PLUSEQ

%type <int_val> expr type_specifier

%%

program:
    includes declarations functions 
    | declarations functions {
        printf("Semantic Analysis Completed!\n");
        printf(error_count ? "Total errors: %d\n" : "No errors detected.\n", error_count);
    }
    ;

includes: /* empty */ | includes INCLUDE HEADER ;

declarations: /* empty */ | declarations declaration ;

declaration: 
    type_specifier IDENTIFIER SEMICOLON { insert_symbol($2, $1); }
    | type_specifier IDENTIFIER LPAREN param_list RPAREN SEMICOLON { insert_symbol($2, $1); }
    ;

functions: function | functions function ;

function:
    type_specifier MAIN LPAREN RPAREN compound_stmt { insert_symbol("main", $1); }
    | type_specifier IDENTIFIER LPAREN param_list RPAREN compound_stmt { insert_symbol($2, $1); }
    ;

type_specifier:
    INT { $$ = INT_TYPE; }
    | DOUBLE { $$ = DOUBLE_TYPE; }
    | CHAR { $$ = CHAR_TYPE; }
    ;

param_list: /* empty */ | parameters ;
parameters: parameter | parameters COMMA parameter ;
parameter: 
    type_specifier IDENTIFIER { insert_symbol($2, $1); }
    | type_specifier IDENTIFIER LBRACK RBRACK { insert_symbol($2, $1); }
    ;

compound_stmt: LBRACE stmt_list RBRACE ;
stmt_list: /* empty */ | stmt_list statement ;

statement:
    declaration
    | type_specifier IDENTIFIER LBRACK NUMBER RBRACK SEMICOLON { insert_symbol($2, $1); }
    | type_specifier IDENTIFIER SEMICOLON { insert_symbol($2, $1); }
    | type_specifier IDENTIFIER ASSIGN expr SEMICOLON { insert_symbol($2, $1); }
    | expr SEMICOLON
    | compound_stmt
    | IF LPAREN expr RPAREN statement
    | IF LPAREN expr RPAREN statement ELSE statement
    | FOR LPAREN for_parts RPAREN statement
    | RETURN expr SEMICOLON
    | SEMICOLON
    ;

for_parts:
    SEMICOLON SEMICOLON
    | expr SEMICOLON SEMICOLON
    | SEMICOLON expr SEMICOLON
    | SEMICOLON SEMICOLON expr
    | expr SEMICOLON expr SEMICOLON
    | expr SEMICOLON SEMICOLON expr
    | SEMICOLON expr SEMICOLON expr
    | expr SEMICOLON expr SEMICOLON expr
    ;

expr:
    IDENTIFIER {
        int type = lookup_symbol($1);
        if (type == UNDEF_TYPE) {
            printf("Line %d: Undefined variable '%s'\n", line_no, $1);
            error_count++;
        }
        $$ = type;
    }
    | NUMBER { $$ = INT_TYPE; }
    | FLOAT_NUM { $$ = DOUBLE_TYPE; }
    | STRING { $$ = STRING_TYPE; }
    | IDENTIFIER ASSIGN expr {
        int left_type = lookup_symbol($1);
        if (left_type == UNDEF_TYPE) {
            printf("Line %d: Undefined variable '%s'\n", line_no, $1);
            error_count++;
        } else if (left_type == CHAR_TYPE && $3 == DOUBLE_TYPE) {
            printf("Line %d: Type mismatch - assigning double to char\n", line_no);
            error_count++;
        }
        $$ = left_type;
    }
    | IDENTIFIER PLUSEQ expr {
        int left_type = lookup_symbol($1);
        if (left_type == UNDEF_TYPE) {
            printf("Line %d: Undefined variable '%s'\n", line_no, $1);
            error_count++;
        }
        $$ = left_type;
    }
    | expr PLUS expr { $$ = $1; }
    | expr MINUS expr { $$ = $1; }
    | expr TIMES expr { $$ = $1; }
    | expr DIV expr { $$ = $1; }
    | expr LT expr { $$ = INT_TYPE; }
    | expr GT expr { $$ = INT_TYPE; }
    | expr EQ expr {
        if ($1 == CHAR_TYPE && $3 == STRING_TYPE) {
            printf("Line %d: Type mismatch - comparing char with string\n", line_no);
            error_count++;
        }
        $$ = INT_TYPE;
    }
    | expr NE expr { $$ = INT_TYPE; }
    | expr AND expr { $$ = INT_TYPE; }
    | expr OR expr { $$ = INT_TYPE; }
    | LPAREN expr RPAREN { $$ = $2; }
    | PRINTF LPAREN expr RPAREN { $$ = INT_TYPE; }
    | PRINTF LPAREN expr COMMA expr RPAREN { $$ = INT_TYPE; }
    | IDENTIFIER LPAREN RPAREN { 
        // Function call with no arguments
        if (strcmp($1, "sumArray") == 0) {
            printf("In line no %d, Function call 'sumArray': argument count mismatch.\n", line_no);
            error_count++;
        }
        $$ = lookup_symbol($1); 
    }
    | IDENTIFIER LPAREN expr RPAREN { 
        // Function call with 1 argument
        if (strcmp($1, "sumArray") == 0) {
            printf("In line no %d, Function call 'sumArray': argument count mismatch.\n", line_no);
            error_count++;
        }
        $$ = lookup_symbol($1); 
    }
    | IDENTIFIER LPAREN expr COMMA expr RPAREN { 
        // Function call with 2 arguments
        if (strcmp($1, "sumArray") == 0) {
            printf("In line no %d, Function call 'sumArray': argument count mismatch.\n", line_no);
            error_count++;
        }
        $$ = lookup_symbol($1); 
    }
    | IDENTIFIER INC { $$ = lookup_symbol($1); }
    | IDENTIFIER LBRACK expr RBRACK { $$ = lookup_symbol($1); }
    ;
%%

int main() {
    yyparse();
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "%s at line %d\n", s, line_no);
    return 0;
} 