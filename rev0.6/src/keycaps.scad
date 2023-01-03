include <keycap_base.scad>
include <keycap_convex.scad>
include <runner.scad>

// 何Uか？
keycap_u_size = 1;

r3_height = base_height - 0.6;


// R2
module keycap_r2() {
  // D 0.736mm
  shift_upward = 1.4;
  keycap(base_height, 2, keycap_u_size, shift_upward);
}

// R3
module keycap_r3() {
  // C 0.704mm
  shift_upward = 0.8;
  keycap(r3_height, 4, keycap_u_size, shift_upward);
}

// ホームポジション用の棒線を配置する
module keycap_home() {
  union() {
    keycap_r3();
    hull(){
      translate([-2,-3.5,r3_height - 0.9]) sphere(0.5);
      translate([2,-3.5,r3_height - 0.9]) sphere(0.5);
    }
  }
}

// R4
module keycap_r4() {
  // C 0.74mm
  shift_upward = 0.8;
  keycap(base_height - 0.5, 10, keycap_u_size, shift_upward);
}

// コンベックス
module keycap_convex_key(u_size=keycap_u_size) {
  keycap_convex(u_size);
}



y_count = 5;

module r2() {
  for (y = [0:y_count-1])
    translate([0, 17 * y, 0])
      keycap_r2();

  for (y = [0:y_count-1])
    translate([17, 17 * y, 0])
      keycap_r2();

  // ランナー
  concat_by_runner(2, 5);
}


module r3() {
  translate([0, 0, 0])
    keycap_home();
  for (y = [1:y_count-1])
    translate([0, 17 * y, 0])
      keycap_r3();

  translate([17, 0, 0])
    keycap_home();
  for (y = [1:y_count-1])
    translate([17, 17 * y, 0])
      keycap_r3();

  // ランナー
  concat_by_runner(2, 5);
}


module r4() {
  for (y = [0:y_count-1])
    translate([0, 17 * y, 0])
      keycap_r4();

  for (y = [0:y_count-1])
    translate([17, 17 * y, 0])
      keycap_r4();

  // ランナー
  concat_by_runner(2, 5);
}

// 1.25が4つ、1uが6つ
module convex() {
  // 1.25 用のやつ を2行
  diff = ((key_bottom * 1.25) - key_bottom) / 2;
  for (y = [0:1])
    translate([ 0 - diff, 17 * y, 0])
      keycap_convex_key(1.25);
  for (y = [0:1])
    translate([17 + diff, 17 * y, 0])
      keycap_convex_key(1.25);

  // 1u を3行
  for (y = [2:y_count-1])
    translate([0, 17 * y, 0])
      keycap_convex_key();

  for (y = [2:y_count-1])
    translate([17, 17 * y, 0])
      keycap_convex_key();

  // ランナー
  concat_by_runner(2, 5);
}

module all() {
  // ランナー
  concat_by_runner(2, 5);

  diff = ((key_bottom * 1.25) - key_bottom) / 2;
  translate([ 0 - diff, 17 * 0, 0]) keycap_convex_key(1.25);
  translate([17 + diff, 17 * 0, 0]) keycap_convex_key(1.25);

  translate([ 0, 17 * 1, 0]) keycap_home();
  translate([17, 17 * 1, 0]) keycap_home();

  translate([ 0, 17 * 2, 0]) keycap_r4();
  translate([17, 17 * 2, 0]) keycap_r4();

  translate([ 0, 17 * 3, 0]) keycap_r3();
  translate([17, 17 * 3, 0]) keycap_r3();

  translate([ 0, 17 * 4, 0]) keycap_r2();
  translate([17, 17 * 4, 0]) keycap_r2();
}



/* r2(); */
/* r3(); */
/* r4(); */
convex();
/* all(); */
