
ballBearingHolder(28, 8, 4);

module ball_bearing(type) {

    rim = type[1] / 10;

    render() difference() {
        cylinder(r = type[1] / 2, h = type[2], center = true, $fn = 50);
        cylinder(r = type[0] / 2, h = type[2] + 1, center = true, $fn = 50);
        for(z = [-type[2] / 2, type[2] / 2])
            translate([0,0,z]) difference() {
                cylinder(r = (type[1] - rim) / 2, h = 2, center = true, $fn = 50);
                cylinder(r = (type[0] + rim) / 2, h = 3, center = true, $fn = 50);
            }
    }
}

module ballBearingHolder(outer, h, thickness) {
    difference(){
        cylinder(h = h + 2, d1 = outer + thickness * 2, d2 = outer + thickness * 2);
        
        translate([0, 0, 2]) 
            cylinder(h = h+1, d1 = outer, d2 = outer);
        
        translate([0, 0, -1])
            cylinder(h = h + 4, d1 = outer - 4, d2 = outer - 4); 
    }
}