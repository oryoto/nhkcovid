total_case <- 
nhk_covid |> 
  group_by(date) |> 
  summarise(
    case_total = sum(case_day, na.rm = TRUE)
  )

total_case |> 
  filter(date >= "2022-01-01") |> 
  ggplot()+
  geom_line(aes(date, case_total))+
  labs(
    x = "",
    y = ""
  )+
  scale_y_continuous(labels = comma)+
  theme_bw()
ggsave("img/nhk_covid_total_case.png", width = 1800, height = 900, units = "px")
