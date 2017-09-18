include <../../parts/motor.scad>

$fn = 50;

difference(){
	translate([-25, -15, 0.01])
		cube([50, 30, 12]);
		
	cylinder(d1 = 18.5, d2 = 5.5, h = 6.5);
	
	translate([0, 0, 6.5 - 0.01])
		dCylinder(15, 4.5, 0.8, false);

	
	//translate([0, 0, 11])
	//	cylinder(d1 = 2, d2 = 15, h = 10);
	
	cylinder(d1 = 18, d2 = 5, h = 6.5);	
	
	translate([18, 0, 0])
		sphere(d = 12);
		
	translate([-18, 0, 0])
		sphere(d = 12);
}