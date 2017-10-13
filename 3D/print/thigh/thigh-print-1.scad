include <thigh-print.scad>

//$fn = 50;

rotate([0, 90, 0])
difference() {
	union() {
		difference() {
			thigh();
			cut();
		}
		
		intersection(){
			thighBase("outer");
			boltsPlus();
		}
	}
	
	boltsMinus();
}