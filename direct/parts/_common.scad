module coords() {
	cylinder(h = 200, d = 1, center = true);
	rotate([90, 0, 0]) cylinder(h = 200, d = 1, center = true);
	rotate([0, 90, 0]) cylinder(h = 200, d = 1, center = true);
}

function plus2th(mode) = (mode == "outer" ? th*2 : 0);
