
%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "llisp.h"
%}
%union {int iVal; struct _cons* list;}
%token <iVal> INT
%token CONS APPEND CAR CDR 
%type <iVal> int_expr i_cmd
%type <list> list_expr l_cmd int_list

%%
prog: prog list_expr '\n' {eval($2); free($2);}
     | prog int_expr '\n' {printf("%d\n", $2);}
     |prog '\n'
     | /* EMPTY*/

list_expr: '(' l_cmd ')' {$$=$2;}
         | '\'' '(' int_list ')' {$$=$3;}
         ;

l_cmd: CONS int_expr list_expr {$$=cons($2, $3);}
      | APPEND list_expr list_expr {$$=append($2, $3);}
      | CDR list_expr{$$=cdr($2);}
      ;

int_expr: '(' i_cmd ')' {$$=$2;}
        | INT
        ;
 
i_cmd: CAR list_expr {$$ = car($2);}
     | '+' int_expr int_expr {$$ = $2 + $3;}
     ;

int_list: INT {$$ = cons($1, NNULL);}
        | INT int_list {$$ = cons($1, $2);}
        ;
%%
void yyerror(char* s){
    printf("%s\n", s);
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
} 