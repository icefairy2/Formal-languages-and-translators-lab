%{
#include "y.tab.h"
%}

%%
"ding" {return DING;}

"dong" {return DONG;}

"dell" {return DELL;}

[ \t]+ ;
[\n] { return '\0'; }
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}