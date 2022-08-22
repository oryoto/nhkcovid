gdp2018_full |>
  ggplot(aes(tokyo_power_cv, value)) +
  geom_smooth(method = "lm") +
  geom_point() +
  labs(
    x = "東京倍率",
    y = "県民経済計算"
  ) +
  scale_y_continuous(labels = comma)+
  theme_bw() +
    facet_wrap(~gdp_j, scales = "free_y")
ggsave("img/plot_gdp2018_tokyo_power_cv.png", width = 4000, height = 1800, units = "px")

gdp2018_idx
gdp2018_wide |>
  select(jpref, tokyo_power_cv, gdp9) |>
  arrange(desc(tokyo_power_cv)) |>
  filter(tokyo_power_cv < 1.5)