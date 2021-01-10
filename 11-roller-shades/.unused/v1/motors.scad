
/*
body_diameter = 24;
body_height = 19.5;
wire_cover_center = 28.4 - (body_diameter/2) - (10/2);
wire_cover_height = 16.1;
wire_cover_width = 14;

shaft_lib_diameter = 7.9;
shaft_lib_height = 1.4;
shaft_center_offset = (shaft_lib_diameter) - 1.5;
shaft_circular_diameter = 5;
shaft_square_width = 3;
shaft_circular_length = 3;
shaft_total_length = 14;
    
mounting_holes_distance = 31.5;
mounting_holes_diameter = 4;
mounting_holes_flang_diameter = 7;
mounting_holes_flang_thickness = 1;
*/

body_diameter = 28;
body_height = 19;
wire_cover_center = 31 - (body_diameter/2) - (10/2);
wire_cover_height = 15.5;
wire_cover_width = 14.5;

shaft_lib_diameter = 9.1;
shaft_lib_height = 1.5;
shaft_center_offset = (shaft_lib_diameter) - 1.5;
shaft_circular_diameter = 5;
shaft_square_width = 3;
shaft_circular_length = 2;
shaft_total_length = 8;
    
mounting_holes_distance = 35;
mounting_holes_diameter = 4;
mounting_holes_flang_diameter = 7;
mounting_holes_flang_thickness = 1;


//center_pos=[0,0,0]; // normal
center_pos = [shaft_center_offset, 0, -body_height]; // shaft
//center_pos = [0, 0, -body_height]; // mounting


function shaft_offset() = shaft_center_offset;
function motor_mounting_flang_length() = mounting_holes_distance + 2*mounting_holes_flang_diameter;
function motor_mounting_pos() = [[shaft_center_offset, -mounting_holes_distance/2], [shaft_center_offset, mounting_holes_distance/2]];



module _25byj() {
    
    translate(center_pos) {
        linear_extrude(body_height) circle(d=body_diameter);
        translate([wire_cover_center,0,body_height-wire_cover_height]) linear_extrude(wire_cover_height) square([10,wire_cover_width], center=true);
        translate([-shaft_center_offset, 0, body_height]) linear_extrude(shaft_lib_height) circle(d=shaft_lib_diameter);
        translate([-shaft_center_offset, 0, body_height+shaft_lib_height]) linear_extrude(shaft_circular_length) circle(d=shaft_circular_diameter);
        translate([-shaft_center_offset, 0, body_height+shaft_lib_height+shaft_circular_length]) linear_extrude(shaft_total_length-shaft_circular_length) intersection() {
            circle(d=shaft_circular_diameter);
            square([shaft_circular_diameter, shaft_square_width], center=true);
        }
        
        translate([0,0,body_height-mounting_holes_flang_thickness]) linear_extrude(mounting_holes_flang_thickness) difference() {
            union() {
                square([mounting_holes_flang_diameter, mounting_holes_distance], center=true);
                translate([0, mounting_holes_distance/2]) circle(d=mounting_holes_flang_diameter);
                translate([0, -mounting_holes_distance/2]) circle(d=mounting_holes_flang_diameter);
            }
            translate([0, mounting_holes_distance/2]) circle(d=mounting_holes_diameter);
            translate([0, -mounting_holes_distance/2]) circle(d=mounting_holes_diameter);
        }
    }
}

module _25byj_cutout() {
    
    translate(center_pos) {
        linear_extrude(body_height+0.2) circle(d=body_diameter+0.4);
        translate([wire_cover_center,0,body_height-wire_cover_height]) linear_extrude(wire_cover_height+0.2) square([10+0.4,wire_cover_width+0.4], center=true);
        translate([-shaft_center_offset,0,body_height]) _25byj_shaft_cutout();
        
        translate([0,0,body_height-mounting_holes_flang_thickness]) linear_extrude(mounting_holes_flang_thickness+0.2) {
            square([mounting_holes_flang_diameter+0.4, mounting_holes_distance+0.4], center=true);
            translate([0, mounting_holes_distance/2]) circle(d=mounting_holes_flang_diameter+0.4);
            translate([0, -mounting_holes_distance/2]) circle(d=mounting_holes_flang_diameter+0.4);            
        }
    }
}


module _25byj_shaft_cutout() {
    
    linear_extrude(shaft_lib_height+0.2) circle(d=shaft_lib_diameter+0.4);
    linear_extrude(shaft_lib_height+shaft_circular_length+shaft_lib_height-0.2-1) circle(d=shaft_circular_diameter+0.4);
    linear_extrude(shaft_lib_height+shaft_circular_length+shaft_total_length-shaft_circular_length+0.2) intersection() {
        circle(d=shaft_circular_diameter+0.4);
        square([shaft_circular_diameter+0.4, shaft_square_width+0.2], center=true);
    }
}





//translate(motor_mounting_pos()[0]) circle(d=5);

_25byj($fn=30);
#_25byj_cutout($fn=30);
//_25byj_shaft_cutout($fn=30);

