


use <settings.scad>;

use <common-profiles.scad>;

use <driver-modules.scad>;
use <driver-profiles.scad>;
use <idler-profiles.scad>;
use <idler-modules.scad>;


!driver_assembly();
mirror([1,0,0]) idler_assembly();


module driver_assembly() {
    difference() {
        linear_extrude(window_frame()) housing_profile();
              
        /* electronics compartment */
        linear_extrude(window_frame()-2) driver_electronic_compartment(debug=false);
        /* */
        
        /* bottom mounting screw */
        translate([0, bounding_box(y())-cleat_screw_head(d()), window_frame()/2]) rotate([0,90,0]) linear_extrude(wall(y())) circle(d=cleat_screw_body(d()), $fn=60);
        translate([wall(y()), bounding_box(y())-cleat_screw_head(d()), window_frame()/2]) rotate([0,90,0]) linear_extrude(10) circle(d=cleat_screw_head(d()), $fn=60);
        /* */

        /* belt and pullies cutout*/
        #translate([0,0,wall(z())]) linear_extrude(30) driver_belt_cutout();
        /* */

        /* roller cutout */
        translate([0,0,wall(z())+gt2_belt(w())+1]) linear_extrude(window_frame()-wall(z())) roller_cutout();
        translate([0,0,wall(z())+gt2_belt(w())+1]) linear_extrude(window_frame()-wall(z())) roller_boom_cover_slot();
        translate(concat(roller_center([x(),y()]), wall(z())-magnet(h())-0.4)) linear_extrude(magnet(h())) magnet_circluar_array();
        /* */
        
        /* motor cutouts */
        // motor body
        translate(concat(motor_center(), nema_shaft(h()))) linear_extrude(nema(z()))  square(nema([0,1]), true);
        translate(concat(motor_center(), nema_shaft(h())-nema_shaft_neck(h()))) linear_extrude(nema_shaft_neck(h())) circle(d=nema_shaft_neck(d())+1, $fn=60);
        
        // mounting holes
        for(pos=nema_mount_holes()) translate(pos+motor_center()) linear_extrude(nema_shaft(h())) circle(d=3, $fn=30);
        for(pos=nema_mount_holes()) translate(pos+motor_center()) linear_extrude(3) circle(d=6, $fn=30);
        
        // motor shaft
        translate(motor_center()) linear_extrude(nema_shaft(h())) circle(d=nema_shaft(d())+1, $fn=60);
        
        // wire groove
        //translate(nema_wire_guide_center()) linear_extrude(wall(z())) square([11 ,6], center=true);
        /*
        translate(nema_wire_guide_center()) translate([0,0,2]) rotate([0,90,0]) linear_extrude(boom_center(x())-motor_center(x())) circle(d=5, $fn=60);
        translate([nema(x())*0.70, bounding_box(y())-cleat_screw_head(d())]) translate([0,0,2]) rotate([90,0,0]) linear_extrude(nema(y())+2) circle(d=5, $fn=60);
        translate([nema(x())*0.70, bounding_box(y())-cleat_screw_head(d())-nema(y())/2]) translate([0,0,2]) rotate([90,0,60]) linear_extrude(30) circle(d=5, $fn=60);
        /* */
 
    }
    /* clutch modules */
    // clutch spine
    translate(concat(roller_center(), wall(z()))) {
        bearing_19105_mount();
        roller_pulley();
        *clutch_spine();
        *translate([0,0,bearing_19105(h())+0.2]) spring_spine_adapter();
        *translate([0,0,0.2]) clutch_spring_pulley();
        *translate([0,0,gt2_belt(w())+1+0.4]) roller_adapter();
    }
    
    /* */
}

module idler_assembly() {
    difference() {
        linear_extrude(window_frame()) housing_profile();
            
        /* bottom mounting screw */
        translate([0, bounding_box(y())-cleat_screw_head(r()), window_frame()/2]) rotate([0,90,0]) linear_extrude(wall(y())) circle(d=cleat_screw_body(d()), $fn=60);
        translate([wall(y()), bounding_box(y())-cleat_screw_head(r()), window_frame()/2]) rotate([0,90,0]) linear_extrude(10) circle(d=cleat_screw_head(d()), $fn=60);
        /* */

        /* roller cutout */
        translate([0,0,wall(z())+cord_balls(d())+1-0.2]) linear_extrude(window_frame()-wall(z())) roller_cutout();
        translate([0,0,wall(z())+cord_balls(d())+1]) linear_extrude(window_frame()-wall(z())) roller_boom_cover_slot();        
        /* */
        
        translate([0,0,wall(z())]) linear_extrude(cord_balls(d())+1) idler_cord_cutout_profile();
        
        translate(roller_center()) linear_extrude(wall(z()))  circle(d=m4_screw_body(d()), $fn=30);
    }
    
    /* cord pulley */
    translate(concat(roller_center([x(), y()]), wall(z()))) cord_pulley_spine();
    

    /* seperate modules */
    translate(concat(roller_center([x(), y()]), wall(z()))) cord_roller_pulley();
    /* */
}





