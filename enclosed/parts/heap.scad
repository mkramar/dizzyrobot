include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/sensor.scad>
use <thigh.scad>

// public ---------------------------------------------------------------------

axis1Xoffset = 60;
axis1Yoffset = 40;
axis1Zoffset = 0;

bearing1Offset = -5;
bearing2Offset = 35;

holderHeight = 50;

module heapAssembly(){
	difference()
	{
		//color("tan") 
		%heap();
		
		//translate([0, 0, -100]) cube([100, 100, 200]);
		//translate([-200, -100, -100]) cube([200, 200, 200]);
	}
	
	#heapMarkers();
	heapMotors();
	color("white") heapMetal();
}

module heap(){
	difference()
	{
		union()
		{
			difference()
			{
				heapBase("outer");
				heapBase("inner");		
			}
			
			holder();
		}
		
		render()
			thighOpening();		
	}
}

module heapBase(mode = "outer"){
	d1 = heapShellInner1 + (mode == "outer" ? th * 2 : 0);
	d2 = heapShellInner2 + (mode == "outer" ? th * 2 : 0);
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
	
	rotate([90, 0, 0])
	{
		shayba2(d = d1, h = h1, x = 5, rd = rd);
		#cylinder(d = 1, h = 200, center = true);
	}
}

module heapMetal() {
	// axis 1
	
	translate([bearing2Offset, -axis1Yoffset, axis1Zoffset])
	rotate([0, 90, 0])
		bb6800();
		
	translate([bearing1Offset, -axis1Yoffset, axis1Zoffset])
	rotate([0, 90, 0])
		bb6800();

	// axis 2
	
	//rotate([0, -thighMotorToAxisUpperAngle, 0])
	//translate([gr2 - rm, 0, 0])
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
	translate([80, -axis1Yoffset, axis1Zoffset])
	{
		rotate([-10, 0, 0])
		translate([0, 0, -(gr3 - rm)])
		rotate([0, -90, 0])
			motor4Gear();
	}
}

// private --------------------------------------------------------------------

module thighOpening() {
	h1 = 30;

	difference()
	{
		union()
		{
			for (a = [heapAngle1Min:20:heapAngle1Max])
			{
				rotate([0, a, 0])
				rotate([0, -thighMotorToAxisUpperAngle, 0])
				translate([rm - gr2, 0, 0])
				rotate([0, thighMotorToAxisUpperAngle, 0])
					thighBase("spacing");
			}
							
			rotate([0, heapAngle1Max, 0])
			rotate([0, -thighMotorToAxisUpperAngle, 0])
			translate([rm - gr2, 0, 0])
			rotate([0, thighMotorToAxisUpperAngle, 0])
				thighBase("spacing");
		}
		
		translate([0, heapY7, 0])
		rotate([-90, 0, 0])
			cylinder(d = heapShellOuter1 + gap * 2, h = h1 + 0.01);		
	}
}

module holder(){
	d = bb6800o + th*2;

	intersection()
	{
		rotate([90, 0, 0])
			cylinder(d = heapShellInner1 - (gap + th + gap) * 2, h = 150, center = true);

		union()
		{
			hull()
			{		
				translate([bearing1Offset - d/2, heapY1, axis1Zoffset - d/2])
					cube([1, 1, d]);
					
				translate([bearing2Offset + d/2 - 1, heapY1, axis1Zoffset - holderHeight/2])
					cube([1, 1, holderHeight]);
					
				translate([bearing1Offset, -axis1Yoffset, axis1Zoffset])
					sphere(d = d);
					
				translate([bearing2Offset, -axis1Yoffset, axis1Zoffset])
					sphere(d = d);
			}
			
			difference()
			{
				intersection()
				{
					heapBase("outer");
					
					hull()
					{
						translate([bearing1Offset - d/2, -50, axis1Zoffset - d/2])
							cube([1, 100, d]);
							
						translate([bearing2Offset + d/2 - 1, -50, axis1Zoffset - holderHeight/2])
							cube([1, 100, holderHeight]);
					}
				}
				
				// axis
				
				rotate([90, 0, 0])
					cylinder(d = bb6701o + (th + gap)*2, h = 150, center = true);
			}
		}
	}
}
