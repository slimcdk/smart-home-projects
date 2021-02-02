
use <lk-fuga-utils.scad>;


assembly_screw_pos = [for(i=[1,-1]) for(ii=[-1,1]) [i*17,ii*15]];


color("white") baseline5050($fn=30);
intersection() {
    insert_body($fn=30);
    *translate([0,0,1.2]) rotate([180,0,0]) linear_extrude(50) square([55,55], true);
}
*translate([0,0,1.2+1]) front_pcb($fn=30);
*translate([4.5+3,0,0]) rotate([-90,0,90]) /*!projection()*/ back_pcb(parts=false, $fn=30);

// Claw screws
*translate([0,0,2.2+2]) rotate([180,0,0]) {
    translate([38/2,0]) claw_screw($fn=30);
    translate([-38/2,0]) claw_screw($fn=30);
}


// Panels
*translate([0,50/2-17/2-(50/2-44/2)+0.2,7]) rotate([0,0,90]) new_ihc_tanget($fn=120);
*translate([0,-50/2+17/2+(50/2-44/2)-0.2,7]) rotate([0,0,90]) new_ihc_tanget($fn=120);
*translate([0,0,6]) rotate([0,0,90]) slim_cover_bar($fn=120);


module insert_body() {
    difference() {
        translate([0,0,1.2]) insert_body_blob($fn=30);

        // Front PCB
        translate([0,0,3]) linear_extrude(10) offset(r=0.2) front_pcb_profile($fn=30);
        translate([0,0,2]) linear_extrude(10) difference () {
            offset(r=-1) front_pcb_profile($fn=30);
            for(p=assembly_screw_pos) translate(p) circle(d=6+1.8,$fn=30);
        }

        // Claw guides
        translate([38/2,0]) claw_cutout($fn=30);
        rotate([0,0,180]) translate([38/2,0]) claw_cutout($fn=30);
        
        // Back PCB
        translate([0,0,-22.8]) {
            translate([3.7+3,0]) linear_extrude(23) square([2,40.4], true);
            translate([-5+3,0]) linear_extrude(23) square([17,38], true);
            translate([13+3,11]) linear_extrude(8) square([16,16], true);
            translate([6+3, 0, 0]) linear_extrude(23) square([6,38], true);
        }
        *rotate([180,0,0]) {
            translate([3.7+3,0]) linear_extrude(30) square([2,40.4], true);
            translate([-5+3,0]) linear_extrude(30) square([17,38], true);
            translate([13+3,-11, 14.6]) linear_extrude(16) square([16,16], true);
            *translate([13+3,+13, 14.6]) linear_extrude(16) square([16,11], true);
            *translate([18+3,-11, 18]) linear_extrude(12) square([10,16], true);
            translate([6+3, 0, 0]) linear_extrude(30) square([6,38], true);
        }
        

        // PCB bridge cutout
        *translate([0.8,0]) linear_extrude(2) square([22.4,38], true);
       
        // Assembly screw holes
        for(p=assembly_screw_pos) translate(concat(p, -25)) linear_extrude(35) circle(d=3,$fn=30);
        for(p=assembly_screw_pos) translate(concat(p, 0.5)) cylinder(h=2, d1=3, d2=6);
        for(p=assembly_screw_pos) translate(concat(p, 2.5)) linear_extrude(5) circle(d=6,$fn=30);
    }
}


module claw_cutout() {
    translate([0,0,1.2+1]) linear_extrude(5) circle(d=5.6);
    linear_extrude(5) circle(d=3);
    rotate([180,0,0]) {
        linear_extrude(20) circle(d=3);
        linear_extrude(30) square([7,6], true);
        translate([3,10/2,13.8]) rotate([0,0,180]) linear_extrude(15) square([13, 10]);
    }
}

module insert_body_blob() {
    linear_extrude(4.4) front_profile();
    rotate([180,0,0]) linear_extrude(22) back_profile();
    *rotate([180,0,0]) linear_extrude(24) back_profile();
}


module front_pcb() color("green") !linear_extrude(1.6) front_pcb_profile();
module front_pcb_profile() difference () {
    smooth(r=0.4) square([42.5,42.5], true);
    for (i=[1,-1]) translate([i*(45/2-7/2),0]) {
        circle(d=6);
        translate([i*3-i*0.5,0]) square([6,10], true);
    }
}

module back_pcb_profile() square([40,21]);
module back_pcb(parts=false) {
    color("green") difference() {
        translate([-40/2, 0]) linear_extrude(1.6) back_pcb_profile();
        *translate([0,23-4/2]) linear_extrude(1.6) square([9,4], true);
        
        // Part cutouts
        translate([0, 11, 1.6+1]) hilink();
        translate([-15/2+11, 19, -0.1]) rotate([180,0,0]) terminal_blocks(3);
    }
    if(parts) {
        translate([0, 11, 1.6+1]) hilink();
        translate([-15/2+11, 19, -0.1]) rotate([180,0,0]) terminal_blocks(3);
    }
}


module hilink($fn=10) {
    linear_extrude(15) square([35, 21], true);
    ps = [[35/2-3,  5/2], [35/2-3,  -5/2], [-35/2+3,  15/2], [-35/2+3,  -15/2]];
    rotate([180,0,0]) for (p=ps) translate(p) linear_extrude(4) circle(d=1.4);
}
module tactile_sw_holes() for(d=[[1,1], [1,-1], [-1,-1], [-1,1]]) translate([d[0]*5/2,d[1]*6/2]) circle(d=1);

module claw_screw() {
    cylinder(h=1, d1=3, d2=5);
    translate([0,0,1]) cylinder(h=2, d1=5, d2=2);
    translate([0,0,3]) {
        linear_extrude(10-3) circle(d=2);
        linear_extrude(15/*21.5-3*/) circle(d=1.8);
    }
}

module terminal_blocks(n=1, $fn=10) {
    n=floor(n);
    translate([n*5,4]) rotate([90,0, -90]) linear_extrude(n*5) polygon([
        [0,0],[0, 6.5],[1.6, 10],[6.5, 10],[7.5, 6.5],[7.5, 0]
    ]);
    for (p=[0:n-1]) translate([2.5+p*5, 0, -4]) linear_extrude(4) circle(d=1.4);
}
