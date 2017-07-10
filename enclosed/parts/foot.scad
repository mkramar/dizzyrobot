include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/gear.scad>
use <bearings.scad>
use <shin.scad>

// public ---------------------------------------------------------------------

module foot(mode = "preview") {
	difference()
	{
		footBase("outer");
		footBase("inner");
		
		if (mode == "render")
		{
			footOpeningUp();
		}
		else
		{
			render() footOpeningUp();
		}
		
		// around bearings
		
		translate([0, ankleY9, 0])
		rotate([-90, 0, 0])
			ring(d = bb6701o, h = bb6701h, t = th + 2, center = false);

		translate([0, ankleY2, 0])
		rotate([90, 0, 0])
			ring(d = bb6701o, h = bb6701h, t = th + 2, center = false);
	}

	// gear
	
	translate([0, ankleMotorOffset - motor5H - th*2 - gap, 0])
	{
		intersection()
		{
			difference()
			{
				translate([0, - 0.01, 0])
				rotate([90, 0, 0])
					ring(d = df - 3, h = gh, t = 8, center = false);

				rotate([90, 0, 0])
					render() gear(mm_per_tooth,nf,gh,0);
			}
			
			rotate([90, 0, 0])
				cylinderSector(df + 15, gh + 0.01, ankleAngle1+90-20, ankleAngle2+90+20);
		}
	}
	
	// bearing holders
	
	translate([0, ankleY9, 0])
	rotate([-90, 0, 0])
		cylinder(d = bb6701i, h = bb6701h);

	translate([0, ankleY8, 0])
	rotate([-90, 0, 0])
	rotate([0, 0, 90])
		dCylinder(h = 6, d = 4, x = 1);	
		
	translate([0, ankleY2, 0])
	rotate([90, 0, 0])
		cylinder(d = bb6701i, h = bb6701h);
		
	//
	
	intersection()
	{
		translate([-50, 0, -10])
			cube([100, 100, 100]);
	
		translate([0, ankleY1, 0])
		rotate([90, 0, 0])
			torus(50, th);
	}
}

module footMetal(){
	rotate([90, 0, 0])
	{
		translate([0, 0, +ankleH/2 - th - bb6701h/2]) bb6701();
		translate([0, 0, -ankleH/2 + th + bb6701h/2]) bb6701();
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

	difference()
	{
		translate([0, footOffset, 0])	
		for (a = [ankleAngle1:10:ankleAngle2])
		{
			rotate([0, a, 0])
			translate([0, 0, shinLength + (rf - rm)])
			shinBase("spacing");
		}
		
		translate([0, ankleY6, 0])
		rotate([90, 0, 0])
			cylinder(d = footShellOuter + gap * 2, h = h1 + 0.01, center = false);
	}
}
