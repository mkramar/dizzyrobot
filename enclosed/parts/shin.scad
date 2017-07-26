include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/gear.scad>
use <../../lib/sensor.scad>
use <bearings.scad>
use <thigh.scad>

// public ---------------------------------------------------------------------

module shinCutup(){
	difference()
	{
		shin();
		translate([0, -100, 0]) cube([100, 100, 100]);
		translate([0, -50, -shinLength-100]) cube([100, 100, 100]);
	}
}

module shin(){
	z = -(rf - rm);
	h1 = th + gap + th;
	h2 = ankleY3 - ankleY6;
	
	difference()
	{
		union()
		{
			difference()
			{
				shinBase("outer");
				shinBase("inner");
				
				translate([0, 0, -shinLength])
				intersection()
				{
					shinBase("outer");
				
					translate([0, toY(h1, ankleY5), z])
					rotate([90, 0, 0])
						cylinder(d = footShellOuter + gap * 2, h = h1 + 0.01);
				}
			}
			
			translate([0, kneeMotorOffset - motor5H - th - gap - 0.01, 0])
			rotate([90, 0, 0])
				ringSector(d = d1 - 3, h = gh, t = 8, start_angle=-kneeMaxAngle+90-20, end_angle=0+90+20, center = false);
		}
		
		translate([0, kneeMotorOffset - motor5H - th - gap, 0])
		rotate([90, 0, 0])
		intersection()
		{
			render() gear(mm_per_tooth,n1,gh,0);
			cylinderSector(d1 + 15, gh + 0.01, -kneeMaxAngle+90-20, 0+90+20);
		}
			
		openingUp();
		
		// space for foot gear
		
		intersection()
		{
			shinBase("outer");

			translate([0, ankleY5 - footOffset, z])
			rotate([90, 0, 0])
				cylinder(d = footShellOuter + gap * 2, h = h1 + 0.01);
		}
		
		// little space for the bearing
		
		z = -shinLength -(rf - rm);
		
		translate([0, ankleY2-footOffset, z])
		rotate([90, 0, 0])
			cylinder(d = bb6701o, h = bb6701h);		
			
		//
		
		translate([0, ankleY4-footOffset, -shinLength])
		rotate([-90, 0, 0])
			motor5BoltSpace2();
	}
	
	// knee bearing holders
	
	translate([0, kneeY9, 0])
	rotate([-90, 0, 0])
		cylinder(d = bb6701i, h = bb6701h);
		
	translate([0, kneeY2, 0])
	rotate([90, 0, 0])
		cylinder(d = bb6701i, h = bb6701h);
		
	// axis holds ankle bearing
	
	axis = ankleY2 - ankleY9;
	z = -shinLength -(rf - rm);
	
	difference()
	{
		translate([0, toY(axis, kneeY2), z])
		rotate([90, 0, 0])
			ring(d = bb6701o, h = axis - 2, t = th);
			
		shinBase("inner");
		
		translate([0, -gap, 0]) shinBase("inner");
	}
	
	translate([0, -footOffset, 0])
	{
		translate([0, ankleY2 - bb6701h, z])
		rotate([90, 0, 0])
			ring(d = bb6701o - 3, t = 3, h = 1.5, center = false);
		
		translate([0, ankleY9 + bb6701h, z])
		difference()
		{
			rotate([-90, 0, 0])
				cylinder(d = bb6701o, h = 3.5);
			
			rotate([-90, 0, 0])
			rotate([0, 0, 90])
				rotationSensorSpacing();
		}
	}
}

module shinBase(mode = "outer"){
	dk = (mode == "outer" ? kneeShellOuter :  kneeShellInner);
	hk = (mode == "outer" ? motor5HOuter : motor5HInner);
	rdk = (mode == "outer" ? 15 : 10);

	translate([0, -shinOffset, 0])
	rotate([90, 0, 0])
		shayba(d = dk, h = hk, rd = rdk);

	//

	ds = 24 + (mode == "outer" ? th*2 : 0);

	d2 = (motor4D + gap*2) + (mode == "outer" ? th*2 : 0);

	h2 = shinH + (mode == "outer" ? 0 :
				   mode == "inner" ? -th*2 :
				   mode == "spacing" ? gap*2 : 0);

	rd2 = (mode == "outer" ? 10 : 5);

	x = (kneeShellInner - 24)/2;
	z1 = 10;
	z2 = 120;
	translate([-x, 0, 0])
	hull()
	{
		translate([0, -shinOffset, 0])
		rotate([90, 0, 0])
			shayba(d = ds, h = hk, rd = rd2);
	
		translate([0, -shinOffset, 0])
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

		translate([0, 0, -shinLength])
		rotate([90, 0, 0])
			shayba(d = d2, h = h2, rd = rd2);
	}
}

module kneeMetal(){
	translate([0, -shinOffset, 0])
	rotate([90, 0, 0])
	{
		translate([0, 0, +motor5HOuter/2 - th - bb6701h/2]) bb6701();
		translate([0, 0, -motor5HOuter/2 + th + bb6701h/2]) bb6701();
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
			thighBase("spacing");
		}
		
		translate([0, toY(h1, kneeY6), 0])
		rotate([90, 0, 0])
			cylinder(d = kneeShellOuter + gap * 2, h = h1 + 0.01, center = true);
	}
}
