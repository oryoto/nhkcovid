# location
setwd("C:/Users/ryoto/rworks/rprojects/covid19-nhk")

# library
library(dplyr)
library(lubridate)
library(zipangu)
library(ggplot2)
library(scales)
library(patchwork)
library(stringr)
library(tidyr)
library(corrr)
library(rlang)
library(purrr)
library(zoo)
library(fixest)

# R source
list.files("R", "[^R/main_process\\.R]", full.names = TRUE) |>
  walk(source)

# data source
# source("data-raw/nhk_covid.R")
# source("data-raw/nhk_covid_cor.R")
# source("data-raw/tokyo_cor.R")
# source("data-raw/tokyo_vs_other_data.R")
# source("data-raw/t_power_data.R")
# source("data-raw/gdp2018.R")

# data load
list.files("data", full.names = TRUE) |>
  sapply(load, envir = globalenv())

# plot function source
# list.files("img-raw", ".*[^make_plot\\.R]", full.names = TRUE) |>
  # walk(source)
