include <keycap_base.scad>

// 四角
module keycap_outer_shape (key_bottom_size, key_top_size, key_top_height, angle, dish_depth) {
  top_r = 1.5;
  bottom_r = 0.5;

  // 基本的なキーキャップを作成
  hull() {
    translate([0, 0, key_top_height])
      rotate([- angle,  0, 0])
        rounded_cube([key_top_size, key_top_size, 0.01], top_r);
    rounded_cube([key_bottom_size, key_bottom_size, 0.01], bottom_r);
  }
}

// スイッチ部分をくり抜いてキーキャップを作成
module keycap_shape(bottom, top, height, angle) {
  depth = 0.8;
  difference () {
    keycap_outer_shape(bottom, top, height, angle, depth); 
    keycap_inner_shape(bottom, top, height, angle, depth);
  }
}

module keycap(key_height, key_angle) {
  keycap_shape(key_bottom, key_top, key_height, key_angle);

  // キーキャップと合わせられるステムを作成
  intersection() {
    stem();
    // キートップの厚さは1.5mmとする
    keycap_outer_shape(key_bottom, key_top, key_height, key_angle, 1.5);
  }
}

keycap(base_height, 0);
