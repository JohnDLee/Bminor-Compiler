%{
#include "token.h"
%}

DIGIT [0-9]
LETTER [a-zA-Z]
ID [a-zA-Z_][a-zA-Z_0-9]*
    /* EACH KEYWORD IS ISOLATED***** FIX*/
KEYWORD array|auto|boolean|char|else|false|for|function|if|integer|print|return|string|true|void|while

%%

(" "|\t|\n|\r)      /* skip whitespace */



    /* Literals */
{DIGIT}+            { return TOKEN_INT; }
'[^']'              { return TOKEN_CHAR; }
\"([^\"])*\"           { return TOKEN_STR; }

    /* Special Characters */


    /* KEYWORDS + ID */
{KEYWORD}           { return TOKEN_KEYWORD; }
{ID}                { return TOKEN_ID; }

    /* default */
.                   { return TOKEN_ERROR; }

%%

int yywrap() { return 1; }
