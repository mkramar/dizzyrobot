include <thigh-print.scad>

//$fn = 50;

rotate([0, 90, 0])
difference(){
	union() {
		intersection() {
			thigh();
			cut();
		}
		
		intersection(){
			intersection(){
				thighBase("outer");
				cut();
			}
			nutsPlus();
		}
	}
	
	nutsMinus();		
}