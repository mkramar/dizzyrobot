use <../lib/shapes.scad>
include <../_sizes.scad>
include <../_shared.scad>

x1 = 30;
x2 = 40;
z1 = 20;
d1 = 20;
h1 = hs + 15;
h2 = hs + 8;

module part3() {
	difference() {
		part3plus();

		rotate([0, 90, 0])
			cylinder(d = is + 1, h = hs + 1, center = true);
			
		// empty space for the bone rotation
		
		hull()
		{
			rotate([70, 0, 0])
			translate([1, 0, h])
				bone2();
				
			rotate([-70, 0, 0])
			translate([1, 0, h])
				bone2();

			rotate([70, 0, 0])
			translate([-1, 0, h])
				bone2();
				
			rotate([-70, 0, 0])
			translate([-1, 0, h])
				bone2();	
		}
		
		// ball bearing spacing
		
		union()
		{
			translate([hs/2, 0, 0])
			rotate([0, 90, 0])
				torus(d = is - 2, w = 4, $fn = 50);
				
			translate([-hs/2, 0, 0])
			rotate([0, 90, 0])
				torus(d = is - 2, w = 4, $fn = 50);	
		}
		
		// this is the main cavity
		
		difference()
		{
			union()
			{
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
			
			// ball bearing support
			
			union()
			{
				translate([hs/2, 0, 0])
				rotate([0, 90, 0])
					ring(d = is - 1, h = 8, t = 5);
					
				translate([-hs/2, 0, 0])
				rotate([0, 90, 0])
					ring(d = is - 1, h = 8, t = 5);
			}			
		}
		
		// board spacing
		
		rotate([0, 90, 0])
		{
			translate([-boardSize/2, -boardSize/2, 12])
				cube([boardSize, boardSize, 5]);
				
			translate([0, 0, 10])
				cylinder(d = 22, h = 10, center = true);
		}
		
		union()
		{
			translate([0, cableOffset, 0])
			rotate([cableAngle, 0, 0])
				cylinder(h = 35, d = 2, center = true, $fn = 8);
			
			translate([0, -cableOffset, 0])
			rotate([-cableAngle, 0, 0])
				cylinder(h = 35, d = 2, center = true, $fn = 8);			
		}
		
		//
		
		//translate([0, -50, -50]) cube([50, 50, 50]);
	}

	//#translate([18, 0, 0])
	//color("white")
	//rotate([0, -90, 0])
	//	boardJoint();
}

module part3plus() {
	rotate([0, 90, 0])	
		shayba(d = is + 8 + 1, h = h2, rd = 6);

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

module twoSphere(d = 20, h = 30){
	translate([d / 2, 0, 0])
	hull()
	{
		sphere(d=d);

		translate([h - d, 0, 0])
			sphere(d=d);
	}
}