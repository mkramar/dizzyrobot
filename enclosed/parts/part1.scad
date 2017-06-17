include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/sensor.scad>

module part1(){
	z = -(r1 - rm);
	h1 = th + gap + th;
	h2 = kneeY3 - kneeY6;
	axis = kneeY2 - kneeY9;
	
	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					part1Base("outer");

					translate([0, toY(axis, kneeY2), z])
					rotate([90, 0, 0])
						ring(d = bb6701o, h = axis - 2, t = th);
				}
				
				difference()
				{
					intersection()
					{
						part1Base("outer");
					
						translate([0, toY(h1, kneeY5), z])
						rotate([90, 0, 0])
							cylinder(d = kneeShellOuter + gap * 2, h = h1 + 0.01, center = true);
					}
					
					translate([0, toY(axis, kneeY2), z])
					rotate([90, 0, 0])
						ring(d = bb6701o, h = axis, t = th);
				}
			}
				
			translate([0, toY(h2, kneeY3), z])
			rotate([90, 0, 0])
				ring(d = kneeShellInner - (th + gap) * 2, h = h2, t = th);
		}
			
		part1Base("inner");
		
		// space so that bearing fits in
		
		translate([0, kneeY2, z])
		rotate([90, 0, 0])
			cylinder(d = bb6701o, h = bb6701h, center = false);
			
		// motor bolts
		
		translate([0, kneeY4-0.01, 0])
		rotate([-90, 0, 0])
			motor5BoltSpace();
	}
	
	
	// ring that holds bearing
	
	translate([0, kneeY2 - bb6701h, z])
	rotate([90, 0, 0])
		ring(d = bb6701o - 3, t = 3, h = 4, center = false);
	
	translate([0, kneeY9 + bb6701h, z])
	difference()
	{
		rotate([-90, 0, 0])
			cylinder(d = bb6701o, h = th);
		
		rotate([-90, 0, 0])
		rotate([0, 0, 90])
			rotationSensorSpacing();
	}
}

module part1Base(mode = "outer"){
	d = (mode == "outer" ? part1Outer :
	     mode == "inner" ? part1Inner :
		 mode == "spacing" ? part1Outer : 0);

	h = part1H + (mode == "outer" ? 0 : 
	              mode == "inner" ? -th*2 :
				  mode == "spacing" ? gap*2 : 0);

	rd = (mode == "outer" ? 10 : 
	      mode == "inner" ? 5 : 10);

	x = 10;

	rotate([90, 0, 0])
		shayba(d = d, h = h, rd = rd);
	
	translate([-x, 0, 0])
	hull()
	{
		rotate([90, 0, 0])
			shayba(d = d - x*2, h = h, rd = rd);

		translate([0, 0, 200])
		rotate([90, 0, 0])
			shayba(d = d - x*2, h = h, rd = rd);		
	}
}