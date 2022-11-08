testfunc: function void (x: integer, y: integer, z: integer) = {
    r: integer;
    b: boolean;
    r=(x+y)/z;
    r=x+(y+z);
    b=(true||false)&&(false||true);
    r=x+y/z;
    r=x+y+z;
    b=x+y<x+z;
    b=true&&false||false&&true;
}
