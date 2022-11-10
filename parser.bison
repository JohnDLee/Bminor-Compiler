%{
#include <stdio.h>
#include <stdlib.h>

#include "decl.h"
#include "expr.h"
#include "param_list.h"
#include "stmt.h"
#include "type.h"
#include "symbol.h"



extern char *yytext;
extern int yylex();
extern int yyerror( char *str );
struct decl * ast_head = 0;

%}

// keywords
%token TOKEN_ARRAY
%token TOKEN_AUTO
%token TOKEN_BOOLEAN
%token TOKEN_CHAR
%token TOKEN_ELSE
%token TOKEN_IF
%token TOKEN_FALSE
%token TOKEN_TRUE
%token TOKEN_FOR
%token TOKEN_FUNCTION
%token TOKEN_INT
%token TOKEN_PRINT
%token TOKEN_RETURN
%token TOKEN_STRING
%token TOKEN_VOID
%token TOKEN_WHILE

// id
%token TOKEN_ID

// for expr
%token TOKEN_RPAREN
%token TOKEN_LPAREN
%token TOKEN_RBRACKET
%token TOKEN_LBRACKET
%token TOKEN_RBRACE
%token TOKEN_LBRACE
%token TOKEN_INCREMENT
%token TOKEN_DECREMENT
%token TOKEN_NOT
%token TOKEN_EXPONENT
%token TOKEN_MULT
%token TOKEN_DIV
%token TOKEN_MOD
%token TOKEN_PLUS
%token TOKEN_MINUS
%token TOKEN_GT
%token TOKEN_LT
%token TOKEN_GTE
%token TOKEN_LTE
%token TOKEN_EQ
%token TOKEN_NOT_EQ
%token TOKEN_ASSIGN
%token TOKEN_COMMA
%token TOKEN_COLON
%token TOKEN_SEMI
%token TOKEN_AND
%token TOKEN_OR
%token TOKEN_QMARK

//literals
%token TOKEN_STR_LIT
%token TOKEN_CHAR_LIT
%token TOKEN_INT_LIT
%token TOKEN_ERROR

%start program

%union {
	struct decl *decl;
	struct stmt *stmt;
	struct expr *expr;
        struct type *type;
        struct param_list *param_list;
};

%type <decl> program decl decl_list
%type <stmt> stmt unmatched_stmt matched_stmt non_problem_stmt stmt_bunch stmt_braced 
%type <expr> atomic literals id expr_0 expr_1 expr_2 expr_3 expr_4 expr_5 expr_6 expr_7 expr_8 expr_main expr_list expr_eps expr_main_eps expr_braced
%type <type> type
%type <param_list> param_eps param_list




%%

// start
program :  decl_list    { ast_head = $1; }


/**************
* EXPRESSIONS *
***************/
atomic  :   literals            { $$ = $1; }
        |   id                  { $$ = $1; }
        ;

literals:   TOKEN_INT_LIT       { $$ = expr_create_integer_literal( atoi(yytext) ); }
        |   TOKEN_STR_LIT       { $$ = expr_create_string_literal( yytext ); }
        |   TOKEN_CHAR_LIT      { $$ = expr_create_char_literal( *yytext ); }
        |   TOKEN_FALSE         { $$ = expr_create_boolean_literal( 0 ); }
        |   TOKEN_TRUE          { $$ = expr_create_boolean_literal( 1 ); }
        ;

id      :   TOKEN_ID            { $$ = expr_create_name( yytext );}
        ;

expr_0  :   expr_0 TOKEN_INCREMENT                              { $$ = expr_create(EXPR_INCREMENT, $1, 0, 8); }
        |   expr_0 TOKEN_DECREMENT                              { $$ = expr_create(EXPR_DECREMENT, $1, 0, 8); }
        |   TOKEN_LPAREN expr_main TOKEN_RPAREN                 { $$ = $2; }
        |   expr_0 TOKEN_LBRACKET expr_main TOKEN_RBRACKET      { $$ = expr_create(EXPR_INDEX, $1, $3, 8); }
        |   id TOKEN_LPAREN expr_eps TOKEN_RPAREN               { $$ = expr_create(EXPR_FCALL, $1, $3, 8); }
        |   atomic                                              { $$ = $1; }
        ;

expr_1  :   expr_0              { $$ = $1; }
        |   TOKEN_MINUS expr_0  { $$ = expr_create(EXPR_NEGATION, $2, 0, 7); }
        |   TOKEN_NOT expr_0    { $$ = expr_create(EXPR_NOT, $2, 0, 7); }
        ;

expr_2  :   expr_1                              { $$ = $1; }
        |   expr_1 TOKEN_EXPONENT expr_2        { $$ = expr_create(EXPR_EXPONENT, $1, $3, 6); }
        ;

expr_3  :   expr_2                      { $$ = $1; }
        |   expr_3 TOKEN_MOD expr_2     { $$ = expr_create(EXPR_MOD, $1, $3, 5); }
        |   expr_3 TOKEN_MULT expr_2    { $$ = expr_create(EXPR_MUL, $1, $3, 5); }
        |   expr_3 TOKEN_DIV expr_2     { $$ = expr_create(EXPR_DIV, $1, $3, 5); }
        ;

expr_4  :   expr_3                      { $$ = $1; }
        |   expr_4 TOKEN_PLUS expr_3    { $$ = expr_create(EXPR_ADD, $1, $3, 4); }
        |   expr_4 TOKEN_MINUS expr_3   { $$ = expr_create(EXPR_SUB, $1, $3, 4); }
        ;

expr_5  :   expr_4                      { $$ = $1; }
        |   expr_5 TOKEN_GT expr_4      { $$ = expr_create(EXPR_GT, $1, $3, 3); }
        |   expr_5 TOKEN_GTE expr_4     { $$ = expr_create(EXPR_GTE, $1, $3, 3); }
        |   expr_5 TOKEN_LT expr_4      { $$ = expr_create(EXPR_LT, $1, $3, 3); }
        |   expr_5 TOKEN_LTE expr_4     { $$ = expr_create(EXPR_LTE, $1, $3, 3); }
        |   expr_5 TOKEN_EQ expr_4      { $$ = expr_create(EXPR_EQ, $1, $3, 3); }
        |   expr_5 TOKEN_NOT_EQ expr_4  { $$ = expr_create(EXPR_NOT_EQ, $1, $3, 3); }
        ;

expr_6  :   expr_5                      { $$ = $1; }
        |   expr_6 TOKEN_AND expr_5     { $$ = expr_create(EXPR_AND, $1, $3, 2); }
        ;

expr_7  :   expr_6                      { $$ = $1; }
        |   expr_7 TOKEN_OR expr_6      { $$ = expr_create(EXPR_OR, $1, $3, 1); }
        ;

expr_8  :   expr_7                                              { $$ = $1; }
        |   expr_7 TOKEN_ASSIGN expr_8                          { $$ = expr_create(EXPR_ASSIGN, $1, $3, 0); }
        |   expr_7 TOKEN_QMARK expr_8 TOKEN_COLON expr_8        { $$ = expr_create(EXPR_TERNARY1, $1, expr_create(EXPR_TERNARY2, $3, $5, 0), 0); }
        ;

expr_main   :   expr_8   { $$ = $1; }
            ;

expr_list   :  expr_main TOKEN_COMMA expr_list  { $$ = expr_create(EXPR_ARG, $1, $3, 8); }
            |  expr_main                        { $$ = expr_create(EXPR_ARG, $1, 0, 8); }
            ;

expr_eps    :   expr_list       { $$ = $1; }
            |   /*epsilon*/     { $$ = 0; }
            ;

/*************
* STATEMENTS *
**************/

stmt_bunch  :   stmt stmt_bunch         { $$ = $1; $1->next = $2; }
            |   /*epsilon*/             { $$ = 0; }
            ;

stmt_braced :   TOKEN_LBRACE stmt_bunch TOKEN_RBRACE    { $$ = stmt_create(STMT_BLOCK, 0, 0, 0, 0, $2, 0, 0); }
            ;

expr_main_eps   :       expr_main       { $$ = $1; }
                |       /* epsilon */   { $$ = 0; }
                ;

stmt    :   unmatched_stmt      { $$ = $1; }
        |   matched_stmt        { $$ = $1; }
        ;

unmatched_stmt  :   TOKEN_IF TOKEN_LPAREN expr_main TOKEN_RPAREN stmt                                           { $$ = stmt_create(STMT_IF_ELSE, 0, 0, $3, 0, $5, 0, 0); }
                |   TOKEN_IF TOKEN_LPAREN expr_main TOKEN_RPAREN matched_stmt TOKEN_ELSE unmatched_stmt         { $$ = stmt_create(STMT_IF_ELSE, 0, 0, $3, 0, $5, $7, 0); }
                |   TOKEN_FOR TOKEN_LPAREN expr_main_eps TOKEN_SEMI expr_main_eps TOKEN_SEMI expr_main_eps TOKEN_RPAREN unmatched_stmt          { $$ = stmt_create(STMT_FOR, 0, $3, $5, $7, $9, 0, 0); }
                ;

matched_stmt    :   non_problem_stmt    { $$ = $1; }
                |   TOKEN_FOR TOKEN_LPAREN expr_main_eps TOKEN_SEMI expr_main_eps TOKEN_SEMI expr_main_eps TOKEN_RPAREN matched_stmt            { $$ = stmt_create(STMT_FOR, 0, $3, $5, $7, $9, 0, 0); }
                |   TOKEN_IF TOKEN_LPAREN expr_main TOKEN_RPAREN matched_stmt TOKEN_ELSE matched_stmt           { $$ = stmt_create(STMT_IF_ELSE, 0, 0, $3, 0, $5, $7, 0); }
                ;

non_problem_stmt    :   expr_main TOKEN_SEMI                    { $$ = stmt_create(STMT_EXPR, 0, 0, $1, 0, 0, 0, 0); }
                    |   TOKEN_RETURN expr_main_eps TOKEN_SEMI       { $$ = stmt_create(STMT_RETURN, 0, 0, $2, 0, 0, 0, 0); }
                    |   TOKEN_PRINT expr_eps TOKEN_SEMI         { $$ = stmt_create(STMT_PRINT, 0, 0, $2, 0, 0, 0, 0); }
                    |   decl                                    { $$ = stmt_create(STMT_DECL, $1, 0, 0, 0, 0, 0, 0); }
                    |   stmt_braced                             { $$ = $1; }
                    ;

/***************
* DECLARATIONS *
****************/

// for nested lists
expr_braced     :      TOKEN_LBRACE expr_braced TOKEN_RBRACE TOKEN_COMMA expr_braced    { $$ = expr_create(EXPR_BRACE, $2, $5, 8); }
                |      TOKEN_LBRACE expr_braced TOKEN_RBRACE                            { $$ = expr_create(EXPR_BRACE, $2, 0, 8); }
                |      expr_list                        { $$ = $1; }


decl    :   id TOKEN_COLON type TOKEN_ASSIGN expr_braced TOKEN_SEMI     { $$ = decl_create( $1->name, $3, $5, 0, 0); }
        |   id TOKEN_COLON type TOKEN_SEMI                              { $$ = decl_create( $1->name, $3, 0, 0, 0); }
        |   id TOKEN_COLON type TOKEN_ASSIGN stmt_braced                { $$ = decl_create( $1->name, $3, 0, $5, 0); }
        ;   

decl_list :   decl decl_list      { $$ = $1; $1->next = $2;}
          |   /*epsilon*/         { $$ = 0; }

type    :   TOKEN_STRING        { $$ = type_create(TYPE_STRING, 0, 0, 0); }
        |   TOKEN_BOOLEAN       { $$ = type_create(TYPE_BOOLEAN, 0, 0, 0); }
        |   TOKEN_AUTO          { $$ = type_create(TYPE_AUTO, 0, 0, 0); }
        |   TOKEN_INT           { $$ = type_create(TYPE_INTEGER, 0, 0, 0); }
        |   TOKEN_CHAR          { $$ = type_create(TYPE_CHARACTER, 0, 0, 0); }
        |   TOKEN_VOID          { $$ = type_create(TYPE_VOID, 0, 0, 0); }
        |   TOKEN_ARRAY TOKEN_LBRACKET expr_main_eps TOKEN_RBRACKET type        { $$ = type_create(TYPE_ARRAY, $5, 0, $3); }
        |   TOKEN_FUNCTION type TOKEN_LPAREN param_eps TOKEN_RPAREN             { $$ = type_create(TYPE_FUNCTION, $2, $4, 0); }
        ;

param_list  :   id TOKEN_COLON type TOKEN_COMMA param_list      { $$ = param_list_create( $1->name, $3, $5); }
            |   id TOKEN_COLON type                             { $$ = param_list_create( $1->name, $3, 0); }
            ;

param_eps   :   param_list      { $$ = $1; }
            |   /* epsilon */   { $$ = 0; }
            ;
%%

int yyerror( char *str )
{
	printf("parse error: %s\n",str);
	return 0;
}