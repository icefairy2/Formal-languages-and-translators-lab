%start prg
%token HI BYE

%{
#include <stdio.h>
%}

%%
prg : HI {printf("Hello world\n");} 
    | BYE {printf("Bye world\n");}

%%
int yyerror(char* s){
    printf("%s\n", s);
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
}