

use <../../utils/cad/draw-profiles.scad>;
use <settings.scad>;
use <common-profiles.scad>;
use <driver-profiles.scad>;


roller_pulley();


module bearing_19105_mount() {
    linear_extrude(0.2) circle(d=bearing_19105(d())+2, $fn=30);
    translate([0,0,0.2]) linear_extrude(bearing_19105(h())) circle(d=bearing_19105(d()), $fn=30);
}


//clutch_spine();
module clutch_spine() {
    difference() {
        union() {
            linear_extrude(0.2) circle(d=bearing_19105(d())+2, $fn=30);
            translate([0,0,0.2]) linear_extrude(bearing_19105(h())) circle(d=bearing_19105(d()), $fn=30);
            translate([0,0,bearing_19105(h())+0.2]) linear_extrude(gt2_belt(w())+1-bearing_19105(h())+spring_locked_position(h())+2) square(spring_locked_position(r()), true);
            translate([0,0,bearing_19105(h())+0.2+spring_locked_position(h())+gt2_belt(w())+1-bearing_19105(h())+2]) linear_extrude(0.2) circle(d=spring_locked_position(r()), $fn=30);
        }
        linear_extrude(100) circle(d=m4_screw_body(d()), $fn=30);
    }
}


module spring_spine_adapter() {
    difference() {
        union() {
            linear_extrude(gt2_belt(w())+1-bearing_19105(h())) circle(d=spring_locked_position(D())+0.2, $fn=30);
            translate([0,0,gt2_belt(w())+1-bearing_19105(h())]) linear_extrude(spring_locked_position(h())+2) circle(d=spring_locked_position(d()), $fn=30);
        }
        linear_extrude(100) square(spring_locked_position(r())+0.2, true);
    }
}

module clutch_spring_pulley () {
    
    wall = 2;

    difference() {
        union() {
            linear_extrude(gt2_belt(w())+1) driver_pully_profile();
            translate([0,0,gt2_belt(w())+1]) linear_extrude(spring_locked_position(h())) spring_tension_driver(wall);
        }
        linear_extrude(bearing_19105(h())) circle(d=bearing_19105(D()), $fn=30);
        linear_extrude(gt2_belt(w())+1+spring_locked_position(h())) circle(d=spring_locked_position(D())+0.4, $fn=30);
    }
}


module roller_pulley() {
    difference() {
        union() {
            linear_extrude(7) driver_pully_profile();
            linear_extrude(15) inside_bar_profile();
        }
        
        linear_extrude(5) circle(d=19 + 0.2, $fn=60);
        linear_extrude(5.2) circle(d=19-2, $fn=60);
        for (a=[0:36:360]) rotate([0,0,a]) translate([13.9+0.4,0,0.4]) linear_extrude(20) circle(d=8.2, $fn=30);
    }   
}

module roller_adapter() {
    
    wall = 2;
        
    difference() {
        union() {
            linear_extrude(1) circle(d=roller(d()));
            translate([0,0,1]) linear_extrude(spring_locked_position(h())+bearing_1345(w())) inside_bar_profile();
        }
        
        linear_extrude(spring_locked_position(h())+0.2) circle(r=(spring_locked_position(R())+0.2+wall), $fn=30);
        
        // 1345 bearing cutout
        translate([0,0,spring_locked_position(h())+2]) linear_extrude(bearing_1345(h())) circle(d=bearing_1345(D()), $fn=30);
        linear_extrude(spring_locked_position(h())+2) circle(d=bearing_1345(D())-2, $fn=30);
    }
    
    // inner breaking system
    linear_extrude(spring_locked_position(h())+2)difference() {
        spring_tension_driver_negative(wall);
        circle(r=(spring_locked_position(R())+0.2), $fn=30);
    } 
}