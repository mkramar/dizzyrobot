th = 2.5;
dist = 80;

boltPositions = [[65, 35, 0], [35, dist + 65, 0]];
boxSize = [100, 170, 30];
partToBox = [50, 50, 0];
lockPositions = [[15, 15, 0], [15, 90, 0], [15, 155, 0],
				 [85, 15, 0], [85, 90, 0], [85, 155, 0]];

module shell(mode){
	d1 = 60 + plus2th(mode);
	d2 = 50 + plus2th(mode);
	d3 = 25 + plus2th(mode);
	
	sphere(d = d1);
	translate([0, dist, 0]) sphere (d = d2);	
	rotate([-90, 0, 0]) cylinder(d = d3, h = dist);
	
	if (mode == "outer") pour();
}

module structPlus(){
	for (d = [0, dist]){
		translate([0, d, 0])
		for (a = [0 : 60 : 180]) {
			rotate([0, 0, a])
			cube([100, th, 100], center = true);
		}
	}
}

module structMinus(){
	for (d = [0, dist]){
		translate([0, d, 0]) {
			cylinder(d = 30, h = 40);
			
			translate([-10, -10, -40])
				cube([20, 20, 40]);
		}
	}
}

module split(){
	translate([-50, -50, 0])
		cube([100, 200, 45]);
}

//

module pour() {
	rotate([0, 90, 0]) {
		cylinder(d = 3, h = 50);
		
		translate([0, 0, 40])
			cylinder(d1 = 2, d2 = 30, h = 10);
	}
}