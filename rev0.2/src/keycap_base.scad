$fs = 0.1;
$fa = 0.25;  // くり抜く円柱を作成のため、精度を上げる

use <stem.scad>

key_bottom = 16;
key_top = 12.5;

// 基準の高さ
base_height = 7;

// --------
// キャップ部分
// --------

// 角が丸い四角
module rounded_cube(size, r) {
  // cylinder の高さ (適当な値)
  h = 0.0001;
  minkowski() {
    cube([size[0] - r*2, size[1] - r*2, size[2] - h], center = true);
    cylinder(r = r, h = h);
  }
}

// くり抜くための円を作成する
function dish_r(w, d) = (w * w + 4 * d) / (8 * d);

// 四角
module keycap_outer_shape (key_bottom_size, key_top_size, key_top_height, angle, dish_depth, shift_upword) {
  difference() {
    // 基本的なキーキャップを作成
    hull() {
      // cherry プロファイルっぽく上にずらす
      translate([0, shift_upword, key_top_height])
        rotate([- angle,  0, 0])
          rounded_cube([key_top_size, key_top_size, 0.01], 1.5);
      rounded_cube([key_bottom_size, key_bottom_size, 0.01], 0.5);
    }

    // くり抜く円柱を作成
    translate([0, 0, key_top_height])
      rotate([- angle, 0, 0])
      translate([0, 0, dish_r(key_top_size, dish_depth) - dish_depth])
        rotate([90, 0, 0])
        cylinder(r = dish_r(key_top_size, dish_depth), h = 60, center = true);
  }
}

// キーキャップのくり抜くための四角
module keycap_inner_shape(bottom, top, height, angle, depth, shift_upword) {
    thickness = 1;
    keycap_outer_shape(bottom - (thickness * 2), top - (thickness * 2), height - thickness, angle, depth, shift_upword);
}

// スイッチ部分をくり抜いてキーキャップを作成
module keycap_shape(bottom, top, height, angle, shift_upword) {
  depth = 0.8;
  difference () {
    keycap_outer_shape(bottom, top, height, angle, depth, shift_upword);
    keycap_inner_shape(bottom, top, height, angle, depth, shift_upword);
  }
}

module keycap(key_height, key_angle, shift_upword = 0) {

  keycap_shape(key_bottom, key_top, key_height, key_angle, shift_upword);

  // キーキャップと合わせられるステムを作成
  intersection() {
    stem();
    // キートップの厚さは1.5mmとする
    keycap_outer_shape(key_bottom, key_top, key_height, key_angle, 1.5, shift_upword);
  }
}

