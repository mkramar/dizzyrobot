use <../../lib/shapes.scad>
include <../sizes.scad>
include <../../lib/sensor.scad>
include <../../lib/gear.scad>

// public ---------------------------------------------------------------------

module axis1Gear(){
	difference()
	{
		union()
		{
			translate([ring1Offset, 0, 0])
			{
				rotate([0, 90, 0])
				{
					intersection()
					{
						ringSector(d = d1 - 13, h = gh, t = 8, start_angle = axis1Angle1, end_angle = axis1Angle2);
						render() gear(mm_per_tooth,n1,gh,0);
					}
					
					translate([0, 0, -2])
						ringSector(d = d1 - 13, h = 2, t = 8, start_angle = axis1Angle1, end_angle = axis1Angle2);
					
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
		ring(d = rod25o + 0.6, h = axis1Bearing2 - axis1Bearing1 - bb6805h, t = 2, center = false);
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

module axis2Metal(){
	translate([0, axis2yOffset, axis2zOffset])
	{
		rotate([90, 0, 0])
			cylinder(d = 10, h = axis2, center = true);
		
		translate([0, axis2/2 - 2.5, 0]) rotate([90, 0, 0]) bb6800();
		translate([0, -axis2/2 + 2.5, 0]) rotate([90, 0, 0]) bb6800();
	}
}

module axis2Gear() {
	difference()
	{
		union()
		{
			translate([0, axis2yOffset, axis2zOffset])
			difference()
			{
				union()
				{
					translate([0, ring2Offset + gh - th, 0])
					{
						rotate([90, 0, 0])
						{
							intersection()
							{
								ring(d = d2 - 13, h = gh, t = 8, center = false);
								render() gear(mm_per_tooth,n2,gh,0);
							}
						}
						
						translate([0, - gh, 0])
						rotate([90, 0, 0])
							ring(d = d2 - 13, h = 2, t = 8, center = false);
					}

					translate([0, ring2Offset, 0])
					rotate([90, 0, 0])
						//cylinderSector(d = d2 - 10, h = th, start_angle = axis2Angle1, end_angle = axis2Angle2);
						cylinder(d = d2 - 10, h = th);
				}

				rotate([0, -10, 0])
				translate([0, -axis2/2, 0])
					cube([100, 20, 100]);

				rotate([0, 60, 0])
				translate([0, -axis2/2, 0])
					cube([100, 20, 100]);
			}
			
			translate([0, axis2yOffset, axis2zOffset])
			rotate([90, 0, 0])		
				ring(d = rod + 0.6, h = axis2 - bb6800h*2, t = th, center = true);
			

			translate([-axisOverlap, 0, 0])
			{
				translate([axis1xOffset, 0, 0])
				rotate([0, 90, 0])
					ring(d = rod25i - 0.2 - th*2, h = 10 + axis1xOffset, t = th, center = false);

				rotate([0, 90, 0])
					cylinder(d1 = 10, d2 = rod25i - 0.6, h = axis1xOffset);
			}
		}
		
		rotate([90, 0, 0])
			cylinder(d = rod + 0.6, h = axis2, center = true);
	}
}
