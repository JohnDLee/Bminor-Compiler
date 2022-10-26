#include "decl.h"
#include "expr.h"
#include "param_list.h"
#include "stmt.h"
#include "type.h"
#include "symbol.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAB 4

/****************
 * Constructors *
 * **************/

struct decl * decl_create( const char *name, struct type *type, struct expr *value, struct stmt *code, struct decl *next ) {

    struct decl* decl_node = (struct decl *) malloc (sizeof(struct decl));
    if (!decl_node) {
        fprintf(stderr, "print error> unable to allocate memory for decl_node in AST.\n");
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

struct expr * expr_create( expr_t kind, struct expr *left, struct expr *right , int precedence ) {
    
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = kind;
    expr_node->left = left;
    expr_node->right = right;
    expr_node->precedence = precedence;
    
    return expr_node;

}

struct expr * expr_create_name( const char *n ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_ID;
    expr_node->name = strdup(n);
    expr_node->precedence = 8;
    return expr_node;
}
struct expr * expr_create_integer_literal( int c ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_INT_LIT;
    expr_node->literal_value = c;
    expr_node->precedence = 8;
    
    return expr_node;
}
struct expr * expr_create_boolean_literal( int c ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_BOOL_LIT;
    expr_node->literal_value = c;
    expr_node->precedence = 8;
    
    return expr_node;
}
struct expr * expr_create_char_literal( char c ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_CHAR_LIT;
    expr_node->literal_value = (int) c;
    expr_node->precedence = 8;

    return expr_node;
}
struct expr * expr_create_string_literal( const char *str ) {
    struct expr *expr_node = expr_malloc();

    // fill node
    expr_node->kind = EXPR_STR_LIT;
    expr_node->string_literal = strdup(str);
    expr_node->precedence = 8;
    
    return expr_node;
}

struct param_list * param_list_create( const char *name, struct type *type, struct param_list *next ) {
    struct param_list * plist_node = (struct param_list *) malloc (sizeof(struct param_list));
    if (!plist_node) {
        fprintf(stderr, "print error> unable to allocate memory for param_list_node in AST.\n");
        exit(1);
    }

    // fill plist node
    plist_node->name = name;
    plist_node->type = type;
    plist_node->next = next;

    return plist_node;
}

struct stmt * stmt_create( stmt_t kind, struct decl *decl, struct expr *init_expr, struct expr *expr, struct expr *next_expr, struct stmt *body, struct stmt *else_body, struct stmt *next ) {
    struct stmt * stmt_node = (struct stmt *) malloc (sizeof(struct stmt));
    if (!stmt_node) {
        fprintf(stderr, "print error> unable to allocate memory for stmt_node in AST.\n");
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

struct type * type_create( type_t kind, struct type *subtype, struct param_list *params, struct expr *arr_val) {
    struct type * type_node = (struct type *) malloc (sizeof(struct type));
    if (!type_node) {
        fprintf(stderr, "print error> unable to allocate memory for type_node in AST.\n");
        exit(1);
    }

    type_node->kind = kind;
    type_node->arr_val = arr_val;
    type_node->params = params;
    type_node->subtype = subtype;

    return type_node;
}


/***********
 * Helpers *
 ***********/

struct expr * expr_malloc() {
    struct expr * expr_node = (struct expr *) malloc (sizeof(struct expr));
    if (!expr_node) {
        fprintf(stderr, "print error> unable to allocate memory for expr_node in AST.\n");
        exit(1);
    }
    return expr_node;
}

void indent_line( int indent ) {
    // indent properly w/ 4 spaces
    int i;
    for (i = 0; i < indent * TAB; i++) {
        printf(" ");
    }
}

struct stmt * wrap_stmt( struct stmt *s ) {
    if (s->kind != STMT_BLOCK) {
        // wrap body with braces
        return stmt_create(STMT_BLOCK, 0, 0, 0, 0, s, 0, 0);
    } 
    return s;
}


struct expr * check_precedence( struct expr *e, assoc_t associativity, int ignore_right) {



    // if precedence of left or right is lower than this one
    // check if left parens are necessary
    if (e->left->precedence < e->precedence) {
        e->left = wrap_expr(e->left);
    } else if (associativity == LEFT && e->left->precedence == e->precedence) {
        e->left = wrap_expr(e->left);
    } 

    // check if right is necessary
    if (!ignore_right) {
        if ( e->right && e->right->precedence < e->precedence) {
                e->right = wrap_expr(e->right);
        } else if (associativity == RIGHT && e->right->precedence == e->precedence) {
                e->right = wrap_expr(e->right);
        } 
    }

    return e;
}

struct expr * wrap_expr( struct expr * e ) {
    return expr_create(EXPR_GROUP, e, 0, 0);
}


/************
 * Printers *
 ************/

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
            s->body = wrap_stmt(s->body);
            stmt_print(s->body, indent);
            if (s->else_body) { // if an else block exists
                printf(" else ");
                // if it continues with if stmts, don't wrap
                if (s->else_body->kind != STMT_IF_ELSE) {
                    s->else_body = wrap_stmt(s->else_body);
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
            s->body = wrap_stmt(s->body);
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
            fprintf(stderr, "print error> Invalid statement type found.\n");
            exit(1);
    }
    stmt_print(s->next, indent);
}

void type_print( struct type *t ) {
    // does not handle precendence right now.
    switch (t->kind) {
        case TYPE_VOID:
            printf("void");
            break;
        case TYPE_BOOLEAN:
            printf("boolean");
            break;
        case TYPE_CHARACTER:
            printf("char");
            break;
        case TYPE_INTEGER:
            printf("integer");
            break;
        case TYPE_STRING:
            printf("string");
            break;
        case TYPE_ARRAY:
            printf("array [");
            expr_print(t->arr_val);
            printf("] ");
            type_print(t->subtype);
            break;
        case TYPE_FUNCTION:
            printf("function ");
            type_print(t->subtype);
            printf(" (");
            param_list_print(t->params);
            printf(")");
            break;
        case TYPE_AUTO:
            printf("auto");
            break;
        default:
            fprintf(stderr, "print error> Invalid type found.\n");
            exit(1);
    }
}

void expr_print( struct expr *e ) {
    if (!e) return;

    
    switch (e->kind) {
        case EXPR_ADD:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "+");
            break;
        case EXPR_SUB:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "-");
            break;
        case EXPR_MUL:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "*");
            break;
        case EXPR_DIV:
            e = check_precedence(e, RIGHT, 0);
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
            e = check_precedence(e, RIGHT, 1);
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
            e = check_precedence(e, LEFT, 0);
            expr_print_bin(e, "^");
            break;
        case EXPR_MOD:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "\%");
            break;
        case EXPR_GT:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, ">");
            break;
        case EXPR_GTE:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, ">=");
            break;
        case EXPR_LT:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "<");
            break;
        case EXPR_LTE:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "<=");
            break;
        case EXPR_EQ:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "==");
            break;
        case EXPR_NOT_EQ:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "!=");
            break;
        case EXPR_AND:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "&&");
            break;
        case EXPR_OR:
            e = check_precedence(e, RIGHT, 0);
            expr_print_bin(e, "||");
            break;
        case EXPR_ASSIGN:
            e = check_precedence(e, LEFT, 0);
            expr_print_bin(e, "=");
            break;
        case EXPR_TERNARY1:
            e = check_precedence(e, LEFT, 0);
            expr_print_bin(e, "?");
            break;
        case EXPR_TERNARY2:
            e = check_precedence(e, LEFT, 0);
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
            fprintf(stderr, "print error> Invalid expression type found.\n");
            exit(1);

    }
}

void expr_print_bin( struct expr *e, char * op) {
    expr_print(e->left);
    printf("%s", op);
    expr_print(e->right);
}



void param_list_print( struct param_list *a ) {
    // base case
    if (!a) return;

    printf("%s: ", a->name);
    type_print(a->type);
    // if there is no next, don't recurse again.
    if (!a->next) return;
    printf(", ");
    param_list_print(a->next);

}