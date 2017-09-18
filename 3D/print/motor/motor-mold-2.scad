include <../../parts/motor.scad>

$fn = 50;

difference(){
	translate([-25, -15, -10 + 0.01])
		cube([50, 30, 10]);
		

	translate([4, 0, -20])
		cylinder(d = 2, h = 30);		
}

translate([0, 3.25, -0.01])
	sphere(d = 5.2);
	
translate([0, -3.25, -0.01])
	sphere(d = 5.2);

translate([18, 0, 0])
	sphere(d = 11);
	
translate([-18, 0, 0])
	sphere(d = 11);
