rotationSensor();

module rotationSensor(){
	//Digi-Key Part Number: 490-2400-ND
	//Manufacturer Part Number: SV01A103AEA01B00
	
	difference()
	{
		cube ([12, 11, 2], center = true);
		
		//translate([0.5, 0, 0]) 
		difference() 
		{
			cylinder(h = 5, d1 = 4, d2 = 4, center = true, $fn = 15);
			translate([3, 0, 0]) cube([4, 4, 4], center = true);
		}
		
		translate([7.5, 7.5, 0])
		rotate([0, 0, 45]) 
			cube([10, 10, 5], center = true);
		
		translate([7.5, -7.5, 0])
		rotate([0, 0, -45]) 
			cube([10, 10, 5], center = true);
		
		translate([-8.7, 8.7, 0])
		rotate([0, 0, 45]) 
			cube([10, 10, 5], center = true);
		
		translate([-8.7, -8.7, 0])
		rotate([0, 0, -45]) 
			cube([10, 10, 5], center = true);				
	}
	
	translate([-6.5, -2.5, -0.6])
		cube([1.5, 0.8, 0.2], center = true);
		
	translate([-6.5, 0, -0.6])
		cube([1.5, 0.8, 0.2], center = true);		
		
	translate([-6.5, 2.5, -0.6])
		cube([1.5, 0.8, 0.2], center = true);		
		
	translate([6.5, 0, -0.6])
		cube([1.5, 0.8, 0.2], center = true);				
}