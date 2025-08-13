#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.h"

struct symbol symtab[100];
int sym_count = 0;

void insert_symbol(char *name, int type) {
    // Check if symbol already exists
    for (int i = 0; i < sym_count; i++) {
        if (strcmp(symtab[i].name, name) == 0) {
            // Symbol already exists, update type if needed
            symtab[i].type = type;
            return;
        }
    }
    
    // Add new symbol
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

void print_symbol_table() {
    printf("\n--- Symbol Table ---\n");
    printf("Name\t\tType\n");
    printf("----\t\t----\n");
    
    for (int i = 0; i < sym_count; i++) {
        printf("%-15s", symtab[i].name);
        switch(symtab[i].type) {
            case INT_TYPE: printf("int\n"); break;
            case DOUBLE_TYPE: printf("double\n"); break;
            case CHAR_TYPE: printf("char\n"); break;
            case STRING_TYPE: printf("string\n"); break;
            default: printf("unknown\n"); break;
        }
    }
    printf("-------------------\n");
}
