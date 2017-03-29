use <../lib/shapes.scad>
include <../_sizes.scad>
include <../_shared.scad>

module part1()
{    
    difference()
	{
        union()
        {
			rotate([0, 0, 90])
            difference()
            {
                smallBall();
                smallBallMinus1();
            }
            
            bone1();

            translate([0, 0, -h])
                bigBall();
        }
        
        //translate([0, 0, -h/2]) cube([50, 50, h + 50]);
        translate([0, -30, -h]) cube ([50, 60, 50]);        
		
		translate([-12, 4, -110])
		rotate([0, 90, 0])
			cylinder(h = 10, d1 = 18, d2 = 18);
		
		rotate([0, 0, 90])
		{
			smallBallMinus2();
			smallBallMinus3();
			smallBallMinus4a();
			smallBallMinus4b();
		}
        bone1Minus();
		
		translate([0, 0, -i1/2 + 2.5])
		rotate([0, 90, 0])
			cylinder(h = 30, d1 = 2, d2 = 2, center = true, $fn = 10);
        
        translate([0, 0, -h])
        {
            smallBall(inflate = 2);
            smallBallMinus3();
			//smallBallMinus4a();
			smallBallMinus4b();
        
            hull()
            {
                rotate([-part1angle1, 0, 0])
                    com12BonePlus(inflate = 2);
                
                rotate([-part1angle2, 0, 0])
                    com12BonePlus(inflate = 2);
            }
        }
		
		// board
		
		translate([0, 0, -h])
		rotate([0, 90, 0])
		{
			translate([-boardSize/2, -boardSize/2, 14])
				cube([boardSize, boardSize, 5]);
				
			translate([0, 0, 10])
				cylinder(d = 22, h = 10, center = true);
		}		
		
		// pull
		
		translate([0, 0, -h])
		rotate([20, 0, 0])
		translate([0, i1/2, 0])
		{
			cylinder(h = 35, d = cd2, $fn = 10);
			translate([0, 0, 20]) cylinder(h = 8, d = cd1, $fn = 10);
		}

		translate([0, 0, -h])
		rotate([-30, 0, 0])
		translate([0, -i1/2, 0])
		{
			cylinder(h = 35, d = cd2, $fn = 10);
			translate([0, 0, 24]) cylinder(h = 8, d = cd1, $fn = 10);
		}
    }
}
