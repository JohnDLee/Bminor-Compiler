simplefunc: function void (r: integer, s: integer, t: integer) = {
    i: integer;
    for (i=0;i<r;i++) {
        print i, "\n";
    }
    i=0;
    for (;i<s;i++) {
        print i, "\n";
    }
    i=0;
    for (;i<r;) {
        print i, "\n";
        i++;
    }
    for (;;) {
        print "forever!\n";
    }
}
