#ifndef SYMTAB_H
#define SYMTAB_H

#define INT_TYPE 1
#define DOUBLE_TYPE 2
#define CHAR_TYPE 3
#define STRING_TYPE 4
#define UNDEF_TYPE -1

struct symbol {
    char *name;
    int type;
};

extern struct symbol symtab[100];
extern int sym_count;

void insert_symbol(char *name, int type);
int lookup_symbol(char *name);
void print_symbol_table();

#endif
