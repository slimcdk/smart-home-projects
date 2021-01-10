
use <../../utils/cad/draw-profiles.scad>;

use <settings.scad>;
use <mount-profiles.scad>;


difference() {
    linear_extrude(4) ir_faceplate();
    linear_extrude(magnets(t())) magnets_faceplate();
}