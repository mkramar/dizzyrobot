use <../lib/shapes.scad>
include <../_sizes.scad>
include <../_shared.scad>
use <common23.scad>

x1 = 35;
x2 = 45;
z1 = 25;
d1 = 20;
h1 = com23JointH + 20;
h2 = com23JointH + 15;

h3 = com23JointD + th * 2 + 3;

module part3() {
	difference() {
		part3plus();
		
		rotate([0, 90, 0])	
			shayba(d = com23JointD - th * 2, h = com23JointH - th * 2, rd=8);		
		
		rotate([0, 90, 0])
			cylinder(h = 10, d = 15);
			
		com23BearingSpacing();
		
		// space for rotation sensor
		
		translate([-com12JointH / 2, 0, 0])
		rotate([0, 90, 0])		
			rotationSensorSpacing();
			
			
		//translate([com12JointH / 2, 0, 0])
		//rotate([180, 0, 0])
		//rotate([0, -90, 0])
		//	rotationSensorSpacing();			
			
/*		
		// ball bearing spacing
		
		union()
		{
			translate([com23JointH/2, 0, 0])
			rotate([0, 90, 0])
				torus(d = com23JointD - 6, w = 5.5, $fn = 50);
				
			translate([-com23JointH/2, 0, 0])
			rotate([0, 90, 0])
				torus(d = com23JointD - 6, w = 5.5, $fn = 50);	
		}
*/
		// opening up
		
		translate([-4, 0, 0])
		hull()
		{
			rotate([-45, 0, 0]) cylinder(d = 4, h = 30, $fn = 15);
			rotate([45, 0, 0]) cylinder(d = 4, h = 30, $fn = 15);
		}
		
		com23openingDownMinus();
		
		translate([-com23CableOffset, 0, 0])
		rotate([0, 90, 0])
			ringDiamond(d = com23JointD, h = 2);
		
		//
		
		//translate([0, -50, -50]) cube([50, 50, 150]);
	}
}

module part3plus() {
	rotate([0, 90, 0])	
		shayba(d = com23JointD, h = com23JointH, rd=5, $fn = 50);

	difference()
	{
		footPlus();
		footMinus();
				
		rotate([0, 90, 0])
			cylinder(d = h3, h = 50, center = true);
	}
	
	intersection()
	{
		footPlus();
		
		rotate([0, 90, 0])
			ring(d = h3, h = 50, t = th);
	}
	
	com23openingDownPlus	();
}

module footPlus() {
	// rear part
	
	hull()
	{
		translate([-h1 / 2, -x1, -z1])
			twoSphere(d = d1, h = h1);
	
		translate([-h2 / 2, 0, -z1 + 4])
			twoSphere(d = d1, h = h2);
	}
	
	// front part
	
	hull()
	{
		translate([-h1 / 2, x2, -z1])
			twoSphere(d = d1, h = h1);
		
		translate([-h2 / 2, 0, -z1 + 4])
			twoSphere(d = d1, h = h2);
	}
}

module footMinus() {
	// rear part
	
	hull()
	{
		translate([-h1 / 2 + th, -x1, -z1])
			twoSphere(d = d1 - th * 2, h = h1 - th*2);
	
		translate([-h2 / 2 + th, 0, -z1 + 4])
			twoSphere(d = d1 - th * 2, h = h2 - th * 2);
	}

	// front part
	
	hull()
	{
		translate([-h1 / 2 + th, x2, -z1])
			twoSphere(d = d1 - th * 2, h = h1 - th*2);
		
		translate([-h2 / 2 + th, 0, -z1 + 4])
			twoSphere(d = d1 - th * 2, h = h2 - th * 2);
	}
}

module twoSphere(d = 20, h = 30){
	translate([d / 2, 0, 0])
	hull()
	{
		sphere(d=d);

		translate([h - d, 0, 0])
			sphere(d=d);
	}
}