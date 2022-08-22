# 東京比率の計算用データ
# 名称変更：min_case
t_ratio_data <- \(min) {
  nhk_covid |> 
    filter(
      !pref == "Tokyo",
      if_all(where(is.numeric), ~ is_real(.x)),
      tokyo >= min,
    )  
}

# エイリアス
trd <- t_ratio_data
# trd(1000)
