include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../../_temp/gimbal.scad>
use <../_shared.scad>

module bone1() {
	// heap joint to motor
	
	hull()
	{
		rotate([90, 0, 0])
		translate([0, 0, -bone1UpperAttachment/2])
			cylinder(d = bbi + th* 2, h = bone1UpperAttachment, center = true);
			
		translate(bone1HeapMotorOffset)
			sphere();					
	}
	
	hull() 
	{
		translate(bone1HeapMotorOffset)
		rotate([90, 0, 0])
			shayba(d = 50, h = 30, rd = 5);

		sphere();
	}
	
	// heap motor to knee motor
	
	hull() 
	{
		translate(bone1HeapMotorOffset)
		rotate([90, 0, 0])
			shayba(d = 50, h = 30, rd = 5);
			
		translate(bone1KneeMotorOffset)
			sphere();
	}

	hull()
	{
		translate(bone1KneeMotorOffset)
		rotate([0, -90, 0])
			shayba(d = 70, h = 35, rd = 10);
			
		translate(bone1HeapMotorOffset)
			sphere();			
	}
		
	// knee motor to joint
	
	hull()
	{
		translate(bone1KneeMotorOffset)
		rotate([0, -90, 0])
			shayba(d = 70, h = 35, rd = 10);
			
		translate(bone1KneeOffset)
			sphere();					
	}
	
	hull()
	{
		translate(bone1KneeOffset)
		rotate([0, -90, 0])
		translate([0, 0, -bone1LowerAttachment/2])
			cylinder(d = bbi + th* 2, h = bone1LowerAttachment, center = true);	
			
		translate(bone1KneeMotorOffset)
			sphere();					
	}
}

module bone1Motors(){
	translate(bone1HeapMotorOffset)
	rotate([90, 0, 0])
	translate([0, 0, -15 + th])
		bgm3608();
		
	// knee motor
	translate(bone1KneeMotorOffset)
	rotate([0, -90, 0])
	translate([0, 0, -15 + th])
		tyiPower5008();		
}