  FILE* yyin;
  FILE* yyout;
%%
"int" |
"char" |
"float" |
"if" |
"do" |
"for" fprintf(yyout, "KEYWORD: %s\n", yytext);
[();] fprintf(yyout, "SEPARATOR: %c\n", *yytext);
[-+*/<>] fprintf(yyout, "OPERATOR\n");
[a-zA-Z]+ fprintf(yyout, "IDENTIFIER\n");
"=" fprintf(yyout, "ASSIGNMENT\n");
[0-9]+ 
%%
int yywrap(){
  return 1;
}

int main(int argc, char* argv[]){
  if (argc==2){
    yyout = fopen("output", "w");
    if (yyin = fopen(argv[1], "r")){
      yylex();
    } else {
      printf("No file");
    } 
  } else {
    printf("Wrong usage\n");
    return 1;
  }
  return 0;
}
