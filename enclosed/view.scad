include <sizes.scad>
include <parts/part1.scad>
include <parts/part2.scad>
include <parts/foot.scad>
include <parts/motor.scad>

assembly();


kneeAngle = 00;

module assembly(){
	// part1
	
	color("pink")
	difference()
	{
		//part1();		
		//translate([0, -50, 0]) cube([100, 100, 100]);		
	}

	// motor

	translate([0, motorOffset, 0])
	rotate([90, 0, 0])
		motor5Gear();

	// knee markers

	#kneeMarkers();

	// part2
		
	translate([0, 0, -(r1 - rm)])
	{
		rotate([0, -kneeAngle, 0])
		{
			difference()
			{
				%part2();
				translate([0, -100, 0]) cube([100, 100, 100]);

				//translate([0, -motorGearOffset - gh/2, -100 + 0.01])
				//mirror([0, 1, 0])
				//	cube([100, 100, 100]);
			}
			color ("white") kneeMetal();

			// foot
			
			translate([0, -footOffset, -part2Length])
			{		
				translate([0, ankleMotorOffset, 0])
				rotate([90, 0, 0])
					motor4Gear();
					
				translate([0, 0, -(rf - rm)])
				{
					color("pink")
					difference()
					{
						foot();
						translate([0, -50, -50]) cube([100, 100, 100]);
					}
					
					color ("white") footMetal();
				}
				
				#ankleMarkers();
			}
		}
	}
}

module kneeMarkers(){
	translate([-5, 0, 0])
	{
		translate([0, kneeY1, 0]) cube([10, 0.01, 30]);
		translate([0, kneeY2, 0]) cube([10, 0.01, 30]);
		translate([0, kneeY3, 0]) cube([10, 0.01, 30]);
		translate([0, kneeY4, 0]) cube([10, 0.01, 30]);
		translate([0, kneeY5, 0]) cube([10, 0.01, 30]);
		translate([0, kneeY6, 0]) cube([10, 0.01, 30]);
		translate([0, kneeY7, 0]) cube([10, 0.01, 30]);
		translate([0, kneeY8, 0]) cube([10, 0.01, 30]);
		translate([0, kneeY9, 0]) cube([10, 0.01, 30]);
		translate([0, kneeY0, 0]) cube([10, 0.01, 30]);
	}
}

module ankleMarkers(){
	translate([-5, 0, 0])
	{
		translate([0, ankleY1, 0]) cube([10, 0.01, 30]);
		translate([0, ankleY2, 0]) cube([10, 0.01, 30]);
		translate([0, ankleY3, 0]) cube([10, 0.01, 30]);
		translate([0, ankleY4, 0]) cube([10, 0.01, 30]);
		translate([0, ankleY5, 0]) cube([10, 0.01, 30]);
		translate([0, ankleY6, 0]) cube([10, 0.01, 30]);
		translate([0, ankleY7, 0]) cube([10, 0.01, 30]);
		translate([0, ankleY8, 0]) cube([10, 0.01, 30]);
		translate([0, ankleY9, 0]) cube([10, 0.01, 30]);
		translate([0, ankleY0, 0]) cube([10, 0.01, 30]);
	}
}