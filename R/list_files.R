#' ファイル検索のための便利な関数
#'
#' @param `.dir = NULL` ディレクトリ名。初期値`NULL`はダウンロードフォルダを検索する。`.dir = "."`を指定するとワーキングディレクトリを検索する。' `.dir = "~"`を指定するとホームディレクトリを検索する。
#' @param `...` `list.files`のオプションに引き継がれる
#' @importFrom here here
list_files <- \(.dir = NULL, ...) {
  if (is.null(.dir)) {
    paste0(Sys.getenv("HOME"), "/Downloads") |>
      list.files(path = _, ...)
  } else if (.dir == ".") {
    here::here() |>
      list.files(path = _, ...)
  } else if (.dir == "~") {
    Sys.getenv("R_USER") |>
      list.files(path = _, ...)
  } else if (is.character(.dir)) {
    list.files(.dir, ...)
  } else {
    stop("`.dir` は文字列を渡してください。")
  }
  }

# list_files()
# list_files(pattern = "nhk")
# list_files(".")
# list_files("~")
# list_files("R")
# list_files("data-raw", .ptn = "^nhk_covid\\.R")
# list_files(1)
