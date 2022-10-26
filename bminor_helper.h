#ifndef BMINOR_HELPER
#define BMINOR_HELPER

#include "decl.h"
#include "expr.h"
#include "param_list.h"
#include "stmt.h"
#include "type.h"
#include "symbol.h"

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
// Converts tokens to strings
int tokToString(token_t token, char* yytext);
// printformatting
void print1(char* token_str, char* yytext);
int scan(void);

/* parser funcs */
int parse(void);

#endif