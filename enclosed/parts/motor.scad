use <../../lib/shapes.scad>
use <../../lib/gear.scad>
include <../sizes.scad>

motorGearW = 8;

// public ---------------------------------------------------------------------

module motor5Gear() {
	z = 3;
	
	cylinder(d1 = 30, d2 = motor5D, h = z);
	translate([0, 0, z]) cylinder(d1 = motor5D, d2 = motor5D, h = motor5H - z * 2);
	translate([0, 0, motor5H - z]) cylinder(d1 = motor5D, d2 = 30, h = z);
	
	translate([0, 0, motor5H])
	render()
	{
		motorGearA();
		translate([0, 0, th]) motorGearB();
	}
}

module motor4Gear() {
	z = 3;
	
	cylinder(d1 = 30, d2 = motor4D, h = z);
	translate([0, 0, z]) cylinder(d1 = motor4D, d2 = motor4D, h = motor4H - z * 2);
	translate([0, 0, motor4H - z]) cylinder(d1 = motor4D, d2 = 30, h = z);
	
	translate([0, 0, motor4H])
	render()
	{
		motorGearA();
		translate([0, 0, th]) motorGearB();
	}
}

module motor5BoltSpace(adjustment = 0){
	d = 25 / sqrt(2) / 2;
	
	for (x = [-d, d])
	for (y = [-d, d])
		translate([x, y, 0])
		hull()
		{
			translate([0, adjustment, 0])
				cylinder(d = 4, h = 10);
				
			translate([0, -adjustment, 0])
				cylinder(d = 4, h = 10);
		}
		
	hull()
	{
		translate([0, adjustment, 0])
			cylinder(d = 10, h = 10);
			
		translate([0, -adjustment, 0])
			cylinder(d = 10, h = 10);			
	}
}

module motor5BoltSpace2(){
	d = 25 / sqrt(2) / 2;
	
	for (x = [-d, d])
	for (y = [-d, d])
		translate([x, y, 0])
			oneBolt();
		
	cylinder(d = 10, h = 10, center = true);
}

module motorGearA() {
	sw = 6.5;
	
	difference()
	{
		union()
		{
			cylinder(d = 26, h = th);
			
			rotate([0, 0, 45])
			translate([-motorGearW/2, -motorGearW/2, th])
				cube([motorGearW, motorGearW, gh]);
		}
		
		cylinder(d = 4.5, h = 30, center = true);
		
		dx = 6 / sqrt(2);
		
		for (x = [-dx, dx])
		for (y = [-dx, dx])
			translate([x, y, 0])
				oneBolt();
				
		// translate([0, 0, th-0.01])
			// cylinder(d = sw, h = 15);
	}
}

module motorGearB() {
	difference()
	{
		gear(mm_per_tooth,nm,gh,0);
		
		rotate([0, 0, 45])
			cube([motorGearW + 0.2, motorGearW + 0.2, 30], center = true);
	}
}

// private --------------------------------------------------------------------

module oneBolt() {
	sd = 3.2;
	sw = 6.5;
	sh = 2.5;

	cylinder(d = sd, h = 20, center = true);
	
	translate([0, 0, th - sh])
		cylinder(d1 = sd, d2 = sw, h = sh);
		
	translate([0, 0, th])
		cylinder(d = sw, h = 10);	
}