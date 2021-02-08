
use <settings.scad>;
use <load-cell-profiles.scad>;

module load_cell() {
    linear_extrude(load_cell(h())) load_cell_footprint_profile();
}


load_cell();
load_cell_screw_cutout();

module load_cell_screw_cutout() {
    
    translate([0,0,-6]) linear_extrude(load_cell(h())+8) {
        translate([load_cell(dist()), 0]) circle(d=load_cell(d()), $fn=30);
        translate([load_cell(DIST()), 0]) circle(d=load_cell(d()), $fn=30);
        translate([-load_cell(dist()), 0]) circle(d=load_cell(D()), $fn=30);
        translate([-load_cell(DIST()), 0]) circle(d=load_cell(D()), $fn=30);
    }
    
    translate([0,0,load_cell(h())+2]) linear_extrude(50) {
        translate([load_cell(dist()), 0]) circle(d=8.2, $fn=30);
        translate([load_cell(DIST()), 0]) circle(d=8.2, $fn=30);
        translate([-load_cell(dist()), 0]) circle(d=12.2, $fn=30);
        translate([-load_cell(DIST()), 0]) circle(d=12.2, $fn=30);
    }
}