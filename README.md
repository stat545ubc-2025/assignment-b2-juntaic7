
<!-- README.md is generated from README.Rmd. Please edit that file -->

# missingtool

<!-- badges: start -->

<!-- badges: end -->

The goal of missingtool is to provide a simple way to count missing
values across all columns for each level of a grouping variable. It’s a
convenient wrapper around dplyr’s `group_by()` and `summarize()`
functions.

## Installation

You can install the development version of missingtool from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2025/assignment-b2-juntaic7", ref = "0.1.0")
```

## Example

Here’s a basic example using the built-in `airquality` dataset:

``` r
library(missingtool)

# Count missing values by Month
count_all_missing_by_group(airquality, Month)
#> # A tibble: 5 × 6
#>   Month Ozone Solar.R  Wind  Temp   Day
#>   <int> <int>   <int> <int> <int> <int>
#> 1     5     5       4     0     0     0
#> 2     6    21       0     0     0     0
#> 3     7     5       0     0     0     0
#> 4     8     5       3     0     0     0
#> 5     9     1       0     0     0     0

# Using pipe operator
airquality |> count_all_missing_by_group(Month)
#> # A tibble: 5 × 6
#>   Month Ozone Solar.R  Wind  Temp   Day
#>   <int> <int>   <int> <int> <int> <int>
#> 1     5     5       4     0     0     0
#> 2     6    21       0     0     0     0
#> 3     7     5       0     0     0     0
#> 4     8     5       3     0     0     0
#> 5     9     1       0     0     0     0

# Keep the output grouped
count_all_missing_by_group(airquality, Month, .groups = "keep")
#> # A tibble: 5 × 6
#> # Groups:   Month [5]
#>   Month Ozone Solar.R  Wind  Temp   Day
#>   <int> <int>   <int> <int> <int> <int>
#> 1     5     5       4     0     0     0
#> 2     6    21       0     0     0     0
#> 3     7     5       0     0     0     0
#> 4     8     5       3     0     0     0
#> 5     9     1       0     0     0     0
```
