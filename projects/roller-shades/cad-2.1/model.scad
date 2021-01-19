
// Import libaries
use <./../../../utils/cad/gears/gears.scad>;
use <./../../../utils/cad/BOSL/nema_steppers.scad>;
use <./../../../utils/cad/Round-Anything/polyround.scad>;
use <./../../../utils/cad/MCAD/bearing.scad>;

cover_gear_assembly_screw_positions = [for(a=[0:120:360]) [cos(a), sin(a)]*21];
cover_gear_mounting_screw_positions = [for(a=[0:120:360]) [cos(a), sin(a)]*9];
motor_mounting_screw_positions = [for(a=[0:360/6:360]) [cos(a), sin(a)]*(31/2)];


/* STRING PARAMETERS */
n_balls = 27;
ball_distance = 102.5/17;
ball_diameter=4.1;
string_diameter=1.2;
ball_clearance = 1;
ball_radius = ball_diameter / 2;
string_radius = string_diameter / 2;
fitted_pulley_radius = (n_balls * ball_distance) / PI / 2;
pulley_groove_width = ball_diameter + ball_clearance;
 
bearing_shim = 0.2;
bearing_id = 25;
bearing_od = 37;
bearing_width = 7;



housing_shape();
//translate([0,0,-1]) base($fn=60);
//bearing_mount($fn=60);
main_gear($fn=60);
//adapter($fn=60);
//translate([30,0,36.5/2]) rotate([0,-90,0]) motor_gear([for(a=[0:5:280])[cos(a), sin(a)]*(6.2/2)]);
//motor_mount($fn=60);

//translate([93,36.5/2-(36.5-11),36.5/2]) rotate([0,-90,0]) dc_motor();


*translate([0,0,bearing_shim]) bearing_25377();
//dc_motor($fn=60);

module motor_mount() {
    translate([30+20-5,0]) rotate([0,-90,180]) linear_extrude(20) difference() {
        translate([0, -50/2]) square([28, 50]);
        circle(d=37);
        for (pos=motor_mounting_screw_positions) translate(pos) circle(d=3);
    }
}

module dc_motor() difference() {
    union() {
        linear_extrude(22) circle(d=32);
        translate([0,0,22]) linear_extrude(24) circle(d=36.5);
        translate([0,36.5/2-11,22+24]) {
            linear_extrude(21) circle(d=6);
            linear_extrude(6) circle(d=12);   
        }
    }
    for (pos=motor_mounting_screw_positions) translate(concat(pos,22+24-10)) linear_extrude(10) circle(d=3);
}

module motor_gear(bore_shape) {
    difference() {
        bevel_gear(modul=1, tooth_number=24,  partial_cone_angle=45, tooth_width=4, bore=0, pressure_angle=20, helix_angle=0);
        linear_extrude(10) polygon(bore_shape);
    }
}

// Base plate
module base() difference() {
    translate([40,0]) linear_extrude(20) housing_shape();
    linear_extrude(20) circle(d=51);
    
    // string guide
    #linear_extrude(4.1+1) string_guide();
}

module string_guide() {
    outline = [
        [200,fitted_pulley_radius],
        [0,string_pulley_radius],
        for(a=[90:2:270]) [cos(a), sin(a)]*fitted_pulley_radius,
        [200,-fitted_pulley_radius],
    ];
    
    difference() {
        offset(delta=4.1+1) polygon(outline);
        polygon(outline);
    }
}

module bearing_mount() {
    difference() {
        linear_extrude(bearing_width) circle(d=bearing_od+2);
        translate([0,0,bearing_shim]) cylinder(h=bearing_width, d1=bearing_od+0.2, d2=bearing_od+0.3);
        linear_extrude(bearing_shim) circle(d=bearing_od-2);
    }
    linear_extrude(19) circle(d=10.8); // in practice 19 mm in height
    translate([0,0,19]) cylinder(d1=8.1, d2=8, h=3);
}

module main_gear() translate([0,0,bearing_shim]) {
    difference() {
        union() {
            ball_string_pulley($fn=60);
            translate([0,0,4.1+1]) bevel_gear(
                modul=1, 
                tooth_number=58,  
                partial_cone_angle=45, 
                tooth_width=4, 
                bore=0, 
                pressure_angle=20, 
                helix_angle=0
            );
        }
        difference() {
            linear_extrude(bearing_width)circle(d=bearing_od+3);
            cylinder(h=bearing_width, d1=bearing_id+0.1, d2=bearing_id+0.2);
        }
        linear_extrude(10) circle(d=bearing_id-2);
    }
    translate([0,0,bearing_width-bearing_shim]) linear_extrude(bearing_shim) difference() {
        circle(d=bearing_id+2);
        circle(d=bearing_id-1);
    }
    
    // Center piece spring unlocker
    linear_extrude(8) difference() {
        circle(d=bearing_id-2);
        circle(d=12.6);
        circle_section(a=180, r=12.5, $fn=60);
    }
    
    linear_extrude(18) difference() {
        circle(d=bearing_id-2-4-1);
        circle(d=12.6);
        circle_section(a=180, r=12.5, $fn=60);
    }
}




// Cover bar adapter
module adapter() translate([0, 0, bearing_shim]) {
  
    difference() {
        // body
        linear_extrude(21+1.7+5) rotate([0,0,180]) union() {
            circle(r=8.5);
            circle_section(a=360-64, r=12.3, $fn=60);
        }
        // clearance
        linear_extrude(7.4) difference() {
            circle(d=bearing_id+1);
            circle(d=bearing_id-2-1);
        }
        
        // spring pusher cutout
        linear_extrude(7.4) rotate([0,0,180]) circle_section(a=360-90, r=12.5+1, $fn=60);
        translate([0,0,7.4]) linear_extrude(19-8.2) intersection() {
            circle(d=bearing_id-4);
            rotate([0,0,180]) circle_section(a=360-90, r=12.5, $fn=60);
        }
        
        // stud cutout
        linear_extrude(19) circle(d=13);
        linear_extrude(30) circle(d=10);
        
        // bearing cutout
        translate([0,0,19]) {
            cylinder(h=3.5, d1=12.2, d2=12.1);
            translate([0,0,3.5]) linear_extrude(0.2) circle(d=12.1);
        }
    }
    
    translate([0,0,7.4]) linear_extrude(1) rotate([0,0,180]) difference() {
        offset(delta=1) {
            circle(r=8.5);
            circle_section(a=360-64, r=12.3, $fn=60);
        }
        circle(r=8.5);
        circle_section(a=360-64, r=12.3, $fn=60);
    }
}



module ball_string_pulley() {
   
    // Main body
    difference() {
        linear_extrude(pulley_groove_width) circle(r=fitted_pulley_radius-string_radius);
        linear_extrude(pulley_groove_width) for(a=[0:360/n_balls:360]) rotate([0,0,a]) translate([fitted_pulley_radius,0]) circle(r=ball_radius+0.2);
        translate([0,0,pulley_groove_width/2]) rotate_extrude(angle=360) translate([fitted_pulley_radius-string_radius,0]) circle(d=string_diameter+0.2);
    }
}


module torsion_spring() {
    linear_extrude(9) difference() {
        circle(d=13);
        circle(d=13-2*1);
    }
    rotate([0,0,10]) translate([13/2,0]) linear_extrude(1) square([2,1], true);
    rotate([0,0,170]) translate([13/2,0,9-1]) linear_extrude(1) square([2,1], true);
}

module bearing_81234() difference() {
    wall=2;
    
    linear_extrude(bearing_width) circle(d=bearing_od);
    linear_extrude(bearing_width) circle(d=bearing_id);
    
    linear_extrude(0.3) difference() {
        circle(d=bearing_od-wall);
        circle(d=bearing_id+wall);
    }
    
    translate([0,0,bearing_width-0.3]) linear_extrude(0.5) difference() {
        circle(d=bearing_od-wall);
        circle(d=bearing_id+wall);
    }
}

module bearing_25377() difference() {
    wall=2;
    
    linear_extrude(bearing_width) circle(d=bearing_od);
    linear_extrude(bearing_width) circle(d=bearing_id);
    
    linear_extrude(0.3) difference() {
        circle(d=bearing_od-wall);
        circle(d=bearing_id+wall);
    }
    
    translate([0,0,bearing_width-0.3]) linear_extrude(0.5) difference() {
        circle(d=bearing_od-wall);
        circle(d=bearing_id+wall);
    }
}

module housing_shape() {
    
    outline=[
        [fitted_pulley_radius+6,0],
        [fitted_pulley_radius+6, fitted_pulley_radius+6],
        for(a=[90:2:180]) [cos(a), sin(a)]*(fitted_pulley_radius+6),
        [-fitted_pulley_radius-6, -70],
        [fitted_pulley_radius+6, -70],
    ];
    
    polygon(outline);
}


module circle_section(a,r=1, $fn=10) polygon([[cos(-a/2),sin(a/2)], [0,0], [cos(a/2),sin(-a/2)], for(_a=[0:a/$fn:a]) [cos(_a-a/2),sin(_a-a/2)]]*r);

