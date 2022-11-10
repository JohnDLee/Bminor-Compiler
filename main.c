#include "bminor_helper.h"

#include <stdio.h>
#include <string.h>


// #ifdef YYDEBUG
//   yydebug = 1
//   ;
// #endif


int main(int argc, char* argv[]){
    
    if (argc != 3) {
        fprintf(stderr, "bminor> invalid input: incorrect number of arguments\nusage:\n\t./bminor -<scan|parse|print|resolve|typecheck> <program.bminor>\n");
        return 1;
    }

    yyin = fopen(argv[2], "r");
    if(!yyin) {
        fprintf(stderr, "bminor> could not open %s!\n", argv[2]);
        return 1;
    }

    // scanning
    if (strcmp(argv[1], "-scan") == 0) {
            return scan();
        }
    // parsing
    else if (strcmp(argv[1], "-parse") == 0) {
        return parse();
    }
    // printing
    else if (strcmp(argv[1], "-print") == 0) {
        return pprint();
    } 
    // name resolution
    else if (strcmp(argv[1], "-resolve") == 0) {
        return resolve();
    }
    // type check
    else if (strcmp(argv[1], "-typecheck") == 0) {
        return typecheck();
    }
    else {
        fprintf(stderr, "bminor> you must provide one of (-print, -parse, -scan) as a flag\n");
        return 1;
    }

}