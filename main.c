#include "bminor_helper.h"
#include <stdio.h>
#include <string.h>


// #ifdef YYDEBUG
//   yydebug = 1
//   ;
// #endif


int main(int argc, char* argv[]){
    
    if (argc != 3) {
        fprintf(stderr, "bminor> invalid input: incorrect number of arguments\nusage:\n\t./bminor -parse <program.bminor>\n");
        return 1;
    }

    yyin = fopen(argv[2], "r");
    if(!yyin) {
        fprintf(stderr, "bminor> could not open %s!\n", argv[2]);
        return 1;
    }

    if (strcmp(argv[1], "-parse") == 0) {
        return parse();
    }
    else if (strcmp(argv[1], "-scan") == 0) {
        return scan();
    }
    else {
        fprintf(stderr, "bminor> you must provide one of (-parse, -scan) as a flag\n");
        return 1;
    }




}