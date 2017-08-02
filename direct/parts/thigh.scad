include <../sizes.scad>

module thighAssembly(){
	#coords();
	
	color("tan") {
		thigh();
		thighMotor();
	}
}

module thigh(){
	zUp = 10;
	zDn = 10;
	
	difference() {
		union() {
			hull(){		
				translate([0, 0, 0.01])
				rotate([0, -90, 0])
					motor8caseStator();

				translate([10, 0, -zUp])
				rotate([0, 90, 0])
					shayba2(20, 60, 5, 10);
			}
		
			hull(){
				translate([10, 0, -zUp])
				rotate([0, 90, 0])
					shayba2(20, 60, 5, 10);
					
				translate([10, 0, -thighLength+zDn])
				rotate([0, 90, 0])
					shayba2(20, 50, 5, 10);					
			}

			hull(){
				translate([10, 0, -thighLength+zDn])
				rotate([0, 90, 0])
					shayba2(20, 50, 5, 10);		
						
				translate(thighMotorOffset)
				rotate([0, -90, 0])
					motor8caseStator();
			}
		}
		
		rotate([0, -90, 0])
			motor8MinusRotor();
			
		translate(thighMotorOffset)
		rotate([0, -90, 0])
			motor8MinusRotor();
	}
}

module thighMotor(){
	translate(thighMotorOffset)
	rotate([0, -90, 0])
		motor8();
}