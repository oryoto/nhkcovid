# 東京倍率の移動平均
nhk_covid |> 
  filter(date >= "2022-07-01", !is.na(rmean7)) |> 
  ggplot(aes(date, rmean7, color = pref))+
  geom_line()+
  guides(color = "none")
