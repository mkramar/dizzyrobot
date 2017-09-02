gimbal();

module standard_servo(){
    color("blue") cube([42, 20, 40]);
    color("white") translate([10, 10, 40]) cylinder(h=7, d1=4, d2=4, $fn=20);
    color("white") translate([10, 10, 45]) cylinder(h=2, d1=20, d2=20, $fn=20);
}

module servo_cage(w){
    translate([-w, -w, -w]) cube([w * 2, 20 + w * 2, w]);
    translate([10-w/2, -w, -w]) cube([w, 20 + w * 2, w]);
    translate([42-w, -w, -w]) cube([w * 2, 20 + w * 2, w]);
    translate([42, -w, -w]) cube([w, 20 + w * 2, w * 2]);
    translate([42, -w, 40 - w]) cube([w, 20 + w * 2, w * 2]);
    translate([42-w, -w, 40]) cube([w * 2, 20 + w * 2, w]);
    translate([-w, -w, 40]) cube([w * 2, 20 + w * 2, w]);
    translate([-w, -w, 40 - w]) cube([w, 20 + w * 2, w * 2]);
    translate([-w, -w, -w]) cube([w, 20 + w * 2, w * 2]);
    
    translate([0, -w, -w]) cube([42 + w, w, w*2]);
    translate([0, -w, 40-w]) cube([42 + w, w, w*2]);
    translate([-w, -w, 0]) cube([w* 2, w, 40]);
    translate([42-w, -w, 0]) cube([w* 2, w, 40]);
    
    translate([0, 20, -w]) cube([42 + w, w, w*2]);
    translate([0, 20, 40-w]) cube([42 + w, w, w*2]);
    translate([-w, 20, 0]) cube([w* 2, w, 40]);
    translate([42-w, 20, 0]) cube([w* 2, w, 40]);    
}

module 9g_motor(){
	difference(){			
		union(){
			color("blue") cube([23,12.5,22], center=true);
			color("blue") translate([0,0,5]) cube([32,12,2], center=true);
			color("blue") translate([5.5,0,2.75]) cylinder(r=6, h=25.75, $fn=20, center=true);
			color("blue") translate([-.5,0,2.75]) cylinder(r=1, h=25.75, $fn=20, center=true);
			color("blue") translate([-1,0,2.75]) cube([5,5.6,24.5], center=true);		
			color("white") translate([5.5,0,3.65]) cylinder(r=2.35, h=29.25, $fn=20, center=true);
		}
		translate([10,0,-11]) rotate([0,-30,0]) cube([8,13,4], center=true);
		for ( hole = [14,-14] ){
			translate([hole,0,5]) cylinder(r=2.2, h=4, $fn=20, center=true);
		}	
	}
}

module motor37()
{
    cylinder(h=30, d1 = 35, d2 = 35);
    
    translate([0, 0, 30])
        cylinder(h = 20, d1 = 37, d2 = 37);
    
    translate([0, 0, 50])
        cylinder(h = 7, d1 = 12, d2 = 12);
    
    translate([0, 0, 57])
        cylinder(h = 15, d1 = 6, d2 = 6);
    
    translate([0, 0, -1])
        cylinder(h = 1, d1 = 12, d2 = 12);
    
    translate([12, -3, -6])
        cube([1, 6, 6]);
    
    translate([-13, -3, -6])
        cube([1, 6, 6]);    
}

module motor25()
{
    cylinder(h=54, d1 = 25, d2 = 25);
    
    translate([0, 0, 54])
        cylinder(h = 2.5, d1 = 7, d2 = 7);
    
    translate([0, 0, 56])
        cylinder(h = 8, d1 = 4, d2 = 4);
    
    translate([0, 0, -1])
        cylinder(h = 1, d1 = 7, d2 = 7);
    
    translate([8, 0, -5])
        cube([3, 1, 5]);
    
    translate([-11, 0, -5])
        cube([3, 1, 5]);      
}

module gimbal()
{
    cylinder(h = 20, d1 = 63, d2 = 63);
    translate([0, 0, 20])
        cylinder(h = 3.5, d1 = 63, d2 = 40);
}