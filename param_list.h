
#ifndef PARAM_LIST_H
#define PARAM_LIST_H

#include "type.h"
#include "scope.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int resolve_err;

struct param_list {
	const char *name;
	struct type *type;
	struct symbol *symbol;
	struct param_list *next;
};
// create a param list node
struct param_list * param_list_create( const char *name, struct type *type, struct param_list *next );
// print a param list
void param_list_print( struct param_list *a );
// resolve a param list
void param_list_resolve(struct param_list *a);

// check two param lists are equal
int param_list_equals(struct param_list *a, struct param_list *b);
// copy a param list
struct param_list* param_list_copy(struct param_list *a);
// delete a param list node
void param_list_delete( struct param_list *a);
// check if a param list is valid
void param_list_check_valid( struct param_list *a);

#endif
