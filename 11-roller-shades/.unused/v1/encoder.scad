/** ENCODER **/
module encoder_model() {
    // body
    linear_extrude(4.5) square([11.9, 12.1], center=true);
    translate([0,0,4.5]) linear_extrude(7) circle(d=7);
    
    // axis
    translate([0,0,4.5+7]) linear_extrude(1.6) circle(d=3.5);
    translate([0,0,4.5+7+1.6]) linear_extrude(1.1) circle(d=6);
    translate([0,0,4.5+7+1.6+1.1]) linear_extrude(10) intersection() {
        circle(d=6, $fn=$fn);
        translate([0, (6-4.2)/2,0]) square([6,4.2], center=true);
    }
    
    // pins
    rotate([180,0,0]) linear_extrude(3.5) {
        translate([11.9/2-0.5/2, 0, 0]) square([0.5, 2.5], center=true);
        translate([-11.9/2+0.5/2, 0, 0]) square([0.5, 2.5], center=true);
    }
}

module encoder_cutout(shaft_tol=0, shaft_tol_h=0, extended=0) {
    translate([0,0,-extended])  linear_extrude(2.5+extended) square([12,16], center=true);
    linear_extrude(4.5) square([11.9,12.1], center=true);
    linear_extrude(13.1) circle(d=7.2);
    color("red") translate([0,0,4.5+shaft_tol_h])  linear_extrude(9.8-shaft_tol_h) circle(d=6.9+shaft_tol);
    
    linear_extrude(14.3) circle(d=6+0.3);
    rotate([0,0,90]) linear_extrude(24.5+extended) intersection() {
        circle(d=6+0.3);
        translate([1.5,0]) square([6,6+0.3], center=true);
    }
}


encoder_cutout(shaft_tol=0.4, shaft_tol_h=2, extended=0, $fn=60);