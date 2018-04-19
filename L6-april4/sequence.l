%{
#include "y.tab.h"
%}

%%
"," {return COMMA;}
[0-9] {return INT;}

[ \t]+ ;
[\n] { return '\0'; }
. { printf("Illegal character: %c\n", yytext[0]); }


%%
int yywrap(){
  return 1;
}