%{
#include "token.h"
%}



DIGIT [0-9]
LETTER [a-zA-Z]
ID [a-zA-Z_][a-zA-Z_0-9]{0,254}

%%

(" "|\t|\n|\r)      /* skip whitespace */


    /* Literals */
(-|\+)?{DIGIT}+                 { return TOKEN_INT_LIT; }
'([^\\'\n]|\\.)'                { fixString(yytext);  
                                  return TOKEN_CHAR_LIT; }
\"([^\\\"\n]|\\.){0,255}\"      { fixString(yytext);  
                                  return TOKEN_STR_LIT; }

    /* Comments */
\/\/[^\n]*                          /* skip C Comment */
\/\*(([^\*])|(\*+[^\/\*]))*\*+\/    /* skip C++ Comment */
\/\*([^\*]|(\*+[^\/\*]))*(\*+)?     { fprintf(stderr, "scan error> Comment was not closed.\n");
                                     return TOKEN_ERROR; }
    
    /* Expression Symbols */
\(                  { return TOKEN_PARENTHESIS_OPEN; }
\)                  { return TOKEN_PARENTHESIS_CLOSE; }
\[                  { return TOKEN_BRACKET_OPEN; }
\]                  { return TOKEN_BRACKET_CLOSE; }
\{                  { return TOKEN_BRACE_OPEN; }
\}                  { return TOKEN_BRACE_CLOSE; }
\+\+                { return TOKEN_INCREMENT; }
--                  { return TOKEN_DECREMENT; }
\^                  { return TOKEN_EXPONENT; }
\*                  { return TOKEN_MULT; }
\/                  { return TOKEN_DIVIDE; }
%                   { return TOKEN_MODULUS; }
\+                  { return TOKEN_ADD; }
-                   { return TOKEN_SUB; }
>=                  { return TOKEN_GTE; }
\<=                 { return TOKEN_LTE; }
==                  { return TOKEN_EQ; }
!=                  { return TOKEN_NOT_EQ; }
>                   { return TOKEN_GT; }
\<                  { return TOKEN_LT; }
!                   { return TOKEN_NOT; }
=                   { return TOKEN_ASSIGN; }
,                   { return TOKEN_COMMA; }
:                   { return TOKEN_COLON; }
;                   { return TOKEN_SEMICOLON; }
\|\|                { return TOKEN_OR; }
&&                  { return TOKEN_AND; }


    /* KEYWORDS + ID */
array               { return TOKEN_ARRAY; }
auto                { return TOKEN_AUTO; }
boolean             { return TOKEN_BOOLEAN; }
char                { return TOKEN_CHAR; }
else                { return TOKEN_ELSE; }
false               { return TOKEN_FALSE; }
for                 { return TOKEN_FOR; }
function            { return TOKEN_FUNCTION; }
if                  { return TOKEN_IF; }
integer             { return TOKEN_INT; }
print               { return TOKEN_PRINT; }
return              { return TOKEN_RETURN; }
string              { return TOKEN_STRING; }
true                { return TOKEN_TRUE; }
void                { return TOKEN_VOID; }
while               { return TOKEN_WHILE; }

{ID}                { return TOKEN_ID; }

    /* default */
.                   { return TOKEN_ERROR; }

%%

int yywrap() { return 1; }

void fixString(char* yytext) {
    /* Fixes string/character form */
    char* src = yytext;
    char* dest = yytext;
    // remove first "
    src++;
    // check for null. shift src to destination. 
    while (*src != '\0') {
        
        // if \ is encountered, determine next char
        if (*src == '\\') {
            *src++;
            switch (*src)
            {
            case 'n':
                *dest = '\n';
                break;
            case '0':
                *dest = '\0';
                break;
            default:
                *dest = *src;
                break;
            }
        } else {
            *dest = *src;
        }
        src++;
        dest++;
    }
    // remove last "
    *dest--;
    *dest = '\0';
}