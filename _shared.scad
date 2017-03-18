use <../lib/shapes.scad>
include <_sizes.scad>

module bigBall(){
	rotate([0, 90, 0])
		shayba(h = o2, d = o1, rd = 15, $fn = 50);
}

module smallBall(inflate = 0){
	rotate([0, 90, 0])
		shayba(h = i2 + inflate, d = i1 + inflate, rd = 10, $fn = 50);
}
module smallBallMinus1(){
    rotate([0, 90, 0])
		torus(d = i1 + 2, w = 4, $fn = 50);
}
module smallBallMinus2(){
	rotate([0, 90, 0])
		shayba(h = i2 - 8, d = i1 - 8, rd = 8, $fn = 50);
}
module smallBallMinus3(){
	x = 1.5;
	
    translate([i2/2 - x, 0, 0])
    rotate([0, 90, 0])
        torus(d = i1-x, w = 4.5, $fn = 50);
    
    translate([-i2/2 + x, 0, 0])
    rotate([0, 90, 0])
        torus(d = i1-x, w = 4.5, $fn = 50);
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

module bone1(inflate = 0){
	xUp = 0.35;
	xDown = 0.5;
	
	hull()
	{
		translate([0, -1, 0])
		scale([1, xUp, 1])
			cylinder(h = 1, d1 = 23 + inflate/xUp, d2 = 26 + inflate);
			
		translate([0, 5, -h])
		 scale([xDown, 1, 1])
			 cylinder(h = 1, d1 = 35 + inflate/xDown, d2 = 35 + inflate);			
	}
}
module bone1Minus(){
    hull()
    {
        translate([0, 0, 0 /*-(o1 /2 + 5)*/])
        resize([21, 4, 12]) 
            sphere(d = 20);
        
        translate([0, 4, - h +(o1 /2 + 10)])
        resize([15, 21, 18]) 
            sphere(d = 20);            
    }
}

module bone2(inflate = 0){
    translate([0, 0, -h])
	 resize([15 + inflate, 22 + inflate, h])
         cylinder(h = h, d1 = 20, d2 = 20);
}
module bone2Minus(){
    hull()
    {
        translate([0, 0, 0 /*-(o1 /2 + 5)*/])
        resize([15-th*2, 22-th*2, 20]) 
            sphere(d = 20);
        
        translate([0, 0, - h/* +(o1 /2 + 10)*/])
        resize([15-th*2, 22-th*2, 20]) 
            sphere(d = 20);            
    }
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