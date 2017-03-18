use <../lib/shapes.scad>
include <../_sizes.scad>
include <../_shared.scad>
include <../elec/board-joint.scad>

module part2()
{    
    difference(){
		union()
		{
			// main
			
			difference()
			{
				union()
				{
					difference()
					{
						smallBall();
						smallBallMinus1();
					}
					
					bone2();
					
					translate([0, 0, -h])
					rotate([0, 90, 0])
						cylinder(d = is, h = hs, center = true);		
				}
				
				smallBallMinus2();
				smallBallMinus3();
				smallBallMinus4a(half = true);
				smallBallMinus4b();
				bone2Minus();
			}
			
			// cable holder
			
			intersection()
			{
				bone2();
				
				translate([0, 0, -h])
				{
					translate([0, cableOffset, 0])
					rotate([cableAngle, 0, 0])
					difference()
					{
						translate([0, 0, 15])
						intersection()
						{
							translate([-5, -3]) cube([10, 6, 20])
							rotate([90 - cableAngle, 0, 0]) cube([30, 30, 30]);
						}
					}
					
					translate([0, -cableOffset, 0])
					rotate([-cableAngle, 0, 0])
					difference()
					{
						translate([0, 0, 15])
						intersection()
						{
							translate([-5, -3]) cube([10, 6, 20])
							rotate([cableAngle, 0, 0]) cube([30, 30, 30]);
						}
					}
				}
			}			
		}
        
        //translate([0, 0, -h/2]) cube([50, 50, h + 50]);
        //translate([0, -25, -h]) cube ([50, 50, 50]);
		//translate([-25, 0, -h]) cube ([50, 50, 50]);
        
		translate([0, 0, -h])
		rotate([0, 90, 0])		
		{
			translate([0, 0, -hs/2 - th - 1])
				cylinder(d = is-8, h = hs + 2);
				
			rotate([0, 0, 180])
				dCylinder(d = is - 8, h = hs+20, x = (is-8)/2 + 2);
		}

		// ball bearing spacing
		
		translate([hs/2, 0, -h])
		rotate([0, 90, 0])
			torus(d = is - 2, w = 4.1, $fn = 50);
			
		translate([-hs/2, 0, -h])
		rotate([0, 90, 0])
			torus(d = is - 2, w = 4.1, $fn = 50);
			
		// cable spacing
		
		translate([0, 0, -h])
		{
			translate([0, cableOffset, 0])
			rotate([cableAngle, 0, 0])
			{
				cylinder(h = 100, d = cd2, center = true, $fn = 8);
				translate([0, 0, 32]) cylinder(h = 18, d = cd1, $fn = 15);
			}
			
			translate([0, -cableOffset, 0])
			rotate([-cableAngle, 0, 0])
			{
				cylinder(h = 100, d = cd2, center = true, $fn = 8);
				translate([0, 0, 32]) cylinder(h = 18, d = cd1, $fn = 15);
			}			
		}
	}
	
	// rotation sensor axis
	
	rotate([0, 90, 0])
	translate([0, 0, i2/2])
		dCylinder(h = 4, d = 4, x = 1, $fn = 20);
		
	translate([0, 0, -h])
	rotate([0, 90, 0])
	translate([0, 0, hs/2])
		dCylinder(h = 4, d = 4, x = 1, $fn = 20);
}
