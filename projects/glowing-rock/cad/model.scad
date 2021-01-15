
include<threads.scad>;


lamp_height=150;
lamp_diameter=120;
lamp_radius=10;
resolution=200;


// bottom
union() {
    
    difference() {
        translate([0,0,45]) rotate([180,0,0])  shell(d=lamp_diameter, h=45, r=lamp_radius, t=5, $fn=resolution);
        translate([lamp_diameter/2-12,0,0]) linear_extrude(5) square([8,11], center=true);
        #translate([lamp_diameter/2-15,0,1]) rotate([0,90,0]) linear_extrude(20) {
            translate([-1,0,0]) circle(d=4, $fn=resolution);
            translate([0,0,0]) square([2,4], center=true);
        }
    }
    
    /*
    translate([0,0,3]) intersection() {
        union() {
            linear_extrude(lamp_height-30) circle(d=40);
            translate([0,0,lamp_height-30]) difference() {
                sphere(d=40);
                rotate([180,0,0]) linear_extrude(20) square([40,40], center=true);
            }
        }
        metric_thread (40, 25, lamp_height, rectangle=0.2,  square=true, n_starts=1);
    }
    */
    
}



// top
!union() {
    translate([0,0,45]) shell(d=lamp_diameter, h=lamp_height-30, r=lamp_radius, t=1, $fn=resolution);
    translate([0,0,45+3/2]) rotate_extrude($fn=resolution) translate([lamp_diameter/2-3/2,0,0]) difference() {
       square([3,3], center=true);
       rotate([0,0,135]) translate([3,0,0]) square([6,6], center=true);
    }
}







module shell(d, h, r, t, $fn=30) {
    difference() {
        stub(d, h, r, $fn=$fn);
        stub(d-t, h-t, r-t, $fn=$fn);
    }
}

module stub(d, h, r, fn) {
    
    rotate_extrude($fn=$fn) union() {
        square([d/2, h-r]);
        square([d/2-r, h]);
        translate([d/2-r, h-r, 0]) circle(r=r, $fn=$fn/2);
    }

}