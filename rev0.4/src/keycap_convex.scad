include <keycap_base.scad>
use <stem.scad>

// コンベックスキー
convex_key_height = base_height + 2;
convex_key_top = key_top * ((convex_key_height * (key_top / key_bottom)) / base_height);

module convex_outershape(key_bottom_size, key_top_size, key_top_height) {
  intersection(){
    // コンベックスの円柱と重なるように、四角を長めに作成しておく
    base_cube(key_bottom_size, key_top_size, key_top_height, angle=0, shift_upword =0);
    rotate([0,90,0]) {
        $fn=128;
        // この丸みを小さくすると、丸くなる
        convex_value = 1.8;
        scale([1,convex_value,1])
          translate([0, 1, 0])
          cylinder(key_bottom_size,key_top_height,key_top_height,true);
    }
  }
}

module convex_innershape(bottom, top, height) {
  thickness = 1;
  /* convex_outershape(bottom - (thickness * 2), top - (thickness * 2), height - thickness); */
  base_cube(bottom - (thickness * 2), top - (thickness * 2), height - thickness, angle=0, shift_upword=0);
}

module convex_shape(bottom, top, height) {
  difference () {
    convex_outershape(bottom, top, height);
    convex_innershape(bottom, top, height);
  }
}

// コンベックスキー
module keycap_convex() {
  convex_shape(key_bottom, convex_key_top, convex_key_height);

  // キーキャップと合わせられるステムを作成
  intersection() {
    stem();
    // キートップの厚さは1.5mmとする
    convex_outershape(key_bottom, convex_key_top, convex_key_height);
  }
}

