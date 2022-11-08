testit: function boolean (x: integer, y: integer) = {
    if (x<y) {
        print "less\n";
    } else {
        print "low\n";
    }
    if (x<y) {
        print "less\n";
    } else {
        print "low\n";
    }
    if (20<10) {
        if (10<20) {
            print "incorrect!";
        } else {
            print "dangling else!";
        }
    }
    if (x>y) {
        i: integer;
        for (i=0;i<x;i++) {
            print i, "\n";
        }
    } else {
        i: integer;
        for (i=0;i<y;i++) {
            print i, "\n";
        }
    }
    i: integer;
    for (i=0;i<x;i++) {
        if (i<x) {
            print "small";
        } else {
            print "large";
        }
    }
    return true;
}
