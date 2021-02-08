
use <settings.scad>;

load_cell_footprint_profile();

module load_cell_footprint_profile(debug=false) {

    difference() {
        square(load_cell([l(), w()]), center=true);
        translate([load_cell(dist()), 0]) circle(d=load_cell(d()), $fn=30);
        translate([load_cell(DIST()), 0]) circle(d=load_cell(d()), $fn=30);
        translate([-load_cell(dist()), 0]) circle(d=load_cell(D()), $fn=30);
        translate([-load_cell(DIST()), 0]) circle(d=load_cell(D()), $fn=30);
    }
}
