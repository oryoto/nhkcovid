plot_t_ratio <- \(from = min(nhk_covid$date), to = max(nhk_covid$date)) {
  nhk_covid |> 
    filter(date >= from, date <= to) |> 
    ggplot(aes(date, tokyo_ratio, color = jpref))+
    geom_line() +
    labs(
      title = "Ratio of the number of cases of infection in each prefecture of Tokyo vs.",
      x = "Date",
      y = "%"
    )+
    scale_y_continuous(labels = percent)+
    theme_bw()+
    guides(color = "none")+
    theme(text = element_text(size = 7))
}

# エイリアス
ptr <- plot_t_ratio


