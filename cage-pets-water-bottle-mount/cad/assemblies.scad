
use <settings.scad>;
use <bottle-modules.scad>;
use <load-cell-modules.scad>;



pipe_cut_depth = sin(bottle_pipe(angle()))*(bottle_cap(r())+wall(t())) + wall(t()) + bottle_pipe(r());

difference() {
    bottle_cup(pipe_cut_depth);
    #translate([-load_cell(DIST()), 0, -pipe_cut_depth-load_cell(h())]) load_cell_screw_cutout();
}
    
