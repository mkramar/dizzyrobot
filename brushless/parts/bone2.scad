include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../../_temp/gimbal.scad>
use <../_shared.scad>

module bone2(preview = false) {
	bearingOuter(withPulley = !preview);
	
	color("teal")
	hull()
	{
		rotate([0, 90, 0])
			cylinder(d = 50, h = th);	
			
		translate([0, 0, -h2])
		rotate([0, 90, 0])
			cylinder(d = 40, h = th);
	}
	
	// ankle motor
	

	
	// ankle joint
	
	translate([-7, 0, -h2])
		bearingWithHolders(innerColor = "teal");
}

module bone2Motors() {
	translate(bone2MotorOffset)
	rotate([0, -90, 0])
		bgm3608();	
}