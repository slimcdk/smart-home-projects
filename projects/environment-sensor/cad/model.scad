


fan_size = [40,40];

housing();


module housing() {
    linear_extrude(65) difference() {
        square(fan_size+[6*0.4, 6*0.4], true);
        square(fan_size, true);
    }
}