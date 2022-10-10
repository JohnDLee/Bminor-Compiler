%{
#include <stdio.h>

extern char *yytext;
extern int yylex();
extern int yyerror( char *str );
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
%%

// start
program :   decl program
        |   /*epsilon*/ // change to sequence of decl

/**************
* EXPRESSIONS *
***************/
atomic  :   literals
        |   id
        ;

literals:   TOKEN_INT_LIT
        |   TOKEN_STR_LIT
        |   TOKEN_CHAR_LIT
        |   TOKEN_FALSE
        |   TOKEN_TRUE
        ;

id      :   TOKEN_ID
        ;

expr_0  :   expr_0 TOKEN_INCREMENT  // can you increment/decrement non-ID
        |   expr_0 TOKEN_DECREMENT
        |   TOKEN_LPAREN expr_main TOKEN_RPAREN
        |   expr_0 TOKEN_LBRACKET expr_main TOKEN_RBRACKET // IS THIS valid?
        |   id TOKEN_LPAREN expr_eps TOKEN_RPAREN
        |   atomic
        ;

expr_1  :   expr_0
        |   TOKEN_MINUS expr_0
        |   TOKEN_NOT expr_0
        ;

expr_2  :   expr_1
        |   expr_1 TOKEN_EXPONENT expr_2  // right to left
        ;

expr_3  :   expr_2
        |   expr_3 TOKEN_MOD expr_2
        |   expr_3 TOKEN_MULT expr_2
        |   expr_3 TOKEN_DIV expr_2
        ;

expr_4  :   expr_3
        |   expr_4 TOKEN_PLUS expr_3
        |   expr_4 TOKEN_MINUS expr_3
        ;

expr_5  :   expr_4
        |   expr_5 TOKEN_GT expr_4
        |   expr_5 TOKEN_GTE expr_4
        |   expr_5 TOKEN_LT expr_4
        |   expr_5 TOKEN_LTE expr_4
        |   expr_5 TOKEN_EQ expr_4
        |   expr_5 TOKEN_NOT_EQ expr_4
        ;

expr_6  :   expr_5
        |   expr_6 TOKEN_AND expr_5
        ;

expr_7  :   expr_6
        |   expr_7 TOKEN_OR expr_6
        ;

expr_8  :   expr_7
        |   expr_7 TOKEN_ASSIGN expr_8      // right to left
        |   expr_7 TOKEN_QMARK expr_8 TOKEN_COLON expr_8    // right to left
        ;

expr_main   :   expr_8   
            ;

expr_list   :  expr_main TOKEN_COMMA expr_list
            |   expr_main
            ;

expr_eps    :   expr_list
            |   /*epsilon*/
            ;

/*************
* STATEMENTS *
**************/

stmt_bunch  :   stmt stmt_bunch
            |   /*epsilon*/
            ;

stmt_braced :   TOKEN_LBRACE stmt_bunch TOKEN_RBRACE
            ;

expr_main_eps   :       expr_main
                |       /* epsilon */
                ;

stmt    :   unmatched_stmt
        |   matched_stmt
        ;

unmatched_stmt  :   TOKEN_IF TOKEN_LPAREN expr_main TOKEN_RPAREN stmt
                |   TOKEN_IF TOKEN_LPAREN expr_main TOKEN_RPAREN matched_stmt TOKEN_ELSE unmatched_stmt
                |   TOKEN_FOR TOKEN_LPAREN expr_main_eps TOKEN_SEMI expr_main_eps TOKEN_SEMI expr_main_eps TOKEN_RPAREN unmatched_stmt
                ;

matched_stmt    :   non_problem_stmt
                |   TOKEN_FOR TOKEN_LPAREN expr_main_eps TOKEN_SEMI expr_main_eps TOKEN_SEMI expr_main_eps TOKEN_RPAREN matched_stmt
                |   TOKEN_IF TOKEN_LPAREN expr_main TOKEN_RPAREN matched_stmt TOKEN_ELSE matched_stmt
                ;

non_problem_stmt    :   expr_main TOKEN_SEMI
                    |   TOKEN_RETURN expr_main TOKEN_SEMI
                    |   TOKEN_PRINT expr_eps TOKEN_SEMI
                    |   decl
                    |   stmt_braced
                    ;

/***************
* DECLARATIONS *
****************/

// for nested lists
expr_braced     :      TOKEN_LBRACE expr_braced TOKEN_RBRACE TOKEN_COMMA expr_braced
                |      TOKEN_LBRACE expr_braced TOKEN_RBRACE
                |      expr_list


decl    :   decl_start TOKEN_ASSIGN expr_main TOKEN_SEMI
        |   decl_start TOKEN_SEMI
        |   decl_start TOKEN_ASSIGN TOKEN_LBRACE expr_braced TOKEN_RBRACE TOKEN_SEMI 
        |   decl_start TOKEN_ASSIGN stmt_braced
        ;   

decl_start      :    id TOKEN_COLON type
                ;

type    :   TOKEN_STRING
        |   TOKEN_BOOLEAN
        |   TOKEN_AUTO
        |   TOKEN_INT
        |   TOKEN_CHAR
        |   TOKEN_VOID
        |   TOKEN_ARRAY TOKEN_LBRACKET expr_main TOKEN_RBRACKET type
        |   TOKEN_ARRAY TOKEN_LBRACKET TOKEN_RBRACKET type
        |   TOKEN_FUNCTION type TOKEN_LPAREN param_eps TOKEN_RPAREN
        ;

param_list  :   decl_start TOKEN_COMMA param_list
            |   decl_start
            ;

param_eps   :   param_list
            |   /* epsilon */
            ;
%%

int yyerror( char *str )
{
	printf("parse error: %s\n",str);
	return 0;
}