%{
#include <stdlib.h>
#include "y.tab.h"
%}

%%

"CONS" {return CONS;}
[()'+\n] {return yytext[0];}
"APPEND" {return APPEND;}
"CAR" {return CAR;}
"CDR" {return CDR;}

[0-9]+          {
                   yylval.iVal = atoi(yytext);
                   return INT;
                }


[ \t]+        ;      // Skip whitespaces.

.               yyerror("Unknown character.\n");

%%

int yywrap(void)
{
    return 1;
}