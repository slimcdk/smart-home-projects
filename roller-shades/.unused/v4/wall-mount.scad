
// libraries
use <../v1/encoder.scad>;
use <../parametricPulley_v3.scad>;



// variables
height=42;
fatness=5;

mount_base_width=20;
mount_base_length=28;
mount_motor_length=70;



// assembly
!bracket($fn=60);
translate([fatness+mount_base_length,fatness+0.6,height/2]) rotate([-90,0,0]) _pulley($fn=60);
translate([mount_base_length+mount_motor_length-42/2,fatness,height/2]) rotate([90,0,180]) color("lightblue") motor_extender($fn=60);
#translate([mount_base_length+mount_motor_length-42/2,fatness+16,height/2]) rotate([90,0,0]) nema17();

color("gray") translate([fatness+mount_base_length, fatness+0.6, height/2]) rotate([-90,0,0]) linear_extrude(5) difference() {
    circle(d=19);
    circle(d=10);
}


module motor_extender() {
    linear_extrude(18) difference() {
        offset(delta=4, chamfer=true) square([34,34], center=true);
        for (a=[45:90:360-45]) rotate([0,0,a]) translate([44/2,0]) circle(d=3.2);
        circle(d=23);
        polygon([[0,-23/2], [0,23/2], [42/2, 23/2], [42/2,-23/2]]);
    }
    
}


module inside_bar_profile() {
    a = 33;
    od = 24.6;
    id= 17.2;
    difference() {
        circle(d=od);
        polygon([[0,0], [od*cos(a),od*sin(a)], [od*cos(a),-od*sin(a)]]);
    }
    circle(d=id);
    
    echo("lip to lip (packman mouth) dist:", od*sin(a));
}


module _pulley() {
    
    difference() {
        union() {
            pulley("GT2 2mm", tooth_spacing (2,0.254), 0.764, 1.494 );
            translate([0,0,8]) linear_extrude(1) circle(d=40);
            translate([0,0,8]) linear_extrude(15) rotate([0,0,90]) inside_bar_profile();
        }
        // fastner screw
        translate([0,0,12]) rotate([90,0,0]) linear_extrude(15) circle(d=3);
        translate([0,-1.5-5,12]) rotate([90,0,0]) linear_extrude(15) circle(d=6);
        
        // encoder
        translate([0,0,-6.6]) encoder_cutout(shaft_tol=0.4, shaft_tol_h=2, extended=10, $fn=60);
        
        // bearing
        linear_extrude(5.6) circle(d=19.1);
    }
    // bearing lip
    translate([0,0,5]) linear_extrude(0.6) difference() {
        circle(d=19.1);
        circle(d=15);
    }
}



module bracket() {
    
    difference() {
        union() {
            color("white") mount_base();
            translate([fatness+mount_base_length,0]) mount_motor();
            translate([fatness+mount_base_length,fatness,height/2]) rotate([-90,0,0]) linear_extrude(0.6) circle(d=12);
            translate([fatness+mount_base_length,fatness,height/2]) rotate([-90,0,0]) linear_extrude(0.6+4.9) circle(d=10);
        }
        
        // encoder cutout       
        translate([fatness+mount_base_length,-1,height/2]) rotate([-90,0,0]) encoder_cutout(shaft_tol=0.4, shaft_tol_h=2, extended=10, $fn=60);
        
        
        
        // roller cutout
        // translate([fatness+mount_base_length,0,height/2]) rotate([-90,0,0]) linear_extrude(fatness) circle(d=19);
        // translate([fatness+mount_base_length, fatness/2, height]) rotate([180,0,0]) linear_extrude(height/2) circle(d=3);
        // translate([fatness+mount_base_length, fatness/2, height]) rotate([180,0,0]) linear_extrude(6) circle(d=7);
        


    }
    
}


module slot(d, c2cl) {
    square([c2cl,d], center=true);
    translate([-c2cl/2,0]) circle(d=d);
    translate([c2cl/2,0]) circle(d=d);
}


module fillet(r) {
    translate([r,r]) rotate([0,0,180]) difference() {
        square([r/2,r/2]*2);
        circle(r=r);
    } 
}

module mount_base() {
  
    difference() {
        union() {
            linear_extrude(height) {
                square([fatness, fatness+mount_base_width]);
                square([mount_base_length+fatness,fatness]);
            }
            
            // joint holes enforcement
            //translate([fatness,fatness/2,2.5]) rotate([0,90,0]) linear_extrude(mount_base_length) circle(d=5);
            //translate([fatness,fatness/2,height-2.5]) rotate([0,90,0]) linear_extrude(mount_base_length) circle(d=5);
        }
        
        // fillets
        translate([0,fatness+mount_base_width,0]) rotate([90,-90,90]) linear_extrude(fatness) fillet(8);
        translate([0,fatness+mount_base_width,height]) rotate([90,180,90]) linear_extrude(fatness) fillet(8);
        
        // wall mounting slots
        translate([0,fatness,10])  rotate([90,0,90]) linear_extrude(fatness) slot(4, mount_base_width);
        translate([0,fatness,height-10]) rotate([90,0,90]) linear_extrude(fatness) slot(4, mount_base_width);
        translate([3,fatness,10])  rotate([90,0,90]) linear_extrude(4) slot(8, mount_base_width);
        translate([3,fatness,height-10]) rotate([90,0,90]) linear_extrude(4) slot(8, mount_base_width);

        
        // joint holes
        // translate([fatness,fatness/2,2.5]) rotate([0,90,0]) linear_extrude(mount_base_length) circle(d=3.2);
        // translate([fatness,fatness/2,height-2.5]) rotate([0,90,0]) linear_extrude(mount_base_length) circle(d=3.2);
        // translate([fatness+mount_base_length-10,fatness/2-5/2,5]) rotate([0,90,0]) linear_extrude(2.5) square([5,5]);
        // translate([fatness+mount_base_length-10,fatness/2-5/2,height]) rotate([0,90,0]) linear_extrude(2.5) square([5,5]);
    }
}


module mount_motor() {
    
    difference() {
        union() {
            linear_extrude(height) square([mount_motor_length, fatness]);
        }
        
        translate([47.5,0,height/2]) rotate([-90,0,0]) linear_extrude(fatness) slot(20, 10);
        
         // nema mounting slots
        l=6;
        translate([47.5,0,height/2]) {
            translate([-31/2,0,31/2]) rotate([-90,0,0]) {
                linear_extrude(fatness) slot(3.2, l);
                linear_extrude(2) slot(7.2, l);
            }
            translate([-31/2,0,-31/2]) rotate([-90,0,0]) {
                linear_extrude(fatness) slot(3.2, l);
                linear_extrude(2) slot(7.2, l);
            }
            translate([31/2,0,31/2]) rotate([-90,0,0]) {
                linear_extrude(fatness) slot(3.2, l);
                linear_extrude(2) slot(7.2, l);
            }
            translate([31/2,0,-31/2]) rotate([-90,0,0]) {
                linear_extrude(fatness) slot(3.2, l);
                linear_extrude(2) slot(7.2, l);
            }
        }
    }
    
    
    //translate([45,fatness,height/2]) rotate([90,0,0]) nema17($fn=60);
    
}


module nema17 () {
    translate([0,0,-36]) difference() {
        union() {
            linear_extrude(34) offset(delta=4, chamfer=true) square([34,34], center=true);
            linear_extrude(34+2) circle(d=22);
            linear_extrude(34+2+18) circle(d=5);
        }
        for (a=[45:90:360-45]) rotate([0,0,a]) translate([44/2,0,34-10]) linear_extrude(10) circle(d=3);
    }
}

