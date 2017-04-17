//bgm3608-70

module bgm3608_70() {
	bgm3608_70_1();
	bgm3608_70_2();
}

module bgm3608_70_1(inflate = 0) {
	cylinder(d = 20 + inflate, h = 3, $fn = 50);
	cylinder(d = 15 + inflate, h = 10, $fn = 50);
	cylinder(d = 4 + inflate, h = 28.5, $fn = 20);
}

module bgm3608_70_2() {
	difference()
	{
		union()
		{
			translate([0, 0, 9]) cylinder(d = 42.2, h = 12, $fn = 50);
	
			translate([-20, -2.5, 21])
				cube([40, 5, 4]);
				
			translate([-2.5, -20, 21])
				cube([5, 40, 4]);
		}
		
		bgm3608_70_1(inflate = 2);
	}
}

module bgm3608(){
	cylinder(d = 43, h = 30);
	cylinder(d = 14, h = 40);
}

module tyiPower5008() {
	cylinder(d = 58, h = 33.5);
	cylinder(d = 14, h = 45);
}