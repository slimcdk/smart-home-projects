

include <../../../utils/cad/NopSCADlib/lib.scad>;


GLASS_DIAMETER = 800;   // mm
GLASS_THICKNESS = 4;    // mm
BACK_SPACING = 25;      // mm


SECTIONS = 12;
SECTION_ASSEMBLY_POINTS = 4;

$fn=60;

%mirror_plate();
for(a=[0:360/SECTIONS:360]) rotate([0,0, a]) {
    frame_front_section();
    frame_back_section();
}


translate(concat([cos(180),sin(180)]*(GLASS_DIAMETER/2-190),-9)) n173hgel11();

//rotate([0,0,90]) translate([GLASS_DIAMETER/2,0]) pcbs_mount(); 


function frame_assembly_points() = [for(i=[0:1:SECTION_ASSEMBLY_POINTS-1]) [
    cos(i*360/SECTIONS/SECTION_ASSEMBLY_POINTS+360/SECTIONS/SECTION_ASSEMBLY_POINTS/2),
    sin(i*360/SECTIONS/SECTION_ASSEMBLY_POINTS+360/SECTIONS/SECTION_ASSEMBLY_POINTS/2),]
]*(GLASS_DIAMETER/2+3);

function attachments_points() = [for(i=[0:1:2-1]) [
    cos(i*360/SECTIONS/2+360/SECTIONS/2/2),
    sin(i*360/SECTIONS/2+360/SECTIONS/2/2),]
]*(GLASS_DIAMETER/2-10);

module mirror_plate() linear_extrude(GLASS_THICKNESS) circle(d=GLASS_DIAMETER);

module frame_front_section() translate([0,0,GLASS_THICKNESS]) difference() {
    rotate_extrude(angle=360/SECTIONS) translate([GLASS_DIAMETER/2,0]) frame_front_profile();
    for(pos=frame_assembly_points()) translate(pos) linear_extrude(15) circle(d=2.8);
}


module frame_back_section() rotate([0,0,-360/SECTIONS/2]) difference() {
    rotate_extrude(angle=360/SECTIONS) translate([GLASS_DIAMETER/2,0]) frame_back_profile();
    for(pos=frame_assembly_points()) translate(concat(pos,-1)) {
        rotate([180,0,0]) linear_extrude(BACK_SPACING) circle(d=6);
        cylinder(h=2, d1=6, d2=3.1);
        translate([0,0,2]) linear_extrude(3) circle(d=3.1);
    }
    translate([0,0,-5]) for(i=[0:1:2]) rotate([0,90,i*360/SECTIONS/4+360/SECTIONS/4]) linear_extrude(GLASS_DIAMETER/2+9.6-2) circle(d=5);
}

module pcbs_mount() {

    RPI_POS = [-60,0];
    RPI_ANGLE = 90;
    rpi_hole_pos = [[19,24.5], [19,-24.5], [-39,24.5],  [-39,-24.5]];

    //translate([0,0,-5]) for(i=[0:1:2]) rotate([0,90,i*360/SECTIONS/4+360/SECTIONS/4]) linear_extrude(GLASS_DIAMETER/2+9.6-2) circle(d=5);
    //#translate([-GLASS_DIAMETER/2,0]) rotate([0,0,-360/SECTIONS/2]) for(pos=attachments_points()) translate(pos) circle(d=20);

    rotate([0,180,0]) linear_extrude(BACK_SPACING) difference() {
            linear_extrude(BACK_SPACING-2) hull () {
                
                // Frame mounting points
                translate([-GLASS_DIAMETER/2,0]) rotate([0,0,-360/SECTIONS/2]) for(pos=attachments_points()) translate(pos) circle(d=20);

                // RPi 4 bracket wrapper
                translate(RPI_POS) rotate([0,0,RPI_ANGLE]) for(pos=rpi_hole_pos) translate(pos) circle(d=7);
                
            }
            
            // RPi 4 holes in bracket
            //translate(RPI_POS) rotate([0,0,RPI_ANGLE]) for(pos=rpi_hole_pos) translate(pos) circle(d=3);
        
            
            //translate([-GLASS_DIAMETER/2,0]) linear_extrude(BACK_SPACING) circle(d=GLASS_DIAMETER-13-4);

            
            /*#translate([-GLASS_DIAMETER/2,0]) linear_extrude(BACK_SPACING) difference() {
                circle(d=GLASS_DIAMETER);
                circle(d=GLASS_DIAMETER-13);
            }*/
        }
        
    
    /*translate([0,0,-4-2]) linear_extrude(4) {
        
        // RPi4 standoff
        translate(RPI_POS) rotate([0,0,RPI_ANGLE]) for(pos=rpi_hole_pos) translate(pos) difference() {
            circle(d=7);
            circle(d=3);
        }
    }*/
}

module frame_front_profile() polygon([[-6,0],[0.4,0],[10,0],[15, sin(70)*40],[15-4, sin(70)*40]]);
module frame_back_profile() polygon([[-6, 0],[0.4, 0],[0.4, GLASS_THICKNESS],[10, GLASS_THICKNESS],[10, -BACK_SPACING],[-6, -BACK_SPACING]]);

module n173hgel11() {
    size=[234, 400, 7];
    // FRAME
    translate([0,0,1.6]) {
        color("silver") linear_extrude(size[2]) difference() {
            square([size[0], size[1]], true);
            square([size[0], size[1]]-[6,6], true);
        }
        color("silver") linear_extrude(size[2]-1) square([size[0], size[1]], true);
        color("black") translate([0,0,size[2]-1]) linear_extrude(1) square([size[0], size[1]]-[14,12], true);
    }
    // PCB
    translate([-size[0]/2,0,0]) color("green") linear_extrude(1.6) polygon([
        [6, size[1]/2-4],
        [6+40, size[1]/2-4],
        [6+40, 7.55],
        [6+40+15, -7.5],
        [6+40+15, -size[1]/2+4],
        [6, -size[1]/2+4],
    ]);
}


