include <../sizes.scad>
include <_common.scad>
include <motor.scad>
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
	
	%translate(headOffset)
		sphere(d = headD);
		
	translate([0, 30, 160])
		cube(battery, center = true);
}

module bodyLower(mode){
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
						//rotate([0, 0, 35])
							motor6RotorHolderPlus();
						
						// heap motors
						
						bodySimmetry()
						translate(bodyMotorOffset)
						rotate([-90, 0, 0])
						rotate([0, 0, 90])
							motor6StatorHolderPlus();

						// boards

						bodySimmetry()
						translate([-22, -23, 17])
						rotate([-35, 0, 0])
						rotate([-90, 0, 0])
						//rotate([0, 0, -10])
							boardHolder();
							
						//
 
						translate([0, 0, -10])
							cube([th, 100, 100], center = true);
					}
				}
			}
		}

		if (mode != "preview") {
			// spacing for heap
			
			bodySimmetry()
			translate(bodyMotorOffset)
			rotate([-90, 0, 0]) {
				motor6MinusRotor();
				//cylinder(d = heapConnectorCylinderD + th * 2 + gap * 2, h = 120);
			}
			
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
			//rotate([0, 0, 35]) 
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
			translate([20, -20, -17])
			rotate([90, 0, 0])
				cylinder(d = 15, h = 30);
		}		
	}
		//
		
	// if (mode != "preview") {
		// intersection() {
			// bodyLowerBase("outer");			
			
			// translate([0, 0, -10])
			// cube([th, 100, 100], center = true);
		// }		
	// }
}

module bodyLowerBase(mode) {	
	hull(){
		translate(waistMotorOffset2)
		mirror([0, 0, 1])
			motor6caseRotor(mode);
	
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