# グラフで桁数の多い数字を見栄えよく見せる
suffix_k <- \(x) {
  sprintf("%.1fk", x/1000)
}
# 計算可能な数字かどうか
is_real <- \(x) {
  !is.nan(x) & !is.infinite(x)
}
# NaNまたはInfのときは0を代入する
zero <- \(x) {
  if_else(!is_real(x), 0, x)
}
# 変動係数
cv <- \(x) {
  sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)
}

# ファイルの移動
mv <- \(from, to) {
  file.copy(from = from, to = to)
  file.remove(from)
}

