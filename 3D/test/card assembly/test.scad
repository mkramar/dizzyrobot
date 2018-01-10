include <../../sizes.scad>
include <../../parts/motor6-tyi.scad>
include <../../lib/magnetoSensor.scad>
include <../../lib/boltFlat.scad>

$fn = 50;
z = 20;


boardBolts = [[0, 0, z], [98, 0, z], [98, 53.5, z], [0, 53.5, z]];

breakoutW = 18;
breakoutL = 23;
breakoutOffset = [130, 25, 0];
breakoutBolts = [[0, 0, z], [breakoutW, 0, z], [breakoutW, breakoutL, z], [0, breakoutL, z]];

controllerBolts = [[0, 0, z], [17.4, 23.4, z]];

boardOffset = [10, 10, 0];
controller1Offset = [25, 100, 0];
controller2Offset = [110, 100, 0];
motor1Offset = [35, 175, 15];
motor2Offset = [120, 175, 15];

difference()
{
	union()
	{
		cube([155, 210, 8]);
		
		translate(motor1Offset) motorPlus();
		translate(motor2Offset) motorPlus();
		
		translate(boardOffset) nutsPlus(boardBolts);
		translate(breakoutOffset) nutsPlus(breakoutBolts);
		
		translate(controller1Offset) nutsPlus(controllerBolts);
		translate(controller2Offset) nutsPlus(controllerBolts);
	}
	
	translate(motor1Offset) motorMinus();
	translate(motor2Offset) motorMinus();
	
	translate(boardOffset) nutsMinus(boardBolts);
	translate(breakoutOffset) nutsMinus(breakoutBolts);

	translate(controller1Offset) nutsMinus(controllerBolts);
	translate(controller2Offset) nutsMinus(controllerBolts);
	
	translate([20, 20, -9])
		cube([80, 40, 20]);
		
	translate([10, 100, 0]) twoHoles();
	translate([145, 100, 0]) twoHoles();
}

module nutsPlus(bolts) {
	for (a = bolts)
		translate(a)
			nutPlus(15);	
}

module nutsMinus(bolts) {
	for (a = bolts)
		translate(a)
			nutMinus(10);	
}

module motorPlus() {
	rotate([0, 0, 135])
	union(){
		difference() {
			motor6caseStator("outer");
			motor6caseStator("inner");
		}

		intersection() {
			motor6StatorHolderPlus();
			motor6caseStator("outer");
		}
	}
}

module motorMinus(){
	translate([0, -32, 0])
		cube([20, 10, 10], center = true);

	rotate([0, 0, 135]) 
	{
		rotate([0, 0, 0]) motor6();
		motor6StatorHolderMinus();
	}
}

module twoHoles() {
	translate([0, 0, -9])
		cylinder(d = 10, h = 20);
		
	translate([0, 20, -9])
		cylinder(d = 10, h = 20);
		
	translate([-5, 0, 0])
		cube([10, 20, 4]);
}