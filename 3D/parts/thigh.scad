include <../sizes.scad>
use <../lib/shapes.scad>
use <_common.scad>
include <motor6-tyi.scad>
include <motor8.scad>
use <elec.scad>
				 
module thighAssembly(){
	#coords();

	color("white") thighMotor();
			
	difference() {
		union() {
			color("tan") thigh("preview");
		}
		
		translate([-20, 0, -50])
			cube([100, 100, 100]);

		// translate([0, 0, -thighLength])
		// rotate([45, 0, 0])
		// translate([-20, 0, -50])
			// cube([100, 100, 100]);
			
		translate([0, 0, -thighLength])
		translate([-20, 0, -50])
			cube([100, 100, 100]);			
	}
}

module thigh(mode) {
	difference() {
		union() {
			difference() {
				thighShell("outer");
				thighShell("inner");
			}

			if (mode != "preview")
			intersection() {
				thighShell("outer");
		
				union() {
					rotate([0, -90, 0])
					rotate([0, 0, 180])
						motor8StatorHolderPlus();
				
					translate(thighMotorOffset)
					rotate([0, -90, 0])
						motor8StatorHolderPlus();
				}
			}
			
			if (mode != "preview") {
				intersection() {
					thighShell("outer");

					union() {
						_toThighBoard1()
							boardHolderPlus();
					
						_toThighBoard2()
							boardHolderPlus();
					}
				}
			}
		}
		
		if (mode != "preview"){
			rotate([0, -90, 0])
				motor8StatorHolderMinus();
				
			rotate([0, -90, 0])
				motor8();
		
			translate(thighMotorOffset)
			rotate([0, -90, 0])
			rotate([0, 0, 180])
				motor8StatorHolderMinus();
				
			translate(thighMotorOffset)
			rotate([0, -90, 0])
				motor8();
	
			_toThighBoard1()
				boardHolderMinus();
		
			_toThighBoard2()
				boardHolderMinus();				
		}
	}
}

module thighStructPlus(){
	//if (mode != "preview")
	//intersection() {
	//	thighShell("outer");

		union() {
			rotate([0, -90, 0])
			rotate([0, 0, 180])
				motor8StatorHolderPlus();
		
			translate(thighMotorOffset)
			rotate([0, -90, 0])
				motor8StatorHolderPlus();
		}
	//}
	
	//if (mode != "preview") {
	//	intersection() {
	//		thighShell("outer");

			union() {
				_toThighBoard1()
					boardHolderPlus();
			
				_toThighBoard2()
					boardHolderPlus();
			}
	//	}
	//}
}

module thighStructMinus(){
	rotate([0, -90, 0])
		motor8StatorHolderMinus();
		
	rotate([0, -90, 0])
		motor8();

	translate(thighMotorOffset)
	rotate([0, -90, 0])
	rotate([0, 0, 180])
		motor8StatorHolderMinus();
		
	translate(thighMotorOffset)
	rotate([0, -90, 0])
		motor8();

	_toThighBoard1()
		boardHolderMinus();

	_toThighBoard2()
		boardHolderMinus();				
}

module thighShell(mode){
	zUp = 10;
	zDn = 10;
	x = 9;
	
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

// print & mold ---------------------------------------------------------------

cutLevel = 9;
thighBoltPositions = [[50, 22, cutLevel], [50, -22, cutLevel],
				     [150, 20, cutLevel], [150, -20, cutLevel]];
thighLockPositions = [[-40, -45, 0], [-40, 45, 0], [thighLength + 40, -45, 0], [thighLength + 40, 45, 0],
                      [45, 42, cutLevel], [45, -42, cutLevel], [thighLength - 45, 42, cutLevel], [thighLength - 45, -42, cutLevel]];
boxSize = [320, 140, 30];
boxToPart = [-60, -70, 0];
partUp = [0, 0, 3.5];

module thighBoxAdjustment(){
	h = motor8H + 10 + plus2th("outer");
	d = motor8D + plus2th("outer");
	a1 = 35;
	a2 = 40;
	
	difference() {
		translate([0, -55, -0.01])
			cuboid(thighLength, 110, cutLevel, 1);
		
		rotate([0, -90, 0]) 
		translate([cutLevel, 0, 0]){
			translate(thighMotorOffset)
			rotate([0, -90, 0])
				cylinderSector(d, h, a1, 360-a1);
				
			rotate([0, -90, 0])
			mirror([1, 0, 0])
				cylinderSector(d, h, a2, 360-a2);
		}
	}
}

module thighPrintCut() {
	translate([cutLevel, -50, -300])
		cube([20, 100, 400]);
		
	union() {
		translate([cutLevel, 0, 0])
		translate(thighMotorOffset)
		rotate([0, -90, 0])
			motor8caseRough("outer");
		
		translate([cutLevel, 0, 0])		
		rotate([0, -90, 0])
			motor8caseRough("outer");
			
	}
}

// private --------------------------------------------------------------------

module _toThighBoard1(){
	translate([0, 0, -thighLength])
	translate([15, 0, 70])
	rotate([0, -90, 0])
		children();
}

module _toThighBoard2(){
	translate([15, 0, -70])
	rotate([0, -90, 0])
		children();
}