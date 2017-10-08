//$fn = 70;

module cut1(){
	translate([0, 30, 60]) {
		rotate([160, 0, 0])
		translate([-100, 0, 0])
			cube([200, 200, 170]);
			
		translate([-100, -200, 0])
			cube([200, 200, 100]);
	}
}