#include "label.h"

static int cur_label = -1;

int label_create() {
    return ++cur_label;
}

const char* label_name(const char* pre, int l) {
    char str[100];
    sprintf(str, ".%sL%d",pre, l);
    return strdup(str);
}