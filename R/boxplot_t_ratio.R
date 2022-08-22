# 各都道府県の東京比率を可視化
boxplot_t_ratio <- \(min) {
  t_ratio_data(min = min) |> 
    ggplot(aes(reorder(pref, -tokyo_ratio, na.rm = TRUE), tokyo_ratio)) +
    geom_boxplot() +
    theme_bw()+
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))+
    scale_y_continuous(labels = percent)+
    labs(
      x = "Prefectures",
      y = "Prefecture/Tokyo (%)",
      caption = "Covid19 cases (>= 1,000)"
    )
}

# エイリアス
bptr <- boxplot_t_ratio


# 各都道府県の東京比率を可視化（横向き）
boxplot_t_ratio_flip <- \(min) {
  t_ratio_data(min = min) |> 
    ggplot(aes(reorder(pref, tokyo_ratio, na.rm = TRUE), tokyo_ratio)) +
    geom_boxplot() +
    theme_bw()+
    scale_y_continuous(labels = percent)+
    labs(
      x = "Prefectures",
      y = "Prefecture/Tokyo (%)",
      caption = "Covid19 cases (>= 1,000)"
    )+
    coord_flip()
}
# boxplot_t_ratio_flip(1000)
# エイリアス
bptrf <- boxplot_t_ratio_flip
