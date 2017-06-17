include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/gear.scad>
use <bearings.scad>
use <part2.scad>

// public ---------------------------------------------------------------------

module foot() {
	difference()
	{
		footBase("outer");
		footBase("inner");
		
		render() footOpeningUp();
	}
}

// private --------------------------------------------------------------------

module footBase(mode = "outer"){
	d = (mode == "outer" ? footShellOuter : footShellInner);
	h = ankleH + (mode == "outer" ? 0 : -th*2);
	rd = (mode == "outer" ? 10 : 5);
	
	intersection()
	{
		translate([0, -0, 0])
		rotate([90, 0, 0])
			shayba(d = d, h = h, rd = rd);
			
		translate([-50, -50, -10]) cube([100, 100, 100]);
	}
	
	s = 15 + (mode == "inner" ? 0 : th);
	
	translate([0, 0, -10])
	{
		hull()
		{
			translate([-60, 15, 0]) sphere(s);
			translate([-60, -15, 0]) sphere(s);
			
			translate([0, 10, 0]) sphere(s);
			translate([0, -10, 0]) sphere(s);			
		}
		
		hull()
		{
			translate([0, 10, 0]) sphere(s);
			translate([0, -10, 0]) sphere(s);			
		
			translate([35, 15, 0]) sphere(s);
			translate([35, -15, 0]) sphere(s);
		}		
	}
}

module footOpeningUp(){
	h1 = 30;

	render()
	difference()
	{
		translate([0, footOffset, 0])	
		for (a = [ankleAngle1:10:ankleAngle2])
		{
			rotate([0, a, 0])
			translate([0, 0, part2Length + (rf - rm)])
			part2Base("spacing");
		}
		
		translate([0, ankleY6, 0])
		rotate([90, 0, 0])
			cylinder(d = footShellOuter + gap * 2, h = h1 + 0.01, center = false);
	}
}
