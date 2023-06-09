
/* Flex output */
%option outfile="scanner.c"
/* Unused functions */
%option noyywrap
%option nounput
%option noinput
/* Auto increment variable yylineno every time a '\n' is read. */
%option yylineno

%{
#include "tables.h"
#include "parser.h"

#define process_token(type) return type
extern VarTable* var_table;
extern StrTable* str_table;
%}

int_val     [0-9]+
real_val    [0-9]+"."[0-9]+
str_val     \"[^"]*\"

id          [a-zA-Z]+

ignore      [ \t\n]+
comments    \{[^}]*\}

%%

{ignore}    { }
{comments}  { }

"begin"     { process_token(BEGIN_RW); }
"bool"      { process_token(BOOL); }
"else"      { process_token(ELSE); }
"end"       { process_token(END); }
"false"     { process_token(FALSE); }
"if"        { process_token(IF); }
"int"       { process_token(INT); }
"program"   { process_token(PROGRAM); }
"read"      { process_token(READ); }
"real"      { process_token(REAL); }
"repeat"    { process_token(REPEAT); }
"string"    { process_token(STRING); }
"then"      { process_token(THEN); }
"true"      { process_token(TRUE); }
"until"     { process_token(UNTIL); }
"var"       { process_token(VAR); }
"write"     { process_token(WRITE); }

":="        { process_token(ASSIGN); }
"="         { process_token(EQ); }
"("         { process_token(LPAR); }
"<"         { process_token(LT); }
"-"         { process_token(MINUS); }
"/"         { process_token(OVER); }
"+"         { process_token(PLUS); }
")"         { process_token(RPAR); }
";"         { process_token(SEMI); }
"*"         { process_token(TIMES); }

{int_val}   { process_token(INT_VAL); }
{real_val}  { process_token(REAL_VAL); }
{str_val}   { add_string(str_table,yytext); process_token(STR_VAL); }

{id}        {process_token(ID);}

            /* Be sure to keep this as the last rule */
.           { printf("LEXICAL ERROR (%d): Unknown symbol %s\n", yylineno, yytext);
              exit(EXIT_FAILURE); }

%%
