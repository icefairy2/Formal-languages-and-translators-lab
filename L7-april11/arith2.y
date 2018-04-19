%start program
%token INT '-' '+' '*' '/'
%left '-' '+'
%left '*' '/'


%{
#include <stdio.h>
#include <math.h>
%}

%%
program : program exp '\n' {printf("Result: %d\n", $2); }
        | /*EMPTY*/
        ;

exp : INT {$$ = $1; }
    | exp '-' exp { $$ = $1 - $3; }
    | exp '/' exp { $$ = $1 / $3; }
    | exp '*' exp { $$ = $1 * $3; }
    | exp '+' exp { $$ = $1 + $3; }
    ;

%%
int yyerror(char* s){
    printf("%s\n", s);
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
} 