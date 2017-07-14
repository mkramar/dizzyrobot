include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/sensor.scad>

// public ---------------------------------------------------------------------

module thighAssembly(){
	color("pink")
	difference()
	{
		thigh();
		//translate([0, -50, 0]) cube([100, 100, 100]);		
	}

	thighMotors();

	#translate([0, 0, -thighLength])
		kneeMarkers();
}

module thigh(){
	z1 = -(r1 - rm);
	z2 = (gr2 - rm);
	h1 = th + gap + th;
	h2 = kneeY3 - kneeY6;
	heapAxis = heapY8 - heapY2;
	kneeAxis = kneeY2 - kneeY9;
	
	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					thighBase("outer");
					
					// upper

					rotate([0, 90 - thighMotorToAxisUpperAngle, 0])
					translate([0, heapY2, z2])
					rotate([-90, 0, 0])
						ring(d = bb6701o, h = heapAxis - 2, t = th, center = false);
						
					// lower
						
					translate([0, 0, -thighLength])
					translate([0, toY(kneeAxis, kneeY2), z1])
					rotate([90, 0, 0])
						ring(d = bb6701o, h = kneeAxis - 2, t = th);
				}
				
				// upper
				
				difference()
				{
					intersection()
					{
						thighBase("outer");
					
						rotate([0, 90 - thighMotorToAxisUpperAngle, 0])
						translate([0, toY(h1, kneeY2), z2])
						rotate([90, 0, 0])
							cylinder(d = heapShellOuter1 + gap * 2, h = h1 + 0.01, center = true);
					}
					
					rotate([0, 90 - thighMotorToAxisUpperAngle, 0])
					translate([0, toY(kneeAxis, kneeY2), z2])
					rotate([90, 0, 0])
						ring(d = bb6701o, h = kneeAxis, t = th);
				}
				
				// lower
				
				difference()
				{
					intersection()
					{
						thighBase("outer");
					
						translate([0, 0, -thighLength])
						translate([0, toY(h1, kneeY5), z1])
						rotate([90, 0, 0])
							cylinder(d = kneeShellOuter + gap * 2, h = h1 + 0.01, center = true);
					}
					
					translate([0, 0, -thighLength])
					translate([0, toY(kneeAxis, kneeY2), z1])
					rotate([90, 0, 0])
						ring(d = bb6701o, h = kneeAxis, t = th);
				}				
			}
			
			// ring around
				
			translate([0, 0, -thighLength])
			translate([0, toY(h2, kneeY3), z1])
			rotate([90, 0, 0])
				ring(d = kneeShellInner - (th + gap) * 2, h = h2, t = th);
		}
			
		thighBase("inner");
		
		// space so that bearing fits in
		
		translate([0, 0, -thighLength])
		translate([0, kneeY2, z1])
		rotate([90, 0, 0])
			cylinder(d = bb6701o, h = bb6701h, center = false);
			
		// motor bolts
		
		translate([0, 0, -thighLength])
		translate([0, kneeY4-0.01, 0])
		rotate([-90, 0, 0])
			motor5BoltSpace();
	}
	
	// ring that holds bearing
	
	translate([0, 0, -thighLength])
	translate([0, kneeY2 - bb6701h, z1])
	rotate([90, 0, 0])
		ring(d = bb6701o - 3, t = 3, h = 4, center = false);
	
	translate([0, 0, -thighLength])
	translate([0, kneeY9 + bb6701h, z1])
	difference()
	{
		rotate([-90, 0, 0])
			cylinder(d = bb6701o, h = th);
		
		rotate([-90, 0, 0])
		rotate([0, 0, 90])
			rotationSensorSpacing();
	}
}

module thighBase(mode = "outer"){
	d = (mode == "outer" ? motor5DOuter :
	     mode == "inner" ? motor5DInner :
		 mode == "spacing" ? motor5DOuter : 0);

	h = thighH + (mode == "outer" ? 0 : 
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

		translate([0, 0, -thighLength])
		rotate([90, 0, 0])
			shayba(d = d - x*2, h = h, rd = rd);		
	}
	
	translate([0, 0, -thighLength])
	rotate([90, 0, 0])
		shayba(d = d, h = h, rd = rd);	
}

// private --------------------------------------------------------------------

module thighMotors(){
	translate([0, -thighMotorUpperYOffset, 0])
	rotate([-90, 0, 0])
		motor5Gear();
		
	translate([0, 0, -thighLength])
	translate([0, kneeMotorOffset, 0])
	rotate([90, 0, 0])
		motor5Gear();
}

module kneeMarkers(){
	translate([-5, 0, -50])
	{
		translate([0, kneeY1, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY2, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY3, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY4, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY5, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY6, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY7, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY8, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY9, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY0, 0]) cube([10, 0.01, 80]);
	}
}