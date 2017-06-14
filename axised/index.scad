use <../lib/shapes.scad>
include <sizes.scad>
include <../lib/gear.scad>
include <../lib/sensor.scad>

include <parts/body.scad>
include <parts/heap.scad>
include <parts/part1.scad>
include <parts/motor.scad>
include <parts/bearings.scad>

//

difference()
{
	popa();
	cube([100, 100, 100]);
}

assembly(10, 12);
translate([0, -heapWidth, 0]) mirror([0, 1, 0]) assembly(90, -15);

module assembly(angle1 = 0, angle2 = 0)
	{
	// body

	color("turquoise")
	{
		rotate(heapMotorRotate)
		translate(heapMotorTranslate)
		rotate([0, -90, 0])
			motor4Gear();
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
		
		// axis2 with big ring

		color("pink") axis2Gear();
		color("white") axis2Metal();

		//

		rotate([0, angle2, 0])
		{
			translate([0, axis2yOffset, axis2zOffset])
			{
				%render() part1();
				
				translate(motor2offset)
				rotate([90, 0, 0])
					motor5Gear();
			}
		}
	}
}
