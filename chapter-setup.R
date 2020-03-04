#'
#' This entire script is run (by `bookdown`) before each chapter is knitted.
#' 
#' See also:
#' 
#' - `chapter_teardown.R`
#' - `_bookdown.yml`
#' 
library(inventory)
library(BY2011)
library(cacher)
library(formattable)
library(kableExtra)
library(captioner)

#'
#' Start with a clean environment!
#'
keep_objs <- 
  ls(pattern = "^(BY2011_|DB_)")

rm_objs <- 
  setdiff(ls(), keep_objs)

rm(list = rm_objs)

#' Could be handy for inline R calculations.
multiply_by <-
  magrittr::multiply_by

#' See <https://haozhu233.github.io/kableExtra/bookdown/use-bootstrap-tables-in-gitbooks-epub.html>
#' Also see `table_css: false` in `_output.yml`
options(
  kableExtra.html.bsTable = TRUE)

#'
#' Declare the location to be used by `cacher::cached()`.
#' 
options(
  cacher.root = here::here("cache"))

#'
#' Only chart (or tabulate, etc.) these years.
#'
BY2011_YEARS <- 
  CY(1990:2030)

#'
#' Only chart (or tabulate, etc.) these pollutants.
#'
#' This implicitly affects the following functions:
#'
#' `BY2011_chart_annual_emissions_by()`
#'
BY2011_POLLUTANTS <- c(
  "PM",
  "TSP",
  "PM10",
  "PM2.5",
  "TOG",
  "ROG",
  "NOx",
  "SO2",
  "CO",
  "CH4",
  "N2O",
  "CO2")

BY2011_YEAR_LIMITS <- 
  CY(1990, 2030)

BY2011_YEAR_EXPAND <-
  ggplot2::expand_scale(
    add = c(2, 2),
    mult = c(0, 0))

source_all <- function (...) {
  purrr::walk(
    unlist(list(...)), 
    purrr::safely(
      purrr::partial(
        base::source,
        local = FALSE),
      quiet = FALSE))
}

#'
#' Quietly source all .R files in the `functions/` subfolder.
#'
#' These files should all contain function definitions, and only function
#' definitions. So, the order that we source them in doesn't matter.
#' 
source_all(
  dir(
    here::here("functions"), 
    pattern = "\\.R$",
    full.names = TRUE))

#'
#' In contrast to the above, the ordering below matters.
#' 
source_all(
  
  "data/DB_annual_point_source_emission_data.R",
  "data/BY2011_annual_point_source_emission_data.R",
  
  "data/BY2011_annual_area_source_emission_factor_data.R",
  "data/BY2011_annual_control_factor_data.R",
  
  # The order of these matters.
  "data/BY2011_raw_growth_factor_data.R",
  "data/BY2011_growth_profile_crosswalk.R",
  "data/BY2011_annual_growth_factor_data.R",
  
  # The order of these matters.
  "data/BY2011_area_source_projection_data.R",
  "data/BY2011_area_source_throughput_data.R"
  
)
