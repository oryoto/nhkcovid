#' @title データを呼び出す
#'
#' @description パターンにマッチするファイルが2つ以上ある場合は、自動的にpurrr::mapが適用される。
#' @param `.dir = NULL` ディレクトリ名。初期値`NULL`はダウンロードフォルダを検索する。`.dir = "."`を指定するとワーキングディレクトリを検索する。`.dir = "~"`を指定するとホームディレクトリを検索する。
#' @param `.ptn` 必須。データ名のパターン
#' @param `.f = readxl::read_excel` 適用する関数
#' @param `...` `.f`に付与するオプション
#' @importFrom purrr map
#' @return データフレームまたはデータフレームのリスト
#' @export
read_data <- \(.dir = NULL, .ptn = NULL, .f = readxl::read_excel, ...) {
  if (is.null(.dir)) {
    .dir <- paste0(Sys.getenv("HOME"), "/Downloads") |>
      list.files(pattern = .ptn, full.names = TRUE)
  } else if (.dir == ".") {
    .dir <- here::here()
  } else if (.dir == "~") {
    .dir <- Sys.getenv("R_USER")
  } else if (is.character(.dir)) {
    .dir <- list.files(.dir, pattern = .ptn, full.names = TRUE)
  } else if (!is.character(.dir)) {
    stop("`.dir` は文字列を渡してください。")
  } else if (is.null(.ptn)) {
    stop("`.ptn`を指定してください。")
  }
  if (length(.dir) == 1) {
    .dir |> .f(...)
  } else if (length(.dir) > 1) {
    .dir |> purrr::map(.f, ...)
  }
}

# list_files("inst/extdata", pattern = "soukatu._2018")
# read_data("inst/extdata", .ptn = "soukatu._2018", sheet = "Sheet1")
# list_files(.ptn = "^soukatu2_2018")
# read_data(.ptn = "^soukatu2_2018", sheet = "Sheet1")

# パッケージに同梱されているデータを読み込む
# 依存： `read_data` `extdata`
# 返り値： データフレーム
# `.pkg` パッケージ名
# `.ptn` ファイル名のパターン。`extdata(.pkg)`でファイル名一覧を取得できる。
# `.f = read.csv` 読み込みに利用する関数。
# `...` 読み込み関数のオプション
read_pkg_data <- \(.pkg, .ptn, .f = read.csv, ...) {
  .dir <- paste0(find.package(.pkg), "/extdata")
  .file <- extdata(.pkg) |> stringr::str_subset(.ptn)
  read_data(.dir, .ptn = .file, .f = .f, ...)
}

# read_pkg_data("readr", "^challenge", .f = readr::read_csv)

