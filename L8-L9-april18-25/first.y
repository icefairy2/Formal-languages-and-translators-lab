%start prog

%token INT VAR LE GE EQ NE IF ELSE WHILE PRINT
%token '-' '+' '*' '/' '(' ')' '=' '{' '}' '<' '>' ';' 
%nonassoc IFX
%nonassoc ELSE

%left GE LE EQ NE '>' '<'
%left '-' '+' 
%left '*' '/'


%{
#include <stdio.h>
#include "first.h"
int yydebug = 0;
%}

%%
prog : prog stmt                        {printtree($2, 0); freeall($2); }     //{execute($2); freeall($2); }     
     | prog error ';'                   {yyerrok; }
     | /*EMPTY*/ 
     ;
        
stmt : sstmt ';' { $$ = $1; }               //symbol_statement
     | WHILE '(' expr ')' stmt          { $$ =  node(WHILE, $3, $5); }
     | IF '(' expr ')' stmt %prec IFX   { $$ =  triple(IF, $3, $5, NULL); }
     | IF '(' expr ')' stmt ELSE stmt   { $$ =  triple(IF, $3, $5, $7); }
     | '{' stmtlist '}' { $$ = $2; }
     ;

stmtlist : stmt                         { $$ = $1; }
         | stmt stmtlist                { $$ =  node(';', $1, $2); }
         ;

sstmt : expr                            { $$ = $1; }
      | PRINT expr                      { $$ = node(PRINT, $2, NULL); }
      | VAR '=' expr                    { $$ = node('=', leaf(VAR, $1), $3); }
      ;

expr : INT                              { $$ = leaf(INT, $1); }
    | VAR                               { $$ = leaf(VAR, $1); }
    | expr '-' expr                     { $$ = node('-', $1, $3); }
    | expr '/' expr                     { $$ = node('/', $1, $3); }
    | expr '*' expr                     { $$ = node('*', $1, $3); }
    | expr '+' expr                     { $$ = node('+', $1, $3); }
    | expr '<' expr                     { $$ = node('<', $1, $3); }
    | expr '>' expr                     { $$ = node('>', $1, $3); }
    | expr LE expr                      { $$ = node(LE, $1, $3); }
    | expr GE expr                      { $$ = node(GE, $1, $3); }
    | expr EQ expr                      { $$ = node(EQ, $1, $3); }
    | expr NE expr                      { $$ = node(NE, $1, $3); }
    | '(' expr ')'                      {$$ = $2; }
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