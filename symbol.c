
#include "symbol.h"

struct symbol * symbol_create( symbol_t kind, struct type *type, const char *name ) {
    struct symbol *s = (struct symbol *) malloc(sizeof(struct symbol));
    s->kind = kind;
    s->type = type;
    s->name = name;
    s->prototype = 0;
    return s;
}
