# 任意の2つの都道府県を比較する
pref_vs_pref <- \(pref_x, pref_y) {
  nhk_covid |> 
    select(date, pref, case_day) |> 
    pivot_wider(
      names_from = pref,
      values_from = case_day
    ) |> 
    ggplot(aes({{ pref_x }}, {{ pref_y }}))+
    geom_point()
}

# 東京都と他の都道府県を比較する
vs_tokyo <- \(pref_name) {
  nhk_covid |> 
    select(date, pref, case_day) |> 
    pivot_wider(
      names_from = pref,
      values_from = case_day
    ) |> 
    ggplot(aes(Tokyo, !!enquo(pref_name)))+
    geom_point()
}

# 東京都と他のすべての都道府県を一度に比較する
tokyo_vs_others <- \() {
  tokyo_vs_other_data |> 
    ggplot(aes(t_case_day, case_day))+
    geom_point(size = 1, shape = 21)+
    scale_x_continuous(labels = suffix_k)+
    scale_y_continuous(labels = suffix_k)+
    labs(
      x = "Number of infection in Tokyo",
      y = "Number of infection in other pref."
    )+
    theme_bw()+
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))+
    facet_wrap(~ reorder(pref, pref_code), scales = "free")
}
