#ifndef BMINOR_HELPER
#define BMINOR_HELPER


#include "parser/token.h"
#include <stdio.h>

// typedef tokens
typedef enum yytokentype token_t;

// extern necessary globals
extern FILE *yyin;
extern int yylex();
extern char *yytext;


/* scanner funcs */
// Converts tokens to strings
int tokToString(token_t token, char* yytext);
// printformatting
void print1(char* token_str, char* yytext);
int scan(void);

/* parser funcs */
int parse(void);

#endif