include <../sizes.scad>
include <_common.scad>
include <motor.scad>
include <elec.scad>

module bodyUpperAssembly(){
	//color("lightGray") 
	//{
		%bodyUpper("preview");
		//bodyMotors();
	//}
	
	color("white")
		bodyUpperMotors();
	
	%translate(headOffset)
		sphere(d = headD);
		
	translate([0, 30, 160])
		cube(battery, center = true);
		
	color("red")
	translate([0, 30, 40])
		motor6();
}

module bodyUpper(mode){
	difference(){
		union() {
			difference() {
				bodUpperBase("outer");
				bodUpperBase("inner");
			}

			if (mode != "preview") {
				intersection() {
					bodUpperBase("outer");

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
			rotate([-90, 0, 0])
				motor6MinusRotor();

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
			bodUpperBase("outer");			
			
			translate([0, 0, -10])
			cube([th, 100, 100], center = true);
		}		
	}
}

module bodUpperBase(mode) {	
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

	hull(){
		translate([0, shoulderY, shoulderZ])
			spineEnd(mode);
	
		translate([0, 30, 60])
			spineEnd(mode);
	}
}

module spineEnd(mode){
	h = batteryY + 10 + plus2th(mode);
	d1 = batteryX + 30 + plus2th(mode);
	rd = (mode == "outer" ? 20 : 15);

	rotate([90, 0, 0])
		shayba2(h, d1, 10, rd);
}

module bodyUpperMotors(){
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