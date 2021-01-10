
use <baseline-frame.scad>;


assembly_screw_pos = [for(i=[1,-1]) for(ii=[-1,1]) [i*17,ii*15]];


*color("white") baseline5050($fn=30);
intersection() {
    insert_body($fn=30);
    *translate([0,0,1.2]) rotate([180,0,0]) linear_extrude(50) square([55,55], true);
}
translate([0,0,1.2+1]) front_pcb($fn=30);
translate([4.5,0,0]) rotate([-90,0,90]) back_pcb(parts=true, $fn=30);



module insert_body() {
    difference() {
        translate([0,0,1.2]) insert_body_blob($fn=30);

        // Front PCB
        translate([0,0,3]) linear_extrude(10) front_pcb_profile($fn=30);
        translate([0,0,2]) linear_extrude(10) difference () {
            offset(r=-1) front_pcb_profile($fn=30);
            for(p=assembly_screw_pos) translate(p) circle(d=3+2,$fn=30);
        }
            
            
        // Claw guides
        translate([38/2,0]) claw_cutout($fn=30);
        rotate([0,0,180]) translate([38/2,0]) claw_cutout($fn=30);
        
        // Back PCB
        rotate([180,0,0]) {
            translate([3.7,0]) linear_extrude(30) square([2,40.4], true);
            translate([-5,0]) linear_extrude(30) square([17,38], true);
            translate([10,-11, 14]) linear_extrude(16) square([10,15.4], true);
            translate([8, 0, 0]) linear_extrude(30) square([8,38], true);
        }
        
        // PCB bridge cutout
        translate([3.7,0]) linear_extrude(2) square([8,38], true);
       
        // Assembly screw holes
        for(p=assembly_screw_pos) translate(concat(p, -25)) linear_extrude(35) circle(d=3,$fn=30);
    }
}


module claw_cutout() {
    translate([0,0,1.2+1]) linear_extrude(5) circle(d=6);
    linear_extrude(5) circle(d=3);
    rotate([180,0,0]) {
        linear_extrude(20) circle(d=3);
        linear_extrude(30) square([7,6], true);
        translate([3,6/2,15]) rotate([0,0,180]) linear_extrude(7.2) square([9, 6]);
    }
}

module insert_body_blob() {
    linear_extrude(4.4) front_profile();
    rotate([180,0,0]) linear_extrude(23) back_profile();
}


module front_pcb() color("green") linear_extrude(1.6) {
    difference() {
        front_pcb_profile();
        
        // Assembly screw holes
        for(p=assembly_screw_pos) translate(p) circle(d=3,$fn=30);
    } 
}
module front_pcb_profile() difference () {
    smooth(r=1) square([42.8,42.8], true);
    for (d=[1,-1]) translate([d*(45/2-7/2),0]) {
        circle(d=8.2);
        translate([d*3,0]) square([6,8.2], true);
    }
}
module front_profile() {
    smooth(2) square([45,45], true);
    square([46.5,6], true);
}


module back_pcb_profile() square([40,23]);
module back_pcb(parts=false) {
    color("green") difference() {
        translate([-40/2, 0]) linear_extrude(1.6) back_pcb_profile();
        // Part cutouts
        translate([0, 11, 1.6+1]) hilink();
        translate([-15/2+11, 19, -0.1]) rotate([180,0,0]) terminal_blocks(3);
    }
    if(parts) {
        translate([0, 11, 1.6+1]) hilink();
        translate([-15/2+11, 19, -0.1]) rotate([180,0,0]) terminal_blocks(3);
    }
}
module back_profile()  {
    large_radius=50.5/2;
    small_radius=43/2;
    radius_delta=large_radius-small_radius;
    difference() {
        polygon([
            for(a=[0:5:360]) [
                (large_radius+(sin((a-45)*2)*radius_delta))*cos(a), 
                (large_radius+(cos(a*2)*radius_delta))*sin(a)
            ]
        ]);
    }
}

module hilink($fn=10) {
    linear_extrude(15) square([35, 21], true);
    ps = [[35/2-3,  5/2], [35/2-3,  -5/2], [-35/2+3,  15/2], [-35/2+3,  -15/2]];
    rotate([180,0,0]) for (p=ps) translate(p) linear_extrude(4) circle(d=1);
}
module tactile_sw_holes() for(d=[[1,1], [1,-1], [-1,-1], [-1,1]]) translate([d[0]*5/2,d[1]*6/2]) circle(d=1);

module terminal_blocks(n=1, $fn=10) {
    n=floor(n);
    translate([n*5,4]) rotate([90,0, -90]) linear_extrude(n*5) polygon([
        [0,0],[0, 6.5],[1.6, 10],[6.5, 10],[7.5, 6.5],[7.5, 0]
    ]);
    for (p=[0:n-1]) translate([2.5+p*5, 0, -4]) linear_extrude(4) circle(d=1);
}
