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
						translate([-18, -15, 23])
						rotate([-35, 0, 0])
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
				cylinder(d = heapConnectorCylinderD + th * 2 + gap * 2, h = 120);
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
		hull()
		translate([shoulderWidth/2, 0, 0])
		translate([0, shoulderY, shoulderZ])
		rotate([0, 90, 0])
			motor8case(mode);
	}

	hull(){
		translate([0, shoulderY, shoulderZ])
			spineEnd(mode);
	
		translate([0, 30, 60])
			spineEnd(mode);
	}

	hull(){
		translate([0, 40, 60])
			sphere(25 + plus2th(mode));
	
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
	//intersection() {
		children();
		
	//	translate([0, -500, -500])
	//		cube([1000, 1000, 1000]);
	//}
	
	//intersection() {
		mirror([1, 0, 0])
			children();
		
	//	translate([-1000, -500, -500])
	//		cube([1000, 1000, 1000]);
	//}
}

module bodyMirror(){
	children();
	mirror(1, 0, 0) children();
}