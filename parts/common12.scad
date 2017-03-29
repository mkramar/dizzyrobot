use <../lib/shapes.scad>
include <../_sizes.scad>

com12CableOffset = 3; // offset from center to the cable ring

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