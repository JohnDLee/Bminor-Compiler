a: array [10] integer = {100, 200, 300, 400, 500, 600, 700, 800, 900};
b: array [10] integer;
c: array [10] array [10] integer;
testfunc: function void () = {
    i: integer;
    j: integer;
    for (i=0;i<10;i++) {
        b[i]=a[i]*10;
    }
    for (i=0;i<5;i++) {
        b[i*2]=a[i]+b[i];
    }
    for (j=0;j<10;i++) {
        for (i=0;i<10;i++) {
            c[i][j]=i*j;
        }
    }
    for (j=0;j<10;i++) {
        for (i=0;i<10;i++) {
            print c[i][j];
            print " ";
        }
        print "\n";
    }
}
