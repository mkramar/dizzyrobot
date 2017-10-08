include <../sizes.scad>

shinTubeUpZ = motor8D/2 + 10;
shinTubeDownZ = motor6D/2 + 10;
shinTubeLength = shinLength - shinTubeUpZ - shinTubeDownZ;

shinTubeUpOffset = [ - 20, 0, -shinLength + shinTubeDownZ + shinTubeLength];
shinTubeDownOffset = [ - 20, 0, -shinLength + shinTubeDownZ];

module shinAssembly(){
	#coords();
	
	difference() {
		union() {
			color("turquoise") shin("preview");
			color("white") shinMotor();
		}
		
		translate([-100, 0, -50])
			cube([100, 100, 100]);
	}
}

module shin(mode) {
	difference() {
		union() {
			difference(){
				shinBase("outer");
				shinBase("inner");
			}

			intersection() {
				shinBase("outer");
				
				if (mode != "preview") {
					rotate([0, -90, 0])
						motor8RotorHolderPlus();
				}
			}
		}
		
		if (mode != "preview") {
			rotate([0, -90, 0])
				motor8RotorHolderMinus();		
				
			rotate([0, -90, 0])
				motor8();
		}
	}
}

module shinBase(mode) {
	zUp = 10;
	zDn = 10;
	x = -30;
	
	h = 16 + plus2th(mode);
	d1 = 56 + plus2th(mode);
	d2 = 36 + plus2th(mode);
	rd = (mode == "outer" ? 10 : 8);
	
	difference() {
		union() {
			hull(){
				translate([0, 0, 0.01])
				rotate([0, -90, 0])
					motor8caseRotor(mode);
					
				translate([x, 0, -zUp])
				rotate([0, 90, 0])
					shayba2(h, d1, 5, rd);			
			}
				
			hull(){
				translate([x, 0, -zUp])
				rotate([0, 90, 0])
					shayba2(h, d1, 5, rd);
					
				translate([x, 0, -shinLength+zDn])
				rotate([0, 90, 0])
					shayba2(h, d2, 5, rd);
			}

			hull(){
				translate([x, 0, -thighLength+zDn])
				rotate([0, 90, 0])
					shayba2(h, d2, 5, rd);

				translate(shinMotorOffset)
				rotate([0, 90, 0])
					motor6caseStator(mode);
			}
		}
		
		translate(shinMotorOffset)
		rotate([0, 90, 0])
			motor6MinusRotor();
	}
}

module shinMotor() {
	translate(shinMotorOffset)
	rotate([0, 90, 0])
		motor6();
}