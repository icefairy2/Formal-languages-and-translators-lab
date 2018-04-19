%token GLOBAL LOCAL INT REAL NAME COMMA

%{
#include <stdio.h>
int yydebug = 0;
%}

%%
decl: class type namelist
    ;
class: GLOBAL {$$ = 1;}
     | LOCAL {$$ = 2;}
     ;
type: INT {$$ = 1;}
     | REAL {$$ = 2;}
     ;
namelist: /*NAME*/ {printf("Namelist(0)\n");} //{mksymbol($-1, $0, $1);}
        | namelist NAME {printf("Namelist(2)\n"); mksymbol($-1, $0, $2);}
        | namelist COMMA NAME {printf("Namelist(3)\n"); mksymbol($-1, $0, $3);}
        ;

%%
int yyerror(char* s){
    printf("%s\n", s);
    return 1;
}

int main(int argc, char* argv[]){
    yydebug = 1;
    yyparse();
    return 0;
} 

int mksymbol(int arg1, int arg2, int arg3){
    printf("Result: ");
    if (arg1 == 1){
        printf("GLOBAL ");
    }
    else {
        printf("LOCAL ");
    }

    if (arg2 == 1){
        printf("INT ");
    }
    else {
        printf("REAL ");
    }

    printf("%c\n", arg3 + 'a');
}