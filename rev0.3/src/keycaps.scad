include <keycap_base.scad>

// R2
module keycap_r2() {
  // D 0.736mm
  shift_upward = 1;
  keycap(base_height, 2, shift_upward);
}

// R3
module keycap_r3() {
  // C 0.704mm
  shift_upward = 1;
  keycap(base_height - 0.6, 4, shift_upward);
}

// R4
module keycap_r4() {
  // C 0.74mm
  shift_upward = 1;
  keycap(base_height - 0.3, 10, shift_upward);
}

keycap_r2();
/* keycap_r3(); */
/* keycap_r4(); */

//for (x = [0, 1, 2, 3, 4])
  //translate([17 * x, 17, 0])
    //keycap_r4();

/* for (x = [0, 1, 2, 3, 4])        */
/*   translate([17 * x, 17 * 2, 0]) */
/*     keycap_r3();                 */

/* for (x = [0, 1, 2, 3, 4])        */
/*   translate([17 * x, 17 * 3, 0]) */
/*     keycap_r2();                 */

