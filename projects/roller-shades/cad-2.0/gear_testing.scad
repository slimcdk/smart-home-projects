
// Import libaries
use <./../../../utils/cad/gears/gears.scad>;
use <./../../../utils/cad/BOSL/nema_steppers.scad>;


module string_pulley() {
    difference() {
        linear_extrude(8) circle(r=30);
        for(a=[0:36:360]) rotate([0,0,a]) translate([30,0,8/2]) sphere(d=3);
    }
}

difference() {
    string_pulley($fn=60);
    translate([0,0,2]) linear_extrude(8) circle(r=26);
}

translate([0,0,8]) bevel_gear(modul=1, tooth_number=62,  partial_cone_angle=45, tooth_width=5, bore=0, pressure_angle=20, helix_angle=0);

rotate([0,0,90]) translate([0,32,nema_motor_width(17)/2]) rotate([0,90,-90]) bevel_gear(modul=1, tooth_number=25,  partial_cone_angle=45, tooth_width=5, bore=0, pressure_angle=20, helix_angle=0);

translate([-48,0, nema_motor_width(17)/2]) rotate([0,90,0]) nema17_stepper();