use <shapes.scad>
/*
union()
{
	test();
	roundCut(d = 37);
}

//translate([0, 0, -2])
difference()
{
	translate([0, 0, -10]) 	
		test();
		
	roundCutMinus(d = 37);
}
*/

module roundCut(d){
	for (i = [0:45:360])
	{
		rotate([180, 0, i])
		translate([d/2 - 5, -4 + 0.25, -1])
		//rotate([0, 90, 0])
			tapered_cuboid(w =10, l = 7.5, h = 4.3, taper = 2); 			
	}	
}

module roundCutMinus(d){
	for (i = [0:45:360])
	{
		rotate([180, 0, i])
		translate([d/2 - 5, -4, -1])
		//rotate([0, 90, 0])
			tapered_cuboid(w =10, l = 8, h = 4.5, taper = 2); 			
	}	
}

module roundCut2(d, angles){
	for (i = angles)
	{
		rotate([180, 0, i])
		translate([d/2 - 5, -4 + 0.25, -1])
		//rotate([0, 90, 0])
			tapered_cuboid(w =10, l = 7.5, h = 4.3, taper = 2); 			
	}	
}

module roundCut2Minus(d, angles){
	for (i = angles)
	{
		rotate([180, 0, i])
		translate([d/2 - 5, -4, -1])
		//rotate([0, 90, 0])
			tapered_cuboid(w =10, l = 8, h = 4.5, taper = 2); 			
	}	
}
/*
module test(){
	difference()
	{
		cylinder(h = 10, d1 = 40, d2 = 40);
		translate([0, 0, -1]) cylinder(h = 12, d1 = 34, d2 = 34);
	}
}
*/