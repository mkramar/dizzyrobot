use <../lib/shapes.scad>
include <../_sizes.scad>

module com12BonePlus(inflate = 0){
	hull()
	{
		translate([4, 10 ,0]) sphere(d = 6);
		translate([-4, 10 ,0]) sphere(d = 6);
		
		translate([4, -10 ,0]) sphere(d = 6);
		translate([-4, -10 ,0]) sphere(d = 6);		
	
		translate([0, 0, -h])
		{
			translate([6, 12 ,0]) sphere(d = 10);
			translate([-6, 12 ,0]) sphere(d = 10);
			
			translate([6, -12 ,0]) sphere(d = 10);
			translate([-6, -12 ,0]) sphere(d = 10);		
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