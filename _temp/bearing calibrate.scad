use <../lib/shapes.scad>

$fn = 100;

th = 3;
bbi = 25;
bbo = 37;
bbh = 7;

// inner

ring(h = 10, d = bbi - th*2 - 0.25, t = th);

translate([30, 0, 0])
	ring(h = 10, d = bbi - th*2 - 0.5, t = th);
	
translate([60, 0, 0])
	ring(h = 10, d = bbi - th*2 - 1, t = th);	
	
// outer

translate([0, 40, 0])
	ring(h = 10, d = bbo + 0.25, t = th);

translate([50, 40, 0])
	ring(h = 10, d = bbo + 0.5, t = th);
	
translate([100, 40, 0])
	ring(h = 10, d = bbo + 1, t = th);
	
// plastic

translate([0, -35, 0])
ring(h = 10, d = bbi + 0.25, t = th);

translate([35, -35, 0])
	ring(h = 10, d = bbi + 0.5, t = th);
	
translate([70, -35, 0])
	ring(h = 10, d = bbi + 1, t = th);	
