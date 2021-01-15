
module draw(path, debug=false) {
    
    // switch view mode
    if (!debug) {
        polygon(path);
    } else {
        #translate([0,0,-1]) polygon(path);
        for (i = [ 0 : len(path)-1 ] ) translate(path[i]) {
            circle(d=1, $fn=30);
            rotate([0,0,180]) color("black") text(size=1, str(i/*, " ", point*/));
        } 
    }
}
