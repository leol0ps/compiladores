%option outfile="scanner.c"
%option noyywrap
%option nounput
%option noinput

%{
#include "parser.h" // For the token types from bison.
%}

%%
"other"     { return OTHER; }
"else"     { return ELSE; }
"if"     { return IF; }
"1"     { return TRUE; }
"0"     { return FALSE; }
"("     { return LPAR; }
")"     { return RPAR; }
"-"     { return MINUS; }
"*"     { return TIMES; }
"/"     { return OVER; }
[0-9]+  { return NUMBER; }
"+"     { return PLUS; }
"\n"    { return ENTER; }
<<EOF>> { return EOF; }
" "     { /* ignore spaces */ }
.       { printf("LEXICAL ERROR: Unknown symbol %s\n", yytext);
          exit(EXIT_FAILURE); }
