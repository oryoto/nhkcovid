# 東京都と他の都道府県の相関係数
tokyo_cor <-
nhk_covid_cor |>
  select(term, Tokyo) |>
  arrange(desc(Tokyo))

usethis::use_data(tokyo_cor, overwrite = TRUE)
