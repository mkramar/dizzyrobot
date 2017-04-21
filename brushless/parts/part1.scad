include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../_shared.scad>

upperAttachmentCentre = [0, 0, -part1UpperAttachment/2 - bbh/2 - th];
lowerAttachmentCentre = [0, 0, -part1LowerAttachment/2 - bbh/2 - th];

module part1(preview = false) {
	difference()
	{
		part1Base();
		
		if (!preview)
		{
			part1Base(inner = true);
			part1MotorOpening();
		}
		
		// translate([0, 0, -200])
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
			cylinder(d = bbi + wall, h = part1UpperAttachment+ wall, center = true);
			
		translate([0, 0, motorAdjustment])
		translate(part1HeapMotorOffset)
			sphere(d = 20+ wall);					
	}
	
	hull() 
	{
		translate([0, 0, motorAdjustment])
		translate(part1HeapMotorOffset)
		rotate([90, 0, 0])
			shayba(d = motor4SpaceD+ wall, h = motor4SpaceH+ wall, rd = 5);

		rotate([90, 0, 0])
		translate(upperAttachmentCentre)
			sphere(d = 10+ wall);
	}
	
	// heap motor
	
	hull() 
	{
		translate([0, 0, motorAdjustment])
		translate(part1HeapMotorOffset)
		rotate([90, 0, 0])
			shayba(d = motor4SpaceD+ wall, h = motor4SpaceH+ wall, rd = 5);

		translate([0, 0, -motorAdjustment])
		translate(part1HeapMotorOffset)
		rotate([90, 0, 0])
			shayba(d = motor4SpaceD+ wall, h = motor4SpaceH+ wall, rd = 5);
	}	
	
	// heap motor to knee motor
	
	hull() 
	{
		translate([0, 0, -motorAdjustment])
		translate(part1HeapMotorOffset)
		rotate([90, 0, 0])
			shayba(d = motor4SpaceD+ wall, h = motor4SpaceH+ wall, rd = 5);
			
		translate(part1KneeMotorOffset)
			sphere(d = 10+ wall);
	}

	hull()
	{
		translate([0, 0, +motorAdjustment])
		translate(part1KneeMotorOffset)
		rotate([0, -90, 0])
			shayba(d = motor5SpaceD+ wall, h = motor5SpaceH+ wall, rd = 10);
			
		translate(part1HeapMotorOffset)
			sphere(d = 10+ wall);			
	}
	
	// knee motor
		
	hull()
	{
		translate([0, 0, +motorAdjustment])
		translate(part1KneeMotorOffset)
		rotate([0, -90, 0])
			shayba(d = motor5SpaceD+ wall, h = motor5SpaceH+ wall, rd = 10);
			
		translate([0, 0, -motorAdjustment])
		translate(part1KneeMotorOffset)
		rotate([0, -90, 0])
			shayba(d = motor5SpaceD+ wall, h = motor5SpaceH+ wall, rd = 10);
	}
			
	// knee motor to joint
	
	// hull()
	// {
		// translate([0, 0, -motorAdjustment])
		// translate(part1KneeMotorOffset)
		// rotate([0, -90, 0])
			// shayba(d = motor5SpaceD+ wall, h = motor5SpaceH+ wall, rd = 10);
			
		// translate(part1KneeOffset)
		// translate([0, 0, 20])
		// rotate([0, -90, 0])
		// translate(lowerAttachmentCentre)
			// sphere(d = 10+ wall);					
	// }
	
	translate(part1KneeOffset)
	hull()
	{
		rotate([0, -90, 0])
		translate(lowerAttachmentCentre)
			cylinder(d = bbi + wall, h = part1LowerAttachment+ wall, center = true);
			
		
		translate([1, 0, 40])
		rotate([0, -90, 0])
		translate(lowerAttachmentCentre)
			cube([1, 30 + wall, 6 + wall], center = true);					
	}
	
	if (!inner)
	{
		translate(part1KneeOffset)
		rotate([0, -90, 0])
		translate(lowerAttachmentCentre)		
			cylinder(d = bbi - bbMargin * 2, h = part1LowerAttachment + (bbh + thEdge) * 2, center = true);	
	}
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
		cylinder(d = bbi - bbMargin * 2, h = 10);
	
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
	translate(lowerAttachmentCentre)
		cylinder(d = bbi - th * 2, h = part1LowerAttachment + (bbh + thEdge) * 2 + 1, center = true);
}