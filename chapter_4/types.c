
#include "types.h"
#include <stdlib.h>
#include <stdio.h>
extern int yylineno;
static const char *TYPE_STRING[] = {
    "int",
    "real",
    "bool",
    "string"
};

const char* get_text(Type type) {
    return TYPE_STRING[type];
}


Type unify_over(Type a ,Type b){
    if(a == STR_TYPE | b == STR_TYPE | a == BOOL_TYPE | b == BOOL_TYPE){
      printf("SEMANTIC ERROR (%d): incompatible types for operator 'OVER', LHS is '%s' and RHS is '%s'.", yylineno,get_text(a),get_text(b));
      exit(EXIT_FAILURE);
    }
    if( a == REAL_TYPE | b == REAL_TYPE)
      return REAL_TYPE;
    return INT_TYPE;
    
}
Type unify_times(Type a ,Type b){
    if(a == STR_TYPE | b == STR_TYPE | a == BOOL_TYPE | b == BOOL_TYPE){
      printf("SEMANTIC ERROR (%d): incompatible types for operator 'TIMES', LHS is '%s' and RHS is '%s'.", yylineno,get_text(a),get_text(b));
      exit(EXIT_FAILURE);
    }
    if( a == REAL_TYPE | b == REAL_TYPE)
      return REAL_TYPE;
    return INT_TYPE;
}
Type unify_minus(Type a ,Type b){
    if(a == STR_TYPE | b == STR_TYPE | a == BOOL_TYPE | b == BOOL_TYPE){
      printf("SEMANTIC ERROR (%d): incompatible types for operator 'MINUS', LHS is '%s' and RHS is '%s'.", yylineno,get_text(a),get_text(b));
      exit(EXIT_FAILURE);
    }
    if( a == REAL_TYPE | b == REAL_TYPE)
      return REAL_TYPE;
    return INT_TYPE;
}

Type unify_plus(Type a , Type b){
  if(a == STR_TYPE | b == STR_TYPE){
      return STR_TYPE;
   }
  if( a == BOOL_TYPE)
      return b;
  if(b == BOOL_TYPE)
    return a;
  if(a == REAL_TYPE | b == REAL_TYPE)
    return REAL_TYPE;
  return INT_TYPE;
}

Type unify_EQ(Type a, Type b){
    if(a == STR_TYPE && b == STR_TYPE)
      return STR_TYPE;
    if(a == BOOL_TYPE && b == BOOL_TYPE)
      return BOOL_TYPE;
    if(a == INT_TYPE && b == INT_TYPE)
      return INT_TYPE;
    if(a == REAL_TYPE && b == INT_TYPE | a == INT_TYPE && b == REAL_TYPE | a == REAL_TYPE && b == REAL_TYPE)
      return REAL_TYPE;
    printf("SEMANTIC ERROR (%d): incompatible types for operator 'EQ', LHS is '%s' and RHS is '%s'.", yylineno,get_text(a),get_text(b));
    exit(EXIT_FAILURE);
}
Type unify_LT(Type a, Type b){
    if(a == STR_TYPE && b == STR_TYPE)
      return STR_TYPE;
    if(a == BOOL_TYPE && b == BOOL_TYPE)
      return BOOL_TYPE;
    if(a == INT_TYPE && b == INT_TYPE)
      return INT_TYPE;
    if(a == REAL_TYPE && b == INT_TYPE | a == INT_TYPE && b == REAL_TYPE | a == REAL_TYPE && b == REAL_TYPE)
      return REAL_TYPE;
    printf("SEMANTIC ERROR (%d): incompatible types for operator 'LT', LHS is '%s' and RHS is '%s'.", yylineno,get_text(a),get_text(b));
    exit(EXIT_FAILURE);
}

Type unify_assign(Type a, Type b){
    if(a == STR_TYPE && b == STR_TYPE)
      return STR_TYPE;
    if(a == BOOL_TYPE && b == BOOL_TYPE)
      return BOOL_TYPE;
    if(a == INT_TYPE && b == INT_TYPE)
      return INT_TYPE;
    if(a == REAL_TYPE && b == INT_TYPE | a == REAL_TYPE && b == REAL_TYPE)
      return REAL_TYPE;
    printf("SEMANTIC ERROR (%d): incompatible types for operator 'ASSIGN', LHS is '%s' and RHS is '%s'.", yylineno,get_text(a),get_text(b));
    exit(EXIT_FAILURE);
}