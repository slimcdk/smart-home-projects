
// Window 
WINDOW_FRAME_WIDTH = 30;

// Housing parameters
WALL_THICKNESS_X = 2;
WALL_THICKNESS_Y = 2;
WALL_THICKNESS_Z = 7;


// Screws sizes
CLEAT_SCREW_HEAD_DIAMETER = 10; 
CLEAT_SCREW_HEAD_HEIGHT = 3.5; 
CLEAT_SCREW_BODY_DIAMETER = 5;
CLEAT_SCREW_BODY_HEIGHT = 20;
M3_SCREW_HEAD_DIAMETER = 6.2;
M3_SCREW_HEAD_HEIGHT = 3;
M3_SCREW_BODY_DIAMETER = 3;
M3_SCREW_BODY_HEIGHT = 0;
M4_SCREW_HEAD_DIAMETER = 8.2;
M4_SCREW_HEAD_HEIGHT = 3;
M4_SCREW_BODY_DIAMETER = 4;
M4_SCREW_BODY_HEIGHT = 0;


// 13x4x5 bearing
BEARING_1345_OD = 13 + 0.2;
BEARING_1345_ID = 4 - 0.2;
BEARING_1345_WIDTH = 5;

// 19x10x5 bearing
BEARING_19105_OD = 19 + 0.2;
BEARING_19105_ID = 10 - 0.2;
BEARING_19105_WIDTH = 5;


// Motor
NEMA17_BODY_SIDE_LENGTH = 42.3;
NEMA17_BODY_HEIGHT = 39;
NEMA17_MOUNTING_HOLE_DIST = 31;
NEMA17_SHAFT_LENGTH = 23;
NEMA17_SHAFT_DIAMETER = 5;
NEMA17_SHAFT_NECK_DIAMETER = 22;
NEMA17_SHAFT_NECK_HEIGHT = 2;


// Belt and pulleys
MOTOR_PULLEY_TEETHS = 20;
ROLLER_PULLEY_TEETHS = 64;
BELT_WIDTH = 6;
BELT_LENGTH = 158;
BELT_CLEARANCE = 2 + 2; // thickness of belt + extra clearance
MOTOR_PULLEY_THICKNESS = 8;
ROLLER_PULLEY_THICKNESS = 8;

// Curtain
ROLLER_MAX_DIAMETER = 48;
ROLLER_BAR_SMALL_DIAMETER = 17.2;
ROLLER_BAR_LARGE_DIAMETER = 25;
BOOM_DIAMETER = 19;


// Cord
CORD_BALL_DISTANCE = 200 / 33;
CORD_BALL_DIAMETER = 4.2;
CORD_DIAMETER = 1;


// Clutch
SPRING_LOCKED_INSIDE_DIAMETER = 11;
SPRING_LOCKED_OUTSIDE_DIAMETER = 12.5;
SPRING_HEIGHT = (9*1) + 3;
SPRING_OPENING_ANGLE = 220;
SPRING_DRIVER_WALL = 2;

// Magnet
MAGNETS_DIAMETER = 8.2;
MAGNETS_THICKNESS = 3;
MAGNETS_X = 15.5;
MAGNETS_Y = 15.5;




/** DO NOT ALTER **/
function x() = 0;       // distance in x direction
function y() = 1;       // distance in y direction
function z() = 2;       // distance in z direction
function d() = 3;       // small diameter
function D() = 4;       // large diameter
function r() = 5;       // small radius
function R() = 6;       // large radius
function w() = 7;       // width
function l() = 8;       // length
function h() = 9;       // height
function t() = 10;      // thickness
function sl() = 11;     // side length
function dist() = 12;   // euclidian distance
function angle() = 13;  // angle in degrees
function pos() = 14;    // positions array
function val() = 15;    // anything
function o() = 16;      // small circumference
function O() = 17;      // large circumference
function n() = 18;      // number of items
function A() = 20;      // triangle angle A
function B() = 21;      // triangle angle B
function C() = 22;      // triangle angle C
function a() = 23;      // triangle side a
function b() = 24;      // triangle side b
function c() = 25;      // triangle side c

function map(i, arr) = i==undef ? unpack([for(e=arr)e[1]]) : (is_array(i) ? unpack(range(i, arr)) : range(i, arr)[0]);
function unpack(arr) = len(arr) == 1 ? arr[0] : arr;
function range(i, arr) = [for(j=i) lookup(j, arr)];
function is_array(x) = ord(str(x)[0])==91&&ord(str(x)[len(str(x))-1])==93;
/** DO NOT ALTER **/


function gt2_t2d (teeth) =  (teeth*2)/PI;
function gt2_cc (bl, lp, sp) = ((4*bl-6.28*(lp+sp)) + sqrt(pow(4*bl-6.28*(lp+sp),2) - 32*pow(lp-sp,2))) / 16;


function c2c_belt_angle(i) = map(i, [
    [A(), atan(motor_pulley(r())  / pulley_cc(dist()))]
]);


function pulley_cc(i) = map(i, [
    [dist(), gt2_cc(gt2_belt(l()),roller_pulley(d()),motor_pulley(d()))+1],
    [angle(), asin( (roller_center(x())-nema(sl())/2) / (gt2_cc(gt2_belt(l()),roller_pulley(d()),motor_pulley(d()))+1))]
]);


function pulley_diffs(i) = map(i, [
    [x(), roller_center(x())-nema(x())/2], 
    [y(), cos(pulley_cc(angle()))*pulley_cc(dist())]
]);


function wall(i) = map(i, [
    [x(), WALL_THICKNESS_X],
    [y(), WALL_THICKNESS_Y],
    [z(), WALL_THICKNESS_Z]
]);

function boom(i) = map(i, [
    [d(), BOOM_DIAMETER],
    [D(), BOOM_DIAMETER],
    [r(), BOOM_DIAMETER/2],
    [R(), BOOM_DIAMETER/2]
]);

function roller(i) = map(i, [
    [d(), ROLLER_MAX_DIAMETER],
    [D(), ROLLER_MAX_DIAMETER],
    [r(), ROLLER_MAX_DIAMETER/2],
    [R(), ROLLER_MAX_DIAMETER/2]
]);

function roller_bar(i) = map(i, [
    [d(), ROLLER_BAR_SMALL_DIAMETER],
    [D(), ROLLER_BAR_LARGE_DIAMETER],
    [r(), ROLLER_BAR_SMALL_DIAMETER/2],
    [R(), ROLLER_BAR_LARGE_DIAMETER/2]
]);


function window_frame(i) = map(i, [
    [w(), WINDOW_FRAME_WIDTH]
]);


function bounding_box(i) = map(i, [
    [x(), nema(x())+boom(d())+wall(y())],
    [y(), motor_center(y())+nema(y())/2+cleat_screw_head(d())],
    [z(), window_frame(w())],
]);

function cord_balls(i) = map(i, [
    [d(), CORD_BALL_DIAMETER],
    [D(), CORD_BALL_DIAMETER],
    [r(), CORD_BALL_DIAMETER/2],
    [R(), CORD_BALL_DIAMETER/2],
    [dist(), CORD_BALL_DISTANCE]
]);

function cord(i) = map(i, [
    [d(), CORD_DIAMETER],
    [D(), CORD_DIAMETER],
    [r(), CORD_DIAMETER/2],
    [R(), CORD_DIAMETER/2]
]);

function cord_pulley(i) = map(i, [
    [d(), (roller(r())-cord_balls(d())-cord(r())) * 2],
    [D(), (roller(r())-cord_balls(d())-cord(r())) * 2],
    [r(), roller(r())-cord_balls(d())-cord(r())],
    [R(), roller(r())-cord_balls(d())-cord(r())],
    //[o(), ]
]);


/*
function cord_pulley_clearances(i) = map(i, [
    [R(), (roller(r())+0.3) - cord_balls(r())*4], // maximum radius: give three radii of clearance
    [O(), this(R()) * 2 * PI],
    [],
    []
]);
maximum_radius = (roller(r())+0.3) - cord_balls(r())*4; // give three radii of clearance
maximum_circumference = maximum_radius * 2 * PI;
maximum_n_balls = floor(maximum_circumference / cord_balls(dist()));
adjusted_circumference = maximum_n_balls * cord_balls(dist());
adjusted_radius = adjusted_circumference / PI / 2;
*/




function spring_locked_position(i) = map(i, [
    [D(),SPRING_LOCKED_OUTSIDE_DIAMETER],
    [R(),SPRING_LOCKED_OUTSIDE_DIAMETER/2],
    [d(),SPRING_LOCKED_INSIDE_DIAMETER],
    [r(),SPRING_LOCKED_INSIDE_DIAMETER/2],
    [h(), SPRING_HEIGHT],
    [angle(), SPRING_OPENING_ANGLE],
]);

function nema(i) = map(i, [
    [x(), NEMA17_BODY_SIDE_LENGTH],
    [y(), NEMA17_BODY_SIDE_LENGTH],
    [z(), NEMA17_BODY_HEIGHT],
    [w(), NEMA17_BODY_SIDE_LENGTH],
    [sl(), NEMA17_BODY_SIDE_LENGTH],
    [h(), NEMA17_BODY_HEIGHT],
]);


function nema_mount_holes(i) = map(i,  [
    [pos(), [for (o=[[1,1], [1,-1], [-1,-1], [-1,1]]) o*NEMA17_MOUNTING_HOLE_DIST/2]]
]);


function nema_shaft_neck(i) = map(i, [
    [d(), NEMA17_SHAFT_NECK_DIAMETER],
    [D(), NEMA17_SHAFT_NECK_DIAMETER],
    [r(), NEMA17_SHAFT_NECK_DIAMETER/2],
    [R(), NEMA17_SHAFT_NECK_DIAMETER/2],
    [h(), NEMA17_SHAFT_NECK_HEIGHT]
]);

function nema_shaft(i) = map(i, [
    [d(), NEMA17_SHAFT_DIAMETER],
    [D(), NEMA17_SHAFT_DIAMETER],
    [r(), NEMA17_SHAFT_DIAMETER/2],
    [R(), NEMA17_SHAFT_DIAMETER/2],
    [l(), NEMA17_SHAFT_LENGTH]
]);

function nema_wire_guide_center(i) = map(i, [
    [x(), nema(x())/2+sin(pulley_cc(angle()))*pulley_cc(dist())/2],
    [y(), motor_center(y())-nema(y())/2-2],
    [z(), 0]
]);


function gt2_belt(i) = map(i, [
    [dist(), BELT_LENGTH],
    [l(), BELT_LENGTH],
    [w(), BELT_WIDTH]
]);

function belt_clearance(i) = map(i, [
    [dist(), BELT_CLEARANCE],
    [l(), BELT_CLEARANCE]
]);

function motor_pulley(i) = map(i, [
    [d(), gt2_t2d(MOTOR_PULLEY_TEETHS)],
    [D(), gt2_t2d(MOTOR_PULLEY_TEETHS)],
    [r(), gt2_t2d(MOTOR_PULLEY_TEETHS)/2],
    [R(), gt2_t2d(MOTOR_PULLEY_TEETHS)/2],
    [t(), MOTOR_PULLEY_THICKNESS]
]);

function motor_center(i) = map(i, [
    [x(), wall(x()) + boom(d()) + nema(x())/2], 
    [y(), roller_center(y())+pulley_diffs(y())+1]
]);
function roller_pulley(i) = map(i, [
    [d(), gt2_t2d(ROLLER_PULLEY_TEETHS)],
    [D(), gt2_t2d(ROLLER_PULLEY_TEETHS)],
    [r(), gt2_t2d(ROLLER_PULLEY_TEETHS)/2],
    [R(), gt2_t2d(ROLLER_PULLEY_TEETHS)/2],
    [t(), ROLLER_PULLEY_THICKNESS]
]);

function roller_center(i) = map(i, [
    [x(), wall(x()) + roller(r())],
    [y(), wall(y()) + roller(r())]
]);


function boom_center(i) = map(i, [
    [x(), wall(x())+boom(r())], 
    [y(), bounding_box(y())-30]
]);


function cleat_screw_head(i) = map(i, [
    [d(), CLEAT_SCREW_HEAD_DIAMETER],
    [D(), CLEAT_SCREW_HEAD_DIAMETER],
    [r(), CLEAT_SCREW_HEAD_DIAMETER/2],
    [R(), CLEAT_SCREW_HEAD_DIAMETER/2],
    [h(), CLEAT_SCREW_HEAD_HEIGHT]
]);


function cleat_screw_body(i) = map(i, [
    [d(), CLEAT_SCREW_BODY_DIAMETER],
    [D(), CLEAT_SCREW_BODY_DIAMETER],
    [r(), CLEAT_SCREW_BODY_DIAMETER/2],
    [R(), CLEAT_SCREW_BODY_DIAMETER/2],
    [h(), CLEAT_SCREW_BODY_HEIGHT],
]);


function m3_screw_head(i) = map(i, [
    [d(), M3_SCREW_HEAD_DIAMETER],
    [D(), M3_SCREW_HEAD_DIAMETER],
    [r(), M3_SCREW_HEAD_DIAMETER/2],
    [R(), M3_SCREW_HEAD_DIAMETER/2],
    [h(), M3_SCREW_HEAD_HEIGHT],
]);

function m3_screw_body(i) = map(i, [
    [d(), M3_SCREW_BODY_DIAMETER],
    [D(), M3_SCREW_BODY_DIAMETER],
    [r(), M3_SCREW_BODY_DIAMETER/2],
    [R(), M3_SCREW_BODY_DIAMETER/2],
    [h(), M3_SCREW_BODY_HEIGHT],
]);


function m4_screw_head(i) = map(i, [
    [d(), M4_SCREW_HEAD_DIAMETER],
    [D(), M4_SCREW_HEAD_DIAMETER],
    [r(), M4_SCREW_HEAD_DIAMETER/2],
    [R(), M4_SCREW_HEAD_DIAMETER/2],
    [h(), M4_SCREW_HEAD_HEIGHT],
]);


function m4_screw_body(i) = map(i, [
    [d(), M4_SCREW_BODY_DIAMETER],
    [D(), M4_SCREW_BODY_DIAMETER],
    [r(), M4_SCREW_BODY_DIAMETER/2],
    [R(), M4_SCREW_BODY_DIAMETER/2],
    [h(), M4_SCREW_BODY_HEIGHT],
]);


function bearing_1345(i) = map(i, [
    [d(), BEARING_1345_ID],
    [r(), BEARING_1345_ID/2],
    [D(), BEARING_1345_OD],
    [R(), BEARING_1345_OD/2],
    [h(), BEARING_1345_WIDTH]
]);

function bearing_19105(i) = map(i, [
    [d(), BEARING_19105_ID],
    [r(), BEARING_19105_ID/2],
    [D(), BEARING_19105_OD],
    [R(), BEARING_19105_OD/2],
    [h(), BEARING_19105_WIDTH]
]);

function magnet(i) = map(i, [
    [d(), MAGNETS_DIAMETER],
    [D(), MAGNETS_DIAMETER],
    [r(), MAGNETS_DIAMETER/2],
    [R(), MAGNETS_DIAMETER/2],
    [t(), MAGNETS_THICKNESS],
    [h(), MAGNETS_THICKNESS]
]);


function magnet_array(i) = map(i, [
    [d(), bearing_19105(D())+magnet(d())+1],
    [D(), bearing_19105(D())+magnet(d())+1],
    [r(), (bearing_19105(D())+magnet(d()))/2+1],
    [R(), (bearing_19105(D())+magnet(d()))/2+1],
    [angle(), 360 / 10], // effectively the spacing
]);



