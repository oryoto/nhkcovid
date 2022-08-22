# 県内GDPのデータを抽出する
gdp2018_origin <-
read_data("inst/extdata", .ptn = "soukatu\\d{1,}_2018", sheet = "Sheet1")

# 2018年の列だけを取り出してまとめたい
nm <- sprintf("gdp%d", 1:11) |> sort()
# nm
gdp2018 <-
gdp2018_origin |>
  map2(.y = nm,
  ~ .x |> select(jpref, `2018`) |> rename("{.y}" := `2018`)) |>
  reduce(left_join, by = "jpref")
usethis::use_data(gdp2018_origin, gdp2018, overwrite = TRUE, internal = TRUE)

# 各列と統計の種類の索引
gdp2018_nm <- names(gdp2018)

names(gdp2018_nm) <-
  c(
    "jpref",
    "県内総生産（生産側、名目）",
    "県内就業者数",
    "県民雇用者数",
    "県内総生産（生産側、実質:連鎖方式）",
    "県内総生産（生産側、デフレーター:連鎖方式）",
    "県内純生産（要素費用表示）",
    "県民所得",
    "県民雇用者報酬",
    "1人当たり県民所得",
    "1人当たり県民雇用者報酬",
    "総人口"
  )
usethis::use_data(gdp2018_nm, overwrite = TRUE)

# gdp2018 |>
#   rename(gdp2018_nm) |>
#   slice(1) |>
# glimpse()

# gdp2018 |>
#   slice(1) |>
# glimpse()

gdp2018_idx <-
  tibble::tibble(c("jpref", nm), names(gdp2018_nm)) |>
  rename(gdp = 1, gdp_j = 2)
usethis::use_data(gdp2018_idx, overwrite = TRUE)

t_power_cv <-
  nhk_covid |>
  summ_fun(tokyo_power, .f = cv, .g = jpref,
   .b = "2021-04-01", .e = "2022-04-01"
  )

t_power_data <-
  nhk_covid |>
  summ_fun(tokyo_power, tokyo_ratio, .f = cv,
    .g = jpref, .b = "2021-04-01", .e = "2022-04-01"
  )


gdp2018_wide <-
full_join(t_power_data, gdp2018) |>
  mutate(
    across(matches("gdp[12456]"), ~.x * 10^(-6)), # 1兆円
    across(matches("gdp[9]"), ~.x * 10^(-5)), # 10万人
    across(matches("gdp(10|11)"), ~.x * 10), # 1万人
    across(matches("gdp[78]"), ~.x * 10^(-1)) # 1万円
  )
# gdp2018_wide
# gdp2018_wide |>
#   slice(1) |>
#   glimpse()
usethis::use_data(gdp2018_wide, overwrite = TRUE)

gdp2018_full <-
  gdp2018_wide |>
  pivot_longer(
    matches("gdp\\d"),
    names_to = "gdp"
  )  |>
  left_join(gdp2018_idx)
usethis::use_data(gdp2018_full, overwrite = TRUE)

