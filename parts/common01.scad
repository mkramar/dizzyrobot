use <../lib/shapes.scad>
include <../_sizes.scad>

com01CableOffset = 3; // offset from center to the cable ring

xUp = 23;
yUp = 10;

xDown = 28;
yDown = 38;

module com01BonePlus(inflate = 0){
	hull()
	{
		translate([0, 0, 0])
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