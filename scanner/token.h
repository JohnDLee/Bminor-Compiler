#ifndef TOKEN
#define TOKEN

typedef enum {
    TOKEN_EOF=0,
    // keywords
    TOKEN_ARRAY,
    TOKEN_AUTO,
    TOKEN_BOOLEAN,
    TOKEN_CHAR,
    TOKEN_ELSE,
    TOKEN_IF,
    TOKEN_FALSE,
    TOKEN_TRUE,
    TOKEN_FOR,
    TOKEN_FUNCTION,
    TOKEN_INT,
    TOKEN_PRINT,
    TOKEN_RETURN,
    TOKEN_STRING,
    TOKEN_VOID,
    TOKEN_WHILE,

    // Identifier
    TOKEN_ID,

    // expression/symbols
    TOKEN_RPAREN,
    TOKEN_LPAREN,
    TOKEN_RBRACKET,
    TOKEN_LBRACKET,
    TOKEN_RBRACE,
    TOKEN_LBRACE,
    TOKEN_INCREMENT,
    TOKEN_DECREMENT,
    TOKEN_NOT,
    TOKEN_EXPONENT,
    TOKEN_MULT,
    TOKEN_DIV,
    TOKEN_MOD,
    TOKEN_PLUS,
    TOKEN_MINUS,
    TOKEN_GT,
    TOKEN_LT,
    TOKEN_GTE,
    TOKEN_LTE,
    TOKEN_EQ,
    TOKEN_NOT_EQ,
    TOKEN_ASSIGN,
    TOKEN_COMMA,
    TOKEN_COLON,
    TOKEN_SEMI,
    TOKEN_AND,
    TOKEN_OR,
    TOKEN_QMARK,

    //literals
    TOKEN_STR_LIT,
    TOKEN_CHAR_LIT,
    TOKEN_INT_LIT,
    TOKEN_ERROR
} token_t;

void fixString(char*);

#endif