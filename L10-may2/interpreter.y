%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "types.h"
#define YYDEBUG 0
/* prototypes */
nodeType *opr(int oper, int nops, ...);
nodeType *id(int i);
nodeType *con(int value);
void freeNode(nodeType *p);
void yyerror(char *s);

int sym[26]; /* symbol table */

FILE* yyin;
FILE* yyout;

%}

%union {
  int iValue;      /* integer value */
  char sIndex;     /* symbol table index */
  nodeType *nPtr;  /* node pointer */
};

%token <iValue> INTEGER 
%token <sIndex> VARIABLE
%token WHILE IF PRINT DO
%nonassoc IFX
%nonassoc ELSE

%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%type <nPtr> statement expr stmt_list

%start      program

%%

program   : function '.'          { exit(0); }
          ;

function  : function statement    { ex($2); freeNode($2); }
          | /* NULL */
          ;
 
statement : ';'                   { $$ = opr(';', 2, NULL, NULL); }
          | expr ';'              { $$ = $1; }
          | PRINT expr ';'        { $$ = opr(PRINT, 1, $2); }
          | VARIABLE '=' expr ';' { $$ = opr('=', 2, id($1), $3); }
          | WHILE '(' expr ')' statement
                 { $$ = opr(WHILE, 2, $3, $5); }
          | DO statement WHILE '(' expr ')'
                 { $$ = opr(DO, 2, $2, $5); }
          | IF '(' expr ')' statement %prec IFX
                 { $$ = opr(IF, 2, $3, $5); }
          | IF '(' expr ')' statement ELSE statement
                 { $$ = opr(IF, 3, $3, $5, $7); }
          | '{' stmt_list '}' { $$ = $2; }
          ;

stmt_list : statement
          | stmt_list statement   { $$ = opr(';', 2, $1, $2); }
          ;

expr      : INTEGER               { $$ = con($1); }
          | VARIABLE              { $$ = id($1); }
          | '-' expr %prec UMINUS { $$ = opr(UMINUS, 1, $2); }
          | expr '+' expr         { $$ = opr('+', 2, $1, $3); }
          | expr '-' expr         { $$ = opr('-', 2, $1, $3); }
          | expr '*' expr         { $$ = opr('*', 2, $1, $3); }
          | expr '/' expr         { $$ = opr('/', 2, $1, $3); }
          | expr '<' expr         { $$ = opr('<', 2, $1, $3); }
          | expr '>' expr         { $$ = opr('>', 2, $1, $3); }
          | expr GE expr          { $$ = opr(GE, 2, $1, $3); }
          | expr LE expr          { $$ = opr(LE, 2, $1, $3); }
          | expr NE expr          { $$ = opr(NE, 2, $1, $3); }
          | expr EQ expr          { $$ = opr(EQ, 2, $1, $3); }
          | '(' expr ')'          { $$ = $2; }
          ;

%%

nodeType *con(int value) 
{ 
  nodeType *p; 
  
  /* allocate node */ 
  if ((p = malloc(sizeof(conNodeType))) == NULL) 
    yyerror("out of memory"); 
  /* copy information */ 
  p->type = typeCon; 
  p->con.value = value; 
  return p; 
} 

nodeType *id(int i) 
{ 
  nodeType *p; 
  /* allocate node */ 
  if ((p = malloc(sizeof(idNodeType))) == NULL) 
    yyerror("out of memory"); 
  /* copy information */ 
  p->type = typeId; 
  p->id.i = i; 
  return p; 
} 

nodeType *opr(int oper, int nops, ...) 
{ 
  va_list ap; 
  nodeType *p; 
  size_t size; 
  int i; 

  /* allocate node */ 
  size = sizeof(oprNodeType) + (nops - 1) * sizeof(nodeType*); 
  if ((p = malloc(size)) == NULL) 
    yyerror("out of memory"); 
  /* copy information */
  p->type = typeOpr; 
  p->opr.oper = oper; 
  p->opr.nops = nops; 
  va_start(ap, nops); 
  for (i = 0; i < nops; i++) 
    p->opr.op[i] = va_arg(ap, nodeType*); 
  va_end(ap); 
  
  return p; 
}

void freeNode(nodeType *p) 
{ 
  int i; 

  if (!p) 
    return; 
  if (p->type == typeOpr) { 
    for (i = 0; i < p->opr.nops; i++) 
      freeNode(p->opr.op[i]); 
  } 
  free (p); 
} 

void yyerror(char *s) 
{ 
  fprintf(yyout, "%s\n", s); 
} 

int main(int argc, char* argv[]) 
{
#if YYDEBUG
  yydebug = 1;
#endif

  if (argc != 2){
    yyerror("Not enough arguments!\n");
    return 1; 
  }

  yyin = fopen(argv[1], "r");

  if (yyin == NULL){
     yyerror("Opening input failure!\n");
    return 2;
  }

  yyout = fopen("output", "w");

  if (yyout == NULL){
    yyerror("Opening output failure!\n");
    return 2;
  }

  yyparse();
  
  if(!fclose(yyin)){
    yyerror("Closing input failure!\n");
    return 3;
  }
  
  if(!fclose(yyout)){
    yyerror("Closing output failure!\n");
    return 4;
  }

  return 0; 
}
