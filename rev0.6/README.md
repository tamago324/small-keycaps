## これはなに？

底面が16mmの Cherry プロファイル風なキーキャップです。

また、JLCPCB の MJF で発注するようにステムを調整しています。
ニッパーでパチパチ切れます

## 実行方法

src/keycaps で出力したい形の module を呼び出すように編集
また、`keycap_u_size` でサイズを変更可能 (1 と 1.25 は確認済み)


例) R2 を `src/keycaps_r2.stl` として出力する

```
openscad -o "stl/keycaps_r2.stl" "src/keycaps.scad"
```


## 参考

* https://github.com/bbrfkr/lhs-profile-keycap
  * こちらの convex と home の作り方を参考にしました。
