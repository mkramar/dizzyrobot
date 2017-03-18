include <main.scad>

translate([0, 45, 0])
rotate([0, 90, 0])
intersection()
{
	part2();
	cutA();
}

translate([-h, 0, 0])
rotate([0, -90, 0])
difference()
{
	part2();
	cutA();
}

module cutA() {
	x = 3;
	
	translate([0, -50, -170])
		cube([100, 100, 200]);
		
	translate([-x, -i1/2, -i1/2])
		cube([i1, i1, i1]);
		
	translate([-x, -is/2, -is/2 - h])
		cube([is, is, is]);
		
	// vert	

	translate([-x + 0.5, 3, 0])
	rotate([90, 0, 0])
	rotate([0, -90, 0])
	tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
	
	translate([-x + 0.5, 3, -h - 40])
	rotate([90, 0, 0])
	rotate([0, -90, 0])
	tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);	
	
	// horiz

	translate([-x + 0.5, -25, -3])
	rotate([0, -90, 0])
	tapered_cuboid(w = 6, l = 50, h = 2, taper = 2);

	//translate([0.5, -25, -30])
	//rotate([0, -90, 0])
	//tapered_cuboid(w = 6, l = 50, h = 2, taper = 2);
	
	translate([0.5, -25, -70])
	rotate([0, -90, 0])
	tapered_cuboid(w = 6, l = 50, h = 2, taper = 2);
	
	//translate([0.5, -25, -110])
	//rotate([0, -90, 0])
	//tapered_cuboid(w = 6, l = 50, h = 2, taper = 2);
	
	translate([-x + 0.5, -25, -h-3])
	rotate([0, -90, 0])
	tapered_cuboid(w = 6, l = 50, h = 2, taper = 2);
}