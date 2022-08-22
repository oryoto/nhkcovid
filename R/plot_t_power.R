plot_t_power <- \(
  from = min(nhk_covid$date),
  to = max(nhk_covid$date),
  prefs = nhk_covid$pref
  ) {
  nhk_covid |> 
    filter(date >= from, date <= to) |> 
    filter(pref %in% prefs) |> 
    ggplot(aes(date, color = jpref))+
    geom_line(aes(y = tokyo_power), size = .5) +
    labs(
      # title = "Multiplier of the number of cases infected in Tokyo for each prefecture",
      x = "Date",
      y = "Multiplier",
      color = "道府県"
    )+
    theme_bw()+
    gghighlight()
    # guides(color = "none")+
}
# plot_t_power("2022-08-01", prefs = t_power_data("2022-08-01")$pref[1:10])
# ggsave("img/t_power_top10_20220801.png", width = 1800, height = 1200, units = "px")

# エイリアス
ptp <- plot_t_power

# 1週間の周期性を考慮する
plot_t_power_week <- \(
  from = min(nhk_covid$date),
  to = max(nhk_covid$date),
  prefs = nhk_covid$pref
  ) {
  nhk_covid |> 
    filter(date >= from, date <= to) |> 
    filter(pref %in% prefs) |> 
    ggplot(aes(date, color = wday))+
    geom_line(aes(y = tokyo_power), size = .5) +
    labs(
      # title = "Multiplier of the number of cases infected in Tokyo for each prefecture",
      x = "Date",
      y = "Multiplier",
      color = "曜日"
    )+
    theme_bw()+
    facet_wrap(~jpref)
    # guides(color = "none")+
}
plot_t_power_week("2022-07-01", prefs = t_power_data("2022-08-01")$pref[1:10])
ggsave("img/t_power_facet_top10_20220801.png", width = 1800, height = 1200, units = "px")

# エイリアス
ptp <- plot_t_power
