
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
#include "label.h"
#include "scratch.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// * AST construction
// creates a decl node
struct decl * decl_create( const char *name, struct type *type, struct expr *value, struct stmt *code, struct decl *next );

// * pprints decl node
void decl_print( struct decl *d, int indent );

// * name resolve decls
void decl_resolve( struct decl *d );

// * typecheck decls.
void decl_typecheck(struct decl *d);


// * codegen
extern FILE* outfile;
// global codegen
void decl_codegen_global(struct decl *d);
// local codegen
void decl_codegen_local(struct decl *d);


#endif


