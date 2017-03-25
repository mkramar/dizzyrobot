use <../_sizes.scad>
use <../lib/sensor.scad>

module boardJoint(){
	color("white")
	translate([0, 0, 1.5])
		rotationSensor();

	cube([boardSize, boardSize, 1], center = true);
}