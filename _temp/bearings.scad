
//6707 = 35x44x5
ballBearing(inner = 35, outer = 44, height = 5);

// 6706 = 30x37x4
translate([50, 0, 0]) ballBearing(inner = 30, outer = 37, height = 4);

// 6705 = 25x32x4
translate([100, 0, 0]) ballBearing(inner = 25, outer = 32, height = 4);


// 8607 = 35x47x7
translate([0, 50, 0]) ballBearing(inner = 35, outer = 47, height = 7);

// 6806 = 30x42x7
translate([50, 50, 0]) ballBearing(inner = 30, outer = 42, height = 7);

// 6805 = 25x27x7
#translate([100, 50, 0]) ballBearing(inner = 25, outer = 37, height = 7);

// 6804 = 20x32x7
translate([0, 100, 0]) ballBearing(inner = 20, outer = 32, height = 7);

//

module ballBearing(inner, outer, height) {
	difference()
	{
		cylinder(d = outer, h = height, $fn = 50);
		translate([0, 0, -1])cylinder(d = inner, h = height + 2, $fn = 50);
	}
}