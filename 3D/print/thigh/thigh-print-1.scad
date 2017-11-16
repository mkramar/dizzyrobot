include <thigh-print.scad>
include <../../lib/cut.scad>

$fn = 50;

mirror([0, 0, 1]) {
	cutBolts(boltPositions){
		rotate([0, -90, 0]) thigh();
		rotate([0, -90, 0]) cut();
		rotate([0, -90, 0]) thighBase("outer");
	}
}

// difference() {
	// union() {
		// difference() {
			// thigh();
			// cut();
		// }
		
		// intersection(){
			// thighBase("outer");
			// boltsPlus();
		// }
	// }
	
	// boltsMinus();
// }