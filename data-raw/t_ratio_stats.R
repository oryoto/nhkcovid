# 東京比率の要約統計量を算出する
# min: 感染者数の下限。東京の値。
t_ratio_stats <- \(min) {
  nhk_covid |> 
    filter(
      tokyo >= min,
      if_all(where(is.numeric), ~ is_real(.x)),
      !pref == "Tokyo"
    ) |> 
    group_by(pref) |> 
    summarise(across(tokyo_ratio, list(mean = mean, sd = sd))) |> 
    ungroup() |> 
    arrange(desc(tokyo_ratio_mean))
}
# エイリアス
trs <- t_ratio_stats

# trs(1000)
