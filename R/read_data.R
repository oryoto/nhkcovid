#' データを呼び出す
#'
#' データを呼び出す。
#' パターンにマッチするファイルが2つ以上ある場合は、自動的に\code{purrr::map}が適用される。
#' 返り値：データフレームまたはデータフレームのリスト
#' パターンにマッチするファイルが2つ以上ある場合は、自動的にpurrr::mapが適用される。
#' 姉妹関数の\code{list_files}で目的パスのファイルを調べてから使うと便利。
#' \code{.dir = NULL} ディレクトリ名。初期値\code{NULL}はダウンロードフォルダを検索する。
#' \code{.dir = "."}を指定するとワーキングディレクトリを検索する。
#' \code{.dir = "~"}を指定するとホームディレクトリを検索する。
#' \code{.ptn} 必須。データ名のパターン
#' \code{.f = readxl::read_excel} 適用する関数
#' \code{...} \code{.f}に付与するオプション
#' @param .dir NULL ディレクトリ名。初期値\code{NULL}はダウンロードフォルダを検索する。\code{.dir = "."}を指定するとワーキングディレクトリを検索する。\code{.dir = "~"}を指定するとホームディレクトリを検索する。
#' @param .ptn 必須。データ名のパターン
#' @param .f readxl::read_excel 適用する関数
#' @param ... \code{.f}に付与するオプション
#' @importFrom purrr map
#' @return データフレームまたはデータフレームのリスト
#' @examples
#' read_data(.ptn = "^soukatu2_2018", sheet = "Sheet1")
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
    stop(".dirは文字列を渡してください。")
  } else if (is.null(.ptn)) {
    stop(".ptnを指定してください。")
  }
  if (length(.dir) == 1) {
    .dir |> .f(...)
  } else if (length(.dir) > 1) {
    .dir |> purrr::map(.f, ...)
  }
}


#' パッケージに同梱されているデータを読み込む
#'
#' 依存： \code{read_data} \code{extdata}
#' 返り値： データフレーム。
#' \code{.pkg} パッケージ名。
#' \code{.ptn} ファイル名のパターン。\code{extdata(.pkg)}でファイル名一覧を取得できる。
#' \code{.f = read.csv} 読み込みに利用する関数。
#' \code{...} 読み込み関数のオプション。
#' @param .pkg package name
#' @param .ptn pattern
#' @param .f function which is applied to read data.
#' @examples
#' pkg_data("readr", "^challenge", .f = readr::read_csv)
#' @export
pkg_data <- \(.pkg, .ptn, .f = read.csv, .dir = "/extdata", ...) {
  dir <- paste0(find.package(.pkg), .dir)
  file <- extdata(.pkg) |> stringr::str_subset(.ptn)
  read_data(dir, .ptn = file, .f = .f, ...)
}


