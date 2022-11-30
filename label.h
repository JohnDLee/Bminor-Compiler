#ifndef INCLUDE_H
#define INCLUDE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// create a label
int label_create();
// return label name from label_id
const char* label_name(const char* pre, int l);

#endif
