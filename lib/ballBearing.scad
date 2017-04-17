
//ballBearingHolder(28, 8, 4);

module ballBearing6707(){
	//35x44x5
	ballBearing(inner = 35, outer = 44, height = 5);
}

module ballBearing6706(){
	//30x37x4
	ballBearing(inner = 30, outer = 37, height = 4);
}

module ballBearing6705() {
	// 25x32x4
	ballBearing(inner = 25, outer = 32, height = 4);
}


module ballBearing8607() {
	// 35x47x7
	ballBearing(inner = 35, outer = 47, height = 7);
}

module ballBearing6806(){
	// 30x42x7
	ballBearing(inner = 30, outer = 42, height = 7);
}

module ballBearing6805() {
	// 25x37x7
	ballBearing(inner = 25, outer = 37, height = 7);
}

module ballBearing6804() {
	//20x32x7
	ballBearing(inner = 20, outer = 32, height = 7);
}

module ballBearing(inner, outer, height) {
	difference()
	{
		cylinder(d = outer, h = height, center = true, $fn = 50);
		cylinder(d = inner, h = height + 2, center = true, $fn = 50);
	}
}

module ballBearingHolder(outer, h, thickness) {
    difference(){
        cylinder(h = h + 2, d1 = outer + thickness * 2, d2 = outer + thickness * 2);
        
        translate([0, 0, 2]) 
            cylinder(h = h+1, d1 = outer, d2 = outer);
        
        translate([0, 0, -1])
            cylinder(h = h + 4, d1 = outer - 4, d2 = outer - 4); 
    }
}