%{
#include "y.tab.h"
extern int yylval;
%}

%%
[a-z] {yylval = yytext[0] - 'a';
       return VAR;}

[A-Z] {yylval = yytext[0] - 'A';
       return VAR;}

[0-9]+ { yylval = atoi(yytext);
         return INT;}

[-+/*()={}<>;] {return yytext[0];}

"<=" {return LE;}
">=" {return GE;}
"==" {return EQ;}
"!=" {return NE;}

[ \t\n]+ ;
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}