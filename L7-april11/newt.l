%{
#include "y.tab.h"
int lineno = 0;
int tokenpos = 0;
char* linebuf_ptr = linebuf;
%}

%%
\n.* {tokenpos = 0;
      strcpy(linebuf, yytext +1);
      lineno++;
      yyless(1); }

[a-zA-Z] {yylval = yytext;
            return ID;}

[0-9]+ { yylval = atoi(yytext);
tokenpos += yyleng;
         return INT;}


[ \t]+ ;
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}