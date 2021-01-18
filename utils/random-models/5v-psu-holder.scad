

wall = 3;



difference() {
    linear_extrude(100) square([52+2*wall, 28.5+2*wall], true);
    
    translate([0,-1]) {  
        linear_extrude(100-wall) square([52, 28.5], true);
        
        translate([0, 0, 100-wall-5]) {
            rotate([0,90,0]) linear_extrude(50) circle(d=3, $fn=30);
            #translate([(53+1)/2,0]) rotate([0,90,0]) cylinder(d1=3, d2=6, h=2, $fn=30);
        }

        translate([0, 0, 100-wall-5-66]) {
            rotate([0,90,0]) linear_extrude(50) circle(d=3, $fn=30);
            translate([(53+1)/2,0]) rotate([0,90,0]) cylinder(d1=3, d2=6, h=2, $fn=30);
        }
    }

    translate([0, 0, 100-20]) {
        rotate([90,0,0]) linear_extrude(30) circle(d=10, $fn=30);
        translate([0,28.5/2+wall]) rotate([90,0,0]) cylinder(d1=4, d2=10, h=4, $fn=30);
    }
    #translate([0, 0, 20]) {
        rotate([90,0,0]) linear_extrude(30) circle(d=10, $fn=30);
        translate([0,28.5/2+wall]) rotate([90,0,0]) cylinder(d1=4, d2=10, h=4, $fn=30);
    }

}

*difference() {
    linear_extrude(wall+110) polygon([
        [-70/2,0],
        [-70/2,wall],
        [-(52+2*wall)/2,wall],
        [-(52+2*wall)/2, 29+wall],
        [(52+2*wall)/2, 29+wall],
        [(52+2*wall)/2,wall],
        [70/2,wall],
        [70/2,0],
        [52/2, 0],
        [52/2, 29],
        [-52/2, 29],
        [-52/2, 0]
    ]);
    
    
    
    
}

*translate([-52/2-wall, 0]) linear_extrude(wall) square([52+2*wall, 29+wall]);