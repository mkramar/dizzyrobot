include <../../main.scad>

boltPositions = [[78, 50, 0], [83, 14, 0], [-73, 50, 0]/*, [-65, 14, 0]*/];

module boltsAplus(){
	for (a =[0:45:350])
	{
		rotate([0, 0, a])
		translate([0, 39, 0])
			cylinder(h = 8, d = 10);
	}
}

module boltsAminus(){
	for (a =[0:45:350])
	{
		rotate([0, 0, a])
		translate([0, 39, 0])
			boltaMinus();
	}
}

module boltsBplus() {
	//for (a =[0:45:350])
	//{
	//	rotate([0, 0, a])
	//	translate([0, 39, 0])
	//		cylinder(h = 8, d = 10);
	//}
}

module boltsBminus() {
	for (a =[0:45:350])
	{
		rotate([0, 0, a])
		translate([0, 39, 0])
			boltbMinus();
	}
}

// bolts 2 --------------------------------------------------------------------

module bolts2Bplus() {
	intersection()
	{
		body2Plus();
		
		translate([-bodyDistance/2, 0, 0])
		for (x = boltPositions)
		{
			//rotate([0, 90, 0])
			//rotate(part1RotMinus) 
			rotate([0, -90, 0])
			translate(x)
			rotate([0, 180, 0])
				cylinder(h = 30, d = 10);
		}
	}
}

module bolts2Bminus() {
	translate([-bodyDistance/2, 0, 0])
	for (x = boltPositions)
	{
		//rotate([0, 90, 0])
		//rotate(part1RotMinus) 
		rotate([0, -90, 0])
		translate(x)
			boltbMinus();
	}
}
