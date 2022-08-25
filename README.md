
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nhkcovid

<!-- badges: start -->

<!-- badges: end -->

The goal of nhkcovid is to …

## Installation

You can install the development version of nhkcovid from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("oryoto/nhkcovid")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(nhkcovid)

nhkcovid_origin <-
read_data(
  .dir = here::here("inst/extdata"),
  .ptn = "nhk_news",
  .f = readr::read_csv
)
```

``` r
nhkcovid
#> # A tibble: 44,368 x 15
#>    date       rmean7 tokyo tokyo_r~1
#>    <date>      <dbl> <dbl>     <dbl>
#>  1 2020-01-16      0     0         0
#>  2 2020-01-17      0     0         0
#>  3 2020-01-18      0     0         0
#>  4 2020-01-19      0     0         0
#>  5 2020-01-20      0     0         0
#>  6 2020-01-21      0     0         0
#>  7 2020-01-22      0     0         0
#>  8 2020-01-23      0     0         0
#>  9 2020-01-24      0     1         0
#> 10 2020-01-25      0     1         0
#> # ... with 44,358 more rows, 11
#> #   more variables:
#> #   tokyo_power <dbl>, wday <ord>,
#> #   pref_code <chr>, jpref <chr>,
#> #   case_day <dbl>, case_cum <dbl>,
#> #   death_day <dbl>,
#> #   death_cum <dbl>, ...
```

``` r
library(ggplot2)

gdp2018_full |>
  ggplot(aes(tokyo_power_cv, value)) +
  geom_smooth(method = "lm") +
  geom_point() +
  labs(
    x = "東京倍率",
    y = "県民経済計算"
  ) +
  scale_y_continuous(labels = scales::comma)+
  theme_bw() +
    facet_wrap(~gdp, scales = "free_y")
#> `geom_smooth()` using formula 'y ~ x'
#> Warning: Removed 11 rows containing
#> non-finite values (stat_smooth).
#> Warning: Removed 11 rows containing
#> missing values (geom_point).
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />
