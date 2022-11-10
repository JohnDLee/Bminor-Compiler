#include "param_list.h"


void param_list_print( struct param_list *a ) {
    // base case
    if (!a) return;

    printf("%s: ", a->name);
    type_print(a->type);
    // if there is no next, don't recurse again.
    if (!a->next) return;
    printf(", ");
    param_list_print(a->next);

}

struct param_list * param_list_create( const char *name, struct type *type, struct param_list *next ) {
    struct param_list * plist_node = (struct param_list *) malloc (sizeof(struct param_list));
    if (!plist_node) {
        fprintf(stderr, "print error> unable to allocate memory for param_list_node in AST.\n");
        exit(1);
    }

    // fill plist node
    plist_node->name = name;
    plist_node->type = type;
    plist_node->next = next;

    return plist_node;
}

void param_list_resolve(struct param_list *a) {
    if (!a) return;
    a->symbol = symbol_create(SYMBOL_PARAM, a->type, a->name);
    if (scope_lookup_current(a->name)) {
        // error
        fprintf(stderr, "resolve error> multiple parameters %s found.\n", a->name);
        resolve_err = 1;
        // skip binding 
    } else {
        scope_bind(a->name, a->symbol);
    }
    param_list_resolve(a->next);
}

int param_list_equals(struct param_list *a, struct param_list *b) {
    if (!a && b) return 0;
    else if (a && !b) return 0;
    else if (!a && !b) return 1; // only true if both end at the same time

    if (type_equals(a->type, b->type)) {
        return param_list_equals(a->next, b->next);
    }
    return 0;
}

struct param_list* param_list_copy(struct param_list *a) {
    if (!a) return NULL;
    return param_list_create(a->name, type_copy(a->type), param_list_copy(a->next));
}

void param_list_delete( struct param_list *a) {
    if (!a) return;
    type_delete(a->type);
    param_list_delete(a->next);
    free(a);
}

void param_list_check_valid( struct param_list *a) {
    if (!a) return;
    if (a->type->kind == TYPE_FUNCTION) {
        // can't have function as param
        fprintf(stdout, "typecheck error> bminor does not support functions as parameters.\n");
        type_err = 1;
    }
    param_list_check_valid(a->next);
}

    