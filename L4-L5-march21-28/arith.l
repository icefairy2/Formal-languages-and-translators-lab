%{
#include "y.tab.h"
extern int yylval;
%}

%%
[0-9]+ { yylval = atoi(yytext);
         return INT;}

"/" {return DIV;}

"*" {return MUL;}

"-" {return MINUS;}

"+" {return PLUS;}

"^" {return POWER;}

"(" {return LPAR;}

")" {return RPAR;}

[ \t]+ ;
[\n] { return '\0'; }
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}