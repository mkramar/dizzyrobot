use <../../lib/shapes.scad>
include <../sizes.scad>
include <../../lib/sensor.scad>
include <../../lib/gear.scad>
include <part1.scad>

// public ---------------------------------------------------------------------

module popa(){
	difference()
	{
		union()
		{
			difference()
			{
				popaBase(true);
				popaBase(false);
				
				// legs
				
				popaMinusHalf();
				translate([0, -heapWidth, 0]) mirror([0, 1, 0]) popaMinusHalf();
				
				// holes
				
				translate([55, -heapWidth/2, 20])
				rotate([0, 90, 0])
					cylinder(d = 40, h = 20);
				
				// top		
				translate([0, -heapWidth/2, 135])
					cube([150, 150, 100], center = true);
			}
			
			intersection()
			{
				popaBase(true);
			
				union()
				{
					popaPlusHalf();
					translate([0, -heapWidth, 0]) mirror([0, 1, 0]) popaPlusHalf();
				}
			}
		}
		
		popaMinusHalf2();
		translate([0, -heapWidth, 0]) mirror([0, 1, 0]) popaMinusHalf2();
		
		//cube([100, 100, 100]);
	}
}

module popaBase(outer = true){
	wall = outer ? 0 : th;

	hull()
	{
		translate([0, -heapWidth, 0]) mirror([0, 1, 0]) popaBaseHalf(outer);
		popaBaseHalf(outer);

		// front
		
		translate([-5, -heapWidth/2, 0])
		translate([-0, 0, 0])
			sphere(30 - wall);
	}
}

// private --------------------------------------------------------------------

module popaPlusHalf(){
	translate([axis1xOffset, 0, 0])
	{
		translate([axis1Bearing1 - bb6805h/2 - th, 0, 0])
		{
			// this holds bearings
			
			rotate([0, 90, 0])
				ring(d = bb6805o - 4, h = 50, t = th + 2, center = false);

			// this joins two axis

			translate([8, -bb6805o/2, -th/2])
			mirror([0, 1, 0])
				cube([axis1Bearing2 - axis1Bearing1 - bb6805h - 8, 30, th]);
		}
		
		// this holds sensor
		
		translate([axis1Bearing2 + bb6805h/2, 0, 0])
		rotate([0, 90, 0])
			cylinder(d = 20, h = 10);
			
	}
	
	// this holds motor
	
	rotate(heapMotorRotate)
	translate(heapMotorTranslate)
	translate([0, -15, -20])
		cube([20, 30, 40]);
}

module popaMinusHalf2(){
	translate([axis1xOffset + axis1Bearing1 - bb6805h/2, 0, 0])
	rotate([0, 90, 0])
		cylinder(d = bb6805o, h = axis1Bearing2 - axis1Bearing1 + bb6805h, t = th, center = false);
		
	// sensor
	
	translate([axis1xOffset + axis1Bearing2 + bb6805h/2, 0, 0])
	{
		translate([-0.01, 0, 0])
		rotate([70, 0, 0])
		rotate([0, 90, 0])
		{
			rotationSensorSpacing();
			
			translate([-25, 0, 0])
			cube ([2, 8.5, 15], center = true);
		}
	}
		
	// motor bolts
	
	translate([-0.01, 0, 0])
	rotate(heapMotorRotate)
	translate(heapMotorTranslate)	
	rotate([90, 0, 0])
	rotate([0, 90, 0])
		motor5BoltSpace();
	
}

module popaMinusHalf() {
	rotate([heapSideAngleMin, 0, 0])
	{
		rotate([0, heapFrontAngleMin, 0])
		translate([0, axis2yOffset, axis2zOffset])
			render() partBase(true);

		rotate([0, 80, 0])
		translate([0, axis2yOffset, axis2zOffset])
			render() partBase(true);				
			
		rotate([0, heapFrontAngleMax, 0])
		translate([0, axis2yOffset, axis2zOffset])
			render() partBase(true);				
	}
	
	rotate([30, 0, 0])
	rotate([0, heapFrontAngleMin, 0])
	translate([0, axis2yOffset, axis2zOffset])
		render() partBase(true);
		
	rotate([60, 0, 0])
	rotate([0, heapFrontAngleMin, 0])
	translate([0, axis2yOffset, axis2zOffset])
		render() partBase(true);
		
	rotate([heapSideAngleMax, 0, 0])
	rotate([0, heapFrontAngleMin, 0])
	translate([0, axis2yOffset, axis2zOffset])
		render() partBase(true);
		
	// space for axis1 gear
	
	translate([axis1xOffset + ring1Offset - 5, 0, 0])
		rotate([0, 90, 0])
		cylinder(d = d1 + 10, h = 18);
		
	// space for axis2 gear
	
	translate([0, axis2yOffset, axis2zOffset])
		sphere(d = d2 + 17);
}

module popaBaseHalf(outer){
	wall = outer ? 0 : th;
	
	// back motors

	translate([-35, 5, 10])
	rotate(heapMotorRotate)
	translate(heapMotorTranslate)
		sphere(40 - wall);

	translate([heapBackBearingOffset - 30, 10, -10])
		sphere(30 - wall);
}
