include <../../lib/shapes.scad>

th = 2.5;
dist = 80;

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
	structMinusOuter();
	structMinusInner();
}

module structMinusOuter(){
	for (d = [0, dist]){
		translate([0, d, 0]) {
			cylinder(d = 30, h = 40);
			
			translate([-10, -10, -40])
				cube([20, 20, 40]);
		}
	}
}

module structMinusInner(){
	for (d = [0, dist]){
		translate([0, d, 0]) {
			cylinder(d = 30, h = 40);
			
			translate([-10, -10, -40])
				cube([20, 20, 40]);
		}
	}
}


// print and mold -------------------------------------------------------------

boltPositions = [[15, -15, 0], [-15, dist + 15, 0]];
boxSize = [100, 170, 35];
boxToPart = [-50, -50, 0];
lockPositions = [[-35, -35, 0], [-35, 40, 0], [-35, 105, 0],
				 [35, -35, 0], [35, 40, 0], [35, 105, 0]];
				 
module split(){
	translate([-50, -50, 0])
		cube([100, 200, 45]);
}

module pour(){
	_pour1();
	_pour2();
}

module _pour1() {
	p1 = [40, -20, 0];
	p2 = [36, -20, 0];
	p3 = [0, -43, 0];
	p4 = [-33, -23, 0];
	p5 = [-38, 0, 0];
	p6 = [-30, 0, 0];
	
	translate(p1)
	rotate([0, 90, 0])
		cylinder(d1 = 2, d2 = 30, h = 11);

	rod(p1, p2, 4, $fn = 15);
	rod(p2, p3, 4, $fn = 15);
	rod(p3, p4, 4, $fn = 15);
	rod(p4, p5, 4, $fn = 15);
	rod(p5, p6, 3, $fn = 15);
	
	//
	
	pa = [40, 10, 0];
	pb = [30, 0, 0];
	
	translate(pa)
	rotate([0, 90, 0])
		cylinder(d1 = 2, d2 = 20, h = 11);
		
	rod(pa, pb, 3, $fn = 15);
}

module _pour2(){
	p1 = [40, 90, 0];
	p2 = [36, 90, 0];
	p3 = [10, 113, 0];
	p4 = [-10, 113, 0];
	p5 = [-33, 90, 0];
	p6 = [-33, 80, 0];
	p7 = [-25, 80, 0];
	
	translate(p1)
	rotate([0, 90, 0])
		cylinder(d1 = 2, d2 = 30, h = 11);

	rod(p1, p2, 4, $fn = 15);
	rod(p2, p3, 4, $fn = 15);
	rod(p3, p4, 4, $fn = 15);
	rod(p4, p5, 4, $fn = 15);
	rod(p5, p6, 4, $fn = 15);
	rod(p6, p7, 3, $fn = 15);
	
	pa = [40, 60, 0];
	pb = [25, 80, 0];
	
	translate(pa)
	rotate([0, 90, 0])
		cylinder(d1 = 2, d2 = 20, h = 11);
		
	rod(pa, pb, 3, $fn = 15);
}

module boxAdjustment() {
}