use <../lib/shapes.scad>
use <../brushless/_shared.scad>
include <../brushless/_sizes.scad>

th = 3;

//

heapWidth = 90;

//

bb6800i = 10;
bb6800o = 19;
bb6800h = 5;

// axis 1

axis1xOffset = rod/2 + th;
axis1Length = 50;

d1 = 85;
ring1Offset = 8;
axis1Angle1 = 80;
axis1Angle2 = 210;
axis1Bearing1 = ring1Offset + bb6805h/2 + th * 2 + 2;
axis1Bearing2 = axis1Length - bb6805h/2;

// axis 2

axis2 = 45;
d2 = 72;
ring2Offset = -axis2/2 + bb6800h + th + 2;
axis2Offset = 0;
axis2Angle1 = 90;
axis2Angle2 = 300;

// angles

heapSideAngleMin = -10;
heapSideAngleMax = 90;
heapFrontAngleMin = -15;
heapFrontAngleMax = 150;

//

axisOverlap = 4;

motorOffset = 33 + ring2Offset - 5;

heapMotorRotate = [axis1Angle2 - 10, 0, 0];
heapMotorTranslate = [60, 0, -(d1 + 25)/2 + 4];

// derivatives

heapBackBearingOffset = axis1xOffset + axis1Bearing2 + bb6805h;

//



//popa();
//assembly(-10, -15);
//translate([0, -heapWidth, 0]) mirror([0, 1, 0]) assembly(90, -15);

module assembly(angle1 = 0, angle2 = 0)
	{
	// body

	color("turquoise")
	{
		rotate(heapMotorRotate)
		translate(heapMotorTranslate)
		rotate([0, -90, 0])
			motor4();

		#body();
	}

	rotate([angle1, 0, 0])
	{
		// axis1 with small ring
		
		translate([axis1xOffset, 0, 0])
		{
			color("pink") 
			{
				axis1Gear();
				
				translate([axis1Bearing1 + bb6805h/2, 0, 0])
					axis1Ring();
			}
			color("white") axis1Metal();
		}
		
		translate([0, 0, axis2Offset])
		{
			// axis2 with big ring

			color("pink") axis2Gear();

			color("white")
			{
				rotate([90, 0, 0])
					cylinder(d = 10, h = axis2, center = true);
				
				translate([0, axis2/2 - 2.5, 0]) rotate([90, 0, 0]) bb6800();
				translate([0, -axis2/2 + 2.5, 0]) rotate([90, 0, 0]) bb6800();
			}

			//

			rotate([0, angle2, 0])
			{
				%render()
				part1();
				
				translate([0, motorOffset, -(d2 + 25)/2 + 4])
				rotate([90, 0, 0])
					motor5();			
			}
		}
	}
}

module popa(){
	difference()
	{
		popaBase(true);
		popaBase(false);
		
		popaMinusHalf();
		translate([0, -heapWidth, 0]) mirror([0, 1, 0]) popaMinusHalf();
	}
}

module popaMinusHalf() {
	render()
	{
		rotate([heapSideAngleMin, 0, 0])
		{
			rotate([0, heapFrontAngleMin, 0])
				partBase(true);

			rotate([0, 80, 0])
				partBase(true);				
				
			rotate([0, heapFrontAngleMax, 0])
				partBase(true);				
		}
		
		rotate([30, 0, 0])
		rotate([0, heapFrontAngleMin, 0])
			partBase(true);
			
		rotate([60, 0, 0])
		rotate([0, heapFrontAngleMin, 0])
			partBase(true);
			
		rotate([heapSideAngleMax, 0, 0])
		rotate([0, heapFrontAngleMin, 0])
			partBase(true);
			
		// space for gear
		
		translate([axis1xOffset + ring1Offset - 3, 0, 0])
			rotate([0, 90, 0])
			cylinder(d = d1 + 10, h = 16);
	}
}

module popaBase(outer = true){
	wall = outer ? 0 : th;

	hull()
	{
		translate([0, -heapWidth, 0]) mirror([0, 1, 0]) popaBaseHalf(outer);
		popaBaseHalf(outer);

		// front
		
		translate([0, -heapWidth/2, 0])
		translate([-10, 0, 0])
			sphere(30 - wall);
	}
}

module popaBaseHalf(outer){
	wall = outer ? 0 : th;
	
	// back motors

	translate([-30, 0, 0])
	rotate(heapMotorRotate)
	translate(heapMotorTranslate)
		sphere(40 - wall);

	translate([heapBackBearingOffset - 30, 5, -5])
		sphere(35 - wall);
}

module part1() {
	difference()
	{
		partBase(outer = true);
		partBase(outer = false);
		
		do = motor5D + th*2;
		h = axis2 - bb6800h*2;
		
		hull()
		{
			rotate([90, 0, 0])
				shayba(d = do, h = h, rd = 10, center = true);

			translate([0, 0, -100])
			rotate([90, 0, 0])
				shayba(d = do, h = h, rd = 10, center = true);
		}		
		
	translate([-100, -100, -300])
		cube([200, 200, 200]);
		
		
		//translate([-100, -100, -100])
		//	cube([100, 100, 100]);
	}
	
	translate([0, -axis2/2 + bb6800h, 0])
	rotate([90, 0, 0])
		ring(d = bb6800o, h = bb6800h, t = th, center = false);
		
	translate([0, axis2/2, 0])
	rotate([90, 0, 0])
		ring(d = bb6800o, h = bb6800h, t = th, center = false);
		
}

module partBase(outer = true) { 
	do = motor5D + (outer ? th*4 : th*2);
	di = bb6800o + (outer ? th*2 : 0);
	h = axis2 + (outer ? th*2 : 0);
	
	difference()
	{
		difference()
		{
			hull()
			{
				rotate([90, 0, 0])
					shayba(d = do, h = h, rd = 15);

				translate([0, 0, -100])
				rotate([90, 0, 0])
					shayba(d = do, h = h, rd = 15);
			}
			
			difference()
			{
				a1 = -65;
				a2 = 240;
				
				translate([0, h/2 + 0.5, 0])
				rotate([90, 0, 0])
					ringSector(d = di, h = h + 1, t = 100, start_angle = a1, end_angle = a2);
					
				rotate([0, -a1, 0])
				translate([0, -h/2, -0.05])
					cube([100, h + 1, di/2 + 0.1]);

				rotate([0, -a2, 0])
				translate([0, -h/2, -di/2])
					cube([100, h + 1, di/2 + 0.01]);
			}
		}
	}
}

module body(){
	translate([axis1xOffset, 0, 0])
	{
		translate([axis1Bearing1, 0, 0])
		rotate([0, 90, 0])
			ring(d = bb6805o, h = bb6805h + th*2, t = th);

		translate([axis1Bearing2, 0, 0])
		rotate([0, 90, 0])
			ring(d = bb6805o, h = bb6805h + th*2, t = th);
	}
}

module axis1Gear(){
	difference()
	{
		union()
		{
			translate([ring1Offset, 0, 0])
			{
				rotate([0, 90, 0])
				{
					ringSector(d = d1 - 10, h = 10, t = 5, start_angle = axis1Angle1, end_angle = axis1Angle2);
					cylinderSector(d = d1 - 10, h = th, start_angle = axis1Angle1, end_angle = axis1Angle2);
				}
			}

			translate([-axisOverlap, 0, 0])
			rotate([0, 90, 0])
				ring(d = rod25o + 0.6, h = axis1Bearing1 + axisOverlap - bb6805h/2, t = th, center = false);
		}

		translate([-axis1xOffset, 0, 0])
		rotate([90, 0, 0])		
			cylinder(d = rod + 0.6 + th*2, h = axis2, center = true);
			
		rotate([0, 90, 0])
			cylinder(d = rod25o + 0.6, h = axis1Bearing1 + axisOverlap - bb6805h/2, center = false);
	}
}

module axis1Ring() {
	rotate([0, 90, 0])
		ring(d = rod25o + 0.6, h = axis1Bearing2 - axis1Bearing1 - bb6805h, t = th, center = false);
}

module axis1Metal(){
	rotate([0, 90, 0])
		ring(d = rod25i, h = axis1Length, t = (rod25o - rod25i)/2, center = false);

	translate([axis1Bearing1, 0, 0])
	rotate([0, 90, 0])
		bb6805();

	translate([axis1Bearing2, 0, 0])
	rotate([0, 90, 0])
		bb6805();
}

module axis2Gear() {
	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					translate([0, ring2Offset + 10 - th, 0])
					rotate([90, 0, 0])
						//ringSector(d = d2 - 10, h = 10, t = 5, start_angle = axis2Angle1, end_angle = axis2Angle2);
						ring(d = d2 - 10, h = 10, t = 5, center = false);

					translate([0, ring2Offset, 0])
					rotate([90, 0, 0])
						//cylinderSector(d = d2 - 10, h = th, start_angle = axis2Angle1, end_angle = axis2Angle2);
						cylinder(d = d2 - 10, h = th);
				}

				rotate([0, 20, 0])
				translate([0, -axis2/2, 0])
					cube([100, 20, 100]);

				rotate([0, 70, 0])
				translate([0, -axis2/2, 0])
					cube([100, 20, 100]);
			}

			rotate([90, 0, 0])		
				ring(d = rod + 0.6, h = axis2, t = th, center = true);

			translate([-axisOverlap, 0, 0])
			{
				translate([axis1xOffset, 0, 0])
				rotate([0, 90, 0])
					ring(d = rod25i - 0.6 - th*2, h = 10 + axis1xOffset, t = th, center = false);

				rotate([0, 90, 0])
					cylinder(d1 = 10, d2 = rod25i - 0.6, h = axis1xOffset);
			}
		}
		
		rotate([90, 0, 0])
			cylinder(d = rod + 0.6, h = axis2, center = true);
	}
}