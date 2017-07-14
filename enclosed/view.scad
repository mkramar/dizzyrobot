include <sizes.scad>
include <parts/thigh.scad>
include <parts/shin.scad>
include <parts/foot.scad>
include <parts/motor.scad>
include <parts/heap.scad>
include <parts/body.scad>

assembly();

heapAngle = 10;
kneeAngle = 0;

module assembly(){
	heapAssembly();
	
	rotate([0, heapAngle, 0])
	rotate([0, -thighMotorToAxisUpperAngle, 0])
	translate([rm - gr2, 0, 0])
	rotate([0, thighMotorToAxisUpperAngle, 0])
	{
		thighAssembly();

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