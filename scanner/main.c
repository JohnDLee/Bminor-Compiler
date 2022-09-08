

#include "token.h"
#include <stdio.h>
extern FILE *yyin;
extern int yylex();
extern char *yytext;


char * strtok(token_t token);

int main(int argc, char* argv[] ) {

    if (argc > 2) {
        fprintf(stderr, "bminor> invalid input: too many arguments\nusage:\n\t./bminor <program.bminor>\n");
        return 1;
    }
    yyin = fopen(argv[1],"r");
    if(!yyin) {
        printf("could not open program.c!\n");
        return 1;
    }

    // output token form
    printf("%20s | %-20s\n", "TOKEN", "VALUE");
    printf("-------------------------------------------\n");
    while(1) {
        token_t t = yylex();
        if(t==TOKEN_EOF) break;
            printf("%20s | %s\n", strtok(t),yytext);
    }
}


char * strtok(token_t token) {
    // tokens
    switch (token) {
        case TOKEN_EOF:
            return "TOKEN_EOF";
        case TOKEN_ERROR:
            return "TOKEN_ERROR";
        
        default:
            return "OTHER";
    }
}