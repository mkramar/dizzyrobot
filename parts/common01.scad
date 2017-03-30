use <../lib/shapes.scad>
include <../_sizes.scad>

com01CableOffset = 0; // offset from centre to the cable ring

com01JointD = 45;
com01JointH = 28;

xUp = 23;
yUp = 13;

xDown = 28;
yDown = 38;

// bone -----------------------------------------------------------------------

module com01BonePlus(inflate = 0){
	hull()
	{
		translate([0, -1, 0])
		resize([xUp + inflate, yUp + inflate, 1])
			sphere(d = 20);
			
		translate([0, 8, -h])
		resize([xDown + inflate, yDown + inflate, 1])
			 sphere(d = 20);			
	}
}
module com01BoneMinus(){
    hull()
    {
        translate([0, 0, 0])
        resize([xUp - th*2, yUp - th*2, 1])
            sphere(d = 20);
        
        translate([0, 8, - h])
        resize([xDown - th*2, yDown - th*2, 1])
            sphere(d = 20);            
    }
}

// joint ----------------------------------------------------------------------

module com01JointOuter(){
	rotate([0, 90, 0])
		shayba(h = com01JointH + 10, d = com01JointD + 10, rd = 15, $fn = 50);
}

module com01JointInner(inflate = 0){
	rotate([0, 90, 0])
		shayba(h = com01JointH + inflate, d = com01JointD + inflate, rd = 5, $fn = 50);
		//cylinder(h = com01JointH + inflate, d = com01JointD + inflate, center = true, $fn = 50);
}
module com01JointInnerMinus1(){
    rotate([0, 90, 0])
		torus(d = com01JointD + 1, w = 3, $fn = 50);
}
module com01JointInnerMinus2(){
	rotate([0, 90, 0])
		shayba(h = com01JointH - 10, d = com01JointD - 8, rd = 8, $fn = 50);
}
module com01JointInnerMinus3(){
    translate([com01JointH/2, 0, 0])
    rotate([0, 90, 0])
        torus(d = com01JointD-5, w = ball, $fn = 50);
    
    translate([-com01JointH/2, 0, 0])
    rotate([0, 90, 0])
        torus(d = com01JointD-5, w = ball, $fn = 50);
}
module com01JointInnerMinus4a(half = false){
    rotate([0, 90, 0])
	{
		if (half)
		{
			dCylinder(h = com01JointH + 12, d = 30, x = 15);
		}
		else
		{
			//cylinder(h = com01JointH + 12, d1 = 15, d2 = 55);
			cylinder(h = com01JointH + 12, d = 30);  
		}
	}
}
module com01JointInnerMinus4b(){
    rotate([0, -90, 0])
    //cylinder(h = com01JointH + 12, d1 = 15, d2 = 55);    
	cylinder(h = com01JointH + 12, d = 30);  
}
