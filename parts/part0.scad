use <../lib/shapes.scad>
include <../_sizes.scad>
include <../_shared.scad>

module part0(){
	part0_1();
	part0_2();
}

module part0_1(){
	db = bodyBearingDiam;

	difference()
	{
		union()
		{
			rotate([0, -90, 0])
			{
				// bearing joining to body
				
				difference()
				{
					cylinder(h = 8, d = db, center = true, $fn = 50);
					torus(d = db + 1, w = ball, $fn = 50);
				}
				
				translate([0, 0, 5])
					ring(h = 5, d = com01JointD - (cd1 + 4), t = cd1 + 4);
			}

			translate(part1Off)
			difference()
			{
				union()
				{
					rotate([0, 0,90])
						com01JointOuter();		

					// pull
			
					 rotate([0, -90, 0])
					 translate([com01JointD / 2, 0, 0])
						 cylinder(h = 35, d = cd1 + 4, $fn = 15);					
				}
				
				// opening for the bone
				
				hull()
				{
					rotate([0, -part0angle1, 0])
						bone1Plus(inflate = 2);
					
					rotate([0, (-part0angle1-part0angle2)/2, 0])
						bone1Plus(inflate = 2);
				}

				hull()
				{
					rotate([0, (-part0angle1-part0angle2)/2, 0])
						bone1Plus(inflate = 2);
					
					rotate([0, -part0angle2, 0])
						bone1Plus(inflate = 2);
				}
			}
		}
		
		// space for part1
		
		translate(part1Off)
		rotate([0, 0, 90])
		union()
		{
			com01JointInner(inflate = 2);
			com01JointInnerMinus3();
			//com01JointInnerMinus4a();
			com01JointInnerMinus4b();
		}		

		//translate([-30, 0, -h/2]) cube([60, 50, h + 50]);
		//cube([60, 50, 50]);
		
		// communication opening into part1
		
		hull()
		{
			translate([0, 6, 12])
			rotate([0, 90, 0])
				cylinder(h = 20, d = 5, center = true);

			translate([0, 6, -12])
			rotate([0, 90, 0])
				cylinder(h = 20, d = 5, center = true);
		}

		hull()
		{
			translate([0, -6, 12])
			rotate([0, 90, 0])
				cylinder(h = 20, d = 5, center = true);

			translate([0, -6, -12])
			rotate([0, 90, 0])
				cylinder(h = 20, d = 5, center = true);
		}
		
		// cable attachment ring
		
		rotate([0, -90, 0])
		translate([0, 0, 5])
			torus(d = com01JointD + (cd1 + 4), w = cd2, $fn = 50);
			
		// pull spacing
		
		translate(part1Off)
		rotate([0, -90, 0])
		{
			translate([com01JointD / 2, 0, 0])
				cylinder(h = 55, d = cd2, $fn = 10);
				
			translate([com01JointD / 2, 0, 28])
				cylinder(h = 10, d = cd1, $fn = 10);		
		}
			
		translate(part1Off)
		rotate([0, -90, 0])
		{
			translate([-com01JointD / 2, 0, 28])
				cylinder(h = 10, d = cd1, $fn = 10);	
		
			translate([-com01JointD / 2, 0, 0])
				cylinder(h = 35, d = cd2, $fn = 10);		
		}
	}
	
	// rotation sensor axis
	
	translate([0, com01JointH/2, 0])
	translate(part1Off)
	rotate([90, 0, 0])
		dCylinder(h = 5, d = 4, x = 1, $fn = 20);
}

module part0_2() {
}