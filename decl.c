# include "decl.h"

char* arg_reg[6] = {"rdi", "rsi", "rdx", "rcx", "r8", "r9"};
int MAX_ARGS = 6;

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
        if (d->symbol->prototype) {
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
        } else if (!d->symbol->prototype && !tmp->prototype) {
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
            // update total for prototype (should only contain args)
            d->symbol->total = scope_num_vars();
            scope_exit();
        }else { // full
            scope_enter();
            param_list_resolve(d->type->params);
            stmt_resolve(d->code);
            if (tmp) // previous prototype exists
                tmp->total = scope_num_vars();
            else // definition is the reference
                d->symbol->total = scope_num_vars();
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



void decl_codegen_global( struct decl *d) {

    if (!d) return;
    // generate code for the expr && value is in 
    
    //Since it's global, you can guarentee these are literals.
    switch (d->type->kind) {
        case TYPE_BOOLEAN:
            d->value = d->value->left; // I did something funky with EXPR_ARGS.
            fprintf(outfile, ".data\n");
            fprintf(outfile, ".globl %s\n", d->name);
            fprintf(outfile, "%s:\n\t.quad %d\n", d->name, d->value ? d->value->literal_value : 0);
            break;
        case TYPE_INTEGER:
            d->value = d->value->left; // I did something funky with EXPR_ARGS.
            fprintf(outfile, ".data\n");
            fprintf(outfile, ".globl %s\n", d->name);
            fprintf(outfile, "%s:\n\t.quad %d\n",d->name, d->value ? d->value->literal_value : 0);
            break;
        case TYPE_CHARACTER:
            d->value = d->value->left; // I did something funky with EXPR_ARGS.
            fprintf(outfile, ".data\n");
            fprintf(outfile, ".globl %s\n", d->name);
            fprintf(outfile, "%s:\n\t.quad %d\n", d->name, d->value ? d->value->literal_value : '\0');
            break;
        case TYPE_STRING:
            d->value = d->value->left; // I did something funky with EXPR_ARGS.
            fprintf(outfile, ".data\n");
            fprintf(outfile, ".globl %s\n", d->name);
            fprintf(outfile, "%s:\n\t.string ",d->name);
            expr_unescape_string(d->value->string_literal, outfile);
            fprintf(outfile, "\n");
            break;
        case TYPE_ARRAY:
            if (d->type->subtype->kind == TYPE_ARRAY) {
                printf("codegen error> Array not implemented: bminor does not support arrays of arrays.\n");
                exit(1);
            }
            fprintf(outfile, ".data\n");
            fprintf(outfile, ".globl %s\n", d->name);
            fprintf(outfile, "%s:\n", d->name);
            struct expr* arg = d->value->left;
            while (arg) {
                if (d->type->subtype->kind == TYPE_STRING) {
                    
                    fprintf(outfile, "\t.string ");
                    expr_unescape_string(arg->left->string_literal, outfile);
                    fprintf(outfile, "\n");
                }
                else {
                    fprintf(outfile, "\t.quad %d\n", arg->left->literal_value);
                }
                arg = arg->right;
            }
        default:
            break;
    }

    // if it is just a prototype
    if (d->type->kind == TYPE_FUNCTION && !d->code) {
        fprintf(outfile, ".text\n.globl %s\n", d->name);
    }
    // generate code for the stmt if it is a function
    if (d->type->kind == TYPE_FUNCTION && d->code) {
        //* preamble
        // .text & .global
        fprintf(outfile, ".text\n.globl %s\n", d->name);
        // func label
        fprintf(outfile, "%s:\n", d->name); 
        // rbp & rsp into rbp
        fprintf(outfile, "\tPUSHQ %%rbp\n");
        fprintf(outfile, "\tMOVQ %%rsp, %%rbp\n");
        // push args
        int num_args = 0;
        struct param_list* p = d->type->params;
        while (p) {
            if (MAX_ARGS == num_args){
                printf("codegen error> functions contain more than 6 parameters, which is not supported with our limited register calling convention\n");
                exit(1);
            }
            fprintf(outfile, "\tPUSHQ %%%s\n", arg_reg[num_args]);
            p = p->next;
            num_args++;
        }
        // allocate space for local vars.
        fprintf(outfile, "\tSUBQ $%d, %%rsp\n", (d->symbol->total - num_args) * 8);
        // push all the callee saved reg
        for (int i = 0; i < 7; i++) {
            if (i != 1 || i != 2)
                fprintf(outfile, "\tPUSHQ %%%s\n", scratch_name(i));
        }
        // label for epilogue
        char func_epilogue[100];
        sprintf(func_epilogue, ".%s_epilogue", d->name);

        stmt_codegen(d->code, func_epilogue);

        // print epilogue
        fprintf(outfile, "%s:\n", func_epilogue);
        // pop all the callee saved reg
        for (int i = 6; i >=0; i--) {
            if (i != 1 || i != 2)
                fprintf(outfile, "\tPOPQ %%%s\n", scratch_name(i));
        }
        // move stack pointer to base
        fprintf(outfile, "\tMOVQ %%rbp, %%rsp\n");
        // pop base pointer back.
        fprintf(outfile, "\tPOPQ %%rbp\n");
        fprintf(outfile, "\tRET\n");
    }
    

    decl_codegen_global(d->next);

}

void decl_codegen_local(struct decl *d) {
    
    if (!d) return;
    // generate code for the expr && value is in 

    // * Expression version
    expr_codegen(d->value);
    switch (d->type->kind) {
        case TYPE_BOOLEAN:
            fprintf(outfile, "\tMOVQ %%%s, %s\n", scratch_name(d->value->reg), symbol_codegen(d->symbol));
            scratch_free(d->value->reg);
            break;
        case TYPE_INTEGER:
            fprintf(outfile, "\tMOVQ %%%s, %s\n", scratch_name(d->value->reg), symbol_codegen(d->symbol));
            scratch_free(d->value->reg);
            break;
        case TYPE_CHARACTER:
            fprintf(outfile, "\tMOVQ %%%s, %s\n", scratch_name(d->value->reg), symbol_codegen(d->symbol));
            scratch_free(d->value->reg);
            break;
        case TYPE_STRING:
            // move the address into stack
            fprintf(outfile, "\tMOVQ %%%s, %s\n", scratch_name(d->value->reg), symbol_codegen(d->symbol));
            scratch_free(d->value->reg);
            break;
        case TYPE_ARRAY:
            // move the address of first point into stack
            //! incomplete, d->value->Reg will not be set.
            fprintf(outfile, "\tMOVQ %%%s, %s\n", scratch_name(d->value->reg), symbol_codegen(d->symbol));
            scratch_free(d->value->reg);
            break;
        default:
            printf("codegen error> Invalid Decl Type found.\n");
            exit(1);
    }
}