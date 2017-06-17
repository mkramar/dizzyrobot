use <../../lib/shapes.scad>
include <../sizes.scad>

// public ---------------------------------------------------------------------

module bb6701(){
	bbi = 12;
	bbo = 18;
	bbh = 4;

	ring(d = bbi, h = bbh, t = (bbo-bbi)/2);
}

module bb6000(){
	bbi = 10;
	bbo = 26;
	bbh = 8;

	ring(d = bbi, h = bbh, t = (bbo-bbi)/2);
}

module bb6800(){
	bbi = 10;
	bbo = 19;
	bbh = 5;

	ring(d = bbi, h = bbh, t = (bbo-bbi)/2);
}

module bb6805(){
	bbi = 25;
	bbo = 37;
	bbh = 7;

	ring(d = bbi, h = bbh, t = (bbo-bbi)/2);
}