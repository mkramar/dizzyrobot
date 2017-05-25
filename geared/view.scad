use <../lib/shapes.scad>
include <../lib/gear.scad>
use <../lib/sensor.scad>
include <sizes.scad>
use <parts/motor.scad>
use <parts/knee.scad>
use <parts/_shared.scad>

//knee();
motorAssembly();
gearAssembly();
axisAssembly();