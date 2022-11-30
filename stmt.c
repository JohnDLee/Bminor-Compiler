#include "stmt.h"

struct stmt * stmt_create( stmt_t kind, struct decl *decl, struct expr *init_expr, struct expr *expr, struct expr *next_expr, struct stmt *body, struct stmt *else_body, struct stmt *next ) {
    struct stmt * stmt_node = (struct stmt *) malloc (sizeof(struct stmt));
    if (!stmt_node) {
        fprintf(stdout, "print error> unable to allocate memory for stmt_node in AST.\n");
        exit(1);
    }

    stmt_node->kind = kind;
    stmt_node->decl = decl;
    stmt_node->init_expr = init_expr;
    stmt_node->expr = expr;
    stmt_node->next_expr = next_expr;
    stmt_node->body = body;
    stmt_node->else_body = else_body;
    stmt_node->next = next;

    return stmt_node;

}

struct stmt * stmt_wrap( struct stmt *s ) {
    if (s->kind != STMT_BLOCK) {
        // wrap body with braces
        return stmt_create(STMT_BLOCK, 0, 0, 0, 0, s, 0, 0);
    } 
    return s;
}


void stmt_print( struct stmt *s, int indent) {
    if (!s) return;
    
    switch (s->kind) {
        case STMT_DECL:
            decl_print(s->decl, indent);
            break;
        case STMT_EXPR:
            indent_line(indent);
            expr_print(s->expr);
            printf(";\n");
            break;
        case STMT_IF_ELSE:
            if (!s->init_expr) indent_line(indent);
            printf("if (");
            expr_print(s->expr);
            printf(") ");
            s->body = stmt_wrap(s->body);
            stmt_print(s->body, indent);
            if (s->else_body) { // if an else block exists
                printf(" else ");
                // if it continues with if stmts, don't wrap
                if (s->else_body->kind != STMT_IF_ELSE) {
                    s->else_body = stmt_wrap(s->else_body);
                } else {
                    // create a marker to tell next iteration to avoid indenting
                    s->else_body->init_expr = expr_create(EXPR_TMP, 0, 0, 0);
                }
                stmt_print(s->else_body, indent);
            }
            if (!s->init_expr) printf("\n");
            break;
        case STMT_FOR:
            indent_line(indent);
            printf("for (");
            expr_print(s->init_expr);
            printf(";");
            expr_print(s->expr);
            printf(";");
            expr_print(s->next_expr);
            printf(") ");
            s->body = stmt_wrap(s->body);
            stmt_print(s->body, indent);
            printf("\n");
            break;
        case STMT_PRINT:
            indent_line(indent);
            printf("print");
            if (s->expr) printf(" ");
            expr_print(s->expr);
            printf(";\n");
            break;
        case STMT_RETURN:
            indent_line(indent);
            printf("return");
            if (s->expr) printf(" ");
            expr_print(s->expr);
            printf(";\n");
            break;
        case STMT_BLOCK:
            // if nested stmt blocks, just ignore this one.
            if (s->body && s->body->kind == STMT_BLOCK) {
                stmt_print(s->body, indent);
                break;
            }
            // otherwise, print one set of braces normally.
            printf("{\n");
            stmt_print(s->body, indent + 1);
            indent_line(indent);
            printf("}");
            break;
        default:
            fprintf(stdout, "print error> Invalid statement type found.\n");
            exit(1);
    }
    stmt_print(s->next, indent);
}

void stmt_resolve( struct stmt *s ) {
    if (!s) return;
    
    switch (s->kind) {
        case STMT_DECL:
            decl_resolve(s->decl);
            break;
        case STMT_EXPR:
            expr_resolve(s->expr);
            break;
        case STMT_IF_ELSE:
            expr_resolve(s->expr);
            scope_enter();
            stmt_resolve(s->body);
            scope_exit();
            scope_enter();
            stmt_resolve(s->else_body);
            scope_exit();
            break;
        case STMT_FOR:
            expr_resolve(s->init_expr);
            expr_resolve(s->expr);
            expr_resolve(s->next_expr);
            scope_enter();
            stmt_resolve(s->body);
            scope_enter();
            break;
        case STMT_PRINT:
            expr_resolve(s->expr);
            break;
        case STMT_RETURN:
            expr_resolve(s->expr);
            break;
        case STMT_BLOCK:
            scope_enter();
            stmt_resolve(s->body);
            scope_exit();
            break;
        default:
            fprintf(stdout, "resolve error> Invalid statement type found.\n");
            exit(1);
    }
    stmt_resolve(s->next);
}


void stmt_typecheck( struct stmt *s , struct decl *func) {
    if (!s) return;
    switch (s->kind) {
        case STMT_DECL:
            decl_typecheck(s->decl);
            break;
        case STMT_EXPR:
            expr_typecheck(s->expr);
            break;
        case STMT_IF_ELSE: {
            //check condition is valid.
            struct type *cond = expr_typecheck(s->expr);
            if (cond->kind != TYPE_BOOLEAN) {
                fprintf(stdout, "typecheck error> if-else conditional is ");
                type_print(cond);
                fprintf(stdout, " (");
                expr_print(s->expr);
                fprintf(stdout, ") when it must be boolean\n");
                type_err = 1;
            }
            type_delete(cond);
            stmt_typecheck(s->body, func);
            stmt_typecheck(s->else_body, func);
            break;
            }
        case STMT_FOR: {
            // check the conditions are valid
            struct type *cond1 = expr_typecheck(s->init_expr);
            if (cond1 && cond1->kind != TYPE_INTEGER) {
                fprintf(stdout, "typecheck error> for loop expression 1 (");
                expr_print(s->init_expr);
                fprintf(stdout, ") is a ");
                type_print(cond1);
                fprintf(stdout, " when it must be an integer");
            }
            struct type *cond2 = expr_typecheck(s->expr);
            if (cond2 && cond2->kind != TYPE_BOOLEAN) {
                fprintf(stdout, "typecheck error> for loop expression 2 (");
                expr_print(s->expr);
                fprintf(stdout, ") is a ");
                type_print(cond2);
                fprintf(stdout, " when it must be an boolean");
            }
            struct type *cond3 = expr_typecheck(s->next_expr);
            if (cond3 && cond3->kind != TYPE_INTEGER) {
                fprintf(stdout, "typecheck error> for loop expression 3 (");
                expr_print(s->next_expr);
                fprintf(stdout, ") is a ");
                type_print(cond3);
                fprintf(stdout, " when it must be an int");
            }
            type_delete(cond1);
            type_delete(cond2);
            type_delete(cond3);

            stmt_typecheck(s->body, func);
            break;
        }
        case STMT_PRINT:
            expr_typecheck(s->expr);
            break;
        case STMT_RETURN: {
            struct type *ret_type = func->type->subtype;
            struct type *e = expr_typecheck(s->expr);
            if (!e) break; // no return value.
            // if return is auto, throw error
            if (e->kind == TYPE_AUTO) {
                fprintf(stdout, "typecheck error> return type of function (%s) cannot be auto.\n", func->name);
                type_err = 1;
            }
            // if it is auto
            if (ret_type->kind == TYPE_AUTO) {
                printf("typecheck notice> return type of function (%s) is now ", func->name);
                type_print(e);
                printf("\n");
                // reassign ret type of function
                func->symbol->type->subtype->kind = e->kind;
            } else {
                if (!type_equals(e, ret_type)) {
                    fprintf(stdout, "typecheck error> return type of function (%s) is ", func->name);
                    type_print(e);
                    fprintf(stdout, " which does not match function definition of ");
                    type_print(ret_type);
                    fprintf(stdout, "\n");
                    type_err = 1;
                }
            }   
            break;
        }
        case STMT_BLOCK:
            stmt_typecheck(s->body, func);
            break;
        default:
            fprintf(stdout, "resolve error> Invalid statement type found.\n");
            exit(1);
    }
    stmt_typecheck(s->next, func);
}




void stmt_codegen(struct stmt *s, const char* func_epilogue) {
    if (!s) return;

    switch (s->kind) {
        case STMT_BLOCK:
            stmt_codegen(s->body, func_epilogue);
            break;
        case STMT_RETURN:
            if (s->expr) { 
                // expr exists, so move expr reg into %rax
                expr_codegen(s->expr);
                fprintf(outfile, "\tMOVQ %%%s, %%rax\n", scratch_name(s->expr->reg) );
                scratch_free(s->expr->reg);
            }
            fprintf(outfile, "\tJMP %s\n", func_epilogue);
            break;
        case STMT_PRINT:{
            struct expr* cur = s->expr;
            while (cur) {
                struct type* t = expr_typecheck(cur->left);
                struct expr* fcall;
                switch (t->kind) {
                    case TYPE_BOOLEAN:
                        // wrap as print_bool
                        fcall = expr_create(EXPR_FCALL, expr_create_name("print_boolean"), expr_create(EXPR_ARG, cur->left, NULL, 8), 8);
                        break;
                    case TYPE_CHARACTER:
                        fcall = expr_create(EXPR_FCALL, expr_create_name("print_character"), expr_create(EXPR_ARG, cur->left, NULL, 8), 8);
                        break;
                    case TYPE_INTEGER:
                        fcall = expr_create(EXPR_FCALL, expr_create_name("print_integer"), expr_create(EXPR_ARG, cur->left, NULL, 8), 8);
                        break;
                    case TYPE_STRING:
                        fcall = expr_create(EXPR_FCALL, expr_create_name("print_string"), expr_create(EXPR_ARG, cur->left, NULL, 8), 8);
                        break;
                    default:
                        printf("codegen error> an unprintable type was found in a print statement.");
                        exit(1);
                }

                expr_call_func(fcall);
                scratch_free(fcall->reg);
                cur = cur->right;
            }
            break;
        }
        case STMT_DECL:
            decl_codegen_local(s->decl);
            break;
        case STMT_EXPR:
            scratch_free(s->expr->reg);
            break;
        case STMT_FOR:
            break;
        case STMT_IF_ELSE:
            break;
        default:
            fprintf(stdout, "codegen error> Invalid Statement type\n");
            exit(1);
    }

    stmt_codegen(s->next, func_epilogue);

}