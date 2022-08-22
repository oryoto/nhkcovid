# パッケージのextdataを見つける
# `.pkg` パッケージ名
# `...` `list.files`のオプションに引き継がれる。フルパスが欲しいときなどに利用
extdata <- \(.pkg, ...) {
find.package(pkg) |>
  list.files(pattern = "extdata", full.names = TRUE) |>
  list.files(...)
}
# extdata("readr", full.names = TRUE)