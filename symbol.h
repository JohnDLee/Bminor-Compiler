
#ifndef SYMBOL_H
#define SYMBOL_H

typedef enum {
	SYMBOL_LOCAL,
	SYMBOL_PARAM,
	SYMBOL_GLOBAL
} symbol_t;

struct symbol {
	symbol_t kind;
	struct type *type;
	const char *name;
	int which;
	int total;
	int prototype;
};

#include "type.h"
#include <string.h>

// * Name Resolution, creating symbols
struct symbol * symbol_create( symbol_t kind, struct type *type, const char *name );

// * Code Gen
const char* symbol_codegen(struct symbol * s);


#endif
