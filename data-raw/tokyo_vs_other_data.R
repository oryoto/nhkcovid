# 東京都の感染者数
tokyo_case <-
  nhk_covid |>
  filter(pref == "Tokyo") |> 
  select(date, t_case_day = case_day)

# 東京都の感染者数を列に加える
tokyo_vs_other_data <- 
  nhk_covid |> 
  group_by(pref) |> 
  left_join(tokyo_case, by = "date") |> 
  select(date, pref, case_day, t_case_day, pref_code) |> 
  ungroup() |> 
  filter(!pref == "Tokyo")
