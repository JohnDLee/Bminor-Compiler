# include "decl.h"

struct decl * decl_create( const char *name, struct type *type, struct expr *value, struct stmt *code, struct decl *next ) {

    struct decl* decl_node = (struct decl *) malloc (sizeof(struct decl));
    if (!decl_node) {
        fprintf(stdout, "print error> unable to allocate memory for decl_node in AST.\n");
        exit(1);
    }
    // fill node
    decl_node->name = name;
    decl_node->type = type;
    decl_node->value = value;
    decl_node->code = code;
    decl_node->next = next;

    return decl_node;
}

void indent_line( int indent ) {
    // indent properly w/ 4 spaces
    int i;
    for (i = 0; i < indent * 4; i++) {
        printf(" ");
    }
}

void decl_print( struct decl *d, int indent ) {
    if (!d) return;
    // indent
    indent_line(indent);

    // print body of declaration
    printf("%s: ", d->name);
    
    type_print(d->type);
    // expr
    if (d->value) {
        printf(" = ");
        expr_print(d->value);
        printf(";");
    }
    // stmt
    else if (d->code) {
        printf(" = ");
        stmt_print(d->code, indent);
    } 
    else {
        printf(";");
    }
    printf("\n");

    // print next declaration
    decl_print(d->next, indent);

}

void decl_resolve( struct decl *d ) {
    if (!d) return;

    // create symbol and bind
    d->symbol = symbol_create( scope_level() > 1 ? SYMBOL_LOCAL : SYMBOL_GLOBAL, d->type, d->name);
    
    //expr
    expr_resolve(d->value);

    // prototype (no definition)
    if (d->type->kind == TYPE_FUNCTION && !d->code) {
        d->symbol->prototype = 1;
    }
    
    // check for a previous declaration
    struct symbol * tmp = scope_lookup_current(d->name);
    if (d->type->kind == TYPE_FUNCTION && tmp) { // a previous function declaration was found
        if (d->symbol->prototype && tmp->prototype) {
            // both are prototypes
            if (!type_equals(tmp->type, d->type)) {
                // error if not the same type
                fprintf(stdout, "resolve error> multiple different prototypes of %s found.\n", d->name);
                resolve_err = 1;
            } else {
                // otherwise warning
                fprintf(stdout, "resolve warning> multiple prototypes of %s found. Ignoring all but first.\n", d->name);
            }
        } else if (!d->symbol->prototype && tmp->prototype) {
            if (!type_equals(tmp->type, d->type)) {
                // error if the params don't match too
                fprintf(stdout, "resolve error> definition of %s does not match prototype %s, global %d.\n", d->name, tmp->name, tmp->which);
                resolve_err = 1;
            } else {
                // valid, but don't rebind.
                printf("resolve> %s defines prototype global %d.\n", d->name, tmp->which);
            }
            // set prototype of tmp to false, since a definition has been provided for prototype, even if an error occured.
            tmp->prototype = 0;
        } else if (!tmp->prototype) {
            fprintf(stdout, "resolve error> multiple function definitions of %s found.\n", d->name);
            resolve_err = 1;
        }
    } else if (tmp) {
        // non-func, but another definition was found. Error
        fprintf(stdout, "resolve error> multiple definitions of %s found in the same scope.\n", d->name);
        resolve_err = 1;
    } else {
        // has not been seen before, so bind.
        scope_bind(d->name, d->symbol);
    }

    // function
    if (d->type->kind == TYPE_FUNCTION) {
        // prototype
        if (d->symbol->prototype) {
            scope_enter();
            param_list_resolve(d->type->params);
            scope_exit();
        }else { // full
            scope_enter();
            param_list_resolve(d->type->params);
            stmt_resolve(d->code);
            scope_exit();
        }
        
    }
    

    // resolve next declaration
    decl_resolve(d->next);
}

void decl_typecheck(struct decl *d) {
    if (!d) return;
    // checks that the type associated with decl is a valid type.
    type_check_valid(d->type, 0); 

    // if this is an expr decl, then check the expr
    struct type *def_type = NULL;
    def_type = expr_typecheck(d->value);  

    // expr exists
    if (def_type) {
        // check that def type is a function
        if (def_type->kind == TYPE_FUNCTION) {
            fprintf(stdout, "typecheck error> bminor does not support function assignment (");
            expr_print(d->value);
            fprintf(stdout, ")\n");
            type_err = 1;
        }
        // check that def type is a void
        if (def_type->kind == TYPE_VOID) {
            fprintf(stdout, "typecheck error> invalid expr of type void\n");
            type_err = 1;
        }
        

        // check that def_type is a constant if global
        if (d->symbol->kind == SYMBOL_GLOBAL) {
            if (!expr_constant(d->value)) {
                fprintf(stdout, "typecheck error> bminor does not support non-constant global initializers (");
                expr_print(d->value);
                fprintf(stdout, ")\n");
                type_err = 1;
            }
        } else { // local
            // check that def_type is an array and {} notation
            if (def_type->kind == TYPE_ARRAY && d->value->kind == EXPR_BRACE) {
                fprintf(stdout, "typecheck error> bminor does not support array initializers in non-global scope (");
                expr_print(d->value);
                fprintf(stdout, ")\n");
                type_err = 1;
            } 
            if (def_type->kind == TYPE_FUNCTION) {
                fprintf(stdout, "typecheck error> bminor does not support functions in non-global scope (");
                expr_print(d->value);
                fprintf(stdout, ")\n");
                type_err = 1;
            }
        }
        // check that both are auto
        if (def_type->kind == TYPE_AUTO && def_type->kind == TYPE_AUTO) {
            fprintf(stdout, "typecheck error> type auto (");
            expr_print(d->value);
            fprintf(stdout, ") cannot occur RHS side of declaration when LHS is also auto\n");
            type_err = 1;
        }
        // if left is auto and right is not;
        if (d->type->kind == TYPE_AUTO) {
            // set the left symbol to permanently the right
            printf("typecheck notice> type of (");
            expr_print(d->value);
            printf(") is ");
            type_print(def_type);
            printf(" so %s is set to ", d->name);
            type_print(def_type);
            printf("\n");
            d->symbol->type->kind = def_type->kind;
        } else {

            // check two types are equal
            if (!type_equals(d->type, def_type)) {
                fprintf(stdout, "typecheck error> declaration type ");
                type_print(d->type);
                fprintf(stdout, " for %s does not match expression type ", d->name);
                type_print(def_type);
                fprintf(stdout, "\n");
                type_err = 1;
            }
        }   
    }

    type_delete(def_type);

    // check code. Can guarentee from parser that if code exists, then its a function.
    stmt_typecheck(d->code, d);

    decl_typecheck(d->next);

}