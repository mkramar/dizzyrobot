use <../../parts/motor.scad>

include <shin-print-1.scad>
include <shin-print-2.scad>
include <shin-print-3.scad>
include <shin-print-4.scad>
include <shin-print-5.scad>

color("orange") translate([0.02, 0.5, 0.5]) shinPrint1();
color("pink") translate([0, 0.5, -0.5]) shinPrint2();
color("green") translate([0.01, -0.501, 0.5]) shinPrint3();
color("lightblue") translate([0.03, -0.5, -0.5]) shinPrint4();
translate([0, -0.5, 0]) shinPrint5();

translate([0, -footOffset, -part2Length])
translate([0, ankleMotorOffset, 0])
rotate([90, 0, 0])
	motor4Gear();