%token COMMA INT

%{
#include <stdio.h>
%}

%%
seq: number {printf("rule1\n");}
   | seq COMMA number {printf("rule2\n");}
   ;

number: INT {printf("rule3\n");}
      ;

%%
int yyerror(char* s){
    printf("%s\n", s);
    return 1;
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
}