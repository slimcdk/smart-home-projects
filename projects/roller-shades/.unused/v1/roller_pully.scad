

string_pully_knobs = 16;
string_knobs_distance = 61 / 10;
string_knobs_diameter = 5;
string_diameter = 1.5;


guide_wall=9;



function pully_height() = 10+10;


function string_pully_diameter (knob_dist, knobs) = (knob_dist * knobs) / PI;
function inner_guide_diameter (spd, knob_d) = spd + knob_d + 6;




module roller_string_pully(roller_d) {
    
    // string pully diameter
    spd = string_pully_diameter(string_knobs_distance, string_pully_knobs);
    igd = inner_guide_diameter(spd, string_knobs_diameter);
    
    difference() {
        union() {
            linear_extrude(10) circle(d=spd);
            //linear_extrude(10+10) circle(d=roller_d);
        }
        for (a=[0:(360/string_pully_knobs):360]) rotate([0,0,a]) translate([spd/2,0,10/2]) sphere(d=string_knobs_diameter);
        rotate_extrude() translate([spd/2, 10/2]) circle(d=string_diameter);
        
        // screw tighteners
        translate([0,0,10+1+5]) rotate([0,0,360/2]) {
            rotate([90,0,0]) linear_extrude(roller_d/2) circle(d=2.9);
            rotate([-90,0,0]) linear_extrude(roller_d/2) circle(d=2.9);
        }
    }
}
module pully_guide_half1(knobs, knob_d, knob_dist, string_d) {
    
    // string pully diameter && inner guide diameter
    spd = string_pully_diameter(knob_dist, knobs);
    igd = inner_guide_diameter(spd, knob_d);
    
    linear_extrude(1) circle(d=igd);
    linear_extrude((10+1.6)) difference() {
        // wall
        circle(d=igd+guide_wall);
        circle(d=igd);
        
        // opening
        translate([-igd/2-1,0]) square([10,igd], center=true);
    }
}
module pully_guide_half2(knobs, knob_d, knob_dist, string_d) {
    
    // string pully diameter && inner guide diameter
    spd = string_pully_diameter(knob_dist, knobs);
    igd = inner_guide_diameter(spd, knob_d);
    
    difference() {
        pully_guide_half1(knobs=knobs, knob_d=knob_d, knob_dist=knob_dist, string_d=string_d);
        linear_extrude(1) circle(d=igd-12);
    }
    translate([0,0,1]) scale([1,1,-1]) linear_extrude(4) difference() {
        circle(d=igd+guide_wall);
        circle(d=igd-12);
    }
}
module pully_guide() {
    
    // string pully diameter && inner guide diameter
    spd = string_pully_diameter(string_knobs_distance, string_pully_knobs);
    igd = inner_guide_diameter(spd, knob_d);
    
    difference() {
        union() {
            translate([0,0,10+1.6]) scale([1,1,-1]) pully_guide_half2(knobs=knobs, knob_d=knob_d, knob_dist=knob_dist, string_d=string_d);
            //pully_guide_half1(knobs=knobs, knob_d=knob_d, knob_dist=knob_dist, string_d=string_d);
        }
        translate([0,0,12.4+3]) rotate([180,0,0]) for (a=[0:90:360]) rotate([0,0,a+45]) translate([igd/2+2,0]) {
            linear_extrude(20) circle(d=2.9);
            linear_extrude(3) circle(d=6.2);
        }
    }
}


difference() {
    roller_string_pully(roller_d=24.2, $fn=30);
    
    linear_extrude(10) intersection() {
        circle(d=3+0.2, $fn=30);
        translate([-1.5-0.1,-1.5-0.1]) square([3+0.2,2.1+0.2]) ;
    }
    
    translate([0, 20, 5]) rotate([90,0,0]) linear_extrude(40) circle(d=2.9, $fn=30);
}