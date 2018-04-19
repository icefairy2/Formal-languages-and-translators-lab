%union {
    int ival; 
    double rval;
}

%token <ival> INT 
%token <rval> REAL

%type <ival> int_const
%type <rval> real_const

%{
#include <stdio.h>
%}

%%
start : int_const  {printf("int: %d\n", $1);}
      | real_const {printf("float: %f\n", $1);}
      ;

int_const : INT     {$<ival>$ = $<ival>1;}
          ;

real_const : REAL   {$<rval>$ = $<rval>1;}
           ;

%%
int yyerror(char* s){
    printf("%s\n", s);
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
} 