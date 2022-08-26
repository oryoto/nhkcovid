#' パネルデータのための便利な要約関数
#'
#' パネルデータのための便利な要約関数。
#' 任意の複数列に対して任意の関数1つを適用する。
#' `.data` はデータフレーム。
#' `...` は関数が適用される列たち。
#' `.f` は列に適用する関数。
#' `.g` はグループ。
#' `.b = min(.data$date)` は期間はじめ。
#' `.e = max(.data$date)` は期間おわり。
#' @param `.data` データフレーム
#' @param `...` 関数が適用される列たち
#' @param `.f` 列に適用する関数
#' @param `.g` グループ
#' @param `.b = min(.data$date)` 期間はじめ
#' @param `.e = max(.data$date)` 期間おわり
#' @importFrom dplyr filter group_by summarise
#' @import rlang
#' @export
summ_fun <- \(.data, ..., .f, .g = pref,
  .b = min(.data$date), .e = max(.data$date)
) {
  vars <- rlang::enquos(...)
  .data |>
    filter(
      !pref == "Tokyo",
      date >= .b,
      date <= .e
    ) |>
    group_by({{ .g }}) |>
    summarise(across(c(!!!vars), {{ .f }},
     .names = paste0("{.col}", "_", rlang::englue("{{ .f }}"))
    ))
}
# nhk_covid |>
#   summ_fun(tokyo_power, tokyo_ratio,
#     .f = mean, .g = jpref,
#     .b = "2022-08-01"
#   )
# t_power_data("2022-08-01", "2022-08-19") |>
# filter(tokyo_power > 5, tokyo_power < 10)
# t_power_data("2022-06-29", "2022-07-02") |> arrange(desc(tokyo_power_cv))
# t_power_data("2021-12-30", "2022-01-02") |> arrange(desc(tokyo_power_cv))
# t_power_data() |> arrange(desc(tokyo_power_cv))
# nhk_covid |> tail()
