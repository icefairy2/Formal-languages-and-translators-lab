#ifndef LLISP_H
#define LLISP_H

#define NNULL (struct _cons*)0

typedef struct _cons{int car; struct _cons*cdr;}cons_c;

cons_c* cons(int nr, cons_c* l){
    cons_c* p = (cons_c*) malloc(sizeof(cons_c));
    p->car=nr;
    p->cdr=l;
    return p;
}

cons_c* append(cons_c* l1, cons_c* l2){
    cons_c* p;
    for(p=l1; p->cdr != NNULL; p = p->cdr);
    p->cdr = l2;
    return l1;
}

cons_c* cdr(cons_c* l){
    return l->cdr;
}

int car(cons_c* l){
    return l->car;
}

void eval(cons_c* l){
    cons_c* p;
    printf("( ");
    for(p=l;p->cdr !=NNULL; p=p->cdr){
        printf("%d ", p->car);
    }
    if (p != NNULL)
        printf("%d ", p->car);
    printf(")\n");
}

#endif