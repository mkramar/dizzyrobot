include <body-print.scad>

$fn = 100;

translate([5, 5, heapBackBearingOffset])
cylinder(d = 3, h = 20);

rotate([0, -90, 0])
difference() {
	union()
	{
		difference()
		{
			popa();
			cutA();
			//cube([100, 100, 100]);
		}
		
		intersection()
		{
			popaBase(true);
			union()
			{
				boltsAplus();
				boltsBplus();
			}
		}
	}
	boltsAminus();
	boltsBminus();
}