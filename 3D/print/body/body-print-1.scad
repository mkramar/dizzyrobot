include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor.scad>
include <../../lib/shapes.scad>
include <../../parts/body.scad>
use <body-print.scad>

//$fn = 70;

intersection() {
	body();

	cut1();
}