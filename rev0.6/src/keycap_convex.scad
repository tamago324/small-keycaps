include <keycap_base.scad>
use <stem.scad>

// コンベックスキー
convex_key_height = base_height + 0.5;
convex_key_top = key_top * ((convex_key_height * (key_top / key_bottom)) / (base_height - 1));
/* convex_key_height = base_height + 2;                                                       */
/* convex_key_top = key_top * ((convex_key_height * (key_top / key_bottom)) / (base_height)); */

module convex_outershape(key_bottom_size, key_top_size, key_top_height, u_size) {
  intersection(){
    // コンベックスの円柱と重なるように、四角を長めに作成しておく
    base_cube(key_bottom_size, key_top_size, key_top_height, u_size, angle=0, shift_upword =0.8);
    rotate([0,90,0]) {
        $fn=128;
        // この丸みを小さくすると、丸くなる
        convex_value = 1.7;
        scale([1,convex_value,1])
          translate([0, 1, 0])
          cylinder(key_bottom_size*u_size,key_top_height,key_top_height,true);
    }
  }
}

module convex_innershape(bottom, top, height, u_size) {
  thickness = 1;
  convex_outershape(bottom - (thickness * 2), top - (thickness * 2), height - thickness, u_size);
  /* base_cube(bottom - (thickness * 2), top - (thickness * 2), height - thickness, angle=0, shift_upword=0); */
}

module convex_shape(bottom, top, height, u_size) {
  difference () {
    convex_outershape(bottom, top, height, u_size);
    convex_innershape(bottom, top, height, u_size);
  }
}

// コンベックスキー
module keycap_convex(u_size=1.0) {
  convex_shape(key_bottom, convex_key_top, convex_key_height, u_size);

  // キーキャップと合わせられるステムを作成
  intersection() {
    stem();
    // キートップの厚さは1.5mmとする
    convex_outershape(key_bottom, convex_key_top, convex_key_height, u_size);
  }
}
