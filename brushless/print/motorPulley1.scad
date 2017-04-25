include <../_sizes.scad>
use <../_shared.scad>
use <../../lib/pulley.scad>
use <../../lib/bolt.scad>

difference() {
	pulley(teeth=38, height = belt, center = true);
	
	cylinder(d = 4.5, h = 20, center = true, $fn = 20);
	
	translate([6, 0, -4])
		boltaMinus();
		
	translate([-6, 0, -4])
		boltaMinus();
		
	translate([0, 6, -4])
		boltaMinus();
		
	translate([0, -6, -4])
		boltaMinus();				
}
