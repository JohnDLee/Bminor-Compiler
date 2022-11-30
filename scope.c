
#include "scope.h"

struct ht_list *stack_top = NULL; // global stack
int resolve_err = 0;
int type_err = 0;


void scope_enter() {
    struct ht_list *ht_node = (struct ht_list *) malloc (sizeof(struct ht_list));

    // default ht
    ht_node->ht = hash_table_create(0, 0);
    // level
    ht_node->level = stack_top ? stack_top->level + 1 : 1; 
    if (stack_top && stack_top->level > 2) {
        // if the current top is not global or args, then keep track from prev
        ht_node->num_vars = stack_top->num_vars;
    } else {
        ht_node->num_vars = 0;
    }
    // next
    ht_node->next = stack_top;

    stack_top = ht_node;
}

void scope_exit() {
    // update the num_vars from previous scope
    if (stack_top->level > 2) {
        stack_top->next->num_vars = stack_top->num_vars;
    }
    stack_top =  stack_top->next;
}

int scope_level() {
    return stack_top->level;
}

int scope_num_vars() {
    return stack_top->num_vars;
}

void scope_bind( const char *name, struct symbol *sym ) {
    // assign and increment which
    sym->which = stack_top->num_vars;
    stack_top->num_vars+=1;
    if (!hash_table_insert(stack_top->ht, name, sym)) {
        fprintf(stdout, "hashtable error> unable to hash duplicate key.\n");
        exit(1);
    }
}

struct symbol *scope_lookup( const char *name ) {
    struct ht_list* cur_level = stack_top;
    while (cur_level) {
        struct symbol *sym = hash_table_lookup(cur_level->ht, name);
        if (sym) return sym;
        cur_level = cur_level->next;
    } 
    return NULL;
}

struct symbol *scope_lookup_current( const char *name ) {
    return hash_table_lookup(stack_top->ht, name);
}



