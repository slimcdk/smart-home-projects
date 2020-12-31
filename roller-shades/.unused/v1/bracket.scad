
back_thickness=6;
mount_thickness=4;
support_thickness=3;

mount_width = 26.4;

//bracket_length=40;
bracket_width=55;


//function bracket_length() = bracket_length;
function bracket_width() = bracket_width;
function bracket_back_thickness() = back_thickness;
function bracket_mount_thickness() = mount_thickness;
function bracket_support_thickness() = support_thickness;


/** BRACKET **/
module bracket(bracket_length) {    
    // mounting
    translate([0,0,(mount_width+back_thickness)/2]) rotate([90,0,0]) linear_extrude(mount_thickness) difference() {
        square([bracket_width, mount_width+back_thickness], center=true);
        translate([0,back_thickness/2]) {
            translate([15,0]) circle(d=4); 
            translate([-15,0]) circle(d=4);
        }
    }
    translate([-bracket_width/2+support_thickness, 0, back_thickness]) rotate([0,-90,0]) linear_extrude(support_thickness) support_profile();
    translate([bracket_width/2, 0, back_thickness]) rotate([0,-90,0]) linear_extrude(support_thickness) support_profile();
    
    // back
    linear_extrude(back_thickness) {
        translate([0,bracket_length/2,0]) square([bracket_width, bracket_length], center=true);
        translate([0,bracket_length,0]) circle(d=bracket_width);
    }
}

module support_profile() {
   polygon([[0,0], [mount_width,0], [0,mount_width]]);
} 


/** TESTING **/
bracket(bracket_length=40, $fn=60);