include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/pulley.scad>
use <../_shared.scad>

module part2(preview = false) {
	difference()
	{
		part2Base(inner = false, preview = preview);
		
		if (!preview)
		{
			part2Base(inner = true, preview = preview);
			part2MotorOpening();
		}
		
		// translate([0, 0, -200])
			// cube ([100, 100, 300]);
	}
}

module part2Base(inner = false, preview = false) {
	wall = inner ? 0 : th * 2;
	crossCilinder = 50;
	
	translate([-pulleyH/2 - 5, 10, -45])
		cylinder(d =10, h = 60);
	
	translate([-pulleyH/2 - 5, -10, -45])
		cylinder(d =10, h = 60);	
	{
		l = 15;
		
		#translate([-pulleyH/2 - l/2 + 3, 0, 0])
		rotate([0, 90, 0])
			shayba(d = bbo + th * 2, h = l, rd = 6);
	}
	
	// to joint - inner side
	
	rotate([0, 90, 0])
	if (preview)
	{
			cylinder(h = pulleyH, d = bbo + th * 2, center = true);
	}
	else
	{
		pulley(teeth=70, height = belt, center = true);
	}
	
	//hull()
	//{
	//	rotate([0, 90, 0])
	//	translate([0, 0, - 5])
	//		cylinder(h = 1, d = bbo + th, center = true);		
	//
	//	translate([- 10, 0, -bbo / 2])
	//		cube ([8, 10, 40], center = true);
	//}
	
	// to joint - outer side
	
	// hull()
	// {
		// rotate([0, 90, 0])
		// translate([0, 0, upperHolderOffset])
			// cylinder(h = bbh + th, d = bbo + th, center = true);
			
		// translate([0, 0, -crossCilinder])
		// rotate([0, 90, 0])	
		// translate([0, 0, upperHolderOffset])
			// cylinder(h = bbh + th, d = 30, center = true);		
	// }
	
	// translate([0, 0, -crossCilinder])
	// rotate([0, 90, 0])	
		// cylinder(h = part1LowerAttachment + th* 4 + bbh*2 + 2, d = 30, center = true);

	// joint to motor
	
	//hull()
	//{
	//	translate([0, 0, -crossCilinder])
	//	rotate([0, 90, 0])	
	//		cylinder(h = part2LowerAttachment + th* 4 + bbh*2 + 2, d = 30, center = true);
	//		
	//	translate(part2MotorOffset)
	//		sphere(d = 10);
	//}

	hull()
	{
		//translate([0, 0, -crossCilinder])
		//	sphere(d = 10);
	
		translate(part2MotorOffset)
		rotate([0, 90, 0])
		translate([motorAdjustment, 0, 0])
			shayba(d = motor4SpaceD+ wall, h = motor4SpaceH+ wall, rd = 15);	
	}
	
		
	// motor
	
	translate(part2MotorOffset)
	rotate([0, 90, 0])
		motor4BlockA(wall);
	
	translate(part2AnkleOffset)
	hull()
	{
		rotate([0, -90, 0])
			cylinder(d = bbi - th*2 + wall, h = part2LowerAttachment + wall, center = true);
			
		translate([1, 0, 40])
		rotate([0, -90, 0])
			cube([1, 30 + wall, 6 + wall], center = true);					
	}	

}

module part2Motors() {
	translate(part2MotorOffset)
	rotate([0, -90, 0])
	translate([0, 0, -motor4H / 2])
		motor4();	
}