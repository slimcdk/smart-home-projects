
use <settings.scad>;
use <bottle-profiles.scad>;





module bottle_cup(pipe_cut_depth) {
 
    
    difference() {
        union() rotate_extrude($fn=60) bottle_cup_profile($fn=60);
        
        /* use bottle profile to cut out inside of bottle cup */
        translate([0,0,wall(t())]) rotate_extrude($fn=60) bottle_profile($fn=60);
        /* */
        
        
        /* pipe cutout stuff */
        translate([0,0,wall(t())]) rotate([180,0,0]) linear_extrude(pipe_cut_depth) pipe_bottom_cutout_profile();
        rotate([90+bottle_pipe(angle()),0,90]) {
            linear_extrude(bottle(r())) {
                circle(d=bottle_pipe(d()), $fn=30);
                translate([-bottle_pipe(r()), 0]) square([bottle_pipe(d()), bottle(h())]);        
            }
        }
    }
}




module load_cell_cutout() {
    linear_extrude(load_cell(h())) load_cell_footprint_profile();
}
