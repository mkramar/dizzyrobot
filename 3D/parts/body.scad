include <../sizes.scad>
include <_common.scad>
include <motor.scad>
include <elec.scad>

module bodyAssembly(){
	//color("lightGray") 
	//{
		%body("preview");
		//bodyMotors();
	//}
	
	color("white")
		bodyMotors();
	
	%translate(headOffset)
		sphere(d = headD);
		
	translate([0, 30, 120])
		cube(battery, center = true);
		
	color("red")
		cylinder(d = 40, h = 60);
}

module body(mode){
	difference(){
		union() {
			difference() {
				bodyBase("outer");
				bodyBase("inner");
			}

			if (mode != "preview") {
				intersection() {
					bodyBase("outer");
					
					bodySimmetry()
					union() {
						translate(bodyMotorOffset)
						rotate([-90, 0, 0])
						rotate([0, 0, 90])
							motor6StatorHolderPlus();
							
						// boards

						bodySimmetry()
						translate([-22, -25, 27])
						rotate([-18, 0, 0])
						rotate([-90, 0, 0])
						//rotate([0, 0, -10])
							boardHolder();
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
			
			//
			
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
		
	if (mode != "preview") {
		intersection() {
			bodyBase("outer");			
			
			translate([0, 0, -10])
			cube([th, 100, 100], center = true);
		}		
	}
}

module bodyBase(mode) {	
	bodySimmetry(){
		hull() {
			translate([shoulderWidth/2, 0, 0])
			translate([0, shoulderY, shoulderZ])
			rotate([0, 90, 0])
				motor8case(mode);
				
			translate([0, shoulderY, shoulderZ])
				sphere(10);
		}
	}

	// hull() {
		// translate([0, 50, 180])
			// sphere(45 + plus2th(mode));
		
		// translate([0, 50, 80])
			// sphere(45 + plus2th(mode));
	// }
	
	hull(){
		translate([0, shoulderY, shoulderZ])
			spineEnd(mode);
	
		translate([0, 30, 60])
			spineEnd(mode);
	}

	hull(){
		translate([0, 30, 60])
			spineEnd(mode);
	
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