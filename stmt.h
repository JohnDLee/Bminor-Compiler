
#ifndef STMT_H
#define STMT_H

#include "decl.h"
#include "bminor_helper.h"
#include "expr.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
	STMT_DECL,
	STMT_EXPR,
	STMT_IF_ELSE,
	STMT_FOR,
	STMT_PRINT,
	STMT_RETURN,
	STMT_BLOCK
} stmt_t;

struct stmt {
	stmt_t kind;
	struct decl *decl;
	struct expr *init_expr;
	struct expr *expr;
	struct expr *next_expr;
	struct stmt *body;
	struct stmt *else_body;
	struct stmt *next;
};

extern int type_err;

// * AST Creation
// creates a stmt node
struct stmt * stmt_create( stmt_t kind, struct decl *decl, struct expr *init_expr, struct expr *expr, struct expr *next_expr, struct stmt *body, struct stmt *else_body, struct stmt *next );

// * pprints a stmt
void stmt_print( struct stmt *s, int indent );
// wrap a statement if it is a non-STMT_BLOCK with a STMT_BLOCK
struct stmt * stmt_wrap( struct stmt *s );

// * name resolution of a stmt
void stmt_resolve( struct stmt *s );

// * typechecking 
// typecheck driver for stmt
void stmt_typecheck( struct stmt *s, struct decl* func );

// * codegen
void stmt_codegen(struct stmt *s, const char* func_epilogue);
extern FILE* outfile;

#endif
