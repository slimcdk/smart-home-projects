


*color("gray") gearbox();
*color("gray") translate([0,44/2,51.5/2+1]) rotate([90-6,0,180]) ttgo();


difference () {
    difference() {
        housing($fn=60);
        *translate([0,0, 51]) linear_extrude(10) square([100, 100], true);
        *translate([0,0, 0]) linear_extrude(19) square([100, 100], true);
        
        // Screw holes
        for(pos=[[20,25], [-20,25]]) translate(pos) {
            linear_extrude(50) circle(d=2.9, $fn=30);
            linear_extrude(2) circle(d=6, $fn=30);
        }
        translate([0,-23.8, -1]) rotate([0,0]) {
            linear_extrude(11) circle(d=1.9, $fn=30);
            linear_extrude(1.6) circle(d=4, $fn=30);
        }
    }
    *translate([0,-35, -5]) linear_extrude(80) square([30, 80]);
    linear_extrude(4) square([100, 100], true);
}


module housing() {
    difference() {
        linear_extrude(54) { // 55
            translate([-(44+4)/2,-3]) square([44+4, (44+4)/2+20]);
            translate([0,-3]) circle(d=44+4);
        }
        translate([0,-2.6,-3]) rotate([5,0,180]) linear_extrude(60) difference() {
            translate([-48/2,0]) square([48,30]);
            circle(d=48);
            *translate([0,24]) circle(d=6);
        }
               
        
        // Gearbox cutout
        linear_extrude(13.5) circle(d=45);
        linear_extrude(35) intersection() {
            circle(d=41);
            translate([0,-8]) square([41,41], true);
        }    
        translate([0,-3.5]) {
            // Motor center
            linear_extrude(29+22) circle(d=28);
            linear_extrude(29+18) {
                square([34, 2], true);
                square([2, 33], true);
            }
        }
        translate([0,4,35]) linear_extrude(16) square([28,17], true);
        
        
        // TTGO cutout
        translate([0,44/2,51.5/2+1.5]) rotate([90-6,0,180]) ttgo_cutout();
        translate([-30/2,0]) rotate([90,0,90]) linear_extrude(30) polygon([
            [12.5,13.5],
            //[21,1.5],
            [12.5,1.5],
            [29.8,1.5],
            [29.8-(sin(6)*51),51],
            [0,51],
            [0,51-16],
            [12.5,51-16]
        ]);
        
        
        // Front panel cutout
        translate([0,35-2]) rotate([90+6,0,0]) {
            // Display
            translate([-18/2,19-3]) {
                linear_extrude(2) square([18.5, 32.5]);
                linear_extrude(5) square([18.5, 5]);
            }
            // Buttons
            translate([0,5.2]) {
                translate([8,0]) linear_extrude(8) circle(d=4);
                translate([-8,0]) linear_extrude(8) circle(d=4);
            }
            // Face
            translate([48/2,-5]) rotate([180,0,180]) linear_extrude(40) square([48,70]);
        }
        
        // Temp sensor wire cutout
        *translate([14,22.2]) linear_extrude(51) {
            circle(d=4.2);
            rotate([0,0,-35]) translate([0, -3]) square([4.2, 6], true);
        }
        
    }
    
    // Gearbox hook
    translate([0,-44/2+0.5]) linear_extrude(1) square([7,2], true);
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


module ttgo_cutout() {
    difference() {
        union() {
            translate([0,0,-0.3]) linear_extrude(1.2+0.6) square([25.2+1, 51.5], true);
            translate([-9/2,-51.5/2-8,1.2]) linear_extrude(3.2) square([9,10]);

            translate([0, -51.5/2+3,1.2]) linear_extrude(2.5) {
                translate([-16/2,0]) square([3.5,4], true);
                translate([16/2,0]) square([3.5,4], true);
            }
            translate([0, -51.5/2+8]) rotate([180,0,0]) linear_extrude(3.5) square([8,5], true);
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