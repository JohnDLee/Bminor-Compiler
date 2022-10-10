#include "bminor_helper.h"

int tokToString(token_t token, char* yytext) {

    // tokens
    switch (token) {
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
        case TOKEN_LPAREN:
            print1("PARENTHESIS_OPEN", yytext);
            break;
        case TOKEN_RPAREN:
            print1("PARENTHESIS_CLOSE", yytext);
            break;
        case TOKEN_LBRACKET:
            print1("BRACKET_OPEN", yytext);
            break;
        case TOKEN_RBRACKET:
            print1("BRACKET_OPEN", yytext);
            break;
        case TOKEN_LBRACE:
            print1("BRACE_OPEN", yytext);
            break;
        case TOKEN_RBRACE:
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
        case TOKEN_DIV:
            print1("DIVIDE", yytext);
            break;
        case TOKEN_MOD:
            print1("MODULUS", yytext);
            break;
        case TOKEN_PLUS:
            print1("PLUS", yytext);
            break;
        case TOKEN_MINUS:
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
        case TOKEN_SEMI:
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
            return 1;
            break;
        
        default:
            print1("OTHER", yytext);
            return 1;
    }
    return 0;
}

void print1(char* token_str, char* yytext) {
    printf("%20s | %s\n", token_str, yytext);
}

int scan() {
    // output token form
    printf("%20s | %-20s\n", "TOKEN", "VALUE");
    printf("-------------------------------------------\n");
    while(1) {
        token_t t = yylex();
        if(t==0) break; //! FIX
        if (tokToString(t, yytext) == 1) return 1;
    }
    return 0;
}

int parse(void) {

    if(yyparse()==0) {
		printf("Parse successful!\n");
		return 0;
	} else {
		printf("Parse failed.\n");
		return 1;
	}
}
