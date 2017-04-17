include <../../main.scad>

boltPositions = [[0, 54, 4], [0, 14, 27]/*, [0, 8, -25]*/];

module cutA() {
	translate([0, -75, -200])
		cube([30, 150, 250]);

	translate([0.5, -20, -16])
	rotate([0, -90, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
		
	translate([0.5, -20, 10])
	rotate([0, -90, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);		

	translate([0.5, 30, 0])
	rotate([20, 0, 0])
	rotate([0, -90, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
		
	translate([0.5, 30, 0])
	rotate([80, 0, 0])
	rotate([0, -90, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);		
}


module boltsAplus(){
	for (x = boltPositions)
	{
		//intersection()
		//{
		//	bone1Plus();
			
			translate(x)
			rotate([0, 90, 0])				
				cylinder(h = 8, d = 10);
		//}
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
		//intersection()
		//{
		//	bone1Plus();
			
			translate(x)
			rotate([0, -90, 0])				
				cylinder(h = 13, d = 10);
		//}
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