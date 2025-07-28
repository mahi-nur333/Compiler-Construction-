%{
#include "cal.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+      { yylval.ival = atoi(yytext); return INT_NUM; }
"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MUL; }
"/"         { return DIV; }
"("         { return LPAREN; }
")"         { return RPAREN; }
\n          { return EOL; }
[ \t]       ; /* skip whitespace */
.           ; /* ignore unrecognized characters */

%%

int yywrap(void) {
    return 1;
}
