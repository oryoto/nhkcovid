#' グラフで桁数の多い数字を見栄えよく見せる
#'
#' @param x number
suffix_k <- \(x) {
  sprintf("%.1fk", x/1000)
}


#' 計算可能な数字かどうか
#'
#' @param x input
is_real <- \(x) {
  !is.nan(x) & !is.infinite(x)
}

#' NaNまたはInfのときは0を代入する
#'
#' @param x input
#' @importFrom dplyr if_else
zero <- \(x) {
  if_else(!is_real(x), 0, x)
}

#' 変動係数
#'
#' @param x input
cv <- \(x) {
  sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)
}

#' ファイルの移動
#'
#' @param from 移動するファイルの場所
#' @param to 移動するファイルの移動先
mv <- \(from, to) {
  file.copy(from = from, to = to)
  file.remove(from)
}

