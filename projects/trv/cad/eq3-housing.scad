



difference() {
    union() {
        color("gray") gearbox();
        color("gray") translate([0,44/2-4,51.5/2+10]) rotate([-90+13,0,0]) ttgo();
        intersection() {
            housing($fn=60);
            translate([0,-50]) linear_extrude(80) square([50,100]);
        }
    }
   
    hole_pos = [[-(44+4)/2+4,8], [-(44+4)/2+4,63-8], [(44+4)/2-4,8], [(44+4)/2-4,63-8]];
    translate([0,44/2+3,0]) rotate([90,0,0]) for (p=hole_pos) translate(p) {
        linear_extrude(5) circle(d=3.5, $fn=30);
        linear_extrude(50) circle(d=3, $fn=30);
    }
}





module housing() {
    difference() {
        linear_extrude(63) { //63
            translate([-(44+4)/2,0]) square([44+4, (44+4)/2+1]);
            circle(d=44+4);
        }
        *translate([0,0,-2]) rotate([3,0,180]) linear_extrude(54) difference() {
            translate([-48/2,0]) square([48,30]);
            circle(d=48);
        }
        
        

        // Gearbox cutout
        linear_extrude(13.5) circle(d=44);
        linear_extrude(35) circle(d=41);
       
        // Motor center
        translate([0,-3.5]) {
            linear_extrude(61.5) circle(d=28);
            linear_extrude(52)square([34, 2], true);
            linear_extrude(52) square([2, 33], true);
        }
        
        // TTGO cutout
        translate([-26/2,44/2,10]) linear_extrude(5) square([26,3]);
        translate([30/2,44/2+3,10+5]) linear_extrude(46.5) rotate([0,0,180]) square([30,25]);
        translate([-10/2,44/2-5.9,65]) rotate([180+13,0,0]) linear_extrude(5) square([10,4]);
    }
    translate([-30/2,44/2-10,61.5]) rotate([180,0,0]) linear_extrude(2) square([30,2]);
    
    
    /*difference() {
        linear_extrude(4) square([48, 50], true);
        linear_extrude(2.4) square([18, 31], true);
        translate([0,31/2-1]) linear_extrude(5) square([18, 2], true);
    }*/

}

module ttgo() {
    difference() {
        union() {
            linear_extrude(1.2) square([25.2, 51.5], true);
            translate([-9/2,-51.5/2-1.5,1.2]) linear_extrude(3.2) square([9,8]);

            translate([0, -51.5/2+3,1.2]) linear_extrude(2.5) {
                translate([-16/2,0]) square([3.5,4], true);
                translate([16/2,0]) square([3.5,4], true);
            }
            translate([0, -51.5/2+8]) rotate([180,0,0]) linear_extrude(3.5) square([8,5], true);
        }
        
        linear_extrude(1.2) translate([0, -51.5/2+16]) for (p=[0:11]) translate([0, 2.56*p]) {
            translate([-23/2,0]) circle(d=1);
            translate([23/2,0]) circle(d=1);
        }
    }
}

module gearbox() {
    difference() {
        union() {
            linear_extrude(13.5) circle(d=44);
            linear_extrude(15) circle(d=41);
            linear_extrude(29) circle(d=39);
            
            translate([0,-3.5]) {
                linear_extrude(50) circle(d=25);
                linear_extrude(46) circle(d=28);
                linear_extrude(46) square([33, 2], true);
                linear_extrude(46) square([2, 32], true);
            }
        }
        translate([-44/2,44/2-9.5,16.5]) linear_extrude(40) square([44,30]);        
        
        *linear_extrude(10) circle(d=44-2);
        *translate([0, -44/2]) linear_extrude(2) square([8,3], true);
        *translate([0, -44/2]) linear_extrude(6) {
            translate([-3.5,0]) square([1,3], true);
            translate([3.5,0]) square([1,3], true);
        }
    }

    translate([0,0,15]) linear_extrude(19) intersection() {
        difference() {
            circle(d=41);
            circle(d=39);        
        }
        square([50, 15.5], true);
    }
}