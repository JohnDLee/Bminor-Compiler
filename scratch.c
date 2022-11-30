#include "scratch.h"

static int reg_free_map[] = {1,1,1,1,1,1,1};
static int NUM_REGS = 7;



// allocate a free register
int scratch_alloc(void) {
    int reg;
    for (reg = 0; reg < NUM_REGS; reg++) {
        if (reg_free_map[reg] == 1) {
            reg_free_map[reg] = 0; // take up the space
            return reg;
        }
    }

    // ! What happens if there are no free registers
    // Temporary.
    fprintf(stderr, "codegen error> There are no free registers left.\n");
    exit(1);
    return -1;
}

// free the particular reg
void scratch_free(int r) {
    if (r < 0 || r > NUM_REGS) {
        // not a valid reg
        fprintf(stderr, "codegen error> Attempted to free a register outside of known registers.\n");
        exit(1);
    }
    reg_free_map[r] = 1;
}

// get name of register
const char* scratch_name(int r) {
    if (r < 0 || r > NUM_REGS) {
        // not a valid reg
        fprintf(stderr, "codegen error> Attempted to get name of a register outside of known registers.\n");
        exit(1);
    }
    if (r == 0) {
        return "rbx";
    } else {
        char str[4];
        sprintf(str, "r%d", r + 9);
        return strdup(str);
    }
}
