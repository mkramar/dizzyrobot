include <../../parts/heap.scad>
use <heap.scad>

rotate([0, 45, 0])
difference() {
	union()
	{
		translate([heapWidth / cos(45), 0, 0])
		rotate([0, 45, 0])
		translate([0, 0, -heapWidth])
		rotate([90, 0, 0]) 
		heap2();

		intersection()
		{
			boltsBplus();
			
			rotate([0, -45, 0])
				cylinder(d = bbo - thEdge*2 + th * 2, h = 100, center = true, $fn = 70);
		}
	}
	
	boltsBminus();
}