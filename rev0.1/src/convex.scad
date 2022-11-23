include <keycap_base.scad>
include <stem.scad>

// 膨らみを表現する
module convex_top(key_top_height, key_top_size, dish_depth, angle) {
  difference() {
    translate([0, 0, key_top_height])
      rotate([- angle, 0, 0])
      translate([0, 0, -(dish_r(key_top_size, dish_depth) - dish_depth)])
        rotate([90, 0, 0])
          cylinder(r = dish_r(key_top_size, dish_depth), h = key_top_size, center = true);

    translate([0, 0, -(100/2)+key_top_height])
      cube([100, key_top_size+10, 100], center=true);

    translate([0, 0, -(100/2)+key_top_height])
      cube([100, key_top_size-4, 100], center=true);
  }
}

// 四角
module keycap_convex_outer_shape (key_bottom_size, key_top_size, key_top_height, angle, dish_depth) {
  /* difference() { */
    // 基本的なキーキャップを作成
    hull() {
      // cherry プロファイルっぽく上にずらす
      translate([0, 0, key_top_height])
        rotate([- angle,  0, 0])
          rounded_cube([key_top_size, key_top_size, 0.01], 1.5);
      rounded_cube([key_bottom_size, key_bottom_size, 0.01], 0.5);
    }

    convex_top(key_top_height, key_top_size, dish_depth, angle);

  /* } */
}

// キーキャップのくり抜くための四角
module keycap_convex_inner_shape(bottom, top, height, angle, depth) {
    thickness = 1;
    keycap_outer_shape(bottom - (thickness * 2), top - (thickness * 2), height - thickness, angle, depth);
}


// スイッチ部分をくり抜いてキーキャップを作成
module keycap_convex_shape(bottom, top, height, angle) {
  // くぼみの深さ
  depth = 0.8;
  difference () {
    keycap_convex_outer_shape(bottom, top, height, angle, depth); 
    keycap_convex_inner_shape(bottom, top, height, angle, depth);
  }
}

module keycap_convex(key_height) {

  keycap_convex_shape(key_bottom, key_top, key_height, 0);

  /* // キーキャップと合わせられるステムを作成          */
  /* intersection() {                                                      */
  /*   stem();                                                             */
  /*   // キートップの厚さは1.5mmとする                        */
  /*   keycap_convex_outer_shape(key_bottom, key_top, key_height, 0, 1.5); */
  /* }                                                                     */
}

keycap_convex(base_height);

/* convex_top(key_bottom, key_top, base_height, 0); */
