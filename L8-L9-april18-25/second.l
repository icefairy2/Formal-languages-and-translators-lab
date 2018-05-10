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

[-+/*()={}<>;",] {return yytext[0];}

"<=" {return LE;}
">=" {return GE;}
"==" {return EQ;}
"!=" {return NE;}

"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"print" {return PRINT;}

"int" {return INTT;}
"float" |
"double" {return REAL;}
"bool" |
"boolean" {return BOOL;}
"char" {return CHAR;}
"char*" |
"string" {return STRING;}

"auto" {return AUTO;}
"extern" {return EXTERN;}
"static" {return STATIC;}
"register" {return REG;}

[a-zA-Z0-9]+ {return STR;} 

[ \t\n]+ ;
. { printf("Illegal character: %c\n", yytext[0]); }

%%
int yywrap(){
  return 1;
}