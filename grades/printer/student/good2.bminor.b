testfunc: function void (x: integer, y: integer, z: integer) = {
    r: integer;
    b: boolean;
    r=x++++;
    r=x++++;
    r=f(x);
    r=f(x=1, y=2);
    r=x++[x++];
    r=(x+y)[x++];
    r=a[x++][x++];
    r=f(x, y);
    r=e^3^4;
    r=(e^3)^4;
    r=e^3^4;
}
