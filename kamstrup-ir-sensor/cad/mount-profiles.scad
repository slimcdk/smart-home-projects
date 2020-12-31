

use <../../utils/cad/draw-profiles.scad>;

use <settings.scad>;


module faceplate() {
    difference() {
        ir_faceplate();
        magnets_faceplate();
    }
}

module ir_faceplate () {
    difference() {
        circle(r=ir_faceplate(r()), $fn=60);
        translate([ir_diodes(dist())/2, 0]) circle(d=ir_diodes(d()), $fn=60);
        translate([-ir_diodes(dist())/2, 0]) circle(d=ir_diodes(d()), $fn=60);
    }
}

module magnets_faceplate () {
    for (v=[[1,1], [1,-1], [-1,-1], [-1,1]]) translate([v[0]*faceplate_magnets(x())/2, v[1]*faceplate_magnets(y())/2]) circle(d=magnets(d()), $fn=60);
}
