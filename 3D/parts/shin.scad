include <motor8.scad>
include <motor6-tyi.scad>

include <../sizes.scad>
use <elec.scad>

shinTubeUpZ = motor8D/2 + 10;
shinTubeDownZ = motor6D/2 + 10;
shinTubeLength = shinLength - shinTubeUpZ - shinTubeDownZ;

shinTubeUpOffset = [ - 20, 0, -shinLength + shinTubeDownZ + shinTubeLength];
shinTubeDownOffset = [ - 20, 0, -shinLength + shinTubeDownZ];

module shinAssembly(){
	#coords();
	
	difference() {
		union() {
			color("turquoise")
			difference(){
				shinShell("outer");
				shinShell("inner");
			}
			
			color("white") shinMotor();
		}
		
		translate([-100, 0, -50])
			cube([100, 100, 100]);
	}
}

module shinShell(mode) {
	zUp = 10;
	zDn = 10;
	x = -30;
	
	h = 16 + plus2th(mode);
	d1 = 56 + plus2th(mode);
	d2 = 36 + plus2th(mode);
	rd = (mode == "outer" ? 10 : 8);
	
	hull(){
		//translate([0, 0, 0.01])
		_toMotor1() motor8caseRotor(mode);
			
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

		_toMotor2() motor6caseStator(mode);
	}
}

module shinStructPlus(){
	_toMotor1() motor8RotorHolderPlus();
	_toMotor2() motor6StatorHolderPlus();
	
	_toShinBoard() boardHolderPlus();
	_toTerminator() terminatorHolderPlus();
}

module shinStructMinus(){
	shinStructMinusOuter();
	shinStructMinusInner();
}

module shinStructMinusOuter(){
	_toMotor1() motor8RotorHolderMinus();
	_toMotor2() motor6StatorHolderMinus();
	
	// cable hole
	
	translate([0, 0, -55])
	rotate([0, -90, 0])
		cylinder(d = 10, h = 40);
}

module shinStructMinusInner(){
	_toMotor1() motor8();
	_toMotor1() motor8MinusStator();
	
	_toMotor2() motor6();
	_toMotor2() motor6MinusRotor();
	
	_toShinBoard() boardHolderMinus();
	_toTerminator() terminatorHolderMinus();
}
	
module shinMotor() {
	_toMotor2() motor6();
}

// print & mold ---------------------------------------------------------------

shinCutLevel = -25;
//shinMoldDown = -3.5;
shinBoltPositions = [[50, 20, shinCutLevel], [50, -20, shinCutLevel],
				     [150, 15, shinCutLevel], [150, -15, shinCutLevel]];
					 
// shinLockPositions = [[-40, -55, shinMoldDown], [-20, 55, shinMoldDown], [shinLength + 40, -55, shinMoldDown], [shinLength + 20, 55, shinMoldDown],
                      // [45, 42, shinCutLevel + shinMoldDown], [45, -42, shinCutLevel + shinMoldDown], [shinLength - 45, 42, shinCutLevel + shinMoldDown], [shinLength - 45, -42, shinCutLevel + shinMoldDown]];
					  
boxSize = [320, 140, 30];
//boxToPart = [-60, -70, shinMoldDown];

module shinPrintCut() {
	h1 = motor8H + 10 + plus2th("outer");
	d1 = motor8D + plus2th("outer");
	a1 = 40;
	
	translate([shinCutLevel, -50, -300])
	mirror([1, 0, 0])
		cube([30, 100, 400]);
		
	_toMotor1() 
	mirror([1, 0, 0]) {
		cylinderSector(d1, h1, a1, 360-a1);
		cylinder(d = 50, h = h1);
	}
	
	h2 = 15;
	d2 = motor6D + plus2th("outer");	
	a2 = 35;

	_toMotor2() {
		cylinderSector(d2, h2, a2 + 135, 360-a2+135);
		cylinder(d = 50, h = h2);
	}	
}

// private --------------------------------------------------------------------

module _toMotor1(){
	rotate([0, -90, 0])
		children();
}

module _toMotor2() {
	translate(shinMotorOffset)
	rotate([0, 90, 0])
	rotate([0, 0, 45])
		children();
}
module _toShinBoard() {
	translate([-35, 0, -shinLength + 85])
	rotate([0, 90, 0])
		children();
}

module _toTerminator(){
	translate([-35, 0, -70])
	rotate([0, -90, 0])
	rotate([0, 0, -90])
		children();
}
