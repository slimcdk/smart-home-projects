use <settings.scad>;


use <common-profiles.scad>;
use <idler-profiles.scad>;


module cord_pulley_spine() {
    linear_extrude(bearing_19105(h())+0.2) difference() {
        circle(d=bearing_19105(d()), $fn=30);
        circle(d=m4_screw_body(d()), $fn=30);
    }
    
    linear_extrude(0.2) difference() {
        circle(d=bearing_19105(d())+2, $fn=30);
        circle(d=m4_screw_body(d()), $fn=30);
    }
}


cord_roller_pulley();
module cord_roller_pulley() {
    
    cord_pulley_width = cord_balls(d()) + 1;
    cord_cover_thickness = 1;
    roller_bar_piece_length = 20;
    
    difference() {
        union() {
            linear_extrude(cord_pulley_width) cord_pulley_profile();
            translate([0,0, cord_pulley_width]) linear_extrude(cord_cover_thickness) circle(d=roller(d())-0.3);
            translate([0,0, cord_pulley_width+cord_cover_thickness]) linear_extrude(roller_bar_piece_length) inside_bar_profile();
        }
        
        linear_extrude(bearing_19105(h())) circle(d=bearing_19105(D()), $fn=30);
        linear_extrude(bearing_19105(h())+0.2) circle(d=bearing_19105(D())-2, $fn=30);
        linear_extrude(50) circle(d=5, $fn=30);
        
        translate([0,0, cord_pulley_width+cord_cover_thickness+roller_bar_piece_length-bearing_1345(h())]) {
            linear_extrude(bearing_1345(h())) circle(d=bearing_1345(D()), $fn=30);
            translate([0,0,-0.2]) linear_extrude(bearing_1345(h())+0.2) circle(d=bearing_1345(d())+4, $fn=30);
        }
    }
}
