use <../lib/shapes.scad>
include <_sizes.scad>

module bigBall(){
	rotate([0, 90, 0])
		shayba(h = o2, d = o1, rd = 15, $fn = 50);
}

module smallBall(inflate = 0){
	rotate([0, 90, 0])
		shayba(h = i2 + inflate, d = i1 + inflate, rd = 5, $fn = 50);
		//cylinder(h = i2 + inflate, d = i1 + inflate, center = true, $fn = 50);
}
module smallBallMinus1(){
    rotate([0, 90, 0])
		torus(d = i1 + 1, w = 3, $fn = 50);
}
module smallBallMinus2(){
	rotate([0, 90, 0])
		shayba(h = i2 - 10, d = i1 - 8, rd = 8, $fn = 50);
}
module smallBallMinus3(){
    translate([i2/2, 0, 0])
    rotate([0, 90, 0])
        torus(d = i1-5, w = ball, $fn = 50);
    
    translate([-i2/2, 0, 0])
    rotate([0, 90, 0])
        torus(d = i1-5, w = ball, $fn = 50);
}
module smallBallMinus4a(half = false){
    rotate([0, 90, 0])
	{
		if (half)
		{
			dCylinder(h = o2 + 2, d = 30, x = 15);
		}
		else
		{
			//cylinder(h = o2 + 2, d1 = 15, d2 = 55);
			cylinder(h = o2 + 2, d = 30);  
		}
	}
}
module smallBallMinus4b(){
    rotate([0, -90, 0])
    //cylinder(h = o2 + 2, d1 = 15, d2 = 55);    
	cylinder(h = o2 + 2, d = 30);  
}



//module bearingOuter() {
//	shayba(h = 15, d = is + 8, rd = 5, $fn = 50);
//}
module bearingInner(inflate = false){
	x1 = inflate ? 1.5 : 0;
	x2 = inflate ? 1.5 : 0;
	x3 = inflate ? 2 : 0;

	difference()
	{
		union()
		{
			cylinder(h = 5 + x1, d1 = is - 2.5 + x2, d2 = is - 2.5 + x2, center = true, $fn = 50);
			cylinder(h = 14, d1 = 20 + x3, d2 = 20 + x3, $fn = 50);
			cylinder(h = 8 + x1/2, d1 = is - 2.5 + x2, d2 = is - 2.5 + x2, $fn = 50);
		}
		
		if (!inflate)
		{
			translate([0, 0, 4])
				torus(d = is, w = 3.5, $fn = 50);
		}
	}
}
module bearingMinus() {
	torus(d = is, w = 4.5, $fn = 50);
}