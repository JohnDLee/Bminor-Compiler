
#ifndef DECL_H
#define DECL_H

extern int resolve_err;
extern int type_err;

struct decl {
	const char *name;
	struct type *type;
	struct expr *value;
	struct stmt *code;
	struct symbol *symbol;
	struct decl *next;
};


#include "type.h"
#include "stmt.h"
#include "expr.h"
#include "symbol.h"
#include "param_list.h"
#include "bminor_helper.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// creates a decl node
struct decl * decl_create( const char *name, struct type *type, struct expr *value, struct stmt *code, struct decl *next );

// prints decl node
void decl_print( struct decl *d, int indent );

// name resolve decls
void decl_resolve( struct decl *d );

// typecheck decls.
void decl_typecheck(struct decl *d);
// checks if expression of decl is constant
int decl_constant_expr(struct expr *e);
#endif


