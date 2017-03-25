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
				// bearing
				difference()
				{
					shayba(h = 6, d = db, rd=3, $fn = 50);
					torus(d = db + 1, w = 5, $fn = 50);
				}
				
				translate([0, 0, 5])
					ring(h = 5, d = i1 - (cd1 + 4), t = cd1 + 4);
			}

			translate(part1Off)
			difference()
			{
				union()
				{
					rotate([0, 0,90])
						bigBall();		

					// pull
			
					 rotate([0, -90, 0])
					 translate([i1 / 2, 0, 0])
						 cylinder(h = 35, d = cd1 + 4, $fn = 15);	
						
					//rotate([0, -90, 0])
					//translate([-i1 / 2, 0, 10])
					//	cylinder(h = 10, d = cd1 + 4, $fn = 15);							
				}
				
				// space for the bone
				hull()
				{
					rotate([0, -part0angle1, 0])
					{
						translate([0, -1, 0])
							bone1();
							
						translate([0, 1, 0])
							bone1();
					}
					
					rotate([0, -part0angle2, 0])
					{
						translate([0, -1, 0])
							bone1();            
							
						translate([0, 1, 0])
							bone1();            
					}
				}		
			}
		}
		
		// space to connect with part1
		
		translate(part1Off)
		rotate([0, 0, 90])
		union()
		{
			smallBall(inflate = 2);
			smallBallMinus3();
			//smallBallMinus4a();
			smallBallMinus4b();
		}		

		translate([-30, 0, -h/2]) cube([60, 50, h + 50]);
		//cube([60, 50, 50]);		

		rotate([0, -90, 0])
		translate([0, 0, 4])
			ring(h = 2, d = i1 + (cd1 + 4) - 3, t = 2);
			
		// pull spacing
		
		translate(part1Off)
		rotate([0, -90, 0])
		{
			translate([i1 / 2, 0, 0])
				cylinder(h = 55, d = cd2, $fn = 10);
				
			translate([i1 / 2, 0, 31])
				cylinder(h = 3, d = cd1, $fn = 10);		
		}
			
		translate(part1Off)
		rotate([0, -90, 0])
		{
			translate([-i1 / 2, 0, 26])
				cylinder(h = 3, d = cd1, $fn = 10);	
		
			translate([-i1 / 2, 0, 0])
				cylinder(h = 35, d = cd2, $fn = 10);		
		}
	}
}

module part0_2() {
}