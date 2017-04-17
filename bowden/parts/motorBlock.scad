use <../lib/shapes.scad>
use <../lib/servo.scad>

module motorBlockA() {
	// 37 motors

	// right
	translate([-6, 0, 0])
	rotate([-90, 0, 0])
		motor37();

	// left
	translate([-44, 0, 0])
	rotate([-90, 0, 0])
		motor37();	

	// upper
	translate([-25, 0, 33])
	rotate([-90, 0, 0])
		motor37();		

	// lower
	translate([-25, 0, -33])
	rotate([-90, 0, 0])
		motor37();		

	// 25 motors

	translate([7, -4, 30])
	rotate([-90, 0, 0])
		motor25();
		
	translate([-57, -4, 30])
	rotate([-90, 0, 0])
		motor25();	

	translate([7, -4, -30])
	rotate([-90, 0, 0])
		motor25();
		
	translate([-57, -4, -30])
	rotate([-90, 0, 0])
		motor25();
}

module motorBlockB() {
	// right
	translate([-11, 0, 0])
	rotate([-90, 0, 0])
		motor25();

	// left
	translate([-39, 0, 0])
	rotate([-90, 0, 0])
		motor25();	

	// upper
	translate([-25, 0, 25])
	rotate([-90, 0, 0])
		motor25();		

	// lower
	translate([-25, 0, -25])
	rotate([-90, 0, 0])
		motor25();		

	translate([2, 0, 25])
	rotate([-90, 0, 0])
		motor25();
		
	translate([-52, 0, 25])
	rotate([-90, 0, 0])
		motor25();	

	translate([2, 0, -25])
	rotate([-90, 0, 0])
		motor25();
		
	translate([-52, 0, -25])
	rotate([-90, 0, 0])
		motor25();	
}