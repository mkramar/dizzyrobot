include <../sizes.scad>

//boardHolder();

module boardHolder() {
	h = 10;
	
	difference(){
		cube([boardW + th*2, boardH+th*2, h], center = true);
		cube([boardW + th*2 + 0.01, boardH - th*2, h + 0.01], center = true);
		cube([boardW - th*2, boardH + th*2 + 0.01, h + 0.01], center = true);
		
		translate([0, 0, h - th]) {
			cube([boardW, boardH, h + 0.01], center = true);
		}
	}
}