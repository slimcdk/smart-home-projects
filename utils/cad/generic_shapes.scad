module slot(d, c2cl) {
    square([c2cl,d], center=true);
    translate([-c2cl/2,0]) circle(d=d);
    translate([c2cl/2,0]) circle(d=d);
}


module fillet(r) {
    translate([r,r]) rotate([0,0,180]) difference() {
        square([r/2,r/2]*2);
        circle(r=r);
    } 
}