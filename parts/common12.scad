use <../lib/shapes.scad>
include <../_sizes.scad>

com12CableOffset = 0; // offset from center to the cable ring

com12JointD = 50;
com12JointH = 24;

// bone -----------------------------------------------------------------------

bone2xUp = 15;
bone2yUp = 17;

bone2xDown = 28;
bone2yDown = 37;

module bone2Plus(inflate = 0){
	hull()
	{
		translate([0, 0, 0])
		resize([bone2xUp + inflate, bone2yUp + inflate, 1])
			sphere(d = 20);
			
		translate([0, 0, -h])
		resize([bone2xDown + inflate, bone2yDown + inflate, 1])
			 sphere(d = 20);			
	}
}
module bone2Minus(){
    hull()
    {
        translate([0, 0, 0])
        resize([bone2xUp - th*2, bone2yUp - th*2, 1])
            sphere(d = 20);
        
        translate([0, 0, - h])
        resize([bone2xDown - th*2, bone2yDown - th*2, 1])
            sphere(d = 20);            
    }
}

// joint ----------------------------------------------------------------------

module com12JointOuter(){
	rotate([0, 90, 0])
		shayba(h = com12JointH + 12, d = com12JointD + th * 2, rd = 15, $fn = 50);
}

module com12JointInner(inflate = 0){
	rotate([0, 90, 0])
		shayba(h = com12JointH + inflate, d = com12JointD + inflate, rd = 5, $fn = 50);
		//cylinder(h = com12JointH + inflate, d = com12JointD + inflate, center = true, $fn = 50);
}
module com12JointInnerMinus1(){
    rotate([0, 90, 0])
		ringDiamond(d = com12JointD + 1, h = cd2);
		//torus(d = com12JointD + 1, w = 3, $fn = 50);
}
module com12JointInnerMinus2(){
	rotate([0, 90, 0])
		shayba(h = com12JointH - 10, d = com12JointD - 8, rd = 8, $fn = 50);
}
module com12JointInnerMinus3(){
    translate([com12JointH/2, 0, 0])
    rotate([0, 90, 0])
        torus(d = com12JointD-5, w = ball, $fn = 50);
    
    translate([-com12JointH/2, 0, 0])
    rotate([0, 90, 0])
        torus(d = com12JointD-5, w = ball, $fn = 50);
}
module com12JointInnerMinus4a(half = false){
    rotate([0, 90, 0])
	{
		if (half)
		{
			dCylinder(h = com12JointH + 12, d = 30, x = 15);
		}
		else
		{
			//cylinder(h = com12JointH + 12, d1 = 15, d2 = 55);
			cylinder(h = com12JointH + 12, d = 30);  
		}
	}
}
module com12JointInnerMinus4b(){
    rotate([0, -90, 0])
    //cylinder(h = com12JointH + 12, d1 = 15, d2 = 55);    
	cylinder(h = com12JointH + 12, d = 30);  
}
