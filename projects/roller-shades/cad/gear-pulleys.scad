

use <../../utils/cad/draw-profiles.scad>;
use <settings.scad>;
use <common-profiles.scad>;

use <parametricPulley_v3.scad>;


roller_pulley();

module driver_pully_profile() {
    projection() pulley("GT2 2mm", tooth_spacing(2,0.254), 0.764, 1.494 );
}


module roller_pulley() {
    difference() {
        union() {
            linear_extrude(7) driver_pully_profile();
            linear_extrude(15) inside_bar_profile();
        }
        
        linear_extrude(5) circle(d=19 + 0.2, $fn=60);
        linear_extrude(5.2) circle(d=19-2, $fn=60);
        for (a=[0:360/8:360]) rotate([0,0,a]) translate([29.972/2-0.4,0,0.4]) linear_extrude(20) circle(d=8.2, $fn=30);
        linear_extrude(50) circle(d=3, $fn=60);
    }   
}

