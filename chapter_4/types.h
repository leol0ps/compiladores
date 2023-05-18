
#ifndef TYPES_H
#define TYPES_H

typedef enum {
    INT_TYPE,
    REAL_TYPE,
    BOOL_TYPE,
    STR_TYPE
} Type;

const char* get_text(Type type);
Type unify_over(Type a ,Type b);
Type unify_plus(Type a ,Type b);
Type unify_times(Type a ,Type b);
Type unify_minus(Type a ,Type b);
Type unify_EQ(Type a, Type b);
Type unify_LT(Type a, Type b);
Type unify_assign(Type a, Type b);
#endif // TYPES_H

