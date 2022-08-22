# ### パネルデータのための便利な要約関数
# 任意の複数列に対して`mean`、`sd`、`cv`を適用する
# `.data` データフレーム
# `...` 関数が適用される列たち。
# `.g = pref` 行を分割するグループ。日本語が欲しい場合は`jpref`
# `.b = min(.data$date)` 期間はじめ
# `.e = max(.data$date)` 期間おわり
summ_cols <- \(.data, ..., .g = pref,
  .b = min(.data$date), .e = max(.data$date)
) {
  cols <- rlang::enquos(...)
  .data |>
    filter(
      !pref == "Tokyo",
      date >= .b,
      date <= .e
    ) |>
    group_by({{ .g }}) |>
    summarise(across(c(!!!cols),
      list(mean = mean, sd = sd, cv = ~sd(.x) / mean(.x))
    ))
}

# nhk_covid |>
# summarise_cols(tokyo_power, tokyo_ratio, .b = "2022-08-01")
# t_power_data("2022-08-01", "2022-08-19") |>
# filter(tokyo_power > 5, tokyo_power < 10)
# t_power_data("2022-06-29", "2022-07-02") |> arrange(desc(tokyo_power_cv))
# t_power_data("2021-12-30", "2022-01-02") |> arrange(desc(tokyo_power_cv))
# t_power_data() |> arrange(desc(tokyo_power_cv))
# nhk_covid |> tail()

