include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/sensor.scad>
use <thigh.scad>

// public ---------------------------------------------------------------------

heapAxis1Yoffset = 45;
heapAxis1Zoffset = 10;

module heapAssembly(){
	difference()
	{
		color("tan") 
			heap();
		
		translate([0, 0, -100]) cube([100, 100, 200]);
		//translate([-200, -100, -100]) cube([200, 200, 200]);
	}
	
	#heapMarkers();
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
		
		translate([heapX4, -heapAxis1Yoffset, heapAxis1Zoffset])
		rotate([0, 90, 0])
			cylinder(d = heapShellInner2 + 10, h = 50);
		
		render()
			thighOpening();
	}
}

module heapBase(mode = "outer"){
	h = (heapX1 - heapX9);
	
	d1 = (mode == "outer" ? heapShellOuter1 : heapShellInner1);
	d2 = (mode == "outer" ? heapShellOuter2 : heapShellInner2);
	h1 = h - (mode == "outer" ? 0 : 2*th);
	rd = (mode == "outer" ? 15 : 10);
	
	// axis 1
	
	translate([heapX1 - h/2, -heapAxis1Yoffset, heapAxis1Zoffset])
	rotate([0, 90, 0])
	{
		shayba(d = d2, h = h1, x = 5, rd = rd);
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
	
	translate([bodyHeapBearing2Offset, -heapAxis1Yoffset, heapAxis1Zoffset])
	rotate([0, 90, 0])
		bb6800();
		
	translate([bodyHeapBearing1Offset, -heapAxis1Yoffset, heapAxis1Zoffset])
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

// private --------------------------------------------------------------------

holderHeight = 50;

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
				translate([bodyHeapBearing1Offset - d/2, heapY1, heapAxis1Zoffset - d/2])
					cube([1, 1, d]);
					
				translate([bodyHeapBearing2Offset + d/2 - 1, heapY1, heapAxis1Zoffset - holderHeight/2])
					cube([1, 1, holderHeight]);
					
				translate([bodyHeapBearing1Offset, -heapAxis1Yoffset, heapAxis1Zoffset])
					sphere(d = d);
					
				translate([bodyHeapBearing2Offset, -heapAxis1Yoffset, heapAxis1Zoffset])
					sphere(d = d);
			}
			
			difference()
			{
				intersection()
				{
					heapBase("outer");
					
					hull()
					{
						translate([bodyHeapBearing1Offset - d/2, -50, heapAxis1Zoffset - d/2])
							cube([1, 100, d]);
							
						translate([bodyHeapBearing2Offset + d/2 - 1, -50, heapAxis1Zoffset - holderHeight/2])
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

module heapMarkers() {
	translate([-5, 0, -50])
	{
		translate([0, heapY1, 0]) cube([10, 0.01, 80]);
		translate([0, heapY2, 0]) cube([10, 0.01, 80]);
		translate([0, heapY3, 0]) cube([10, 0.01, 80]);
		translate([0, heapY4, 0]) cube([10, 0.01, 80]);
		translate([0, heapY5, 0]) cube([10, 0.01, 80]);
		translate([0, heapY6, 0]) cube([10, 0.01, 80]);
		translate([0, heapY7, 0]) cube([10, 0.01, 80]);
		translate([0, heapY8, 0]) cube([10, 0.01, 80]);
		translate([0, heapY9, 0]) cube([10, 0.01, 80]);
		translate([0, heapY0, 0]) cube([10, 0.01, 80]);
	}
	
	translate([0, -heapAxis1Yoffset - 5, heapAxis1Zoffset - 60])
	{
		translate([heapX1,0, 0]) cube([0.01, 10, 120]);
		translate([heapX2,0, 0]) cube([0.01, 10, 120]);
		translate([heapX3,0, 0]) cube([0.01, 10, 120]);
		translate([heapX4,0, 0]) cube([0.01, 10, 120]);
		translate([heapX5,0, 0]) cube([0.01, 10, 120]);
		translate([heapX6,0, 0]) cube([0.01, 10, 120]);
		translate([heapX7,0, 0]) cube([0.01, 10, 120]);
		translate([heapX8,0, 0]) cube([0.01, 10, 120]);
		translate([heapX9,0, 0]) cube([0.01, 10, 120]);
		translate([heapX0,0, 0]) cube([0.01, 10, 120]);
	}
}