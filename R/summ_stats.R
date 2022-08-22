# ### パネルデータのための便利な要約関数
# 任意の1列に対して任意の複数の関数を適用する
# `.data` データフレーム
# `.col` 関数が適用される列
# `...` 列に適用する関数たち
# `.g` グループ
# `.b = min(.data$date)` 期間はじめ
# `.e = max(.data$date)` 期間おわり
summ_stats <- \(.data, .col, ..., .g = pref,
 .b = min(.data$date), .e = max(.data$date)
) {
  funs <- rlang::enquos(...)
  syms <- rlang::ensyms(...)
  .data |>
    filter(
      !pref == "Tokyo",
      date >= .b,
      date <= .e
    ) |>
    group_by({{ .g }}) |>
    summarise(across(c({{ .col }}),
      list(!!!funs),
      .names = "{.col}_{syms}"
    ))
}

# nhk_covid |>
#   summ_stats(tokyo_power,
#                   mean, sd, cv, .b = "2022-08-01")
# t_power_data("2022-08-01", "2022-08-19") |>
# filter(tokyo_power > 5, tokyo_power < 10)
# t_power_data("2022-06-29", "2022-07-02") |> arrange(desc(tokyo_power_cv))
# t_power_data("2021-12-30", "2022-01-02") |> arrange(desc(tokyo_power_cv))
# t_power_data() |> arrange(desc(tokyo_power_cv))
# nhk_covid |> tail()
