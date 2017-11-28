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
		color("tan") //thigh("preview");
			thighShell("outer");
			thighShell("inner");
		
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

// module thigh(mode) {
	// difference() {
		// union() {
			// difference() {
				// thighShell("outer");
				// thighShell("inner");
			// }

			// if (mode != "preview")
			// intersection() {
				// thighShell("outer");
		
				// union() {
					// rotate([0, -90, 0])
					// rotate([0, 0, 180])
						// motor8StatorHolderPlus();
				
					// translate(thighMotorOffset)
					// rotate([0, -90, 0])
						// motor8StatorHolderPlus();
				// }
			// }
			
			// if (mode != "preview") {
				// intersection() {
					// thighShell("outer");

					// union() {
						// _toThighBoard1()
							// boardHolderPlus();
					
						// _toThighBoard2()
							// boardHolderPlus();
					// }
				// }
			// }
		// }
		
		// if (mode != "preview"){
			// rotate([0, -90, 0])
				// motor8StatorHolderMinus();
				
			// rotate([0, -90, 0])
				// motor8();
		
			// translate(thighMotorOffset)
			// rotate([0, -90, 0])
			// rotate([0, 0, 180])
				// motor8StatorHolderMinus();
				
			// translate(thighMotorOffset)
			// rotate([0, -90, 0])
				// motor8();
	
			// _toThighBoard1()
				// boardHolderMinus();
		
			// _toThighBoard2()
				// boardHolderMinus();				
		// }
	// }
// }

module thighStructPlus(){
	_toMotor1() motor8StatorHolderPlus();	
	_toMotor2() motor8StatorHolderPlus();

	_toThighBoard1() boardHolderPlus();
	_toThighBoard2() boardHolderPlus();			
	
	_toTerminator1() terminatorHolderPlus();
	_toTerminator2() terminatorHolderPlus();
}

module thighStructMinus(){
	thighStructMinusInner();
	thighStructMinusOuter();
}

module thighStructMinusOuter(){
	_toMotor1() motor8StatorHolderMinusOuter();
	_toMotor2() motor8StatorHolderMinusOuter();

	_toThighBoard1() boardHolderMinus();
	_toThighBoard2() boardHolderMinus();				
	
	_toTerminator1() terminatorHolderMinusOuter();
	_toTerminator2() terminatorHolderMinusOuter();	
}

module thighStructMinusInner(){
	_toMotor1() {
		motor8StatorHolderMinusInner();
		motor8();
	}

	_toMotor2() {
		motor8StatorHolderMinusInner();
		motor8();
	}
	
	_toTerminator1() terminatorHolderMinusInner();
	_toTerminator2() terminatorHolderMinusInner();	
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
			
		// cable holes
		
		_toCableHole1() cylinder(d1 = 8, d2 = 10, h = 10);			
		_toCableHole2() cylinder(d1 = 8, d2 = 10, h = 10);		
	}
}

module thighMotor(){
	_toMotor2() motor8();
}

// print & mold ---------------------------------------------------------------

thighCutLevel = 9;
thighMoldDown = -3.5;
thighBoltPositions = [[50, 22, thighCutLevel], [50, -22, thighCutLevel],
				     [150, 20, thighCutLevel], [150, -20, thighCutLevel]];
thighLockPositions = [[-40, -55, thighMoldDown], [-20, 55, thighMoldDown], [thighLength + 40, -55, thighMoldDown], [thighLength + 20, 55, thighMoldDown],
                      [45, 42, thighCutLevel + thighMoldDown], [45, -42, thighCutLevel + thighMoldDown], [thighLength - 45, 42, thighCutLevel + thighMoldDown], [thighLength - 45, -42, thighCutLevel + thighMoldDown]];
boxSize = [320, 140, 30];
boxToPart = [-60, -70, thighMoldDown];

module thighBoxAdjustment(){
	h = motor8H + 10 + plus2th("outer");
	d = motor8D + plus2th("outer");
	a1 = 35;
	a2 = 40;
	
	translate([0, 0, thighMoldDown])
	difference() {
		translate([0, -55, -0.01])
			cuboid(thighLength, 110, thighCutLevel, 1);
		
		rotate([0, -90, 0]) 
		translate([thighCutLevel, 0, 0]){
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
	h = motor8H + 10 + plus2th("outer");
	d = motor8D + plus2th("outer");
	a1 = 35;
	a2 = 40;
	
	translate([thighCutLevel, -50, -300])
		cube([20, 100, 400]);
		
	union() {
		translate([thighCutLevel, 0, 0])
		translate(thighMotorOffset)
		rotate([0, -90, 0]){
			cylinderSector(d, h, a1, 360-a1);
			cylinder(d = 50, h = h);
		}
		
		translate([thighCutLevel, 0, 0])		
		rotate([0, -90, 0])
		mirror([1, 0, 0]) {
			cylinderSector(d, h, a2, 360-a2);
			cylinder(d = 50, h = h);
		}
	}
}

module thighPour() {
	_thighPour();
	
	translate([thighLength, 0, 0])
	mirror(0, 0, 1)
		_thighPour();
}

module _thighPour() {
	p1 = [-35, 60, 0];
	p2 = [-54, 20, 0];
	p3 = [-54, -30, 0];
	p4 = [-15, -55, 0];
	p5 = [-10, -45, 0];
	
	translate([0, 0, thighMoldDown]){
		translate(p1)
		rotate([-90, 0, 0])
			cylinder(d1 = 4, d2 = 35, h = 13);
		
		rod(p1, p2, 4, $fn = 15);
		rod(p2, p3, 4, $fn = 15);
		rod(p3, p4, 4, $fn = 15);
		rod(p4, p5, 3, $fn = 15);
		
		//
		
		p6 = [-5, 60, 0];
		p7 = [-5, 46, 0];
		
		translate(p6)
		rotate([-90, 0, 0])
			cylinder(d1 = 3, d2 = 20, h = 13);	
		
		rod(p6, p7, 3, $fn = 15);
	}
}

// private --------------------------------------------------------------------

module _toMotor1() {
	rotate([0, -90, 0])
	rotate([0, 0, 180])
		children();
}
module _toMotor2() {
	translate(thighMotorOffset)
	rotate([0, -90, 0])
		children();
}

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

module _toTerminator1(){
	translate([18, 0, -34])
	rotate([0, 90, 0])
	rotate([0, 0, 90])
		children();
}
module _toTerminator2(){
	translate([19, 0, -thighLength+34])
	rotate([0, 90, 0])
	rotate([0, 0, -90])
		children();
}

module _toCableHole1(){
	translate([15, 0, -20])
	rotate([0, 90, 0])
		children();		

}
module _toCableHole2(){
	translate([15, 0, -thighLength+20])
	rotate([0, 90, 0])
		children();
}