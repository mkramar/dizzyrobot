include <../sizes.scad>
use <_common.scad>
use <motor.scad>
use <../../lib/shapes.scad>

module thighAssembly(){
	#coords();
	
	difference() {
		union() {
			color("tan") thigh();
			#color("white") thighMotor();
		}
		
		translate([-20, 0, -50])
			cube([100, 100, 100]);

		translate([0, 0, -thighLength])
		rotate([45, 0, 0])
		translate([-20, 0, -50])
			cube([100, 100, 100]);
			
		translate([0, 0, -thighLength])
		translate([-20, 0, -50])
			cube([100, 100, 100]);			
	}
}

module thigh() {
	difference() {
		union() {
			difference() {
				thighBase("outer");
				thighBase("inner");
			}

			intersection() {
				thighBase("outer");
				
				translate(thighMotorOffset)
				rotate([0, -90, 0])
					motor8StatorHolderPlus();
			}
		}
		
		translate(thighMotorOffset)
		rotate([0, -90, 0])
			motor8StatorHolderMinus();		
			
		translate(thighMotorOffset)
		rotate([0, -90, 0])
			motor8();			
	}
}

module thighBase(mode){
	zUp = 10;
	zDn = 10;
	x = 10;
	
	h = 16 + plus2th(mode);
	d1 = 56 + plus2th(mode);
	d2 = 46 + plus2th(mode);
	rd = (mode == "outer" ? 10 : 8);
	
	difference() {
		union() {
			hull(){		
				translate([0, 0, 0.01])
				rotate([0, -90, 0])
					motor8caseStator(mode);

				translate([x, 0, -zUp])
				rotate([0, 90, 0])
					shayba2(h, d1, 5, rd);
			}
		
			hull(){
				translate([x, 0, -zUp])
				rotate([0, 90, 0])
					shayba2(h, d1, 5, rd);
					
				translate([x, 0, -thighLength+zDn])
				rotate([0, 90, 0])
					shayba2(h, d2, 5, rd);
			}

			hull(){
				translate([x, 0, -thighLength+zDn])
				rotate([0, 90, 0])
					shayba2(h, d2, 5, rd);
						
				translate(thighMotorOffset)
				rotate([0, -90, 0])
					motor8caseStator(mode);
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