//Draw a prism based on a 
//right angled triangle
//l - length of prism
//w - width of triangle
//h - height of triangle

module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

//The top point will be centred
module pyramid(w, l, h) {
	mw = w/2;
	ml = l/2;
	polyhedron(points = [
		[0,  0,  0],
		[w,  0,  0],
		[0,  l,  0],
		[w,  l,  0],
		[mw, ml, h]
	], faces = [
		[4, 1, 0],
		[4, 3, 1],
		[4, 2, 3],
		[4, 0, 2],
		//base
		[0, 1, 2],
		[2, 1, 3]
	]);
}

//pyramid(4,4,4);

//A cuboid with a tapered top
//w - width
//l - length
//h - height
//taper - how much to taper the each edge at the top by

module tapered_cuboid(w, l, h, taper) {
	ho = taper;
	hw = w - taper;
	hl = l - taper;
	polyhedron( points=[
		[ 0,  0, 0],
		[ho, ho, h],
		[hw, ho, h],
		[ w,  0, 0],
		[ 0,  l, 0],
		[ho, hl, h],
		[hw, hl, h],
		[ w,  l, 0] 
	], faces = [
		[0, 1, 2],
		[2, 3, 0],
		[3, 2, 6],
		[6, 7, 3],
		[7, 6, 5],
		[5, 4, 7],
		[4, 5, 1],
		[1, 0, 4],
		[1, 5, 2],
		[2, 5, 6],
		[4, 0, 3],
		[7, 4, 3],
	] );
}

module ring(d, h, t, center = true)
{
    difference()
    {
        cylinder(h = h, d = d + t * 2, center = center);
		translate([0, 0, center ? 0 : -1])
			cylinder(h = h + 2, d = d, center = center);
    }
}

module ringDiamond(d, h)
{
	rotate_extrude(convexity = 10)
	translate([d/2, 0, 0])
	rotate([0, 0, 45])
		square(size = [h, h], center = true);
}

module ringSector(d, h, t, a1, a2)
{
    intersection()
    {
        $fn=100;
        ring(d, h, t);
        translate([0, 0, -1]) rotate([0, 0, 90+a1]) cube([d, d, h + 2]);
        translate([0, 0, -1])rotate([0, 0, a2]) cube([d, d, h + 2]);
    }
}

module torus(d, w)
{
    rotate_extrude(convexity = 1)
    translate([d / 2, 0, 0])
        circle(d = w);
}

module rod(a, b, d) // a and b are coordinates of ends, d is diameter
{ 
    translate(a) sphere(d = d); 
    translate(b) sphere(d = d); 

    dir = b-a; 
    h   = norm(dir); 
    if(dir[0] == 0 && dir[1] == 0) { 
        // no transformation necessary 
        cylinder(d = d, h=h); 
    } 
    else { 
        w  = dir / h; 
        u0 = cross(w, [0,0,1]); 
        u  = u0 / norm(u0); 
        v0 = cross(w, u); 
        v  = v0 / norm(v0); 
        multmatrix(m=[[u[0], v[0], w[0], a[0]], 
                      [u[1], v[1], w[1], a[1]], 
                      [u[2], v[2], w[2], a[2]], 
                      [0,    0,    0,    1]]) 
        cylinder(d = d, h=h); 
    } 
} 

module shayba(h, d, rd){
	hull()
	{
		translate([0, 0, h/2 - rd/2])
			torus(d = d - rd, w = rd);
			
		translate([0, 0, -h/2 + rd/2])
			torus(d = d - rd, w = rd);			
	}
}

module halfShayba(h, d, rd){
	intersection()
	{
		shayba(h = h * 2, d = d, rd = rd);
		cylinder(h = h + 1, d1 = d + 1, d2 = d + 1);
	}
}

module dCylinder(h, d, x){
	intersection() 
	{
		cylinder(h = h, d1 = d, d2 = d, center = true);
		translate([x, 0, 0]) cube([d, d, h + 1], center = true);
	}
}

module sphereSector(d, w, a) {
	intersection()
	{
		difference()
		{
			sphere(d = d);
			sphere(d = d - w * 2);
		}
		cylinder(h = d + 1, d1 = 0, d2 = d * tan(a));
	}
}

module cylinderSector(d, h, angle) {
	rotate_extrude(angle=angle, convexity=10)
		square(size = [d/2, h]);
}