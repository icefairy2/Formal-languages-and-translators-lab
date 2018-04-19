%{
#include "y.tab.h"
%}

%%
"hi" |
"ola" |
"salut" { return HI;}
"bye" |
"ciao" |
"pa" { return BYE;}
%%
int yywrap(){
  return 1;
}
