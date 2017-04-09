include <../../main.scad>

boltPositions = [[0, -7, -40], [0, 8, -107], [0, -8, -107]];

module cutA() {
	translate([-com23CableOffset, 0, 0])
	{
		translate([0, -50, -200])
			cube([30, 100, 250]);
			
		translate([-4, 0, 0])
		{
			rotate([25, 0, 0])
			rotate([0, 90, 0])
				cylinderSector(d = com12JointD + 0.3, h = 4.1, angle = 310);			
			
			//
			
			translate([0.5, 3, 0])
			rotate([90, 0, 0])
			rotate([0, -90, 0])
				tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
				
			translate([0.5, 10, -3])
			rotate([0, -90, 0])
				tapered_cuboid(w = 6, l = 20, h = 2, taper = 2);
				
			translate([0.5, -30, -3])
			rotate([0, -90, 0])
				tapered_cuboid(w = 6, l = 20, h = 2, taper = 2);			
		}
		
		//

		translate([0.5, -20, -60])
		rotate([0, -90, 0])
			tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);

		translate([0.5, 0, -h - 3])
		rotate([0, -90, 0])
			tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
	}
}


module boltsAplus(){
	for (x = boltPositions)
	{
		intersection()
		{
			bone2Plus();
			
			translate([-com23CableOffset, 0, 0])
			translate(x)
			rotate([0, 90, 0])				
				cylinder(h = 25, d = 10);
		}
	}
}

module boltsAminus(){
	for (x = boltPositions)
	{
		translate([-com23CableOffset, 0, 0])
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
			bone2Plus();
			
			translate([-com23CableOffset, 0, 0])
			translate(x)
			rotate([0, -90, 0])				
				cylinder(h = 13, d = 10);
		}
	}
}

module boltsBminus() {
	for (x = boltPositions)
	{
		translate([-com23CableOffset, 0, 0])
		translate(x)
		rotate([0, 90, 0])
			boltbMinus();
	}
}