include <../sizes.scad>
include <_common.scad>
include <motor6-tyi.scad>
include <elec.scad>
use <../lib/shapes.scad>

module bodyLowerAssembly(){
	//color("lightGray") 
	//{
		%bodyLower("preview");
		//bodyMotors();
	//}
	
	color("white")
		bodyMotors();
}

module bodyLower(mode){
	boardOffset = [-27, -17, 13];
	boardAngle = -35;
	
	difference(){
		union() {
			difference() {
				bodyLowerBase("outer");
				bodyLowerBase("inner");
			}

			if (mode != "preview") {
				intersection() {
					bodyLowerBase("outer");
					
					union() {
						// waist motor
						
						translate(waistMotorOffset2)
						mirror([0, 0, 1])
						rotate([0, 0, 60])
							motor6RotorHolderPlus();
						
						// heap motors
						
						bodySimmetry()
						translate(bodyMotorOffset)
						rotate([-90, 0, 0])
						rotate([0, 0, 90])
							motor6StatorHolderPlus();

						// boards

						bodySimmetry()
						translate(boardOffset)
						rotate([boardAngle, 0, 0])
						rotate([-90, 0, 0])
							boardHolderPlus();
							
						//
 
						translate([0, 0, -10])
							cube([th, 130, 100], center = true);
					}
				}
			}
		}

		if (mode != "preview") {
			// spacing for heap
			
			bodySimmetry()
			translate(bodyMotorOffset)
			rotate([-90, 0, 0])
				motor6MinusRotor();
			
			bodySimmetry()
			translate(bodyMotorOffset)
			translate([0, heapMotorOffsetY, heapMotorOffsetZ])
			rotate([90, 0, 0])
			minkowski() {
				cylinder(d = heapMotorOffsetX + 10, h = 10);
				sphere(d = motor8D);
			}

			// waist motor
			
			translate(waistMotorOffset2)
			mirror([0, 0, 1]) 
			rotate([0, 0, 60])
			{
				motor6RotorHolderMinus();
				motor6();
			}
			
			// heap motors
			
			bodySimmetry()
			translate(bodyMotorOffset)
			rotate([-90, 0, 0])
			rotate([0, 0, 90]){
				motor6StatorHolderMinus();
				motor6();
			}
			
			// cable hole
			
			bodySimmetry()
			translate([15, -20, -30])
			rotate([90, 0, 0])
				cylinder(d = 15, h = 30);
				
			bodySimmetry()
			translate(boardOffset)
			rotate([boardAngle, 0, 0])
			rotate([-90, 0, 0])
				boardHolderMinus();
							
			// adjustments

			translate(waistMotorOffset2)
			mirror([0, 0, 1]) 
			translate([-25, 5, motor6H + 20])
				cube([50, 50, 50]);
				
			translate([0, 27, -50])
			rotate([-20, 0, 0])
				cube([80, 50, 50], center = true);
		}
	}
}

module bodyLowerBase(mode) {	
	hull(){
		translate(waistMotorOffset2)
		mirror([0, 0, 1]) {
			motor6caseRotor(mode);
				
			translate([0, 0, motor6Cut + gap/2]) 
				cylinder(d = motor6D + plus2th(mode), h = 80, center = false);
		}
	
		bodySimmetry()
		translate(bodyMotorOffset)
		rotate([-90, 0, 0])
			motor6case(mode);
	}
}

module spineEnd(mode){
	h = batteryY + 10 + plus2th(mode);
	d1 = batteryX + 30 + plus2th(mode);
	rd = (mode == "outer" ? 20 : 15);

	rotate([90, 0, 0])
		shayba2(h, d1, 10, rd);
}

module bodyMotors(){
	translate(bodyMotorOffset)
	rotate([-90, 0, 0])
		motor6();

	translate(waistMotorOffset2)
	mirror([0, 0, 1])
		motor6();
}

module bodySimmetry(){
	children();
	
	mirror([1, 0, 0])
		children();
}

module bodyMirror(){
	children();
	mirror(1, 0, 0) children();
}