%option   yylineno
%{  
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  
  void printa(int line,char* min){
	int len = strlen(min);
	char* mas = malloc((len+1)*(sizeof(char)));
	for(int i  = 0; i < len; i++){
		mas[i] = min[i] - ' ';
	}
  	mas[len] = '\0';
	printf("%d: %s -> %s\n",line,min,mas);
	free(mas);
  }
%}
/* As definicoes abaixo sao chamadas de fragmentos, que podem
   ser usadas para formar ERs. */
comentario(#*)
reservada begin|bool|else|end|false|if|int|program|read|real|repeat|string|then|true|until|var|write
int [+-]?[1-9][0-9]*|0
real  [-+]?[0-9]*\.[0-9][0-9]*
var [a-z][0-9a-zA-Z]*
str \".*\"

%%
{reservada} {printa(yylineno,yytext);}
[;] {printf("%d: ; -> SEMI\n",yylineno);}
"=" {printf("%d: = -> EQ\n",yylineno);}
":=" {printf("%d: := -> ASSIGN\n",yylineno);}
[*] {printf("%d: * -> TIMES\n",yylineno);}
[-] {printf("%d: - -> MINUS\n",yylineno);}
[<] {printf("%d: < -> LT\n",yylineno);}
[>] {printf("%d: > -> MT\n",yylineno);}
[+] {printf("%d: + -> PLUS\n",yylineno);}
[/] {printf("%d: / -> OVER\n",yylineno);}
[(] {printf("%d: ( -> LPAR\n",yylineno);}
[)] {printf("%d: ) -> RPAR\n",yylineno);}
{str} {printf("%d: %s -> STR_VAL\n",yylineno,yytext);}
{var} {printf("%d: %s -> ID\n",yylineno,yytext);}
{real} {printf("%d: %s -> REAL_VAL\n",yylineno,yytext);}
{int} {printf("%d: %s -> INT_VAL\n",yylineno,yytext);}

%%
int main() {
  yylex();
  return 0;
}

/* Definindo esta funcao nao precisa compilar com -lfl */
int yywrap() {
  return 1;
}

