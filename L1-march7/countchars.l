  int nrDigits = 0;
  int nrTextChars = 0;
  int nrOperators = 0;
%%
[0-9] nrDigits++;
[a-zA-Z] nrTextChars++;
[-+*/] nrOperators++;
%%
int yywrap(){
  return 1;
}

int main(){
  yylex(); 
  printf("Digits: %d\nText characters: %d\nOperators: %d\n", nrDigits, nrTextChars, nrOperators);
  return 0;
}
