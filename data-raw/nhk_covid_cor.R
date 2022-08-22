# 相関係数行列
nhk_covid_cor <-
  nhk_covid |>
  dplyr::select(date, pref, case_day) |>
  pivot_wider(
    names_from = pref,
    values_from = case_day
  ) |>
  dplyr::select(!date) |>
  corrr::correlate()
usethis::use_data(nhk_covid_cor, overwrite = TRUE)
