include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../_shared.scad>

upperAttachmentCentre = [0, 0, -part1UpperAttachment/2 - bbh/2 - th];

module part1(preview = false) {
	difference()
	{
		part1Base();
		
		if (!preview)
		{
			part1Base(inner = true);
		}

		part1MotorOpening();
			
		// translate([-50, 0, -200])
			// cube ([100, 100, 300]);
	}

	rotate([90, 0, 0])
	translate(upperAttachmentCentre)
	difference()
	{		
		cylinder(d = bbi + th * 2, h = part1UpperAttachment + th * 2, center = true);	
		cylinder(d = bbi, h = part1UpperAttachment + th * 2 + 1, center = true);
	}
}

module part1Base(inner = false) {
	wall = inner ? 0 : th * 2;

	// heap joint to motor

	hull()
	{
		rotate([90, 0, 0])
		translate(upperAttachmentCentre)
			cylinder(d = bbiPlastic + wall, h = part1UpperAttachment+ wall, center = true);
			
		translate([0, 0, motorAdjustment])
		translate(part1HeapMotorOffset)
			sphere(d = 20+ wall);					
	}
	
	hull() 
	{
		translate(part1HeapMotorOffset)
		rotate([-90, 90, 0])
			motor4Block(inner);

		rotate([90, 0, 0])
		translate(upperAttachmentCentre)
			sphere(d = 10+ wall);
	}
	
	// heap motor
	
	translate(part1HeapMotorOffset)
	rotate([-90, 90, 0])
		motor4Block(inner);
	
	// heap motor to knee motor
	
	hull() 
	{
		translate(part1HeapMotorOffset)
		rotate([-90, 90, 0])
			motor4Block(inner);
			
		translate(part1KneeMotorOffset)
			sphere(d = 10+ wall);
	}

	hull()
	{
		translate(part1KneeMotorOffset)
		rotate([0, 90, 0])
			motor5Block(inner);
			
		translate(part1HeapMotorOffset)
			sphere(d = 10+ wall);			
	}
	
	// knee motor
	
	translate(part1KneeMotorOffset)
	rotate([0, 90, 0])
		motor5Block(inner);
			
	// knee motor to joint
	
	//hull()
	//{
	//	translate(part1KneeMotorOffset)
	//	rotate([0, 90, 0])
	//		motor5Block(inner);
	//		
	//	translate(part1KneeOffset)
	//	translate([0, 0, 20])
	//	rotate([0, -90, 0])
	//	translate(lowerAttachmentCentre)
	//		sphere(d = 10+ wall);					
	//}
	

	{
		translate([part1LowerAttachment/2 + bbh/2, 0, 0])
		translate(part1KneeOffset)
		rotate([0, 90, 0])	
			cylinder(d = bbiPlastic + th*2, h = part1LowerAttachment, center = true);
	}
	
	// hull()
	// {
		// l = 30;

		// translate(part1KneeOffset)
		// rotate([0,90, 0])
		// translate([0, 0, l/2 + pulleyH / 2])
			// shayba(d = bbiPlastic + wall, h = l, rd = 10);

		// translate([5, 0, 0])
		// translate(part1KneeMotorOffset)
		// rotate([0, -90, 0])
			// sphere(d = 16 + wall);					
	// }
}

module part1Motors(){
	translate(part1HeapMotorOffset)
	rotate([90, 0, 0])
	translate([0, 0, -motor4H / 2])
		motor4();
		
	// knee motor
	translate(part1KneeMotorOffset)
	rotate([0, -90, 0])
	translate([0, 0, -motor5H / 2])
		motor5();		
}

module part1MotorOpening() {
	rotate([90, 0, 0])
	translate([0, 0, -5 - bbh/2])
		cylinder(d = bbiPlastic, h = 10);
	
	hull() 
	{
		translate([0, 0, motorAdjustment])
		translate(part1HeapMotorOffset)
		rotate([90, 0, 0])
			cylinder(d = motor4SpaceD, h = motor4SpaceH + 20);

		translate([0, 0, -motorAdjustment])
		translate(part1HeapMotorOffset)
		rotate([90, 0, 0])
			cylinder(d = motor4SpaceD, h = motor4SpaceH + 20);
	}
	
	hull()
	{
		translate([0, 0, +motorAdjustment])
		translate(part1KneeMotorOffset)
		rotate([0, -90, 0])
			cylinder(d = motor5SpaceD, h = motor5SpaceH + 20);
			
		translate([0, 0, -motorAdjustment])
		translate(part1KneeMotorOffset)
		rotate([0, -90, 0])
			cylinder(d = motor5SpaceD, h = motor5SpaceH + 20);
	}
	
	translate(part1KneeOffset)
	rotate([0, -90, 0])
		cylinder(d = bbi - th * 2, h = (bbh + thEdge) * 2 + 1, center = true);
		
	//
	
	translate(part1HeapMotorOffset)
	rotate([-90, 0, 0])
	translate([0, 0, 10])
		motor5BoltSpace();
		
	translate(part1KneeMotorOffset)
	rotate([90, 0, 0])
	rotate([0, 90, 0])
	translate([0, 0, 10])
		motor5BoltSpace();		
}