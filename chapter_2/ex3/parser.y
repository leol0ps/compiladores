
%output "parser.c"          // File name of generated parser.
%defines "parser.h"         // Produces a 'parser.h'
%define parse.error verbose // Give proper messages when a syntax error is found.
%define parse.lac full      // Enable LAC to improve syntax error handling.


%{
#include <stdio.h>
int yylex(void);
void yyerror(char const *s);
%}
%token   LPAR RPAR OTHER IF ELSE TRUE FALSE
%%

statement: if-stmt
          | OTHER
         ;
if-stmt: IF LPAR exp RPAR statement
        |  IF LPAR exp RPAR statement ELSE statement
       ;
exp: FALSE  | TRUE;
%%
int main(void) {
    if (yyparse() == 0) printf("PARSE SUCCESSFUL!\n");
    else                printf("PARSE FAILED!\n");
    return 0;
}
