%start rhyme
%token DING DONG DELL

%{
#include <stdio.h>
%}

%%
rhyme : sound place {printf("Rhyme\n");}
        ;

sound : DING DONG {printf("Sound\n");}
        ;

place : DELL {printf("Place\n");}
        ;

%%
int yyerror(char* s){
    printf("%s\n", s);
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
}