%start program
%token IF ELSE CBOOL ID LPAR RPAR SCOL ASGN NUMBER
%nonassoc IFX
%nonassoc ELSE


%{
#include <stdio.h>
%}

%%
program : stmt {printf("%s\n", $1); }
        ;

//first has greater precedence than second
stmt : IF LPAR CBOOL RPAR stmt %prec IFX
     | IF LPAR CBOOL RPAR stmt ELSE stmt
     | ID ASGN exp SCOL
     ;

exp : NUMBER
    | ID;

%%
int yyerror(char* s){
    printf("%s\n", s);
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
} 