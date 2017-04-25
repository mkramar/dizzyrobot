include <../_sizes.scad>
use <../_shared.scad>
use <../../lib/pulley.scad>
use <../../lib/bolt.scad>

difference() {
	union()
	{
		translate([0, 0, -4.5])
		cylinder(d = 25, h = 2, center = true);
		pulley(teeth=25, height = belt, center = true);
	}
	
	cylinder(d = 4.5, h = 20, center = true, $fn = 20);	
}