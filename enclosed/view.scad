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
	bodyAssembly();

	bodyToHeap(10)
	{
		heapAssembly();
		
		heapToThigh(30)
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
}

module bodyToHeap(angle){
	translate([0, -heapAxis1Yoffset, heapAxis1Zoffset])
	rotate([angle, 0, 0])
	translate([0, heapAxis1Yoffset, -heapAxis1Zoffset])
		children();
}

module heapToThigh(angle){
	rotate([0, angle, 0])
	rotate([0, -thighMotorToAxisUpperAngle, 0])
	translate([rm - gr2, 0, 0])
	rotate([0, thighMotorToAxisUpperAngle, 0])
		children();
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