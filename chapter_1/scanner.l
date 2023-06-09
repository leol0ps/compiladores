
/* Flex output */
%option outfile="scanner.c"
/* Unused functions */
%option noyywrap
%option nounput
%option noinput
/* Auto increment variable yylineno every time a '\n' is read. */
%option yylineno

%{

void process_token(const char* tk) {
    printf("%d: %s -> %s\n", yylineno, yytext, tk);
}

%}

int_val     [0-9]+
float_val    [0-9]+"."[0-9]+
str_val     \"[^"]*\"

id          [a-zA-Z_]+[0-9a-zA-Z_]*

ignore      [ \t\n]+
comments    "/*"([^*][^/])*"*/"  

%%
("//".*\n) {}
{ignore}    { }
{comments}  { }
";"         { process_token("SEMI"); }
"char*"     { process_token("STRING"); }
"else"      { process_token("ELSE"); }
"if"        { process_token("IF"); }
"int"       { process_token("INT"); }
"float"     { process_token("FLOAT"); }
"="         { process_token("ASSIGN"); }
"("         { process_token("LPAR"); }'
")"         { process_token("RPAR"); }
"<"         { process_token("LT"); }
">"         { process_token("LT"); }
"-"         { process_token("MINUS"); }
"/"         { process_token("OVER"); }
"+"         { process_token("PLUS"); }
"*"         { process_token("TIMES"); }
"!"         { process_token("NOT"); }
"=="        { process_token("EQ"); }
{int_val}   { process_token("INT_VAL"); }
{float_val}  { process_token("FLOAT_VAL"); }
{str_val}   { process_token("STR_VAL"); }

{id}        { process_token("ID"); }

            /* Be sure to keep this as the last rule */
.           { printf("LEXICAL ERROR (%d): Unknown symbol %s\n", yylineno, yytext);
              exit(EXIT_FAILURE); }

%%
