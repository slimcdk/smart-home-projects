
use <encoder.scad>;
use <bracket.scad>;
use <motors.scad>;
use <magnetic_gear.scad>;
use <roller_pully.scad>;

M3_bolt_grip = 2.9;
M3_bolt_slip = 3.4;

roller_distance_into_bracket = 36;
roller_inner_diameter = 24.1;

worm_gear_angle = -90;
roller_pully_bracket_bearing_diameter = 13.2;
roller_pully_bracket_bearing_width = 5;



/** LEFT BRACKET ASSEMBLY **/ 
// compute positions
function gear_origin() = [0, roller_distance_into_bracket, bracket_back_thickness()+0.2];
function magnetic_gear_origin() = gear_origin();
function magnetic_gear_stator_origin() = gear_origin();
function magnetic_worm_gear_origin() = [gear_origin()[0], gear_origin()[1]-worm_gear_offset(), gear_origin()[2]+ (worm_gear_radius()+half_magnet_height())/2];

function motor_pos() = [magnetic_worm_gear_origin()[0]-worm_gear_length()/2-bracket_support_thickness()-0.3+1, magnetic_worm_gear_origin()[1], magnetic_worm_gear_origin()[2]];
function motor_rotation() = [180,-90,0];
function motor_mount_pos() = [motor_pos()[0], motor_pos()[1], motor_pos()[2]];
function motor_tilt() = [-50,0,0];


function worm_gear_bolt_cutout_pos() = [-worm_gear_length()/2, magnetic_worm_gear_origin()[1], magnetic_worm_gear_origin()[2]];
function worm_gear_bearing_cutout_pos() = [worm_gear_length()/2+bracket_support_thickness()+0.3, magnetic_worm_gear_origin()[1], magnetic_worm_gear_origin()[2]];
function worm_gear_bearing_cutout_rot() = [0,-90,0];

function encoder_pos() = [0,roller_distance_into_bracket, bracket_back_thickness()-4.5-4];

// cuts into bracket
difference() {
    union() {
        bracket(bracket_length=roller_distance_into_bracket, $fn=60);
        translate(motor_mount_pos()) rotate(motor_tilt()) rotate(motor_rotation()) for(pos=motor_mounting_pos()) translate(pos) linear_extrude(bracket_width()-1) circle(d=5, $fn=30);
    }
    translate(encoder_pos()) encoder_cutout(shaft_tol=0.4, shaft_tol_h=2, extended=10, $fn=60);
    translate(magnetic_worm_gear_origin()) rotate([0,0,worm_gear_angle]) magnetic_worm_gear_cutout(center=true, $fn=60);
    translate(motor_pos()) rotate(motor_tilt()) rotate(motor_rotation()) _25byj_cutout($fn=30);
    translate(worm_gear_bearing_cutout_pos()) rotate(worm_gear_bearing_cutout_rot()) worm_gear_bearing_cutout($fn=30);
    
    translate(motor_pos()) rotate(motor_tilt()) rotate(motor_rotation()) _25byj($fn=30);
    translate(motor_mount_pos()) rotate(motor_tilt()) rotate(motor_rotation()) for(pos=motor_mounting_pos()) translate(pos) linear_extrude(bracket_width()-1) circle(d=M3_bolt_grip, $fn=30);   
}

// cuts into magnetic gear and stator
difference() {
    union() {
        translate(magnetic_gear_origin()) magnetic_gear(d=32+0.5, magnets=8, $fn=60);
        translate(magnetic_gear_stator_origin()) rotate([0,0,-67.5]) magnetic_gear_stator(d=32, roller_d=roller_inner_diameter-0.4, magnets=8, $fn=60);
    }
    translate(encoder_pos()) encoder_cutout(shaft_tol=0.4, shaft_tol_h=5.4, extended=10, $fn=60);
}

// cuts into worm gear
difference() {
    translate(magnetic_worm_gear_origin()) rotate([0,0,worm_gear_angle]) magnetic_worm_gear(center=true);
    translate(motor_pos()) rotate(motor_tilt()) rotate(motor_rotation()) _25byj_shaft_cutout();
    translate(worm_gear_bolt_cutout_pos()) rotate(motor_rotation()) linear_extrude(worm_gear_length()) circle(d=M3_bolt_grip, $fn=30);
}
*translate(magnetic_worm_gear_origin()) rotate([0,0,worm_gear_angle]) magnetic_worm_gear_cutout(center=true);
translate(motor_pos()) rotate(motor_tilt()) rotate(motor_rotation()) _25byj(, $fn=30);
translate(encoder_pos()) encoder_model($fn=30);



module worm_gear_bearing_cutout() {
    union() {
        linear_extrude(1) circle(d=8+0.4);
        linear_extrude(bracket_support_thickness()) circle(d=7+0.2);
    }
}


/** MANUAL BRACKET ASSEMBLY **/ /*

// compute positions
function bearing_cutout_pos() = [0, roller_distance_into_bracket, 0];
function pully_pos() = [0, roller_distance_into_bracket, bracket_back_thickness()+0.2];


difference() {
    bracket(bracket_length=roller_distance_into_bracket, $fn=60);
    
    translate(bearing_cutout_pos()) linear_extrude(roller_pully_bracket_bearing_width+0.2) circle(d=roller_pully_bracket_bearing_diameter, $fn=30);
    translate(bearing_cutout_pos()) linear_extrude(bracket_back_thickness()) circle(d=M3_bolt_slip, $fn=30);  
}

!difference() {
    translate(pully_pos()) roller_string_pully(roller_d=roller_inner_diameter, $fn=30);
    translate(pully_pos()) linear_extrude(pully_height()) circle(d=M3_bolt_slip, $fn=30);  
}




/*
union() {
    *difference() {
        color("white") bracket(length=60, $fn=60);
        
        // mounting holes in bracket
        translate([0,roller_distance_into_bracket]) linear_extrude(bracket_back_thickness) {
            circle(d=13.2, $fn=60);
            spd = string_pully_diameter(string_knobs_distance, string_pully_knobs);
            igd = inner_guide_diameter(spd, string_knobs_diameter);
            for (a=[0:90:360]) rotate([0,0,a+45]) translate([igd/2+2,0]) circle(d=3, $fn=30);
        }
    }
    
    translate([0,roller_distance_into_bracket, bracket_back_thickness]) difference() { 
        union() {
            translate([0,0,0.2]) roller_string_pully(roller_d=roller_inner_diameter, $fn=60);
            *pully_guide_v1($fn=60);
        }
        linear_extrude(60) circle(d=2.9, $fn=60);
    }
}
*/
