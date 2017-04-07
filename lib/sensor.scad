//rotationSensor();
//rotationSensorSpacing();

module rotationSensor(){
	//Digi-Key Part Number: 490-2400-ND
	//Manufacturer Part Number: SV01A103AEA01B00
	
	roatationSensorBody();
	
	translate([-6.5, -2.5, -0.6])
		cube([1.5, 0.8, 0.2], center = true);
		
	translate([-6.5, 0, -0.6])
		cube([1.5, 0.8, 0.2], center = true);		
		
	translate([-6.5, 2.5, -0.6])
		cube([1.5, 0.8, 0.2], center = true);		
		
	translate([6.5, 0, -0.6])
		cube([1.5, 0.8, 0.2], center = true);				
}

module roatationSensorBody(inflate = false) {
	x1 = inflate ? 1 : 0;
	x2 = inflate ? 0.25 : 0;

	difference()
	{
		cube ([12 + x1, 11 + x1, 2 + x2], center = true);
		
		//translate([0.5, 0, 0]) 
		difference() 
		{
			cylinder(h = 5, d1 = 4, d2 = 4, center = true, $fn = 15);
			translate([3, 0, 0]) cube([4, 4, 4], center = true);
		}
		
		translate([8 + x2, 7.5 + x2, 0])
		rotate([0, 0, 45]) 
			cube([10, 10, 5], center = true);
		
		translate([8 + x2, -7.5 - x2, 0])
		rotate([0, 0, -45]) 
			cube([10, 10, 5], center = true);
		
		//translate([-8.7 - x2, 8.7 + x2, 0])
		//rotate([0, 0, 45]) 
		//	cube([10, 10, 5], center = true);
		
		//translate([-8.7 - x2, -8.7 - x2, 0])
		//rotate([0, 0, -45]) 
		//	cube([10, 10, 5], center = true);				
	}
}

module rotationSensorSpacing() {
	translate([0, 0, 1])
		roatationSensorBody(inflate = true);
	
	cylinder(h = 10, d = 6, $fn = 15);
	
	translate([-7.5, 0, 0])
		cube ([2, 8.5, 15], center = true);

	translate([-5.5, 5, 2.5])
		cube ([2, 2, 1], center = true);
		
	translate([-5.5, -5, 2.5])
		cube ([2, 2, 1], center = true);
}