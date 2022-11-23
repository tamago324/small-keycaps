$fs = 0.1;

// --------
// ステム
// --------
stem_outer_size = 5.5;
stem_cross_length = 4.0;
stem_cross_h = 1.25 + 0.05;
stem_cross_v = 1.10 + 0.05;

module stem() {
  difference () {
    cylinder(d = stem_outer_size, h=15);
    // 十字部分
    translate([0, 0, 15 / 2])
      cube([stem_cross_h, stem_cross_length, 15], center = true);
    translate([0, 0, 15 / 2])
      cube([stem_cross_length, stem_cross_v, 15], center = true);
  }
}
