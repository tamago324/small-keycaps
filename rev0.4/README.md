## 実行方法

src/keycaps で出力したい形の module を呼び出すように編集


例) R2 を `src/keycaps_r2.stl` として出力する

```
openscad -o "stl/keycaps_r2.stl" "src/keycaps.scad"
```


## 参考

* https://github.com/bbrfkr/lhs-profile-keycap
  * こちらの convex と home の作り方を参考にしました。
