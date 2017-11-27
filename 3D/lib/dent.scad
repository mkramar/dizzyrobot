module dent(mode){
	if (mode == "plus") {
		translate([0.5, 3, 0])
			cuboid(w = 6, l = 40, h = 2, taper = 2);
	} else {
		//mirror([0, 0, 1])
		translate([0.4, 3.1, 0])
			cuboid(w = 6.2, l = 40, h = 2, taper = 2);
	}
}
