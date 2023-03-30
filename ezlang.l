%{  /* Reconhece numeros naturais arbitrarios. */
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  void printa(int line,char* min){
	int len = strlen(min);
	char* mas = malloc(len*(sizeof(char)));
	for(int i  = 0; i < len; i++){
		mas[i] = min[i] + ' ';
	}
	printf("%d: %s->%s\n",line,min,mas);
	free(mas);
  }
%}
/* As definicoes abaixo sao chamadas de fragmentos, que podem
   ser usadas para formar ERs. */
comentario(#*)

%%
begin {printa(yylineno,yytext);}
%%

int main() {
  yylex();
  return 0;
}

/* Definindo esta funcao nao precisa compilar com -lfl */
int yywrap() {
  return 1;
}
