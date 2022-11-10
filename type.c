#include "type.h"

struct type * type_create( type_t kind, struct type *subtype, struct param_list *params, struct expr *arr_val) {
    struct type * type_node = (struct type *) malloc (sizeof(struct type));
    if (!type_node) {
        fprintf(stdout, "print error> unable to allocate memory for type_node in AST.\n");
        exit(1);
    }

    type_node->kind = kind;
    type_node->arr_val = arr_val;
    type_node->params = params;
    type_node->subtype = subtype;

    return type_node;
}


void type_print( struct type *t ) {
    switch (t->kind) {
        case TYPE_VOID:
            printf("void");
            break;
        case TYPE_BOOLEAN:
            printf("boolean");
            break;
        case TYPE_CHARACTER:
            printf("char");
            break;
        case TYPE_INTEGER:
            printf("integer");
            break;
        case TYPE_STRING:
            printf("string");
            break;
        case TYPE_ARRAY:
            printf("array [");
            expr_print(t->arr_val);
            printf("] ");
            type_print(t->subtype);
            break;
        case TYPE_FUNCTION:
            printf("function ");
            type_print(t->subtype);
            printf(" (");
            param_list_print(t->params);
            printf(")");
            break;
        case TYPE_AUTO:
            printf("auto");
            break;
        default:
            fprintf(stdout, "print error> Invalid type found.\n");
            exit(1);
    }
}


int type_equals( struct type *a, struct type *b ) {
    if (a->kind == b->kind) {
        switch (a->kind) {
            case TYPE_BOOLEAN:
            case TYPE_CHARACTER:
            case TYPE_INTEGER:
            case TYPE_STRING:
            case TYPE_VOID:
            case TYPE_AUTO:
                return 1;
            case TYPE_ARRAY:
                if (type_equals(a->subtype, b->subtype)) return a->arr_val->literal_value == b->arr_val->literal_value;
                return 0;
            case TYPE_FUNCTION:
                if (type_equals(a->subtype, b->subtype)) return param_list_equals(a->params, b->params);
                return 0;
        }
    }
    return 0;
}

struct type * type_copy( struct type *t ) {
    if (!t) return 0;
    return type_create(t->kind, type_copy(t->subtype), param_list_copy(t->params), expr_copy(t->arr_val));
}

void type_delete( struct type *t ) {
    if (!t) return;
    type_delete(t->subtype);
    param_list_delete(t->params);
    expr_delete(t->arr_val);
    free(t);
}

void type_check_valid( struct type *t,  int arr_internal ) {
    if (!t) return;
    switch (t->kind) {
        case TYPE_AUTO:
        case TYPE_BOOLEAN:
        case TYPE_INTEGER:
        case TYPE_CHARACTER:
        case TYPE_STRING:
        case TYPE_VOID:
            return;
        case TYPE_ARRAY:
            // if it isn't an integer literal, fail.
            if (t->arr_val->kind != EXPR_INT_LIT) {
                fprintf(stdout, "typecheck error> array size (");
                expr_print(t->arr_val);
                fprintf(stdout, ") is not an integer literal\n");
                type_err = 1;
            }
            type_check_valid(t->subtype, 1);
            return;
        case TYPE_FUNCTION:
            // check for if we are checking the internal of an array
            if (arr_internal) {
                fprintf(stdout, "typecheck error> array cannot contain type function\n");
                type_err = 1;
            } else {
                if (t->subtype->kind == TYPE_FUNCTION) {
                    fprintf(stdout, "typecheck error> function cannot return a function\n");
                    type_err = 1;
                }
                param_list_check_valid( t->params);
            }
            return;
            
    }
}
