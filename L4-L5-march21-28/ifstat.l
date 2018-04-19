%{
#include "y.tab.h"
extern int yylval;
%}

%%
"if" {return IF;}
"else" {return ELSE;}
"true" |
"false" {return CBOOL;}
"(" {return LPAR;}
")" {return RPAR;}
";" {return SCOL;}
"=" {return ASGN;}
[a-zA-Z]+ {return ID;}
[0-9]+ {return NUMBER;}

[ \t]+ ;
[\n] { return '\0'; }
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}