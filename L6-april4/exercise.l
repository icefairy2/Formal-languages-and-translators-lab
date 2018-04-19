%{
#include "y.tab.h"
%}

%%
"integer" |
"int" |
"INTEGER" {return INT;}

"real" |
"REAL" {return REAL;}

[a-zA-Z] {yylval.cVal = yytext[0];
            return ID;}



[ \t]+ ;
[\n] { return '\0'; }
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}