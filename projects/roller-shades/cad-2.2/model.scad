
// Import libaries
use <./../../../utils/cad/gears/gears.scad>;
use <./../../../utils/cad/BOSL/nema_steppers.scad>;
use <./../../../utils/cad/Round-Anything/polyround.scad>;
use <./../../../utils/cad/MCAD/bearing.scad>;
include <./../../../utils/cad/NopSCADlib/lib.scad>;


/* STRING PARAMETERS */
BALL_SPACING = 6; //102.5/17; => 6.029
BALL_DIAMETER = 4.1;
BALL_CLEARANCE_DELTA = 0.5;
BALL_CLEARANCE = BALL_DIAMETER + 2*BALL_CLEARANCE_DELTA;

STRING_DIAMETER=1.2;

MOTOR_OFFSET = 50;

BEARING_ID = 25;
BEARING_OD = 37;
BEARING_WIDTH = 7;


HOUSING_ASSEMBLY_SCREWS = [[25,7.4],[25,-7.4], [-23,23], [-23,-23], [67,24.7], [67, -24.7]];

// Housing
union() {
    difference() {
        translate([-56/2, -56/2]) {
            *linear_extrude(1+BALL_CLEARANCE) square([56/2+MOTOR_OFFSET+42.3/2,56]);
            translate([0,0,1+BALL_CLEARANCE]) linear_extrude(2+1.8) square([56/2+MOTOR_OFFSET+42.3/2,56]);
        }
        translate([0,0, 1]) {
            linear_extrude(BALL_CLEARANCE) string_path_profile(24, 12, MOTOR_OFFSET);
            linear_extrude(10) circle(d=46);
            translate([MOTOR_OFFSET,0]) linear_extrude(10) circle(d=22.4);
        }
        
        translate([MOTOR_OFFSET,0]) linear_extrude(1) circle(d=6);
        for(i=[1,-1]) for(ii=[1,-1]) translate([31/2*i,31/2*ii]+[MOTOR_OFFSET,0]) {
            linear_extrude(10) circle(d=3.2);
            cylinder(d1=3+2*cos(45)*2, d2=3.2, h=2);
        }
        for(pos=HOUSING_ASSEMBLY_SCREWS) translate(pos) {
            linear_extrude(20) circle(d=2.9);
            translate([0,0,1+BALL_CLEARANCE+1.8]) cylinder(d2=3+2*cos(45)*2, d1=3.2, h=2);
        }
        translate([MOTOR_OFFSET,0,1+BALL_CLEARANCE+2]) linear_extrude(23) square([42.3,42.3]+[0.4, 0.4], true);
    }

    translate([0,0,1]) difference() {
        translate([0,0,0.2]) union() {
            linear_extrude(0.2) circle(d=BEARING_ID+3);
            cylinder(h=BEARING_WIDTH-0.2, d1=BEARING_ID+0.1, d2=BEARING_ID+0.2);
        }
        linear_extrude(10) circle(d=BEARING_ID-4);
    }
    translate([0,0,1]) {
        linear_extrude(20) circle(d=10.8);
        translate([0,0,20]) cylinder(d1=8.1, d2=8, h=3);
    }
}


*%translate([0,0,1.2]) bearing_25377();
%translate([0,0,1+BALL_CLEARANCE_DELTA]) cover_gear($fn=60);
%translate([MOTOR_OFFSET,0,1+BALL_CLEARANCE_DELTA]) !motor_gear($fn=60);

*difference() {
    guide_profile($fn=30);
    offset(r=-BALL_CLEARANCE) guide_profile($fn=30);
}

module guide_profile() {
    hull() {
        circle(r=string_pulley_radius(24)+BALL_CLEARANCE/2);
        translate([MOTOR_OFFSET-10,0]) circle(r=string_pulley_radius(12)+BALL_CLEARANCE/2);
    }
    translate([MOTOR_OFFSET,0]) square([string_pulley_radius(12)+BALL_CLEARANCE/2,string_pulley_radius(12)+BALL_CLEARANCE/2]*2, true);
}


function string_pulley_radius(n_balls) = (n_balls * BALL_SPACING) / PI / 2;
function string_path_controlpoints(cover_pulley_balls, motor_pulley_balls, dist, inpress_angle, steps) = [
    [string_pulley_radius(cover_pulley_balls)+dist+string_pulley_radius(motor_pulley_balls), string_pulley_radius(motor_pulley_balls)],
    for (a=[30:5:180-inpress_angle]) [cos(a),sin(a)]*(string_pulley_radius(motor_pulley_balls)-1.5+BALL_CLEARANCE) + [dist, 0],
    for (a=[inpress_angle:5:360-inpress_angle]) [cos(a),sin(a)]*(string_pulley_radius(cover_pulley_balls)+0.8+BALL_CLEARANCE),
    for (a=[180+inpress_angle:5:360-30]) [cos(a),sin(a)]*(string_pulley_radius(motor_pulley_balls)-1.5+BALL_CLEARANCE) + [dist, 0],
    [string_pulley_radius(cover_pulley_balls)+dist+string_pulley_radius(motor_pulley_balls), -string_pulley_radius(motor_pulley_balls)],
];
    
module cover_gear() {
    difference() {
        union() {
            linear_extrude(BALL_DIAMETER) ball_string_pulley(24);
            translate([0,0,BALL_DIAMETER]) linear_extrude(2+0.3+1+1) circle(d=46-0.4);
        }
        cylinder(h=BEARING_WIDTH+0.2, d1=BEARING_OD+0.2, d2=BEARING_OD+0.3);
        linear_extrude(BEARING_WIDTH+0.4) circle(d=BEARING_OD-3);
        *linear_extrude(10) circle(d=BEARING_ID);
    }
}

 
module string_path_profile(cover_balls, motor_balls, dist) {
    path = bezier_path(string_path_controlpoints(cover_balls, motor_balls, dist, inpress_angle=20, steps=10));
    difference() {
        polygon(path);
        offset(r=-BALL_CLEARANCE) polygon(path);
    }
    circle(r=string_pulley_radius(cover_balls));
    translate([dist,0]) circle(r=string_pulley_radius(motor_balls));
}



module motor_gear() {
    difference() {
        linear_extrude(BALL_DIAMETER) ball_string_pulley(12);
        linear_extrude(10) circle(d=5.2);
    }
    *translate([4.5,0]) linear_extrude(9.2) square([5.6,5.6], true);
}



module ball_string_pulley(n_balls) {
    ball_radius = BALL_DIAMETER / 2;
    string_radius = STRING_DIAMETER / 2;
    fitted_pulley_radius = (n_balls * BALL_SPACING) / PI / 2;
    pulley_groove_width = BALL_DIAMETER + BALL_CLEARANCE;
    
    // Main body
    difference() {
        /*linear_extrude(pulley_groove_width)*/ circle(r=fitted_pulley_radius-string_radius);
        /*linear_extrude(pulley_groove_width)*/ for(a=[0:360/n_balls:360]) rotate([0,0,a]) translate([fitted_pulley_radius,0]) circle(r=ball_radius+0.2);
            
        //translate([0,0,pulley_groove_width/2]) rotate_extrude(angle=360) translate([fitted_pulley_radius-string_radius,0]) circle(d=STRING_DIAMETER+0.2);
    }
}



module bearing_25377() color("gray") difference() {    
    linear_extrude(BEARING_WIDTH) circle(d=BEARING_OD);
    linear_extrude(BEARING_WIDTH) circle(d=BEARING_ID);
}


module circle_section(a,r=1, $fn=10) polygon([[cos(-a/2),sin(a/2)], [0,0], [cos(a/2),sin(-a/2)], for(_a=[0:a/$fn:a]) [cos(_a-a/2),sin(_a-a/2)]]*r);