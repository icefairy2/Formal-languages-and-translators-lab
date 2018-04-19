%{
#include "y.tab.h"
%}

%%
"global" |
"GLOBAL" {return GLOBAL;}

"local" |
"LOCAL" {return LOCAL;}

"integer" |
"int" |
"INTEGER" {return INT;}

"real" |
"REAL" {return REAL;}

"," {return COMMA;}

[a-z] {yylval = yytext[0] - 'a';
            return NAME;}

[A-Z] {yylval = yytext[0] - 'A';
            return NAME;}

[ \t]+ ;
[\n] { return '\0'; }
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}