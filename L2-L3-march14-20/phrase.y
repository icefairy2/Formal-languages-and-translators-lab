%start sentence
%token SUBJ NOUN ARTC ADVB VERB

%{
#include <stdio.h>
%}

%%
sentence : SUBJ verb_phrase object {printf("Sentence\n");}
            ;

verb_phrase : ADVB VERB {printf("Verb phrase: ADVB VERB\n"); }
            | VERB      {printf("Verb phrase: VERB\n"); }
            ;

object : ARTC NOUN  {printf("Object: ARTC NOUN\n"); }
        | NOUN      {printf("Object: NOUN\n"); }
        ;

%%
int yyerror(char* s){
    printf("%s\n", s);
}

int main(int argc, char* argv[]){
    yyparse();
    return 0;
}