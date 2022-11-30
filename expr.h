#ifndef EXPR_H
#define EXPR_H

#include "symbol.h"
#include "scope.h"
#include "scratch.h"
#include "label.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
	EXPR_ADD,
	EXPR_SUB,
	EXPR_MUL,
	EXPR_DIV,
	EXPR_INCREMENT,
	EXPR_DECREMENT,
	EXPR_INDEX,
	EXPR_FCALL,
	EXPR_ARG,
	EXPR_NEGATION,
	EXPR_NOT,
	EXPR_EXPONENT,
	EXPR_MOD,
	EXPR_GT,
	EXPR_GTE,
	EXPR_LT,
	EXPR_LTE,
	EXPR_EQ,
	EXPR_NOT_EQ,
	EXPR_AND,
	EXPR_OR,
	EXPR_ASSIGN,
	EXPR_TERNARY1,
	EXPR_TERNARY2,
	EXPR_BRACE,
	EXPR_ID,
	EXPR_INT_LIT,
	EXPR_BOOL_LIT,
	EXPR_CHAR_LIT,
	EXPR_STR_LIT,
	EXPR_GROUP,
	EXPR_TMP
} expr_t;

typedef enum {
	NONE,
	LEFT,
	RIGHT
} assoc_t;

struct expr {
	/* used by all kinds of exprs */
	expr_t kind;
	struct expr *left;
	struct expr *right;

	/* used by various leaf exprs */
	int precedence;
	const char *name;
	int literal_value;
	const char * string_literal;
	struct symbol *symbol;

	// register
	int reg;
};

extern int resolve_err;
extern int type_err;

// * creation of expr node
struct expr * expr_create( expr_t kind, struct expr *left, struct expr *right, int precedence );
struct expr * expr_malloc();
struct expr * expr_create_name( const char *n );
struct expr * expr_create_integer_literal( int c );
struct expr * expr_create_boolean_literal( int c );
struct expr * expr_create_char_literal( char c );
struct expr * expr_create_string_literal( const char *str );

// * pprinting
void expr_print( struct expr *e );
// unescape strings with \n
void expr_unescape_string( const char* s, FILE* fp);
// print statement
void expr_print_bin( struct expr *e, char * op);
// check precedence of expr
struct expr * expr_check_precedence( struct expr *e, assoc_t associativity, int ignore_right);
// wrap an expr with parens (expr_group)
struct expr * expr_wrap( struct expr * e );

// * name resolution
void expr_resolve( struct expr *e );

// * typechecking
struct type * expr_typecheck( struct expr *e );
// copy an expr
struct expr * expr_copy (struct expr *e);
// delete an expr
void expr_delete(struct expr *e);
// convert expr into action statements.
char * expr_action_str( expr_t e );
// default err msg
void expr_err_msg( struct expr* e, struct type* lt, struct type* rt, char* req_type);
// check that an expression is a constant
int expr_constant( struct expr* e);

// * codegen
void expr_codegen( struct expr* e);
// for function calls
void expr_call_func( struct expr* fcall );
// for comparison expr
void expr_compare ( struct expr* e );
extern FILE* outfile;
extern char* arg_reg[6];
extern int MAX_ARGS;


#endif
