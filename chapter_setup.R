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

#' Handy for inline R calculations.
multiply_by <-
  magrittr::multiply_by

#'
#' Start with a clean environment!
#' 
rm(list = ls())

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
  "CO")

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
