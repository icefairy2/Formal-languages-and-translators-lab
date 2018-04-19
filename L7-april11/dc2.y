%start prog
%token INT VAR '-' '+' '*' '/' '(' ')' '='
%left '-' '+'
%left '*' '/'


%{
#include <stdio.h>
static int sym_table[26];
int yydebug = 0;
%}

%%
prog : prog stmt '\n' {printf("Result is %d\n", $2); }
        | prog error '\n' {yyerrok; }
        | /*EMPTY*/
        ;
        
stmt : exp {$$ = $1; }
     | VAR '=' exp {$$ = $3; sym_table[$1] = $3; }

exp : INT {$$ = $1; }
    | VAR {$$ = $1; }
    | exp '-' exp { $$ = $1 - $3; }
    | exp '/' exp { $$ = $1 / $3; }
    | exp '*' exp { $$ = $1 * $3; }
    | exp '+' exp { $$ = $1 + $3; }
    | '(' exp ')' {$$ = $2; }
    ;

%%
void yyerror(char* s){
    printf("%s\n", s);
}

int main(int argc, char* argv[]){
    yydebug = 1;
    yyparse();
    return 0;
} 