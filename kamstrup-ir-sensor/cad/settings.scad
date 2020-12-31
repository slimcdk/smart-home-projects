

WALL_THICKNESS = 2;
IR_DIAMETERS = 5;
IR_DISTANCE = 7;

MAGNETS_DIAMETER = 8.2;
MAGNETS_THICKNESS = 3;
MAGNETS_X = 15.5;
MAGNETS_Y = 15.5;





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
function walls(i) = map(i, [
    [t(), WALL_THICKNESS]
]);

function ir_diodes(i) = map(i, [
    [d(), IR_DIAMETERS],
    [D(), IR_DIAMETERS],
    [r(), IR_DIAMETERS/2],
    [R(), IR_DIAMETERS/2],
    [dist(), IR_DISTANCE]
]);

function magnets(i) = map(i, [
    [d(), MAGNETS_DIAMETER],
    [D(), MAGNETS_DIAMETER],
    [r(), MAGNETS_DIAMETER/2],
    [R(), MAGNETS_DIAMETER/2],
    [t(), MAGNETS_THICKNESS],
    [h(), MAGNETS_THICKNESS]
]);

function faceplate_magnets(i) = map(i, [
    [x(), MAGNETS_X],
    [y(), MAGNETS_Y]
]);


function ir_faceplate(i) = map(i, [
    [d(), (sqrt(pow(MAGNETS_X/2,2)+pow(MAGNETS_Y/2,2)) + magnets(r()) + walls(t())) * 2],
    [D(), (sqrt(pow(MAGNETS_X/2,2)+pow(MAGNETS_Y/2,2)) + magnets(r()) + walls(t())) * 2],
    [r(), sqrt(pow(MAGNETS_X/2,2)+pow(MAGNETS_Y/2,2)) + magnets(r()) + walls(t()) ],
    [R(), sqrt(pow(MAGNETS_X/2,2)+pow(MAGNETS_Y/2,2)) + magnets(r()) + walls(t())]
]);




