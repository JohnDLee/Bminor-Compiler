
#include "symbol.h"

struct symbol * symbol_create( symbol_t kind, struct type *type, const char *name ) {
    struct symbol *s = (struct symbol *) malloc(sizeof(struct symbol));
    s->kind = kind;
    s->type = type;
    s->name = name;
    s->total = 0;
    s->prototype = 0;
    return s;
}


const char* symbol_codegen(struct symbol * s) {
    switch (s->kind) {
        case SYMBOL_GLOBAL:
            return s->name;
        case SYMBOL_LOCAL:{
            // changed so that s->which is an absolute position in stack regardless of how manny inner scopes exist
            char str[100];
            sprintf(str, "%d(%%rbp)", -8 * (s->which + 1));
            return strdup(str);
        }
        case SYMBOL_PARAM:{
            char str[100];
            sprintf(str, "%d(%%rbp)", -8 * (s->which + 1));
            return strdup(str);
            break;
        }
        default:
            fprintf(stderr, "codegen error> Invalid symbol type found\n");
            exit(1);
    }
}
