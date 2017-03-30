use <../lib/shapes.scad>
include <../_sizes.scad>

com12CableOffset = 3; // offset from center to the cable ring

// bone -----------------------------------------------------------------------

module com12BonePlus(inflate = 0){
	hull()
	{
		translate([3, 10 ,0]) sphere(d = 6 + inflate);
		translate([-3, 10 ,0]) sphere(d = 6 + inflate);
		
		translate([3, -10 ,0]) sphere(d = 6 + inflate);
		translate([-3, -10 ,0]) sphere(d = 6 + inflate);		
	
		translate([0, 0, -h])
		{
			translate([6, 12 ,0]) sphere(d = 10 + inflate);
			translate([-6, 12 ,0]) sphere(d = 10 + inflate);
			
			translate([6, -12 ,0]) sphere(d = 10 + inflate);
			translate([-6, -12 ,0]) sphere(d = 10 + inflate);		
		}
	}
}
module com12BoneMinus(){
	hull()
	{
		translate([3, 9 ,0]) sphere(d = 3);
		translate([-3, 9 ,0]) sphere(d = 3);
		
		translate([3, -9 ,0]) sphere(d = 3);
		translate([-3, -9 ,0]) sphere(d = 3);		
	
		translate([0, 0, -h])
		{
			translate([5, 11 ,0]) sphere(d = 6);
			translate([-5, 11 ,0]) sphere(d = 6);
			
			translate([5, -11 ,0]) sphere(d = 6);
			translate([-5, -11 ,0]) sphere(d = 6);		
		}
	}
}

// joint ----------------------------------------------------------------------

module com12JointOuter(){
	rotate([0, 90, 0])
		shayba(h = o2, d = o1, rd = 15, $fn = 50);
}

module com12JointInner(inflate = 0){
	rotate([0, 90, 0])
		shayba(h = i2 + inflate, d = i1 + inflate, rd = 5, $fn = 50);
		//cylinder(h = i2 + inflate, d = i1 + inflate, center = true, $fn = 50);
}
module com12JointInnerMinus1(){
    rotate([0, 90, 0])
		torus(d = i1 + 1, w = 3, $fn = 50);
}
module com12JointInnerMinus2(){
	rotate([0, 90, 0])
		shayba(h = i2 - 10, d = i1 - 8, rd = 8, $fn = 50);
}
module com12JointInnerMinus3(){
    translate([i2/2, 0, 0])
    rotate([0, 90, 0])
        torus(d = i1-5, w = ball, $fn = 50);
    
    translate([-i2/2, 0, 0])
    rotate([0, 90, 0])
        torus(d = i1-5, w = ball, $fn = 50);
}
module com12JointInnerMinus4a(half = false){
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
module com12JointInnerMinus4b(){
    rotate([0, -90, 0])
    //cylinder(h = o2 + 2, d1 = 15, d2 = 55);    
	cylinder(h = o2 + 2, d = 30);  
}
