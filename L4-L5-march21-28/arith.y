%start program
%token INT MINUS PLUS MUL DIV LPAR RPAR POWER
%right POWER
%left PLUS MINUS
%left MUL DIV


%{
#include <stdio.h>
#include <math.h>
%}

%%
program : exp {printf("%d\n", $1); }
        ;

//Using yacc rules %left and %right
exp : INT {$$ = $1; }
    | exp MINUS exp { $$ = $1 - $3; }
    | exp DIV exp { $$ = $1 / $3; }
    | exp MUL exp { $$ = $1 * $3; }
    | exp PLUS exp { $$ = $1 + $3; }
   // | exp POWER exp { $$ = pow($1, $3); }
    | LPAR exp RPAR {$$ = $2; }
    ;

/* //Variant3 - associativity
exp : exp PLUS term { $$ = $1 + $3; }
    | exp MINUS term { $$ = $1 - $3; }
    | term
    ;

term : term MUL fact { $$ = $1 * $3; } 
     | term DIV fact { $$ = $1 / $3; }
     | fact
     ;

fact : expo POWER fact
     | expo
     ;

expo : INT {$$ = $1; }
     | LPAR exp RPAR {$$ = $2; }
     ;
*/

/* //Variant2 - precedence
exp : exp MINUS exp { $$ = $1 - $3; }
    | exp PLUS exp { $$ = $1 + $3; }
    | term
    ;

term : term MUL term { $$ = $1 * $3; }
     | term DIV term { $$ = $1 / $3; }
     | fact
     ;

fact : fact POWER fact 
     | expo

expo : INT {$$ = $1; } 
     | LPAR exp RPAR {$$ = $2; }
     ;
*/

/* //Variant1
exp : INT {$$ = $1; }
    | exp MINUS exp { $$ = $1 - $3; }
    | exp DIV exp { $$ = $1 / $3; }
    | exp MUL exp { $$ = $1 * $3; }
    | exp PLUS exp { $$ = $1 + $3; }
   // | exp POWER exp { $$ = pow($1, $3); }
    | LPAR exp RPAR {$$ = $2; }
    ;
*/

%%
int yyerror(char* s){
    printf("%s\n", s);
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
} 