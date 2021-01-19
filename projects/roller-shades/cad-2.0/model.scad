
// Import libaries
use <./../../../utils/cad/gears/gears.scad>;
use <./../../../utils/cad/BOSL/nema_steppers.scad>;
use <./../../../utils/cad/Round-Anything/polyround.scad>;
use <./../../../utils/cad/MCAD/bearing.scad>;

*#circle(d=48);
cover_gear_assembly_screw_positions = [for(a=[0:120:360]) [cos(a), sin(a)]*21];
cover_gear_mounting_screw_positions = [for(a=[0:120:360]) [cos(a), sin(a)]*9];


*color("gray") translate([0,0,0.7]) bearing_25377();

translate([0,0,0.2]) cover_gear(part=0, $fn=60);
*cover_gear_mounting(part=0, $fn=60);

//rotate([0,0,90]) translate([-48,0, nema_motor_width(17)/2]) rotate([0,90,0]) nema17_stepper();
//translate([0,-30,nema_motor_width(17)/2]) rotate([-90,0,0]) motor_bevel_gear();

translate([0,0,-1]) linear_extrude(1) square([60,60], true);



module cover_gear(part=0) intersection() {
    bearing_od=37;
    difference() {
        union() {
            // n balls, ball distance, ball diameter, string diameter, flange thickness
            ball_string_pulley(27, 102.5/17, 4.1, 1.2, 1);
            translate([0,0,4.1+1]) bevel_gear(modul=1, tooth_number=58,  partial_cone_angle=45, tooth_width=5.38, bore=0, pressure_angle=20, helix_angle=0);
            translate([0,0,9]) linear_extrude(1) circle(d=49);
            
            translate([0,0,9]) linear_extrude(20) difference() {
                angle=110;
                circle(d=12.4+2);
                circle(d=12.4);
                polygon([[0,0], [sin(angle/2),cos(angle/2)], [-sin(angle/2),cos(angle/2)]]*20);
            }
        }
        
        // Bearing cutout
        translate([0,0,0.6]) linear_extrude(7.2) circle(d=bearing_od+0.4);        
        linear_extrude(9) circle(d=bearing_od-3);
        linear_extrude(40) circle(d=11.6);
        
        // Assembly screw holes
        for(pos=cover_gear_assembly_screw_positions) translate(pos) {
            linear_extrude(10) circle(d=2.9);
            translate([0,0,8]) cylinder(d2=3+2*cos(45)*2, d1=2.9, h=2);
        }
    }
    

    // Body splitters
    if(part==1) linear_extrude(4.1+1) circle(d=50);
    if(part==2) difference() {
        translate([0,0,4.1+1]) linear_extrude(10) circle(d=80);
        translate([0,0,0.6+7.2]) linear_extrude(10) circle(d=49);
    }
    if(part==3) translate([0,0,0.6+7]) linear_extrude(30) circle(d=49);
}

module cover_gear_mounting(part=0) intersection() {
    bearing_id=25;
    difference() {
        union() {
            difference() {
                union() {
                    linear_extrude(0.6) circle(d=bearing_id+3);
                    linear_extrude(0.6+7.2) circle(d=bearing_id-0.2);
                    translate([0,0,0.6+7.2]) linear_extrude(1) circle(d=bearing_id+3);
                }

                // Assembly screw holes
                for(pos=cover_gear_mounting_screw_positions) translate(pos) {
                    linear_extrude(10) circle(d=2.9);
                    translate([0,0,0.6+7.2-1]) cylinder(d2=3+2*cos(45)*2, d1=2.9, h=2);
                }
            }
            translate([0,0,0.6+7.2+1]) linear_extrude(20) circle(d=11);
        }
        linear_extrude(40) circle(d=2.9);
    }
    
    // Body splitters
    if(part==1) linear_extrude(0.6+7.2) circle(d=30);
    if(part==2) translate([0,0,0.6+7.2]) linear_extrude(40) circle(d=30);
}


module ball_string_pulley(n_balls, ball_distance, ball_diameter, string_diameter, flange_thickness) {

    ball_clearance = 1;
    ball_radius = ball_diameter / 2;
    string_radius = string_diameter / 2;
    fitted_pulley_radius = (n_balls * ball_distance) / PI / 2;
    pulley_groove_width = ball_diameter + ball_clearance;
    
    // Main body
    difference() {
        linear_extrude(pulley_groove_width) circle(r=fitted_pulley_radius-string_radius);
        linear_extrude(pulley_groove_width) for(a=[0:360/n_balls:360]) rotate([0,0,a]) translate([fitted_pulley_radius,0]) circle(r=ball_radius+0.2);
        translate([0,0,pulley_groove_width/2]) rotate_extrude(angle=360) translate([fitted_pulley_radius-string_radius,0]) circle(d=string_diameter+0.2);
    }
}


module motor_bevel_gear() {
    bevel_gear(modul=1, tooth_number=25,  partial_cone_angle=45, tooth_width=5, bore=0, pressure_angle=20, helix_angle=0);
}

module torsion_spring() {
    linear_extrude(9) difference() {
        circle(d=13);
        circle(d=13-2*1);
    }
    rotate([0,0,10]) translate([13/2,0]) linear_extrude(1) square([2,1], true);
    rotate([0,0,170]) translate([13/2,0,9-1]) linear_extrude(1) square([2,1], true);
}

module bearing_25377() difference() {
    outer_d = 37;
    inner_d = 25;
    width = 7;
    wall=1.2;
    
    linear_extrude(width) circle(d=outer_d);
    linear_extrude(width) circle(d=inner_d);
    
    linear_extrude(0.3) difference() {
        circle(d=outer_d-wall);
        circle(d=inner_d+wall);
    }
    
    translate([0,0,width-0.3]) linear_extrude(0.5) difference() {
        circle(d=outer_d-wall);
        circle(d=inner_d+wall);
    }
}
