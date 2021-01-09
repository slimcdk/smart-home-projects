

base($fn=120);
//linear_extrude(500) light_beam_profile();

//rotate([0,0,-45]) translate([0,30]) lid($fn=60);



module base(diameter=120, height=10) {
    difference() {
        union() {
            rotate_extrude() polygon([[0,0], [0,height], for (a=[0:5:90]) [diameter/2+sin(a)*10, cos(a)*height]]);
            linear_extrude(30) light_beam_profile(4);
            rotate([0,0,-45]) translate([0, diameter/2-9, height]) switch_tab_knob();
        }
        translate([0, 0, 1]) linear_extrude(50) light_beam_profile(0.2);
        rotate([0,0,-45]) { 
            translate([-36/2, -.2]) linear_extrude(height-1) square([36,diameter/2+0.4]);
            translate([-40.4/2, diameter/2-60.2]) linear_extrude(3) square([40.4, 60.4]);
            translate([0, diameter/2-9, height-1]) linear_extrude(1) switch_tap();
            
            translate([0,60/2]) {
                linear_extrude(2) square([60,10.4], true);
                linear_extrude(5) {
                    translate([30,0]) circle(d=10.4);
                    translate([-30,0]) circle(d=10.4);
                }
                linear_extrude(height-1) {
                    translate([30,0]) circle(d=4);
                    translate([-30,0]) circle(d=4);
                }
            }
        }
    }
}


module lid() {
    difference() {
        union() {
            linear_extrude(1) {
                square([40, 60], true);
                square([60,10], true);
                translate([30,0]) circle(d=10);
                translate([-30,0]) circle(d=10);
            }
            linear_extrude(4) {
                translate([30,0]) circle(d=10);
                translate([-30,0]) circle(d=10);
            }
        }
        linear_extrude(3) {
            translate([30,0]) circle(d=6.2);
            translate([-30,0]) circle(d=6.2);
        }
        linear_extrude(4) {
            translate([30,0]) circle(d=3);
            translate([-30,0]) circle(d=3);
        }
    }
}





module light_beam_profile(tol=0.0) {
    translate([-(15+tol)/2.1, -(15+tol)/2.1]) polygon([[0,0], for (a=[0:5:90]) [cos(a)*(15+tol), sin(a)*(15+tol)]]);
}

module switch_tab_knob(size=5) {
    intersection() {
        translate([0,0,-20/2]) sphere(d=22);
        linear_extrude(10) circle(r=size);
    }   
}

module switch_tap(size=5, tap_length=5) {
    length=size/2+1+tap_length;
    difference() {
        switch_tap_profile(5, length);
        switch_tap_profile(5-0.4, length);
    }
}

module switch_tap_profile(d=5, tap_length=5) {
    polygon([
        [cos(180+45)*(d),-tap_length],
        [cos(-45)*(d),-tap_length],
        [cos(-45)*(d), sin(-45)*(d)],
        for (a=[-45:5:180+45]) [cos(a)*(d), sin(a)*(d)]
    ]);
}


module switch_tap_cutout_profile() {
    size=5;
    length=5;
    polygon([
        [cos(180+45)*(size),-(size/2+1+length)],
        [cos(-45)*(size),-(size/2+1+length)],
        [cos(-45)*(size), sin(-45)*(size)],
        for (a=[-45:5:180+45]) [cos(a)*(size), sin(a)*(size)]
    ]);
}