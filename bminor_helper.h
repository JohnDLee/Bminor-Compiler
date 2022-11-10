#ifndef BMINOR_HELPER
#define BMINOR_HELPER

#include "decl.h"
#include "expr.h"
#include "param_list.h"
#include "stmt.h"
#include "type.h"
#include "symbol.h"
#include "scope.h"

#include "token.h"
#include <stdio.h>

// typedef tokens
typedef enum yytokentype token_t;

// extern necessary globals
extern FILE *yyin;
extern int yylex();
extern char *yytext;
extern struct decl * ast_head;


/* scanner funcs */
int scan(void);
// Converts tokens to strings
int tokToString(token_t token, char* yytext);
// printformatting
void print1(char* token_str, char* yytext);


/* parser funcs */
int parse(void);

/* pretty printer funcs */
int pprint(void);
// indent output by indent
void indent_line(int indent);

/* resolve funcs */
int resolve(void);
extern int resolve_err;

/* typecheck funcs */
int typecheck(void);
extern int type_err;


#endif