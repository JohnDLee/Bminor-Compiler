x: integer = 65;
s: string = "hello";
b: boolean = false;
min: function integer (a: integer, b: integer) = {
    if (a<b) {
        return a;
    } else {
        return b;
    }
}
testfunc: function void (z: integer) = {
    y: integer = x*(x*10+55%6+z/10);
    print "y: ", y, "\n";
    c: boolean = x<100&&y>200||!b=true;
    print "c: ", c, "\n";
    d: boolean = s=="goodbye";
    print "d: ", d, "\n";
    z=y=x;
    a: array [100] integer;
    y=min(a[10], a[20]);
    q: boolean = z<10?true:false;
    r: boolean = z>10?min(a[10], a[20]):min(a[20], a[10]);
}
