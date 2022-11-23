$fs = 0.1;
$fa = 0.25;  // くり抜く円柱を作成のため、精度を上げる


use <stem.scad>

key_thickness = 3.5;
key_bottom_length = 14;
stem_height = 4.05;

translate([0, 0, stem_height+(key_thickness/2)])
  resize([key_bottom_length, key_bottom_length, key_thickness])
    sphere(r=key_bottom_length/2);

resize([0, 0, stem_height+key_thickness/2], [false, false, true])
stem();


include <keycap_base.scad>

// R3
module keycap_r3() {
  // C 0.704mm
  shift_upward = 1;
  keycap(base_height - 0.6, 4, shift_upward);
}
keycap_r3();
