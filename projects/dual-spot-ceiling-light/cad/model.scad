



PLANK_SIZE=[500,200,20];
SPOT_DISTANCE = 230;
SPOT_POSITIONS = [for(i=[1,-1]) [SPOT_DISTANCE/2*i, 0]];



color("brown") difference() {
    plank(PLANK_SIZE, true);
    for(pos=SPOT_POSITIONS) translate(concat(pos, -PLANK_SIZE[2]/2)) linear_extrude(PLANK_SIZE[2]) circle(d=75);
    for(pos=SPOT_POSITIONS) translate(pos) linear_extrude(PLANK_SIZE[2]) circle(d=75+40);
    linear_extrude(PLANK_SIZE[2]/2) square([SPOT_DISTANCE, 75+40], true);
    
    
    // LED groove
    linear_extrude(PLANK_SIZE[2]/2) difference() {
        square([PLANK_SIZE[0], PLANK_SIZE[1]]-[40,40], true);
        square([PLANK_SIZE[0], PLANK_SIZE[1]]-[60,60], true);
    }
}
for(pos=SPOT_POSITIONS) translate(concat(pos, -PLANK_SIZE[2]/2-5)) color("silver") spotlight($fn=60);

translate([0,20]) PSU5V();


for(pos=SPOT_POSITIONS) translate(concat(pos, -PLANK_SIZE[2]/2)) linear_extrude(PLANK_SIZE[2]) difference() {
    circle(d=75+20);
    circle(d=75);
}

module PSU5V() linear_extrude(30) square([70,55], true);

color("black") for (i=[1,-1]) for (ii=[1,-1]) translate([(PLANK_SIZE[0]-20)/2*i,(PLANK_SIZE[1]-10)/2*ii]) rotate([ii*28,i*15,0]) linear_extrude(200) circle(d=5, $fn=30);


module spotlight() {
    difference() {
        union() {
            linear_extrude(5) circle(d=85);
            linear_extrude(25) circle(d=72);
            linear_extrude(60) circle(d=40);
        }
        linear_extrude(2) circle(d=55);
    }
}


module plank(size, center=false) {
    
    outline = [
        [size[0],0],
        [0,0],
        [0, size[1]],
        [size[0], size[1]],
    ];
    
    translate(center?-size/2:[0,0,0]) linear_extrude(size[2]?size[2]:1) polygon(outline);
}


