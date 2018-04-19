%token INT ID

%{
#include <stdio.h>
%}

%%
prog: stmt
    ;

stmt: INT
    | ID
    ;

%%
void yyerror(char* msg){
    printf("%d: %s: \n %s\n", lineno, msg, linebuf_ptr);
    printf("%*s \n", 1+tokenpos, "^");
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
} 
