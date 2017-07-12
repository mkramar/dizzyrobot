include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/sensor.scad>

// public ---------------------------------------------------------------------

axis1Xoffset = 60;
axis1Yoffset = 40;
axis1Zoffset = 20;
axis2angle = 40;

module heap(){
	difference()
	{
		heapBase("outer");
		heapBase("inner");
	}
}

module heapBase(mode = "outer"){
	d1 = (gd2 + 6 + gap * 2) + (mode == "outer" ? th * 2 : 0);
	d2 = (gd3 + 6 + gap * 2) + (mode == "outer" ? th * 2 : 0);
	h1 = kneeH + (mode == "outer" ? 0 : -th*2);
	rd = (mode == "outer" ? 15 : 10);
	
	// axis 1
	
	translate([axis1Xoffset, -axis1Yoffset, axis1Zoffset])
	rotate([0, 90, 0])
	{
		shayba2(d = d2, h = h1, x = 5, rd = rd);
		#cylinder(d = 1, h = 200, center = true);
	}

	// axis 2
	
	rotate([0, -axis2angle, 0])
	translate([gr2 - rm, 0, 0])
	{
		translate([0, toY(h1, heapY0), 0])
		rotate([90, 0, 0])
		{
			shayba2(d = d1, h = h1, x = 5, rd = rd);
			#cylinder(d = 1, h = 200, center = true);
		}
	}
}

module heapMetal() {
	// axis 1
	
	translate([35, -axis1Yoffset, axis1Zoffset])
	rotate([0, 90, 0])
		bb6800();
		
	translate([-5, -axis1Yoffset, axis1Zoffset])
	rotate([0, 90, 0])
		bb6800();

	// axis 2
	
	rotate([0, -axis2angle, 0])
	translate([gr2 - rm, 0, 0])
	{
		translate([0, heapY2 + bb6800h/2, 0])
		rotate([90, 0, 0]) 
			bb6800();
			
		translate([0, heapY7 + bb6800h/2, 0])
		rotate([90, 0, 0]) 
			bb6800();			
	}
	
}

module heapMotors() {
	translate([0, -15, 0])
	rotate([-90, 0, 0])
		motor5Gear();

	translate([80, -axis1Yoffset, axis1Zoffset])
	{
		rotate([-10, 0, 0])
		translate([0, 0, -(gr3 - rm)])
		rotate([0, -90, 0])
			motor4Gear();
	}
}