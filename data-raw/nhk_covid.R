library(dplyr)
library(lubridate)
library(zipangu)
source("R/utils.R")

origin <-
read_data(
  .dir = here::here("inst/extdata"),
  .ptn = "nhk_news",
  .f = readr::read_csv
)

# usethis::use_data(origin, overwrite = TRUE)  # 保存済み

j_names <- origin |> names()

names(j_names) <- c(
  "date", "pref_code", "jpref", "case_day", "case_cum",
  "death_day", "death_cum", "case_per_hund_thd_week"
)

workdata <-
  origin |>
  rename(all_of(j_names)) |>
  mutate(
    date = ymd(date)
  )

# zipanguパッケージから都道府県の名称データを利用する
e_pref <-
  jpnprefs |>
  select(prefecture_kanji, prefecture) |>
    mutate(
      pref = str_extract(prefecture, "\\w*(?=-)|\\w*")
    )

# tokyo_ratioを計算する
date <-
  seq(
    from = min(workdata$date),
    to = max(workdata$date),
    by = "day"
  )

# 1日ごとの東京比率を計算する
# 東京倍率を計算する
# 7日移動平均を計算する
nhk_covid <-
  workdata |>
  left_join(e_pref, by = c("jpref" = "prefecture_kanji")) |>
  group_by(date) |>
  mutate(
    tokyo = case_day[pref == "Tokyo"],
    tokyo_ratio = zero(case_day / tokyo),
    tokyo_power = zero(tokyo / case_day),
  wday = wday(date, label = TRUE),
    .after = date
  ) |>
  group_by(pref) |>
  mutate(
    rmean7 = zoo::rollmean(tokyo_power, 7, fill = NA, align = "left"),
    .after = date
  ) |>
  ungroup()

# Test: 列に追加した東京都感染者数と
# 元々の東京都感染者数が一致するか
nhk_covid |>
  filter(pref == "Tokyo") |>
  select(tokyo, case_day) |>
  mutate(identical = if_all(.fns = ~!tokyo == case_day)) |>
  summarise(identical = sum(identical)) |>
  pull() == 0

# *************************************
# nhk_covid <- workdata
usethis::use_data(nhk_covid, overwrite = TRUE)
