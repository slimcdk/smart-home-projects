
use <../MCAD/involute_gears.scad>;
use <../gears/gears.scad>;


gear_backplate = 1; // mm

magnet_to_stator_perimeter_clearance = 0.6;
magnet_to_inner_gear_perimeter_clearance = 0.3;

magnet_dim=[8,3];



// worm gear settings
modul=1;
tooth_number=50;
thread_starts=2;
length=55-6-0.6;
pressure_angle=20;
lead_angle=10;

function spur_gear_radius() = modul*tooth_number/2;
function worm_gear_radius() = (modul*thread_starts/(2*sin(lead_angle))) + (modul - (modul/6)); // - modul - (modul/6); 
function worm_gear_length() = length;
function worm_gear_offset() = worm_gear_radius() + spur_gear_radius() - (modul-(modul/6));

function half_magnet_height() = magnet_dim[0] / 2;


module magnet_profile(dim) {
    linear_extrude(dim[1]) square([dim[0]+0.3,dim[0]], center=true);
}


/** ROLLER GEAR **/
module magnetic_gear(d, teeth, magnets) {

    difference() {
        // gear
        gear_spur_part(center=true);

        // stator cutout
        translate([0,0,1.2]) linear_extrude(magnet_dim[0]+1) circle(d=d);
        
        // megnet cutouts
        translate([0,0,(magnet_dim[0]/2)+1]) for (i=[0:(360/magnets):360]) rotate([0,0,i]) translate([d/2+magnet_to_inner_gear_perimeter_clearance,0]) rotate([0,90,0]) magnet_profile(dim=magnet_dim);
        
        // screw cutouts
        for (a=[0:(360/floor(magnets/2)):360]) rotate([0,0,a+floor(360/magnets)/2]) translate([d/2+6.4/2+0.6,0,0]) {
            linear_extrude(50) circle(d=2.9);
            linear_extrude(2.6) circle(d=6.2);
        }
        
        // export removals
        // translate([0,0,(magnet_dim[0]+2)/2]) linear_extrude(magnet_dim[0]+2) circle(d=100); // remove upper half
        // linear_extrude((magnet_dim[0]+2)/2) circle(d=100); // remove lower half
    }
}



module magnetic_gear_stator(d, roller_d, magnets) {

    translate([0,0,gear_backplate+0.2]) difference() {
        
        // stator and roller body
        union() {
            linear_extrude(magnet_dim[0]+1) circle(d=d);
            linear_extrude(magnet_dim[0]+1+10) circle(d=roller_d);
        }

        // magnet placement calculations : shortest distance from stator perimeter to magent perimeter
        v = sqrt((d/2*d/2)-(magnet_dim[0]/2*magnet_dim[0]/2)) - magnet_to_stator_perimeter_clearance;
        // magnet cutouts
        for (i=[0:(360/magnets):360]) rotate([0,0,i]) translate([v,0,(magnet_dim[0]+1)/2]) rotate([0,-90,0]) magnet_profile(dim=magnet_dim);
        
        // screw cutouts
        for (a=[0:(360/floor(magnets/2)):360]) rotate([0,0,a+floor(360/magnets)/2]) translate([8,0,0]) {
            linear_extrude(30) circle(d=2.9);
            linear_extrude(2.6) circle(d=6.2);
        }
        
        // screw tighteners
        translate([0,0,magnet_dim[0]+1+5]) rotate([0,0,45+floor(360/magnets)/2]) {
            rotate([90,0,0]) linear_extrude(d/2) circle(d=2.9);
            rotate([-90,0,0]) linear_extrude(d/2) circle(d=2.9);
        }
        
        // export removals
        // translate([0,0,(magnet_dim[0]+gear_backplate+0.2)/2]) linear_extrude(magnet_dim[0]+20) circle(d=100); // remove upper half
        // linear_extrude((magnet_dim[0]+gear_backplate+0.2)/2) circle(d=100); // remove lower half
    }
}



/** WORM GEAR MODULES **/
module gear_spur_part (center=true) {
    center_pos = [center?0:tooth_number/2,0];
    translate(center_pos) union() {
        spur_gear (modul=1, tooth_number=tooth_number, width=magnet_dim[0]+2.2, bore=0, pressure_angle=pressure_angle, helix_angle=-lead_angle);
        linear_extrude(magnet_dim[0]+2.2) circle(d=tooth_number-6);
    }
}

module magnetic_worm_gear(center=true) {
    center_pos = [center?0:worm_gear_offset(), length/2, 0]; //(half_height() + worm_gear_radius())/2];
    translate(center_pos) rotate([90,0,0]) worm(modul=modul, thread_starts=thread_starts, length=length, bore=0, pressure_angle=pressure_angle, lead_angle=lead_angle, together_built=1);
}

module magnetic_worm_gear_cutout(center=true) {
    center_pos = [center?0:worm_gear_offset(), length/2+0.3, 0];
    translate(center_pos) rotate([90,0,0]) linear_extrude(length+0.6) circle(r=worm_gear_radius()+1);
}


/** TESTING **/
//magnetic_gear(d=32+0.6, teeth=44, magnets=8, $fn=60);
magnetic_gear_stator(d=32, roller_d=24.1, magnets=8, $fn=60);
//magnetic_worm_gear(center=false);
//#magnetic_worm_gear_cutout(center=true);