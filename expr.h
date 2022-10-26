#ifndef EXPR_H
#define EXPR_H

#include "symbol.h"

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
};


struct expr * expr_create( expr_t kind, struct expr *left, struct expr *right, int precedence );

struct expr * expr_malloc();

struct expr * expr_create_name( const char *n );
struct expr * expr_create_integer_literal( int c );
struct expr * expr_create_boolean_literal( int c );
struct expr * expr_create_char_literal( char c );
struct expr * expr_create_string_literal( const char *str );

void expr_print( struct expr *e );
void expr_print_bin( struct expr *e, char * op);
struct expr * check_precedence( struct expr *e, assoc_t associativity, int ignore_right);
struct expr * wrap_expr( struct expr * e );

#endif
