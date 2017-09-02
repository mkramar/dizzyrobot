include <../sizes.scad>
include <_common.scad>

module heapAssembly(){
	#coords();
	
	color("seaGreen") heap("preview");
	color("white") heapMotor();
}

module heap(mode) {
	difference() {
		union() {
			difference() {
				heapBase("outer");
				heapBase("inner");
			}
			
			if (mode != "preview") {
				// heap motor
				
				intersection() {
					// translate(heapMotorOffset)
					// rotate([0, -90, 0])
						// motor8caseRotor("outer");
					heapBase("outer");

					translate(heapMotorOffset)
					rotate([0, -90, 0])
					rotate([0, 0, 90])
						motor8RotorHolderPlus();
				}

				// body motor
				
				intersection() {
					rotate([-90, 0, 0])
						motor6caseRotor("outer");

					rotate([-90, 0, 0])
						motor6RotorHolderPlus();
				}
			}
		}
		
		translate(heapMotorOffset)
		rotate([0, -90, 0])
			motor8MinusStator();
			
		if (mode != "preview") {
			// heap motor

			translate(heapMotorOffset)
			rotate([0, -90, 0])
				motor8RotorHolderMinus();		

			translate(heapMotorOffset)
			rotate([0, -90, 0])
				motor8();

			// body motor

			rotate([-90, 0, 0])
				motor6RotorHolderMinus();
				
			rotate([-90, 0, 0])	
				motor6();
		}
	}
}

module heapBase(mode){
	translate([0, 0, 0.01])
	rotate([-90, 0, 0])
		motor6caseRotor(mode);

	translate(heapMotorOffset)
	rotate([0, -90, 0])
		motor8caseRotor(mode);
		
	d1 = 5 + plus2th(mode);
	d2 = 40 + plus2th(mode);
		
	hull() {
		translate(heapMotorOffset)
		translate([-motor8H - 10, 0, 0])
			sphere(d1);
			
		translate([0, motor6H + 9, 0])
		rotate([90, 0, 0])
			cylinder(h = 1, d = d2);
	}		
}

module heapMotor(){
	translate(heapMotorOffset)
	rotate([0, -90, 0])
		motor8();
}
