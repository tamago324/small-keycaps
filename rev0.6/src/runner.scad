include <keycap_base.scad>

// ランナーの太さ
runner_r = 1.5;
// ランナーの高さ
runner_height = 2;
space = 1;

module runner() {
  // キーキャップの橋に移動
  translate([(key_bottom/2)-(runner_r/2), 0, 0])
  // 全体的に下にずらす (キーキャップの底面が0のため)
  translate([0, 0, -runner_height]) {
    // 横の円柱
    rotate([90, 0, 0])
      cylinder(((runner_r)*2)+(0.5*2)+space, r=runner_r/2, center = true);

    // キーキャップと接続させる部分 x 2
    translate([0, (runner_r/2)+(space/2), 0])
      cylinder(runner_height, r=runner_r/2);
    translate([0, -((runner_r/2)+(space/2)), 0])
      cylinder(runner_height, r=runner_r/2);
  }
}

// キーキャップの半分 (基準が中心のため、半分を移動するために使用)
function keycap_half() = (key_bottom/2);
// ランナーの直径の半分 (真ん中に配置したいときに使用)
function runner_half() = (runner_r/2);
// キー感覚の中間
function space_half() = (space/2);
// 間に配置
function x_runner_place() = keycap_half()-(runner_half()+space_half())+space+runner_half();

// X 方向のランナー
module x_runner() {
  translate([x_runner_place(), -key_bottom+(runner_r), 0])
  rotate([0, 0, 90])
    runner();
}

// 間に配置
function y_runner_place() = keycap_half()+space_half();

// Y 方向のランナー
module y_runner1() {
  translate([key_bottom+space, y_runner_place(), 0])
    runner();
}

module y_runner2() {
  translate([space+runner_r, y_runner_place(), 0])
    runner();
}


// ランナーを配置する
module concat_by_runner(x_count, y_count) {
  for (y = [0:y_count-1])
    translate([0, (key_bottom+space) * y, 0])
      x_runner();

  for (y = [0:x_count+1])
    translate([0, (key_bottom+space) * y, 0])
      y_runner1();

  for (y = [0:x_count+1])
    translate([-(key_bottom+space), (key_bottom+space) * y, 0])
      y_runner2();
}

