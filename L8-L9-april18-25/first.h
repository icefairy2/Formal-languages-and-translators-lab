#ifndef FIRST_INTERPRETER_H
#define FIRST_INTERPRETER_H

#define SYM_TABLE_SIZE 512

#define T_INT 0x01000000 
#define T_REAL 0x02000000 
#define T_CHAR 0x04000000 
#define T_STRING 0x08000000 
#define T_BOOL 0x10000000

#define K_VAR 0x00010000
#define K_SYM_CONS 0x00020000
#define K_LIT_CONS 0x00040000
#define K_FCT_DEF 0x00080000
#define K_FCT_CALL 0x00100000
#define K_FCT_PARAM 0x00200000

#define SC_AUTO 0x00000100
#define SC_EXTERN 0x00000200
#define SC_STATIC 0x00000400
#define SC_REGISTER 0x00000800

struct inode 
{
    int value;
    struct nnode* np;
}; 

struct nnode
{
    int oper;
    struct inode left, right, third;
};

struct sym_table_tag 
{
    char* name;
    /*int type;
    int kind;
    int sclass;
    int scope;*/
    unsigned long attrib;
    union n_value {
        int i;
        double r;
        char c;
        char* s;
    } value;
};

static struct sym_table_tag sym_table[SYM_TABLE_SIZE];
static int sym_table_size;

struct nnode* nalloc();

struct nnode* leaf(int type, int val);

struct nnode *node(int op, struct nnode* left, struct nnode* right);

struct nnode *triple(int op, struct nnode* left, struct nnode* right, struct nnode* third);

void freeall(struct nnode* n);

int execute(struct nnode* n);

#endif      //!FIRST_INTERPRETER_H included