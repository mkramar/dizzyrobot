include <../../main.scad>

boltPositions = [[0, 38, -15], [0, 10, -19], [0, -10, -19], [0, -31, -15]];
/*
translate([-45, 0, 0])
rotate([0, 90, 0])
difference()
{
	union()
	{
		intersection() 
		{
			part3();
			cutA();
		}
		boltsAplus();
	}
	
	boltsAminus();
}

rotate([0, -90, 0])
difference() {
	union()
	{
		difference()
		{
			part3();
			cutA();
		}
		boltsBplus();
	}
	boltsBminus();
}
*/
module cutA() {
	translate([0, -50, -50])
		cube([100, 100, 100]);
		
	// vert
	
	translate([0.5, 30, -40])
	rotate([90, 0, 0])
	rotate([0, -90, 0])
	tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
	
	translate([0.5, 3, -60])
	rotate([90, 0, 0])
	rotate([0, -90, 0])
	tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);	

	translate([0.5, -20, -40])
	rotate([90, 0, 0])
	rotate([0, -90, 0])
	tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
	
	// horiz
	
	translate([0.5, -45, -23])
	rotate([0, -90, 0])
	tapered_cuboid(w = 6, l = 100, h = 2, taper = 2);			
}

module boltsAplus(){
	for (x = boltPositions)
	{
		intersection()
		{
			part3plus();
			
			translate(x)
			rotate([0, 90, 0])				
				cylinder(h = 13, d = 10);
		}
	}
}

module boltsAminus(){
	for (x = boltPositions)
	{
		translate(x)
		rotate([0, 90, 0])
			boltaMinus();
	}
}

module boltsBplus() {
	for (x = boltPositions)
	{
		intersection()
		{
			part3plus();
			
			translate(x)
			rotate([0, -90, 0])				
				cylinder(h = 13, d = 10);
		}
	}
}

module boltsBminus() {
	for (x = boltPositions)
	{
		translate(x)
		rotate([0, 90, 0])
			boltbMinus();
	}
}