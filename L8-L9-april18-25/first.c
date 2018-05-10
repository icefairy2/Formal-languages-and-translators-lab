#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
#include "first.h"

static int sym_table_int[26];

struct nnode* nalloc(){
    struct nnode* np = (struct nnode*) malloc(sizeof(struct nnode));
    if (np == NULL){
        yyerror("Out of Memory");
    }
    return np;
}

struct nnode* leaf(int type, int val){
    struct nnode* np = nalloc();
    np->oper = type;
    np->left.value = val;
    np->left.np = NULL;
    np->right.np = NULL;
    np->third.np = NULL;
    return np;
}

struct nnode *node(int op, struct nnode* left, struct nnode* right)
{
	struct nnode *np = nalloc();
	np->oper = op;
	np->left.np = left;
	np->right.np = right;
	np->third.np = NULL;
	return np;
}

struct nnode *triple(int op, struct nnode* left, struct nnode* right, struct nnode* third)
{
	struct nnode *np = nalloc();
	np->oper = op;
	np->left.np = left;
	np->right.np = right;
	np->third.np = third;
	return np;
}

void freeall(struct nnode* n){
    if (n->left.np != NULL){
        freeall(n->left.np);
    } 
    if (n->right.np != NULL){
        freeall(n->right.np);
    }
    if (n->third.np != NULL){
        freeall(n->third.np);
    }
    free(n);
}

int execute(struct nnode* n) 
{ 
  if (n == NULL) 
    return 0; 

  switch(n->oper) 
    { 
    case VAR: 
        return sym_table_int[n->left.value]; 
    case INT: 
        return n->left.value; 
    case WHILE: 
        while(execute(n->left.np)) 
        {
            execute(n->right.np);
        } 
        return 0; 
    case IF: 
        if (execute(n->left.np)) 
        {
            execute(n->right.np); 
        }
        else 
        {
            if (n->third.np != NULL)
            {
                execute(n->third.np); 
            } 
        }
        return 0; 
    case PRINT:
        printf("%d\n", execute(n->left.np)); 
        return 0; 
    case ';': 
        execute(n->left.np);        
        return execute(n->right.np);
    case '=':         
        return sym_table_int[n->left.value] = execute(n->right.np); 
    case '+': 
        return execute(n->left.np) + execute(n->right.np); 
    case '-': 
        return execute(n->left.np) - execute(n->right.np); 
    case '*': 
        return execute(n->left.np) * execute(n->right.np); 
    case '/': 
        return execute(n->left.np) / execute(n->right.np); 
    case '<': 
        return execute(n->left.np) < execute(n->right.np); 
    case '>': 
        return execute(n->left.np) > execute(n->right.np); 
    case GE: 
        return execute(n->left.np) >= execute(n->right.np); 
    case LE: 
        return execute(n->left.np) <= execute(n->right.np); 
    case NE: 
        return execute(n->left.np) != execute(n->right.np); 
    case EQ: 
        return execute(n->left.np) == execute(n->right.np); 
    } 
}

int printtree(struct nnode* n, int level) 
{ 
  if (n == NULL) 
    return 0; 

  switch(n->oper) 
    { 
    case VAR: 
        printf("Level: %d, Var: %c\n", level, n->left.value +'a');
        return sym_table_int[n->left.value]; 
    case INT: 
        printf("Level: %d, Int: %d\n", level, n->left.value);
        return n->left.value; 
    case WHILE: 
        printf("Level: %d, While\n", level);
        while(printtree(n->left.np, level+1)) 
        {
            printtree(n->right.np, level+1);
        } 
        return 0; 
    case IF: 
        printf("Level: %d, If\n", level);
        if (printtree(n->left.np, level+1)) 
        {
            printtree(n->right.np, level+1); 
        }
        else 
        {
            if (n->third.np != NULL)
            {
                printf("Level: %d, Else\n", level);
                printtree(n->third.np, level+1); 
            } 
        }
        return 0; 
    case PRINT:
        printf("Level: %d, Print\n", level);
        printf("%d\n", printtree(n->left.np, level+1)); 
        return 0; 
    case ';': 
        printf("Level: %d, ;\n", level);
        printtree(n->left.np, level+1);        
        return printtree(n->right.np, level+1);
    case '=': 
        printf("Level: %d, =\n", level);   
        printf("Level: %d, Var: %c\n", level+1, n->left.value +'a');     
        return sym_table_int[n->left.value] = printtree(n->right.np, level+1); 
    case '+': 
        printf("Level: %d, +\n", level); 
        return printtree(n->left.np, level+1) + printtree(n->right.np, level+1); 
    case '-': 
        printf("Level: %d, -\n", level); 
        return printtree(n->left.np, level+1) - printtree(n->right.np, level+1); 
    case '*': 
        printf("Level: %d, *\n", level); 
        return printtree(n->left.np, level+1) * printtree(n->right.np, level+1); 
    case '/': 
        printf("Level: %d, /\n", level); 
        return printtree(n->left.np, level+1) / printtree(n->right.np, level+1); 
    case '<': 
        printf("Level: %d, <\n", level); 
        return printtree(n->left.np, level+1) < printtree(n->right.np, level+1); 
    case '>': 
        printf("Level: %d, >\n", level); 
        return printtree(n->left.np, level+1) > printtree(n->right.np, level+1); 
    case GE: 
        printf("Level: %d, >=\n", level); 
        return printtree(n->left.np, level+1) >= printtree(n->right.np, level+1); 
    case LE: 
        printf("Level: %d, <=\n", level); 
        return printtree(n->left.np, level+1) <= printtree(n->right.np, level+1); 
    case NE: 
        printf("Level: %d, !=\n", level); 
        return printtree(n->left.np, level+1) != printtree(n->right.np, level+1); 
    case EQ: 
        printf("Level: %d, ==\n", level); 
        return printtree(n->left.np, level+1) == printtree(n->right.np, level+1); 
    } 
}