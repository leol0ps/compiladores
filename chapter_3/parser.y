
%output "parser.c"          // File name of generated parser.
%defines "parser.h"         // Produces a 'parser.h'
%define parse.error verbose // Give proper messages when a syntax error is found.
%define parse.lac full      // Enable LAC to improve syntax error handling.

%{
#include <stdio.h>
#include <stdlib.h>
#include "tables.h"
#include "parser.h"
StrTable* str_table;
VarTable* var_table;
Type type_of_id;
int yylex(void);
int yylex_destroy(void);
void yyerror(char const *s);
void exists_var();
void declare_var_check();
extern char *yytext;
extern int yylineno;
%}

%token ASSIGN
%token BEGIN_RW
%token BOOL
%token ELSE
%token END
%token EQ
%token FALSE
%token ID
%token IF
%token INT
%token INT_VAL
%token LPAR
%token LT
%token MINUS
%token OVER
%token PLUS
%token PROGRAM
%token READ
%token REAL
%token REAL_VAL
%token REPEAT
%token RPAR
%token SEMI
%token STRING
%token STR_VAL
%token THEN
%token TIMES
%token TRUE
%token UNTIL
%token VAR
%token WRITE

// Precedence of operators.
// All operators are left associative.
// Higher line number == higher precedence.
%left EQ LT
%left PLUS MINUS
%left TIMES OVER

// Start symbol for the grammar.
%start program

%%

program:
  PROGRAM ID SEMI vars-sect stmt-sect
;

vars-sect:
  VAR opt-var-decl
;

opt-var-decl:
  %empty
| var-decl-list
;

var-decl-list:
  var-decl
| var-decl-list var-decl
;

var-decl:
  type-spec {type_of_id = (Type)yytext;} ID {declare_var_check();}SEMI
;

type-spec:
  BOOL
| INT
| REAL
| STRING
;

stmt-sect:
  BEGIN_RW stmt-list END
;

stmt-list:
  stmt
| stmt-list stmt
;

stmt:
  assign-stmt
| if-stmt
| read-stmt
| repeat-stmt
| write-stmt
;

assign-stmt:
  ID {exists_var();}ASSIGN expr SEMI
;

if-stmt:
  IF expr THEN stmt-list END
| IF expr THEN stmt-list ELSE stmt-list END
;

read-stmt:
  READ ID {exists_var();} SEMI
;

repeat-stmt:
  REPEAT stmt-list UNTIL expr
;

write-stmt:
  WRITE expr SEMI
;

expr:
  expr LT expr
| expr EQ expr
| expr PLUS expr
| expr MINUS expr
| expr TIMES expr
| expr OVER expr
| LPAR expr RPAR
| TRUE
| FALSE
| INT_VAL
| REAL_VAL
| STR_VAL
| {exists_var();}ID
;

%%

// Primitive error handling.
void yyerror (char const *s) {
    printf("SYNTAX ERROR (%d): %s\n", yylineno, s);
    exit(EXIT_FAILURE);
}

int main() {
    str_table = create_str_table();
    var_table = create_var_table();
    yyparse();
    printf("PARSE SUCCESSFUL!\n");
    yylex_destroy();    // To avoid memory leaks within flex...
    print_var_table(var_table);
    free_var_table(var_table);
    free_str_table(str_table);
    return 0;
}

void exists_var(){
    int a = lookup_var(var_table,yytext); 
    if( a < 0){
      printf("SEMANTIC ERROR (%d): variable ’%s’ was not declared.",yylineno,yytext);
      exit(EXIT_FAILURE);
    }
}

void declare_var_check(){
    int a = lookup_var(var_table,yytext);
    if( a >= 0){
      printf("SEMANTIC ERROR (%d): variable ’%s’ already declared at line %d.",yylineno,yytext,get_line(var_table,a));
      exit(EXIT_FAILURE);
    }
    else{
      add_var(var_table,yytext,yylineno,type_of_id);
    }  
}