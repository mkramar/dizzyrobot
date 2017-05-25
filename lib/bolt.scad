// difference()
// {
    // bolta();
    // #boltaMinus();
// }

// translate([0, 0, -3])
// difference()
// {
    // boltb();
    // #boltbMinus();
// }

module bolta()
{
    cylinder(h = 4.5, d = 7);
}

module boltaMinus(h = 15)
{
    translate([0, 0, -1])
    cylinder(h = 7, d = 3.5, $fn = 15);
    
    translate([0, 0, 4.5])
		cylinder(h = h, d = 7, $fn = 15);
}

module boltb()
{
    translate([0, 0, -4.5])
		cylinder(h = 4.5, d = 15);
}

module boltbMinus()
{
    rotate([180, 0, 0])
    {
        translate([0, 0, -1])
            cylinder(h = 7, d = 3.5, $fn = 10);

        translate([0, 0, 4.5])
            cylinder(h = 35, d = 7, $fn = 6);    
    }
}