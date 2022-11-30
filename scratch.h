#ifndef SCRATCH_H
#define SCRATCH_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// allocate a free register
int scratch_alloc(void);
// free the particular reg
void scratch_free(int r);
// get name of register
const char* scratch_name(int r);


#endif