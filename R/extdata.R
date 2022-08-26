#' パッケージのextdataを見つける
#'
#' @param .pkg パッケージ名
#' @param ... \code{list.files}のオプションに引き継がれる。フルパスが欲しいときなどに利用
#' @export
#'
extdata <- \(.pkg, ...) {
find.package(pkg) |>
  list.files(pattern = "extdata", full.names = TRUE) |>
  list.files(...)
}
# extdata("readr", full.names = TRUE
