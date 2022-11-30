#ifndef TYPE_H
#define TYPE_H

#include "param_list.h"
#include "expr.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
	TYPE_VOID,
	TYPE_BOOLEAN,
	TYPE_CHARACTER,
	TYPE_INTEGER,
	TYPE_STRING,
	TYPE_ARRAY,
	TYPE_FUNCTION,
	TYPE_AUTO,
} type_t;

struct type {
	type_t kind;
	struct expr *arr_val;
	struct param_list *params;
	struct type *subtype;
};


// * AST Creation
// creates a type node
struct type * type_create( type_t kind, struct type *subtype, struct param_list *params, struct expr *arr_val);

// * pprints a type node
void          type_print( struct type *t );

// * typechecking
// checks two types are equal
int type_equals( struct type *a, struct type *b );
// copy a type struct
struct type * type_copy( struct type *t );
// free type recursively
void type_delete( struct type *t );
// convert type to a str
void type_print_error( struct type *t );
// check if type is a valid type.
void type_check_valid( struct type *t , int arr_internal);

#endif