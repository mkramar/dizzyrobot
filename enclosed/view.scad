include <sizes.scad>
include <parts/thigh.scad>
include <parts/shin.scad>
include <parts/foot.scad>
include <parts/motor.scad>
include <parts/heap.scad>
include <parts/body.scad>

assembly();

kneeAngle = 0;

module assembly(){
	
	// heap
		
	translate([0, 0, thighLength])
	{	
		#heap();
		heapMarkers();
		heapMotors();
		color("white") heapMetal();
	}
	
	// thigh
	
	color("pink")
	difference()
	{
		thigh();
		translate([0, -50, 0]) cube([100, 100, 100]);		
	}

	// motor

	translate([0, kneeMotorOffset, 0])
	rotate([90, 0, 0])
		motor5Gear();

	// knee markers

	#kneeMarkers();

	// shin
		
	*translate([0, 0, -(r1 - rm)])
	{
		rotate([0, -kneeAngle, 0])
		{
			shinCutup();
			#color("white") kneeMetal();

			// foot
			
			*translate([0, -footOffset, -shinLength])
			{		
				%translate([0, ankleMotorOffset, 0])
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
					
					//color("white") footMetal();
				}
				
				#ankleMarkers();
			}
		}
	}
}

module heapMarkers() {
	translate([-5, 0, -50])
	{
		translate([0, heapY1, 0]) cube([10, 0.01, 80]);
		translate([0, heapY2, 0]) cube([10, 0.01, 80]);
		translate([0, heapY3, 0]) cube([10, 0.01, 80]);
		translate([0, heapY4, 0]) cube([10, 0.01, 80]);
		translate([0, heapY5, 0]) cube([10, 0.01, 80]);
		translate([0, heapY6, 0]) cube([10, 0.01, 80]);
		translate([0, heapY7, 0]) cube([10, 0.01, 80]);
		translate([0, heapY8, 0]) cube([10, 0.01, 80]);
		translate([0, heapY9, 0]) cube([10, 0.01, 80]);
		translate([0, heapY0, 0]) cube([10, 0.01, 80]);
	}
}

module kneeMarkers(){
	translate([-5, 0, -50])
	{
		translate([0, kneeY1, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY2, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY3, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY4, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY5, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY6, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY7, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY8, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY9, 0]) cube([10, 0.01, 80]);
		translate([0, kneeY0, 0]) cube([10, 0.01, 80]);
	}
}

module ankleMarkers(){
	translate([-5, 0, -50])
	{
		translate([0, ankleY1, 0]) cube([10, 0.01, 80]);
		translate([0, ankleY2, 0]) cube([10, 0.01, 80]);
		translate([0, ankleY3, 0]) cube([10, 0.01, 80]);
		translate([0, ankleY4, 0]) cube([10, 0.01, 80]);
		translate([0, ankleY5, 0]) cube([10, 0.01, 80]);
		translate([0, ankleY6, 0]) cube([10, 0.01, 80]);
		translate([0, ankleY7, 0]) cube([10, 0.01, 80]);
		translate([0, ankleY8, 0]) cube([10, 0.01, 80]);
		translate([0, ankleY9, 0]) cube([10, 0.01, 80]);
		translate([0, ankleY0, 0]) cube([10, 0.01, 80]);
	}
}