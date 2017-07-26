include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/sensor.scad>

// public ---------------------------------------------------------------------

module bodyAssembly(){
	body();
	color("lime") symmetry() bodyMotors();
}

module body(){
	cylinderOffset = [40, -heapWidth, 40];
	cylinderD = 70;
	cylinderH = 80;
	
	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					bodyBase();
					symmetry() bodyHalfPlus();
				}
				
				translate(cylinderOffset)
					cylinder(d=cylinderD, h=cylinderH, center = true);		
			}
			
			difference()
			{
				translate(cylinderOffset)
					ring(d=cylinderD, h=cylinderH, t = th);
					
				symmetry() bodyHalfBase("inner");
			}
		}
		
		symmetry() bodyHalfMinus();
	}
}

module bodyHalfMinus(){
	translate([heapX3, -heapAxis1Yoffset, heapAxis1Zoffset])
	rotate([0, -90, 0])
		cylinder(d = heapShellOuter2 + gap*2, h = heapX3-heapX0);		
}

module bodyHalfPlus(){
	translate([bodyHeapBearing1Offset + bb6800h/2, -heapAxis1Yoffset, heapAxis1Zoffset])
	rotate([0, 90, 0])
		cylinder(d = rod10 + th*2, h = bodyHeapBearing2Offset - bodyHeapBearing1Offset - bb6800h);
}

module bodyBase(){
	difference()
	{
		symmetry() bodyHalfBase("outer");
		symmetry() bodyHalfBase("inner");
	}
}

module bodyHalfBase(mode = "outer"){
	h1Inner = 40;
	h1Outer = h1Inner + th*2;

	h2Inner = heapX1 - bodyHeapBearing1Offset-15;
	h2Outer = h2Inner + th*2;

	d1 = (mode == "outer" ? heapShellOuter2 : heapShellInner2);
	h1 = (mode == "outer" ? h1Outer : h1Inner);	
	
	d2 = (mode == "outer" ? motor4DOuter : motor4DInner);
	h2 = (mode == "outer" ? h2Outer : h2Inner);
	rd = (mode == "outer" ? 15 : 10);
	
	translate([heapX1 - h1Outer/2, -heapAxis1Yoffset, heapAxis1Zoffset])
	rotate([0, 90, 0])
		shayba2(d = d1, h = h1, x = 5, rd = rd);
	
	extend([0, -35, 0])
	{
		translate([heapX1 - h2Outer/2, -heapAxis1Yoffset, heapAxis1Zoffset])
		rotate([heapMotorAngle, 0, 0])
		translate([0, 0, -(gr3 - rm)])
		rotate([0, -90, 0])
			shayba2(d = d2, h = h2, x = 5, rd = rd);
	}
}

module bodyMotors() {
	translate([heapX2, -heapAxis1Yoffset, heapAxis1Zoffset])
	{
		rotate([heapMotorAngle, 0, 0])
		translate([0, 0, -(gr3 - rm)])
		rotate([0, -90, 0])
			motor4Gear();
	}
}

module symmetry(){
	children();
	translate([0, -heapWidth-heapAxis1Yoffset*2, 0]) mirror([0, 1, 0]) children();
}

module extend(trans){
	hull()
	{
		children();
		translate(trans) children();
	}
}
