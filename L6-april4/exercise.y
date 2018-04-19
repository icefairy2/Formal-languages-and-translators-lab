
%{
#include <stdio.h>
int do_item1(int one);
int do_item2(char two);
%}

%union {int iVal; 
        double rVal; 
        char cVal;}
%token INT REAL ID
%type <iVal> item1 
%type <rVal> item3
%type <cVal> item2


%%
list: item1 {do_item1($1);} item2 {do_item2($<cVal>3);} item3 {printf("%d %c %lf\n", $1, $<cVal>3, $5);}
    ;
item1: INT {$$ = 1;}
     ;
item2: ID {$$ = $<cVal>1;}
     ;
item3: REAL {$$ = 3.14;}
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

int do_item1(int one){
    return 0;
}
int do_item2(char two){
    printf("do_item2(): %c\n", two);
    return 0;
}