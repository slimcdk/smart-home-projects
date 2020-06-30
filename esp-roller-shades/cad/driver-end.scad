
// libraries
use <../../utils/cad/generic_shapes.scad>;
use <../../utils/cad/nema.scad>;
use <../../utils/cad/parametricPulley_v3.scad>;

function gt2_t2d (teeth) =  (teeth*2)/PI;
function gt2_cc (bl, lp, sp) = ((4*bl-6.28*(lp+sp)) + sqrt(pow(4*bl-6.28*(lp+sp),2) - 32*pow(lp-sp,2))) / 16;


// variables
tight_clearance = 0.1;
sliding_clearance = 0.2;
loose_clearance = 0.3;

roller_sheet_diameter = 48;
roller_cover_thickness = 3;

roller_pulley_teeths = 42;
motor_pulley_teeths = 20;
belt_length = 158;
mounting_screws_x = 3;
nema_17_side_length = 42;


// self tapping mounting screw
mounting_screw_head_diameter = 8;
mounting_screw_head_height = 3;
mounting_screw_body_diameter = 4;
mounting_screw_body_length = 3;



// do not alter these parameters //
BRACKET_BACK = 3;
BRACKET_WIDTH = roller_sheet_diameter + mounting_screw_body_length + roller_cover_thickness;
BRACKET_THICKNESS = 21;

MOUNTING_SCREW_HEAD_DIAMETER = mounting_screw_head_diameter + sliding_clearance;
MOUNTING_SCREW_HEAD_HEIGHT = mounting_screw_head_height + sliding_clearance;
MOUNTING_SCREW_BODY_DIAMETER = mounting_screw_body_diameter + sliding_clearance;
MOUNTING_SCREWS_X = mounting_screw_body_length;

ROLLER_COVER_THICKNESS = roller_cover_thickness;
ROLLER_SHEET_DIAMETER = roller_sheet_diameter;
ROLLER_POS_VECTOR = [mounting_screws_x+roller_sheet_diameter/2,roller_sheet_diameter/2+roller_cover_thickness];

NEMA17_SIDE_LENGTH = nema_17_side_length;

ROLLER_PULLEY_DIAMETER = gt2_t2d(roller_pulley_teeths);
MOTOR_PULLEY_DIAMETER = gt2_t2d(motor_pulley_teeths);
PULLEY_CENTER_CENTER = gt2_cc(belt_length, ROLLER_PULLEY_DIAMETER, MOTOR_PULLEY_DIAMETER) - 1;
PULLEY_DIFF_X = ROLLER_POS_VECTOR[0]-NEMA17_SIDE_LENGTH/2;
PULLEY_ANGLE = 90-asin(PULLEY_DIFF_X/PULLEY_CENTER_CENTER);
PULLEY_DIFF_Y = sin(PULLEY_ANGLE)*PULLEY_CENTER_CENTER;

MOTOR_POS_VECTOR = [NEMA17_SIDE_LENGTH/2, roller_cover_thickness+ROLLER_POS_VECTOR[1]+PULLEY_DIFF_Y];


MOUNTING_SCREWS_FROM_TOP = 6;
MOUNTING_SCREWS_FROM_BOTTOM = 15;//(NEMA17_SIDE_LENGTH / 2);


BELT_PROFILE_PATH = [
    ROLLER_POS_VECTOR,
    ROLLER_POS_VECTOR+[ROLLER_PULLEY_DIAMETER/2+3,0],
    MOTOR_POS_VECTOR+[MOTOR_PULLEY_DIAMETER/2+3,0],
    MOTOR_POS_VECTOR,
    MOTOR_POS_VECTOR-[MOTOR_PULLEY_DIAMETER/2+3,0],
    ROLLER_POS_VECTOR-[ROLLER_PULLEY_DIAMETER/2+3,0],
];


*idler_assembly($fn=60);
driver_assembly($fn=60);





// driver assembly
module driver_assembly() {
    
    BRACKET_LENGTH =  MOTOR_POS_VECTOR[1] + NEMA17_SIDE_LENGTH/2;
    
    difference() {
        union() {
            linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([BRACKET_WIDTH, BRACKET_LENGTH]);
            *translate([0, BRACKET_LENGTH]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([10, MOUNTING_SCREW_HEAD_DIAMETER+4]);
            *translate([10, BRACKET_LENGTH]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) fillet(MOUNTING_SCREW_HEAD_DIAMETER);
        }
        
        // upper mounting screw slot
        translate([(MOUNTING_SCREWS_X-1)/2,MOUNTING_SCREWS_FROM_TOP]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([MOUNTING_SCREWS_X-1,MOUNTING_SCREW_BODY_DIAMETER], true);
        translate([(MOUNTING_SCREWS_X-1)+MOUNTING_SCREW_HEAD_HEIGHT/2,MOUNTING_SCREWS_FROM_TOP]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([MOUNTING_SCREW_HEAD_HEIGHT,MOUNTING_SCREW_HEAD_DIAMETER], true);
        
        // lower mounting screw slot
        translate([(MOUNTING_SCREWS_X-1)/2,BRACKET_LENGTH-MOUNTING_SCREWS_FROM_BOTTOM]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([MOUNTING_SCREWS_X-1,MOUNTING_SCREW_BODY_DIAMETER], true);
        translate([(MOUNTING_SCREWS_X-1)+MOUNTING_SCREW_HEAD_HEIGHT/2,BRACKET_LENGTH-MOUNTING_SCREWS_FROM_BOTTOM]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([MOUNTING_SCREW_HEAD_HEIGHT,MOUNTING_SCREW_HEAD_DIAMETER], true);
        
        
        // roller cutout
        translate(ROLLER_POS_VECTOR) translate([0,0,BRACKET_BACK]) linear_extrude(BRACKET_THICKNESS) circle(d=ROLLER_SHEET_DIAMETER);
        translate(ROLLER_POS_VECTOR) translate([0,0,BRACKET_BACK]) linear_extrude(BRACKET_THICKNESS) square(ROLLER_SHEET_DIAMETER/2);
        translate([BRACKET_WIDTH,0]) rotate([0,0,90]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS+2) fillet(ROLLER_SHEET_DIAMETER/2+ROLLER_COVER_THICKNESS);
        translate([NEMA17_SIDE_LENGTH, ROLLER_POS_VECTOR[1]]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([BRACKET_WIDTH-NEMA17_SIDE_LENGTH,BRACKET_LENGTH-ROLLER_POS_VECTOR[1]]);
        translate([BRACKET_WIDTH-(BRACKET_WIDTH-NEMA17_SIDE_LENGTH), ROLLER_POS_VECTOR[1]+ROLLER_SHEET_DIAMETER/2, BRACKET_BACK]) linear_extrude(BRACKET_THICKNESS) rotate([0,0,90]) fillet(10);
        
        
        
        // motor cutouts
        translate(MOTOR_POS_VECTOR) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) circle(d=24);
        translate(MOTOR_POS_VECTOR) for (pos=[[31/2,31/2], [31/2,-31/2], [-31/2,-31/2], [-31/2,31/2]]) translate(pos+[0,0,BRACKET_BACK]) {
            linear_extrude(BRACKET_WIDTH) circle(d=3.2);
            linear_extrude(2) circle(d=7.2);
        }
        
        // belt cutout
        translate([0,0,BRACKET_BACK]) linear_extrude(BRACKET_THICKNESS) polygon(BELT_PROFILE_PATH);
    }
    
    
    // belt cover wall
    translate([BRACKET_WIDTH-(BRACKET_WIDTH-NEMA17_SIDE_LENGTH), ROLLER_POS_VECTOR[1]]) linear_extrude(BRACKET_BACK+7) {
        difference() {
            union() {
                fillet(BRACKET_WIDTH-NEMA17_SIDE_LENGTH);
                translate([-ROLLER_COVER_THICKNESS, 0]) square([ROLLER_COVER_THICKNESS, BRACKET_WIDTH-NEMA17_SIDE_LENGTH]);
                translate([0, -ROLLER_COVER_THICKNESS]) square([BRACKET_WIDTH-NEMA17_SIDE_LENGTH, ROLLER_COVER_THICKNESS]);
            }
            translate([-ROLLER_COVER_THICKNESS,-ROLLER_COVER_THICKNESS]) fillet(BRACKET_WIDTH-NEMA17_SIDE_LENGTH+ROLLER_COVER_THICKNESS);
            translate([BRACKET_WIDTH-NEMA17_SIDE_LENGTH,BRACKET_WIDTH-NEMA17_SIDE_LENGTH]) rotate([0,0,180]) square([2,20]);
        }
        translate([-ROLLER_COVER_THICKNESS,BRACKET_WIDTH-NEMA17_SIDE_LENGTH]) square([ROLLER_COVER_THICKNESS,20]);
        translate([-1,BRACKET_WIDTH-NEMA17_SIDE_LENGTH+20]) square([1,5]);
    }
    

    // roller clutch placement
    translate([BRACKET_WIDTH-(BRACKET_WIDTH-NEMA17_SIDE_LENGTH), ROLLER_POS_VECTOR[1]]) linear_extrude(BRACKET_BACK) fillet(BRACKET_WIDTH-NEMA17_SIDE_LENGTH);
    translate(ROLLER_POS_VECTOR) translate([0,0,BRACKET_BACK])              clutch_spine();
    *translate(ROLLER_POS_VECTOR) translate([0,0,BRACKET_BACK+0.2+5])        spring_adapter();
    *translate(ROLLER_POS_VECTOR) translate([0,0,BRACKET_BACK+0.2])          spring_pulley();
    *translate(ROLLER_POS_VECTOR) translate([0,0,BRACKET_BACK+0.2+7+0.2])    roller_adapter();
}



module roller_adapter() {
    
    difference() {
        union() {
            linear_extrude(2) circle(d=ROLLER_SHEET_DIAMETER-loose_clearance);
            linear_extrude(2+10.8+5+0.4) rotate([0,0,0]) inside_bar_profile();
        }
        linear_extrude(2+10+0.8) circle(d=17+0.2);
        linear_extrude(30) circle(d=13.2-2);
        linear_extrude(2+10+0.8+0.4) circle(d=13.8);
        translate([0,0,2+10+0.8+0.4+1]) linear_extrude(5+0.4) circle(d=13);
    }
    rotate([0,0,360-90/2]) rotate_extrude(angle=90) translate([17/2-2,0]) square([2.1,2+10.8]);    
}


module spring_pulley () {
    spring_angle=220;
    openings_angle=15;
    
    difference() {
        linear_extrude(7) pully_profile();
        linear_extrude(5) circle(d=19.3);
        linear_extrude(8) circle(d=13);
        translate([0,0,5]) rotate([0,0,-60-openings_angle/2]) rotate_extrude(angle=openings_angle) translate([17/2-2,0]) square([2,2]);
        translate([0,0,5]) rotate([0,0,60-openings_angle/2]) rotate_extrude(angle=openings_angle) translate([17/2-2,0]) square([2,2]);
        *linear_extrude(8) circle(d=17);
    }
    
    // spring tension driver
    difference() {
        translate([0,0,5]) rotate([0,0,180-spring_angle/2]) rotate_extrude(angle=spring_angle) translate([17/2-2,0]) square([2,3+12]);
        translate([0,0,8+17.4]) linear_extrude(5+0.2) circle(d=13.2);
    }
}



module spring_adapter() {
    stud_height = 0.2+5+7.8;
    difference() {
        union() {
            linear_extrude(2) circle(d=13-0.2);
            linear_extrude(2+stud_height) circle(d=11);
        }
        linear_extrude(2+stud_height) square([6+0.2, 6+0.2], center=true);
    }
}

module clutch_spine() {
    difference() {
        union() {
            linear_extrude(0.2) circle(d=12);
            linear_extrude(0.2+5-0.1) circle(d=10-0.05);
            linear_extrude(0.2+5+15) square([6,6], center=true);
            linear_extrude(0.2+5+15+3) circle(d=6);
        }
        linear_extrude(0.2+5+15+3) circle(d=3.9);
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
}


module pully_profile() {
    projection() pulley("GT2 2mm", tooth_spacing (2,0.254), 0.764, 1.494 );
}


// idler assembly
module idler_assembly() {
    
    BRACKET_LENGTH = ROLLER_COVER_THICKNESS + ROLLER_SHEET_DIAMETER + 10;
    
    difference() {
        union() {
            linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([BRACKET_WIDTH, BRACKET_LENGTH]);
            translate([0, BRACKET_LENGTH]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([10, MOUNTING_SCREW_HEAD_DIAMETER+4]);
            translate([10, BRACKET_LENGTH]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) fillet(MOUNTING_SCREW_HEAD_DIAMETER);
        }
        
        // upper mounting screw slot
        translate([MOUNTING_SCREWS_X/2,MOUNTING_SCREWS_Y]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([MOUNTING_SCREWS_X,MOUNTING_SCREW_BODY_DIAMETER], true);
        translate([MOUNTING_SCREWS_X+MOUNTING_SCREW_HEAD_HEIGHT/2,MOUNTING_SCREWS_Y]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([MOUNTING_SCREW_HEAD_HEIGHT,MOUNTING_SCREW_HEAD_DIAMETER], true);
        
        // lower mounting screw slot
        translate([MOUNTING_SCREWS_X/2,BRACKET_LENGTH+MOUNTING_SCREW_HEAD_DIAMETER/2]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([MOUNTING_SCREWS_X,MOUNTING_SCREW_BODY_DIAMETER], true);
        translate([MOUNTING_SCREWS_X+MOUNTING_SCREW_HEAD_HEIGHT/2,BRACKET_LENGTH+MOUNTING_SCREW_HEAD_DIAMETER/2]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([MOUNTING_SCREW_HEAD_HEIGHT,MOUNTING_SCREW_HEAD_DIAMETER], true);

        // roller cutout
        translate(ROLLER_POS_VECTOR) translate([0,0,BRACKET_BACK]) linear_extrude(BRACKET_THICKNESS) circle(d=ROLLER_SHEET_DIAMETER);
        translate(ROLLER_POS_VECTOR) translate([0,0,BRACKET_BACK]) linear_extrude(BRACKET_THICKNESS) square(ROLLER_SHEET_DIAMETER/2);
        translate([BRACKET_WIDTH,0]) rotate([0,0,90]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS+2) fillet(ROLLER_SHEET_DIAMETER/2+ROLLER_COVER_THICKNESS);
        translate([NEMA17_SIDE_LENGTH, ROLLER_POS_VECTOR[1]]) linear_extrude(BRACKET_BACK+BRACKET_THICKNESS) square([BRACKET_WIDTH-NEMA17_SIDE_LENGTH,BRACKET_LENGTH-ROLLER_POS_VECTOR[1]]);
        translate([BRACKET_WIDTH-(BRACKET_WIDTH-NEMA17_SIDE_LENGTH), ROLLER_POS_VECTOR[1]+ROLLER_SHEET_DIAMETER/2, BRACKET_BACK]) linear_extrude(BRACKET_THICKNESS) rotate([0,0,90]) fillet(10);
    }
    translate([BRACKET_WIDTH-(BRACKET_WIDTH-NEMA17_SIDE_LENGTH), ROLLER_POS_VECTOR[1]]) linear_extrude(BRACKET_BACK) fillet(BRACKET_WIDTH-NEMA17_SIDE_LENGTH);
}
