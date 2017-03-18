use <../lib/shapes.scad>
include <../_sizes.scad>
include <../_shared.scad>

module part0(){
	db = bodyBearingDiam;

	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					rotate([0, 90, 0])
						halfShayba(h = 5, d = db + 8, rd = 8, $fn = 50);
						
					translate([-10, 0, 0])
					rotate([0, -90, 0])
						halfShayba(h = 5, d = db + 8, rd = 8, $fn = 50);
				}
					
				translate([-0.5, 0, 0])
				rotate([0, 90, 0])
					torus(d = db, w = 4.5, $fn = 50);
					
				translate([-9.5, 0, 0])
				rotate([0, 90, 0])
					torus(d = db, w = 4.5, $fn = 50);					
			}

			rotate([0, -90, 0])
				translate([0, 0, -1])
				cylinder(h = 15, d1 = db - 10, d2 = db - 10);

			translate(part1Off)
			difference()
			{
				
				union()
				{
					rotate([0, 0,90])
						bigBall();		

					// pull
			
					rotate([0, -10, 0])
					translate([i1 / 2, 0, 10])
						cylinder(h = 10, d1 = 6 ,d2 = 6, $fn = 15);	
						
					rotate([0, 10, 0])
					translate([-i1 / 2, 0, 10])
						cylinder(h = 10, d1 = 6 ,d2 = 6, $fn = 15);							
				}
				
				rotate([0, 0,90])
				union()
				{
					smallBall(inflate = 2);
					smallBallMinus3();
					//smallBallMinus4a();
					smallBallMinus4b();
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

		//translate([-30, 0, -h/2]) cube([60, 50, h + 50]);
		//cube([60, 50, 50]);		

		rotate([0, -90, 0])
		translate([0, 0, -1])
			cylinder(h = 32, d1 = db - 16, d2 = db - 16);
			
		// pull spacing
		
		translate(part1Off)
		rotate([0, -10, 0])
		translate([i1 / 2, 0, 0])
			cylinder(h = 25, d1 = 2, d2 = 2, $fn = 10);
			
		translate(part1Off)
		rotate([0, 10, 0])
		translate([-i1 / 2, 0, 0])
			cylinder(h = 25, d1 = 2, d2 = 2, $fn = 10);		

		translate(part1Off)
		rotate([0, -10, 0])
		translate([i1 / 2, 0, 18])
			cylinder(h = 3, d1 = 4, d2 = 4, $fn = 10);		

		translate(part1Off)
		rotate([0, 10, 0])
		translate([-i1 / 2, 0, 18])
			cylinder(h = 3, d1 = 4, d2 = 4, $fn = 10);	
	}
}