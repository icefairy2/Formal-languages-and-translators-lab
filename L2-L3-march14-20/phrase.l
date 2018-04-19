%{
#include "y.tab.h"
%}

%%
"This" | 
"computer" | 
"I" { printf("Lex -SUBJ: %s\n", yytext);
      return SUBJ;}
"never" { printf("Lex -ADVB: %s", yytext);
          return ADVB;}
"The" | 
"a" { printf("Lex -ARTC: %s\n", yytext);
      return ARTC;}
"university" | 
"lies" |
"girl" |
"program" { printf("Lex -NOUN: %s\n", yytext);
            return NOUN;}
"is" | 
"run" | 
"am" | 
"tell" {  printf("Lex -VERB: %s\n", yytext);
          return VERB;}
[ \t]+ ;
[\n] { return '\0'; }
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}
