

WALL_THICKNESS = 3;
WALL_THICKNESS_X = 0;
WALL_THICKNESS_Y = 0;
WALL_THICKNESS_Z = 2;
BOTTLE_WALL_HEIGHT = 20;

BOTTLE_CAP_SMALL_DIAMETER = 41;
BOTTLE_CAP_LARGE_DIAMETER = 47;
BOTTLE_CAP_HEIGHT = 28;

BOTTLE_DIAMETER = 83;
BOTTLE_HEIGHT = 120;
BOTTLE_CAP_DELTA_Z = 11;

PIPE_DIAMETER = 6;
PIPE_LENGTH = 60;
PIPE_ANGLE = 10;


LOAD_CELL_WIDTH = 15;
LOAD_CELL_HEIGHT = 13;
LOAD_CELL_LENGTH = 80;


LOAD_CELL_LARGE_HOLE_DIAMETER = 5;
LOAD_CELL_SMALL_HOLE_DIAMETER = 4;

LOAD_CELL_HOLE_DIST = 15;
LOAD_CELL_HOLE_END_OFFSET = 5;





/** DO NO ALTER **/
function x() = 0;       // distance in x direction
function y() = 1;       // distance in y direction
function z() = 2;       // distance in z direction
function d() = 3;       // diameter
function D() = 4;       // large diameter
function r() = 5;       // radius
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
function offset() = 16; // offset from something
function o() = 17;      // small circumference
function O() = 18;      // large circumference
function n() = 19;      // number of items
function A() = 20;      // triangle angle A
function B() = 21;      // triangle angle B
function C() = 22;      // triangle angle C
function a() = 23;      // triangle side a
function b() = 24;      // triangle side b
function c() = 25;      // triangle side c
function DIST() = 26;   // large euclidian distance

function map(i, arr) = i==undef ? unpack([for(e=arr)e[1]]) : (is_array(i) ? unpack(range(i, arr)) : range(i, arr)[0]);
function unpack(arr) = len(arr) == 1 ? arr[0] : arr;
function range(i, arr) = [for(j=i) lookup(j, arr)];
function is_array(x) = ord(str(x)[0])==91&&ord(str(x)[len(str(x))-1])==93;
/** DO NO ALTER **/



/* getters */
function bottle_cap(i) = map(i, [
    [d(), BOTTLE_CAP_SMALL_DIAMETER],
    [D(), BOTTLE_CAP_LARGE_DIAMETER],
    [r(), BOTTLE_CAP_SMALL_DIAMETER/2],
    [R(), BOTTLE_CAP_LARGE_DIAMETER/2],
    [h(), BOTTLE_CAP_HEIGHT],
    [angle(), -atan( (BOTTLE_CAP_LARGE_DIAMETER/2-BOTTLE_CAP_SMALL_DIAMETER/2) / BOTTLE_CAP_HEIGHT)]
]);


function bottle(i) = map(i, [
    [d(), BOTTLE_DIAMETER],
    [D(), BOTTLE_DIAMETER],
    [r(), BOTTLE_DIAMETER/2],
    [R(), BOTTLE_DIAMETER/2],
    [h(), BOTTLE_HEIGHT]
]);

function bottle_cap_delta(i) = map(i, [
    [x(), bottle(r())-bottle_cap(r())],
    [y(), bottle(r())-bottle_cap(r())],
    [z(), BOTTLE_CAP_DELTA_Z],
    [angle(),  -atan( (BOTTLE_DIAMETER/2-BOTTLE_CAP_LARGE_DIAMETER/2) / BOTTLE_CAP_DELTA_Z)]
]);


function wall(i) = map(i, [
    [x(), WALL_THICKNESS_X],
    [y(), WALL_THICKNESS_Y],
    [z(), WALL_THICKNESS_Z],
    [t(), WALL_THICKNESS],
    [h(), BOTTLE_WALL_HEIGHT]
]);


function bottle_pipe(i) = map(i, [
    [d(), PIPE_DIAMETER],
    [D(), PIPE_DIAMETER],
    [r(), PIPE_DIAMETER/2],
    [R(), PIPE_DIAMETER/2],
    [l(), PIPE_LENGTH],
    [angle(), PIPE_ANGLE]
]);


function load_cell(i) = map(i, [
    [h(), LOAD_CELL_HEIGHT],
    [w(), LOAD_CELL_WIDTH],
    [l(), LOAD_CELL_LENGTH],
    [D(), LOAD_CELL_LARGE_HOLE_DIAMETER],
    [d(), LOAD_CELL_SMALL_HOLE_DIAMETER],
    [R(), LOAD_CELL_LARGE_HOLE_DIAMETER/2],
    [r(), LOAD_CELL_SMALL_HOLE_DIAMETER/2],
    [offset(), LOAD_CELL_HOLE_END_OFFSET],
    [dist(), LOAD_CELL_LENGTH/2-LOAD_CELL_HOLE_END_OFFSET-LOAD_CELL_HOLE_DIST],
    [DIST(), LOAD_CELL_LENGTH/2-LOAD_CELL_HOLE_END_OFFSET]
]);






