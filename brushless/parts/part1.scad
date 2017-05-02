include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../_shared.scad>

//upperAttachmentCentre = [0, 0, -part1UpperAttachment/2 - bbh/2 - th];

part1TopCut = (part1HeapMotorOffset[0] - motor5SpaceH / 2);
part1BottomCut = (part1KneeMotorOffset[0] - motor5SpaceH / 2);

module part1(preview = false) {
	difference()
	{
		union()
		{
			part1A(preview);
			//part1B(preview);
		}
		
		translate([-50, 0, -200])
			cube ([100, 100, 300]);		
	}
}

module part1B(preview = false) {
	difference()
	{
		part1BBase(inner = false);
		if (!preview) 
		{
			translate([0.1, 0, 0])
				part1BBase(inner = true);
		}
		
		translate([part1TopCut, 0, 0])
		rotate([0, -90, 0])
			cylinder(d = 62, h = 30, $fn = 100);
			
		translate([part1BottomCut, 0, -h1])
		rotate([0, -90, 0])
			cylinder(d = 62, h = 30, $fn = 100);						
	}
}

module part1BBase(inner = false) {
	wall = inner ? 0 : th * 2;
	
	hull() 
	{
		translate(part1HeapMotorOffset)
		rotate([0, 90, 0])
			motor5BlockB(inner);
			
		translate(part1KneeMotorOffset)
		rotate([0, 90, 0])
			motor5BlockB(inner);
	}
}

module part1A(preview = false) {
	difference()
	{
		part1Base();
		
		if (!preview)
		{
			translate([-0.1, 0, 0])
				part1Base(inner = true);
		}

		flatSide();
		part1MotorOpening();
		
		//translate([-50, 0, -200])
		//	cube ([100, 100, 300]);				
	}

	translate([part1UpperAttachment/2 + bbh/2, 0, 0])
	rotate([0, 90, 0])
		ring(d = bbiPlastic, h = part1UpperAttachment, t = th, $fn = 100);
	
	translate([part1LowerAttachment/2 + bbh/2, 0, 0])
	translate(part1KneeOffset)
	rotate([0, 90, 0])
		ring(d = bbiPlastic, h = part1LowerAttachment, t = th, $fn = 100);
}

module part1Base(inner = false) {
	wall = inner ? 0 : th * 2;

	if (inner)
	{
		translate([part1UpperAttachment/2 + bbh/2, 0, 0])
		rotate([0, 90, 0])
			cylinder(d = bbiPlastic, h = 40, center = true);
	}
	
	hull() 
	{
		translate(part1HeapMotorOffset)
		rotate([0, 90, 0])
			motor5BlockA(inner);

		rotate([90, 0, 0])
		translate([12, 0, 0])
			sphere(d = 10 + wall);
	}
	
	// heap motor
	
	translate(part1HeapMotorOffset)
	rotate([0, 90, 0])
		motor5BlockA(inner);
	
	// heap motor to knee motor
	
	hull() 
	{
		translate(part1HeapMotorOffset)
		rotate([0, 90, 0])
			motor5BlockA(inner);
			
		translate(part1KneeMotorOffset)
		rotate([0, 90, 0])
			motor5BlockA(inner);
	}
	
	// knee motor
	
	translate(part1KneeMotorOffset)
	rotate([0, 90, 0])
		motor5BlockA(inner);
			
	// knee motor to joint
	
	hull()
	{
		translate(part1KneeMotorOffset)
		rotate([0, 90, 0])
			motor5BlockA(inner);
			
		translate(part1KneeOffset)
		translate([12, 0, 0])
		rotate([0, -90, 0])
			sphere(d = 10 + wall);					
	}
	
	if (inner)
	{
		translate([part1LowerAttachment/2 + bbh/2, 0, 0])
		translate(part1KneeOffset)
		rotate([0, 90, 0])
			cylinder(d = bbiPlastic, h = 40, center = true);
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
	rotate([0, -90, 0])
	translate([0, 0, -motor5H / 2])
		motor5();
		
	// knee motor
	translate(part1KneeMotorOffset)
	rotate([0, -90, 0])
	translate([0, 0, -motor5H / 2])
		motor5();		
}

module part1MotorOpening() {
	// rotate([90, 0, 0])
	// translate([0, 0, -5 - bbh/2])
		// cylinder(d = bbiPlastic, h = 10);
	
	// hull() 
	// {
		// translate([0, 0, motorAdjustment])
		// translate(part1HeapMotorOffset)
		// rotate([0, -90, 0])
			// cylinder(d = motor5SpaceD, h = motor4SpaceH + 20);

		// translate([0, 0, -motorAdjustment])
		// translate(part1KneeMotorOffset)
		// rotate([0, -90, 0])
			// cylinder(d = motor5SpaceD, h = motor5SpaceH + 20);
	// }
	
	// translate(part1KneeOffset)
	// rotate([0, -90, 0])
		// cylinder(d = bbi - th * 2, h = (bbh + thEdge) * 2 + 1, center = true);
		
	//
	
	translate(part1HeapMotorOffset)
	rotate([90, 0, 0])
	rotate([0, 90, 0])
	translate([0, 0, 10])
		motor5BoltSpace();
		
	translate(part1KneeMotorOffset)
	rotate([90, 0, 0])
	rotate([0, 90, 0])
	translate([0, 0, 10])
		motor5BoltSpace();		
}

module flatSide() {
	difference()
	{
		x = -50 + part1BottomCut;
		
		translate([x, -50, -h1 - 50])
			cube([50, 100, h1 + 100]);

		rotate([0, 90, 0])
			cylinder(d = bbiPlastic + th * 2, h = 100, center = true);
			
		translate(part1KneeOffset)
		rotate([0, 90, 0])
			cylinder(d = bbiPlastic + th * 2, h = 100, center = true);			
	}
}