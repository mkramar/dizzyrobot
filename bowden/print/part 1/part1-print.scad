include <../../main.scad>

boltPositions = [part1BoltHolder1, part1BoltHolder2, [0, 9, -45]];

module cutA() {
	translate([-com12CableOffset, 0, 0])
	{
		translate([0, -50, -200])
			cube([30, 100, 250]);

		translate([0.5, 3, 10])
		rotate([90, 0, -90])
			tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
			
		translate([0.5, -20, -40])
		rotate([0, -90, 0])
			tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);

		translate([0.5, -20, -76])
		rotate([0, -90, 0])
			tapered_cuboid(w = 6, l = 45, h = 2, taper = 2);
			
		translate([0.5, -10, -h])
		rotate([0, -90, 0])
			tapered_cuboid(w = 6, l = 60, h = 2, taper = 2);			
	}
}


module boltsAplus(){
	for (x = boltPositions)
	{
		intersection()
		{
			bone1Plus();
			
			translate([-com12CableOffset, 0, 0])
			translate(x)
			rotate([0, 90, 0])				
				cylinder(h = 25, d = 10);
		}
	}
}

module boltsAminus(){
	for (x = boltPositions)
	{
		translate([-com12CableOffset, 0, 0])
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
			bone1Plus();
			
			translate([-com12CableOffset, 0, 0])
			translate(x)
			rotate([0, -90, 0])				
				cylinder(h = 13, d = 10);
		}
	}
}

module boltsBminus() {
	for (x = boltPositions)
	{
		translate([-com12CableOffset, 0, 0])
		translate(x)
		rotate([0, 90, 0])
			boltbMinus();
	}
}