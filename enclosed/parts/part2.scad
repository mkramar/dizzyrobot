include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/gear.scad>
use <bearings.scad>
use <part1.scad>

// public ---------------------------------------------------------------------

module part2(){
	difference()
	{
		union()
		{
			difference()
			{
				part2Base("outer");
				part2Base("inner");
			}
			
			translate([0, motorOffset - motor5H - th - gap - 0.01, 0])
			rotate([90, 0, 0])
				ring(d = d1 - 3, h = gh, t = 8, center = false);
		}
		
		translate([0, motorOffset - motor5H - th - gap, 0])
		rotate([90, 0, 0])
			render() gear(mm_per_tooth,n1,gh,0);
			
		openingUp();
	}
	
	// bearing holders
	
	translate([0, kneeY9, 0])
	rotate([-90, 0, 0])
		cylinder(d = bb6701i, h = bb6701h);
		
	translate([0, kneeY1, 0])
	rotate([90, 0, 0])
		cylinder(d = bb6701i, h = bb6701h);
}

module part2Base(mode = "outer"){
	dk = (mode == "outer" ? kneeShellOuter :  kneeShellInner);
	hk = kneeH + (mode == "outer" ? 0 : -th*2);
	rdk = (mode == "outer" ? 15 : 10);
	
	translate([0, -part2Offset, 0])
	rotate([90, 0, 0])
		shayba(d = dk, h = hk, rd = rdk);

	//
		
	ds = 24 + (mode == "outer" ? th* 2 : 0);
	
	d2 = (motor4D + gap*2 + th*2) + (mode == "outer" ? th* 2 : 0);
	
	h2 = part2H + (mode == "outer" ? 0 :
				   mode == "inner" ? -th*2 :
				   mode == "spacing" ? gap*2 : 0);
	
	rd2 = (mode == "outer" ? 15 : 10);
	
	x = (kneeShellInner - 24)/2;
	z1 = 10;
	z2 = 120;

	translate([-x, 0, 0])
	hull()
	{
		translate([0, -part2Offset, 0])
		rotate([90, 0, 0])
			shayba(d = ds, h = hk, rd = rd2);
	
		translate([0, -part2Offset, 0])
		translate([0, 0, -kneeShellOuter/2 - z1])
		rotate([90, 0, 0])
			shayba(d = ds, h = hk, rd = rd2);
	}
	
	hull()
	{
		translate([-x, 0, 0])
		translate([0, 0, -kneeShellOuter/2 - z1])
		rotate([90, 0, 0])
			shayba(d = ds, h = h2, rd = rd2);
			
		translate([0, 0, -kneeShellOuter/2 - z2])
		rotate([90, 0, 0])
			shayba(d = d2, h = h2, rd = rd2);
	}
	
	hull()
	{
		translate([0, 0, -kneeShellOuter/2 - z2])
		rotate([90, 0, 0])
			shayba(d = d2, h = h2, rd = rd2);

		translate([0, 0, -part2Length])
		rotate([90, 0, 0])
			shayba(d = d2, h = h2, rd = rd2);
	}
}

module part2Metal(){
	translate([0, -part2Offset, 0])
	rotate([90, 0, 0])
	{
		translate([0, 0, +kneeH/2 - th - bb6701h/2]) bb6701();
		translate([0, 0, -kneeH/2 + th + bb6701h/2]) bb6701();
	}
}

// private --------------------------------------------------------------------

module openingUp(){
	h1 = 30;
	
	render()
	difference()
	{
		for (a = [0:20:kneeMaxAngle])
		{
			rotate([0, a, 0])
			translate([0, 0, (r1 - rm)])
			part1Base("spacing");
		}
		
		translate([0, toY(h1, kneeY6), 0])
		rotate([90, 0, 0])
			cylinder(d = kneeShellOuter + gap * 2, h = h1 + 0.01, center = true);
	}
}
