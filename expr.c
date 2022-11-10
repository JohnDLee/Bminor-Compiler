#include "expr.h"


struct expr * expr_create( expr_t kind, struct expr *left, struct expr *right , int precedence ) {
    
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = kind;
    expr_node->left = left;
    expr_node->right = right;
    expr_node->precedence = precedence;
    expr_node->literal_value = 0;
    expr_node->name = NULL;
    expr_node->string_literal = NULL;
    expr_node->symbol = NULL;
    
    return expr_node;

}

struct expr * expr_create_name( const char *n ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_ID;
    expr_node->name = strdup(n);
    expr_node->precedence = 8;
    expr_node->left = NULL;
    expr_node->right = NULL;
    expr_node->literal_value = 0;
    expr_node->string_literal = NULL;
    expr_node->symbol = NULL;
    return expr_node;
}
struct expr * expr_create_integer_literal( int c ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_INT_LIT;
    expr_node->literal_value = c;
    expr_node->precedence = 8;
    expr_node->left = NULL;
    expr_node->right = NULL;
    expr_node->string_literal = NULL;
    expr_node->symbol = NULL;
    expr_node->name = NULL;
    
    return expr_node;
}
struct expr * expr_create_boolean_literal( int c ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_BOOL_LIT;
    expr_node->literal_value = c;
    expr_node->precedence = 8;
    expr_node->left = NULL;
    expr_node->right = NULL;
    expr_node->string_literal = NULL;
    expr_node->symbol = NULL;
    expr_node->name = NULL;
    
    
    return expr_node;
}
struct expr * expr_create_char_literal( char c ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_CHAR_LIT;
    expr_node->literal_value = (int) c;
    expr_node->precedence = 8;
    expr_node->left = NULL;
    expr_node->right = NULL;
    expr_node->string_literal = NULL;
    expr_node->symbol = NULL;
    expr_node->name = NULL;

    return expr_node;
}
struct expr * expr_create_string_literal( const char *str ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_STR_LIT;
    expr_node->string_literal = strdup(str);
    expr_node->precedence = 8;
    expr_node->left = NULL;
    expr_node->right = NULL;
    expr_node->symbol = NULL;
    expr_node->name = NULL;
    expr_node->literal_value = 0;
    
    return expr_node;
}

struct expr * expr_malloc() {
    struct expr * expr_node = (struct expr *) malloc (sizeof(struct expr));
    if (!expr_node) {
        fprintf(stdout, "print error> unable to allocate memory for expr_node in AST.\n");
        exit(1);
    }
    return expr_node;
}


struct expr * expr_check_precedence( struct expr *e, assoc_t associativity, int ignore_right) {

    // if precedence of left or right is lower than this one
    // check if left parens are necessary
    if (e->left->precedence < e->precedence) {
        e->left = expr_wrap(e->left);
    } else if (associativity == LEFT && e->left->precedence == e->precedence) {
        e->left = expr_wrap(e->left);
    } 

    // check if right is necessary
    if (!ignore_right) {
        if ( e->right && e->right->precedence < e->precedence) {
                e->right = expr_wrap(e->right);
        } else if (associativity == RIGHT && e->right->precedence == e->precedence) {
                e->right = expr_wrap(e->right);
        } 
    }

    return e;
}

struct expr * expr_wrap( struct expr * e ) {
    return expr_create(EXPR_GROUP, e, 0, 0);
}


void expr_print( struct expr *e ) {
    if (!e) return;

    
    switch (e->kind) {
        case EXPR_ADD:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "+");
            break;
        case EXPR_SUB:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "-");
            break;
        case EXPR_MUL:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "*");
            break;
        case EXPR_DIV:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "/");
            break;
        case EXPR_INCREMENT:
            expr_print(e->left);
            printf("++");
            break;
        case EXPR_DECREMENT:
            expr_print(e->left);
            printf("--");
            break;
        case EXPR_INDEX:
            e = expr_check_precedence(e, RIGHT, 1);
            expr_print(e->left);
            printf("[");
            expr_print(e->right);
            printf("]");
            break;
        case EXPR_FCALL:
            expr_print(e->left);
            printf("(");
            expr_print(e->right);
            printf(")");
            break;
        case EXPR_ARG:
            expr_print(e->left);
            if (!e->right) break;
            printf(", ");
            expr_print(e->right);
            break;
        case EXPR_NEGATION:
            printf("-");
            expr_print(e->left);
            break;
        case EXPR_NOT:
            printf("!");
            expr_print(e->left);
            break;
        case EXPR_EXPONENT:
            e = expr_check_precedence(e, LEFT, 0);
            expr_print_bin(e, "^");
            break;
        case EXPR_MOD:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "\%");
            break;
        case EXPR_GT:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, ">");
            break;
        case EXPR_GTE:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, ">=");
            break;
        case EXPR_LT:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "<");
            break;
        case EXPR_LTE:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "<=");
            break;
        case EXPR_EQ:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "==");
            break;
        case EXPR_NOT_EQ:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "!=");
            break;
        case EXPR_AND:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "&&");
            break;
        case EXPR_OR:
            e = expr_check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "||");
            break;
        case EXPR_ASSIGN:
            e = expr_check_precedence(e, LEFT, 0);
            expr_print_bin(e, "=");
            break;
        case EXPR_TERNARY1:
            e = expr_check_precedence(e, LEFT, 0);
            expr_print_bin(e, "?");
            break;
        case EXPR_TERNARY2:
            e = expr_check_precedence(e, LEFT, 0);
            expr_print_bin(e, ":");
            break;
        case EXPR_BRACE:
            printf("{");
            expr_print(e->left);
            printf("}");
            if (e->right) printf(",");
            expr_print(e->right);

            break;
        case EXPR_ID:
            printf("%s", e->name);
            break;
        case EXPR_INT_LIT:
            printf("%d", e->literal_value);
            break;
        case EXPR_BOOL_LIT:
            printf("%s",(e->literal_value)?"true":"false");
            break;
        case EXPR_CHAR_LIT:
            // parse the char for special characters
            printf("'");
            if (e->literal_value == '\0') {
                printf("\\0");
            } else if (e->literal_value == '\n') {
                printf("\\n");
            } else if (e->literal_value == '\'') {
                printf("\\'");
            } else {
                // lose and irrelevant \'s
                printf("%c", e->literal_value);
            }
            printf("'");
            break;
        case EXPR_STR_LIT:
            printf("\"");
            // iterate through each char and print appropriate char
            int i = 0;
            for (i = 0; i < strlen(e->string_literal); i++ ) {
                if (e->string_literal[i] == '\0') {
                    printf("\\0");
                } else if (e->string_literal[i] == '\n') {
                    printf("\\n");
                } else if (e->string_literal[i] == '"') {
                    printf("\\\"");
                } else {
                    // lose and irrelevant \'s
                    printf("%c", e->string_literal[i]);
            }
            }
            printf("\"");
            break;
        case EXPR_GROUP:
            // ignore parens if they are doubled
            if (e->left->kind == EXPR_GROUP) {
                expr_print(e->left);
                break;
            };
            printf("(");
            expr_print(e->left);
            printf(")");
            break;
        default:
            fprintf(stdout, "print error> Invalid expression type found.\n");
            exit(1);

    }
}

void expr_print_bin( struct expr *e, char * op) {
    expr_print(e->left);
    printf("%s", op);
    expr_print(e->right);
}


void expr_resolve( struct expr *e ){
    if(!e) return;
    if( e->kind==EXPR_ID ) {
        e->symbol = scope_lookup(e->name);
        if (!e->symbol) {
            fprintf(stdout, "resolve error> %s is not defined\n", e->name);
            resolve_err = 1;
        } else {
            switch (e->symbol->kind) {
                case SYMBOL_GLOBAL:
                    fprintf(stdout, "resolve> %s resolves to global %d\n", e->symbol->name, e->symbol->which);
                    break;
                case SYMBOL_LOCAL:
                    fprintf(stdout, "resolve> %s resolves to local %d\n", e->symbol->name, e->symbol->which);
                    break;
                case SYMBOL_PARAM:
                    fprintf(stdout, "resolve> %s resolves to param %d\n", e->symbol->name, e->symbol->which);
                    break;
            }
        }
    } else {
        
        expr_resolve( e->left );
        expr_resolve( e->right );
    }
    return;
}

struct expr * expr_copy (struct expr *e) {
    if (!e) return NULL;
    switch (e->kind) {
        case EXPR_ID:
            return expr_create_name(e->name);
        case EXPR_BOOL_LIT:
            return expr_create_boolean_literal(e->literal_value);
        case EXPR_CHAR_LIT:
            return expr_create_char_literal(e->literal_value);
        case EXPR_INT_LIT:
            return expr_create_integer_literal(e->literal_value);
        case EXPR_STR_LIT:
            return expr_create_string_literal(e->string_literal);
        default:
            return expr_create(e->kind, expr_copy(e->left), expr_copy(e->right), e->precedence);
    }
    
}

void expr_delete(struct expr *e) {
    if (!e) return;
    expr_delete(e->left);
    expr_delete(e->right);
    free(e);
}

void expr_err_msg( struct expr* e, struct type* lt, struct type* rt, char* req_type) {
    if (rt) { // a bin expr.
        fprintf(stdout, "typecheck error> cannot %s ", expr_action_str(e->kind));
        type_print(rt);
        fprintf(stdout, " (");
        expr_print(e->right);
        fprintf(stdout, ") to ");
        type_print(lt);
        fprintf(stdout, " (");
        expr_print(e->left);
        fprintf(stdout, ") when both must be %s\n", req_type);
        
    } else { // unary expr
        fprintf(stdout, "typecheck error> cannot %s ", expr_action_str(e->kind));
        type_print(lt);
        fprintf(stdout, " (");
        expr_print(e->left);
        fprintf(stdout, ") when it must be %s\n", req_type);
    }
    type_err = 1;
}

struct type * expr_typecheck( struct expr *e ) {
        if(!e) return 0;
        struct type *lt = expr_typecheck(e->left);
        struct type *rt = expr_typecheck(e->right);
        struct type *result;
        switch(e->kind) {
            case EXPR_INT_LIT:
                result = type_create(TYPE_INTEGER,0,0,0);
                break;
            case EXPR_STR_LIT:
                result = type_create(TYPE_STRING,0,0,0);
                break;
            case EXPR_BOOL_LIT:
                result = type_create(TYPE_BOOLEAN,0,0,0);
                break;
            case EXPR_CHAR_LIT:
                result = type_create(TYPE_CHARACTER,0,0,0);
                break;
            case EXPR_ID:
                result = type_copy(e->symbol->type);
                break;
            case EXPR_ADD:
            case EXPR_SUB:
            case EXPR_MUL:
            case EXPR_MOD:
            case EXPR_DIV:
            case EXPR_EXPONENT:
                if (lt->kind != TYPE_INTEGER || rt->kind != TYPE_INTEGER) {
                    expr_err_msg(e, lt, rt, "integer");
                }
                // construct an integer regardless.
                result = type_create(TYPE_INTEGER, 0, 0, 0);
                break;
            case EXPR_INCREMENT:
            case EXPR_DECREMENT:
            case EXPR_NEGATION:
                if (lt->kind != TYPE_INTEGER) {
                    expr_err_msg(e, lt, NULL, "integer");
                }
                result = type_create(TYPE_INTEGER, 0, 0, 0);
                break;
            case EXPR_NOT:
                if (lt->kind != TYPE_BOOLEAN) {
                    expr_err_msg(e, lt, NULL, "boolean");
                }
                result = type_create(TYPE_BOOLEAN, 0,0,0);
                break;
            case EXPR_AND:
            case EXPR_OR:
                if (lt->kind != TYPE_BOOLEAN || rt->kind != TYPE_BOOLEAN) {
                    expr_err_msg(e, lt, rt, "boolean");
                }
                result = type_create(TYPE_BOOLEAN, 0, 0, 0);
                break;
            case EXPR_LT:
            case EXPR_LTE:
            case EXPR_GT:
            case EXPR_GTE:
                if (lt->kind != TYPE_INTEGER || rt->kind != TYPE_INTEGER) {
                    expr_err_msg(e, lt, rt, "integer");
                }
                result = type_create(TYPE_BOOLEAN, 0, 0, 0);
                break;
            case EXPR_EQ:
            case EXPR_NOT_EQ:
                if (!type_equals(lt, rt)) {
                    expr_err_msg(e, lt, rt, "the same type");
                }
                if (lt->kind==TYPE_VOID ||
                    lt->kind==TYPE_ARRAY ||
                    lt->kind==TYPE_FUNCTION ||
                    lt->kind==TYPE_AUTO ) {
                    expr_err_msg(e, lt, rt, "boolean, integer, char, or string");
                }
                result = type_create(TYPE_BOOLEAN, 0,0,0);
                break;
            case EXPR_FCALL:
                if (lt->kind == TYPE_FUNCTION) {
                    // valid function
                    // check args that follow
                    struct expr * r = e->right;
                    struct param_list * p = lt->params;
                    int counter = 1;
                   
                    while (r || p) {
                        if (!r && p) {
                            fprintf(stdout, "typecheck error> number of arguments for %s %s is less than parameters found in definition.\n", expr_action_str(e->kind), e->left->name);
                            type_err = 1;
                            break;
                        }
                        if (r && !p) {
                            fprintf(stdout, "typecheck error> number of arguments for %s %s is more than parameters found in definition.\n", expr_action_str(e->kind), e->left->name);
                            type_err = 1;
                            break;
                        }
                        // check they are equivalent.
                        struct type * argtype = expr_typecheck(r->left);
                        if (argtype->kind == TYPE_FUNCTION || argtype->kind == TYPE_VOID || argtype->kind == TYPE_AUTO) {
                            fprintf(stdout, "typecheck error> function argument cannot be ");
                            type_print(argtype);
                            fprintf(stdout, " (");
                            expr_print(r->left);
                            fprintf(stdout, ")\n");
                            type_err = 1;
                        }
                        if (!type_equals(p->type, argtype)) {
                            fprintf(stdout, "typecheck error> param %d of function %s is a ", counter, e->left->name);
                            type_print(argtype);
                            fprintf(stdout, " (");
                            expr_print(r->left);
                            fprintf(stdout, ") when it must be ");
                            type_print(p->type);
                            fprintf(stdout, "\n");
                            type_err = 1;
                        }
                        type_delete(argtype);
                        // auto in argtype is already handled in EXPR_ARG, don't duplicate error.
                        counter ++;
                        p = p->next;
                        r = r->right;
                    }
                    result = type_copy(lt->subtype);
                } else {
                    // invalid call
                    fprintf(stdout, "typecheck error> attempted to call ");
                    type_print(lt);
                    fprintf(stdout, " (");
                    expr_print(e->left);
                    fprintf(stdout, ") not function\n");
                    type_err = 1;
                    // fill with a valid result
                    result = type_copy(lt);
                }
                break;
            case EXPR_ARG:
                // just copy up the left value anyways
                result = type_copy(lt);
                break;
            case EXPR_ASSIGN:
                // Deal with Auto
                if (!type_equals(lt, rt)) {
                    expr_err_msg(e, lt, rt, "the same type");
                }
                if (rt->kind == TYPE_AUTO) {
                    // invalid to assign auto to a type -> only real case is undefined decl.
                    fprintf(stdout, "typecheck error> cannot %s ", expr_action_str(e->kind));
                    fprintf(stdout, "auto (");
                    expr_print(e->right);
                    fprintf(stdout, ") to ");
                    type_print(lt);
                    fprintf(stdout, " (");
                    expr_print(e->left);
                    fprintf(stdout, ") when RHS must not be auto\n");
                    type_err = 1;
                } else if (lt->kind == TYPE_AUTO) {
                    // replace the AUTO
                    e->left->symbol->type->kind = rt->kind;
                }

                if (rt->kind==TYPE_FUNCTION || rt->kind == TYPE_VOID) {
                    fprintf(stdout, "typecheck error> cannot %s ", expr_action_str(e->kind));
                    type_print(rt);
                    fprintf(stdout, " (");
                    expr_print(e->right);
                    fprintf(stdout, ") to ");
                    type_print(lt);
                    fprintf(stdout, " (");
                    expr_print(e->left);
                    fprintf(stdout, ") when RHS must not be a function or void\n");
                    type_err = 1;
                }
                // copy right side of assignment since it can't be auto validly.
                result = type_copy(rt);
                break;
            case EXPR_BRACE:
                // base level w/ only the single array
                if (e->left->kind == EXPR_ARG) {
                    int counter = 0;
                    struct expr *cur = e->left;
                    struct type *exp_type = NULL;
                    while (cur) {
                        // check each cur is correct type
                        struct type *argtype = expr_typecheck(e->left);
                        if (!exp_type) exp_type = argtype; // set after first one
                        if (!type_equals(exp_type, argtype)) {
                            printf("typecheck error> array values are of inconsistent types ");
                            type_print(argtype);
                            printf(" and ");
                            type_print(exp_type);
                            printf("\n");
                            type_err = 1;
                        }
                        // check value is not of type void, func, or auto
                        if (argtype->kind == TYPE_VOID || argtype->kind == TYPE_FUNCTION || argtype->kind == TYPE_AUTO) {
                            fprintf(stdout, "typecheck error> array values cannot be ");
                            type_print(argtype);
                            fprintf(stdout, " (");
                            expr_print(cur->left);
                            fprintf(stdout, ")\n");
                            type_err = 1;
                        }
                        if (counter > 0)
                            type_delete(argtype);
                        counter++;
                        cur = cur->right;
                    }
                    result = type_create(TYPE_ARRAY, exp_type, 0, expr_create_integer_literal(counter));

                    if (e->right && !e->literal_value) {
                        struct expr* cur = e->right;
                        counter = 1;
                        while (cur) {
                            cur->literal_value = 1;
                            struct type* right = expr_typecheck(cur);
                            if (!type_equals(result, right)) {
                                printf("typecheck error> array values (");
                                type_print(result);
                                printf(") and (");
                                type_print(right);
                                printf(") are inconsistent\n");
                                type_err = 1;
                            }
                            type_delete(right);
                            cur = cur->right;
                            counter += 1;
                        }
                        // assume that they are the same for continued error checking.
                        result = type_create(TYPE_ARRAY, result, 0, expr_create_integer_literal(counter));
                    }

                } if (e->left->kind == EXPR_BRACE) {
                    result = type_copy(lt);
                    
                    if (e->right && !e->literal_value) {
                        struct expr* cur = e->right;
                        int counter = 1;
                        while (cur) {
                            cur->literal_value = 1;
                            struct type* right = expr_typecheck(cur);
                            if (!type_equals(result, right)) {
                                printf("typecheck error> array values (");
                                type_print(result);
                                printf(") and (");
                                type_print(right);
                                printf(") are inconsistent\n");
                                type_err = 1;
                            }
                            type_delete(right);
                            cur = cur->right;
                            counter += 1;
                        }
                        // assume that they are the same for continued error checking.
                        result = type_create(TYPE_ARRAY, result, 0, expr_create_integer_literal(counter));
                    } 
                    
                }
                break;
            case EXPR_GROUP:
                // just copy inner. Error check can happen elsewhere.
                result = type_copy(lt);
                break;
            case EXPR_INDEX:
                if (lt->kind == TYPE_ARRAY) {
                    // valid array
                    if (rt->kind  != TYPE_INTEGER) {
                        // invalid index
                        fprintf(stdout, "typecheck error> index is a ");
                        type_print(rt);
                        fprintf(stdout, " (");
                        expr_print(e->right);
                        fprintf(stdout, ") it must be an integer\n");
                        type_err = 1;
                    }
                    result = type_copy(lt->subtype);
                } else {
                    // not an array
                    expr_err_msg(e, lt, NULL, "array");
                    // return valid type anyways
                    result = type_copy(lt);
                }
                break;
            case EXPR_TERNARY1:
                if (lt->kind != TYPE_BOOLEAN) {
                    expr_err_msg(e, lt, NULL, "boolean");
                } 
                // gets type of rt.
                result = type_copy(rt);
                break;
            case EXPR_TERNARY2:
                // check left and right are same type
                if (!type_equals(lt, rt)) {
                    fprintf(stdout, "typecheck error> cannot %s ", expr_action_str(e->kind));
                    type_print(lt);
                    fprintf(stdout, " (");
                    expr_print(e->left);
                    fprintf(stdout, ") and ");
                    type_print(rt);
                    fprintf(stdout, " (");
                    expr_print(e->right);
                    fprintf(stdout, ") when both must be %s\n", "the same type");
                    type_err = 1;
                }

                if (lt->kind==TYPE_VOID ||
                    lt->kind==TYPE_FUNCTION ||
                    lt->kind==TYPE_AUTO) {
                    fprintf(stdout, "typecheck error> cannot %s ", expr_action_str(e->kind));
                    type_print(lt);
                    fprintf(stdout, " (");
                    expr_print(e->left);
                    fprintf(stdout, ") and ");
                    type_print(rt);
                    fprintf(stdout, " (");
                    expr_print(e->right);
                    fprintf(stdout, ") when both must be %s\n", "boolean, int, char, string or array");
                    type_err = 1;
                }
                // if valid, copy type of one of them.
                result = type_copy(lt);
                break;
            /* more cases here */
            default:
                // should not happen
                printf("typecheck error> an invalid expr kind was found\n");
                exit(1);

        }
        type_delete(lt);
        type_delete(rt);
        return result;
}



char * expr_action_str( expr_t kind ) {
    switch (kind) {
        case EXPR_ADD:
            return "add";
        case EXPR_SUB:
            return "subtract";
        case EXPR_MUL:
            return "multiply";
        case EXPR_DIV:
            return "divide";
        case EXPR_INCREMENT:
            return "increment";
        case EXPR_DECREMENT:
            return "decrement";
        case EXPR_INDEX:
            return "index";
        case EXPR_FCALL:
            return "call function";
        case EXPR_ARG:
            return "arg";
        case EXPR_NEGATION:
            return "negate";
        case EXPR_NOT:
            return "logical invert";
        case EXPR_EXPONENT:
            return "exponentiate";
        case EXPR_MOD:
            return "compute modulus of";
        case EXPR_GT:
        case EXPR_GTE:
        case EXPR_LT:
        case EXPR_LTE:
            return "compare";
        case EXPR_EQ:
        case EXPR_NOT_EQ:
            return "check equality of";
        case EXPR_AND:
            return "logical and";
        case EXPR_OR:
            return "logical or";
        case EXPR_ASSIGN:
            return "assign";
        case EXPR_TERNARY1:
            return "check condition of ternary operator";
        case EXPR_TERNARY2:
            return "have truth_return and false_return of ternary operator be";
        case EXPR_BRACE:
            return "brace";
        case EXPR_ID:
            return "id";
        case EXPR_INT_LIT:
            return "integer literal";
        case EXPR_BOOL_LIT:
            return "boolean literal";
        case EXPR_CHAR_LIT:
            return "char literal";
        case EXPR_STR_LIT:
            return "string literal";
        case EXPR_GROUP:
            return "group";
        default:
            fprintf(stdout, "print error> Invalid expression type found.\n");
            exit(1);
    }
}

int expr_constant( struct expr* e) {
    if (!e) return 1;
    switch (e->kind) {
        case EXPR_INT_LIT:
        case EXPR_BOOL_LIT:
        case EXPR_CHAR_LIT:
        case EXPR_STR_LIT:
            return 1;
        case EXPR_BRACE:
        case EXPR_ARG:
            return expr_constant(e->left) && expr_constant(e->right);
        default:
            return 0;
    }
}