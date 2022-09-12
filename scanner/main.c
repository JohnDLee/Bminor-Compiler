

#include "token.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE *yyin;
extern int yylex();
extern char *yytext;


char * tokToString(token_t token, char* yytext);
void print1(char* token_str, char* yytext);


int main(int argc, char* argv[] ) {

    if (argc > 3) {
        fprintf(stderr, "bminor> invalid input: too many arguments\nusage:\n\t./bminor -scan <program.bminor>\n");
        return 1;
    }
    if (strcmp(argv[1], "-scan") != 0) {
        fprintf(stderr, "bminor> you must provide -scan as a flag\n");
        return 1;
    }


    yyin = fopen(argv[2],"r");
    if(!yyin) {
        fprintf(stderr, "bminor> could not open %s!\n", argv[2]);
        return 1;
    }

    // output token form
    printf("%20s | %-20s\n", "TOKEN", "VALUE");
    printf("-------------------------------------------\n");
    while(1) {
        token_t t = yylex();
        if(t==TOKEN_EOF) break;
        tokToString(t, yytext);
    }
}


char * tokToString(token_t token, char* yytext) {

    // tokens
    switch (token) {
        case TOKEN_EOF:
            break;
        // keywords
        case TOKEN_ARRAY:
            print1("ARRAY", yytext);
            break;
        case TOKEN_AUTO:
            print1("AUTO", yytext);
            break;
        case TOKEN_BOOLEAN:
            print1("BOOLEAN", yytext);
            break;
        case TOKEN_CHAR:
            print1("CHAR", yytext);
            break;
        case TOKEN_ELSE:
            print1("ELSE", yytext);
            break;
        case TOKEN_FALSE:
            print1("FALSE", yytext);
            break;
        case TOKEN_FOR:
            print1("FOR", yytext);
            break;
        case TOKEN_FUNCTION:
            print1("FUNCTION", yytext);
            break;
        case TOKEN_IF:
            print1("IF", yytext);
            break;
        case TOKEN_INT:
            print1("INTEGER", yytext);
            break;
        case TOKEN_PRINT:
            print1("PRINT", yytext);
            break;
        case TOKEN_RETURN:
            print1("RETURN", yytext);
            break;
        case TOKEN_STRING:
            print1("STRING", yytext);
            break;
        case TOKEN_TRUE:
            print1("TRUE", yytext);
            break;
        case TOKEN_VOID:
            print1("VOID", yytext);
            break;
        case TOKEN_WHILE:
            print1("WHILE", yytext);
            break;
        // expression/symbol:
        case TOKEN_PARENTHESIS_OPEN:
            print1("PARENTHESIS_OPEN", yytext);
            break;
        case TOKEN_PARENTHESIS_CLOSE:
            print1("PARENTHESIS_CLOSE", yytext);
            break;
        case TOKEN_BRACKET_OPEN:
            print1("BRACKET_OPEN", yytext);
            break;
        case TOKEN_BRACKET_CLOSE:
            print1("BRACKET_OPEN", yytext);
            break;
        case TOKEN_BRACE_OPEN:
            print1("BRACE_OPEN", yytext);
            break;
        case TOKEN_BRACE_CLOSE:
            print1("BRACE_CLOSE", yytext);
            break;
        case TOKEN_INCREMENT:
            print1("INCREMENT", yytext);
            break;
        case TOKEN_DECREMENT:
            print1("DECREMENT", yytext);
            break;
        case TOKEN_NOT:
            print1("NOT", yytext);
            break;
        case TOKEN_EXPONENT:
            print1("EXPONENTIATION", yytext);
            break;
        case TOKEN_MULT:
            print1("MULTIPLY", yytext);
            break;
        case TOKEN_DIVIDE:
            print1("DIVIDE", yytext);
            break;
        case TOKEN_MODULUS:
            print1("MODULUS", yytext);
            break;
        case TOKEN_ADD:
            print1("ADD", yytext);
            break;
        case TOKEN_SUB:
            print1("SUBTRACT", yytext);
            break;
        case TOKEN_GT:
            print1("GT", yytext);
            break;
        case TOKEN_LT:
            print1("LT", yytext);
            break;
        case TOKEN_GTE:
            print1("GTE", yytext);
            break;
        case TOKEN_LTE:
            print1("LTE", yytext);
            break;
        case TOKEN_EQ:
            print1("EQ", yytext);
            break;
        case TOKEN_NOT_EQ:
            print1("NOT_EQ", yytext);
            break;
        case TOKEN_ASSIGN:
            print1("ASSIGN", yytext);
            break;
        case TOKEN_COMMA:
            print1("COMMA", yytext);
            break;
        case TOKEN_SEMICOLON:
            print1("SEMICOLON", yytext);
            break;
        case TOKEN_COLON:
            print1("COLON", yytext);
            break;
        case TOKEN_AND:
            print1("AND", yytext);
            break;
        case TOKEN_OR:
            print1("OR", yytext);
            break;
        // identifier
        case TOKEN_ID:
            print1("IDENTIFIER", yytext);
            break;
        // literals
        case TOKEN_STR_LIT:
            print1("STRING_LITERAL", yytext);
            break;
        case TOKEN_CHAR_LIT:
            print1("CHARACTER_LITERAL", yytext);
            break;
        case TOKEN_INT_LIT:
            print1("INTEGER_LITERAL", yytext);
            break;
        case TOKEN_ERROR:
            fprintf(stderr, "scan error> %s is not a valid token\n", yytext);
            exit(1);
            break;
        
        default:
            return "OTHER";
    }
}

void print1(char* token_str, char* yytext) {
    printf("%20s | %s\n", token_str, yytext);
}
