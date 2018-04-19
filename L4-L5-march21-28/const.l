%{
#include "y.tab.h"
%}

D [0-9]
E [DEde][-+]?{D}+
%%
{D}+			{yylval.ival = atoi(yytext);
                 return INT;}
{D}+"."{D}*({E})?	|
{D}*"."{D}+({E})?	|
{D}+{E}			{yylval.rval = atof(yytext);
                 return REAL;}

[ \t]+ ;
[\n] { return '\0'; }
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}