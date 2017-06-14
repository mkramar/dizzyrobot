use <../../lib/shapes.scad>
include <../sizes.scad>
include <../../lib/sensor.scad>
include <../../lib/gear.scad>
include <motor.scad>

// public ---------------------------------------------------------------------

module part1() {
	difference()
	{
		partBase(outer = true);
		partBase(outer = false);
		
		do = motor5D + th*2;
		h = axis2 - bb6800h*2;
		
		hull()
		{
			rotate([90, 0, 0])
				shayba(d = do, h = h, rd = 10, center = true);

			translate([0, 0, -100])
			rotate([90, 0, 0])
				shayba(d = do, h = h, rd = 10, center = true);
		}
		
		translate([0, -axis2/2 + bb6800h, 0])
		rotate([-90, 0, 0])
			cylinder(d = d2 + 6, h = gh + 2 + 4);
		
		translate(motor2offset)
		translate([0, -1, 0])
		rotate([-90, 0, 0])
			motor5BoltSpace();
		
		translate([-100, -100, -300])
			cube([200, 200, 200]);

		translate([0, axis2/2 - axis2yOffset])
		rotate([-90, -60, 0])
			rotationSensorSpacing();
		
		//translate([-100, -100, -100])
		//	cube([100, 100, 100]);
	}
	
	translate([0, -axis2/2 + bb6800h, 0])
	rotate([90, 0, 0])
		ring(d = bb6800o, h = bb6800h, t = th, center = false);
		
	translate([0, axis2/2, 0])
	rotate([90, 0, 0])
		ring(d = bb6800o, h = bb6800h, t = th, center = false);
}

module partBase(outer = true) { 
	do = motor5D + (outer ? th*4 : th*2);
	di = bb6800o + (outer ? th*2 : 0);
	h = axis2 + (outer ? th*2 : 0);
	rd = outer? 15: 10;
	
	difference()
	{
		difference()
		{
			hull()
			{
				rotate([90, 0, 0])
					shayba(d = do, h = h, rd = rd);

				translate([0, 0, -100])
				rotate([90, 0, 0])
					shayba(d = do, h = h, rd = rd);
			}
			
			difference()
			{
				a1 = -65;
				a2 = 240;
				
				translate([0, h/2 + 0.5, 0])
				rotate([90, 0, 0])
					ringSector(d = di, h = h + 1, t = 100, start_angle = a1, end_angle = a2);
					
				rotate([0, -a1, 0])
				translate([0, -h/2, -0.05])
					cube([100, h + 1, di/2 + 0.1]);

				rotate([0, -a2, 0])
				translate([0, -h/2, -di/2])
					cube([100, h + 1, di/2 + 0.01]);
			}
		}
	}
}
