plot_case <- \(
  from = min(nhk_covid$date),
  to = max(nhk_covid$date),
  prefs = nhk_covid$pref) {
  nhk_covid |>
    filter(
      date >= from,
      date <= to,
      pref %in% prefs
      ) |>
    ggplot(aes(date, case_day, color = jpref))+
    geom_line() +
    labs(
      # title = "Number of covid19 infected",
      x = "月",
      y = "人数",
      color = "Pref."
    )+
    scale_y_continuous(labels = comma)+
    guides(color = "none")+
    theme_bw()
}

# 秋田県の感染者数の推移
plot_case("2022-01-01", prefs = "Akita")
ggsave("img/nhk_covid_akita_2022.png", width = 1800, height = 900, units = "px")
# plot_case("2022-07-01", "2022-07-31")
