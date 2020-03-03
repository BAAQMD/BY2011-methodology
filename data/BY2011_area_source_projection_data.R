require(DataBank)
require(BY)

#'
#' `BY_area_source_projections()` recreates an entire inventory. For
#' each category, it assembles `tput_qty`, `ef_qty`, and `cf_qty`, and then
#' calculates `ems_qty` from those.
#'
#' It can also do much more --- see `help("BY_area_source_projections")` to learn
#' how you can "swap in" alternative throughputs, emission factors, etc.
#'
#' **NOTE:** For BY2011, in some cases, the calculated emission estimates may
#' differ from the published emission estimates. See the Appendix for an
#' explanation and a specific example.
#' 

if (!exists("BY2011_area_source_projection_data")) {
  
  BY2011_area_source_projection_data <-
    cacher::cached(
      "data", 
      "BY2011_area_source_projection_data",
      verbose = TRUE) %or% 
    {
      BY(2011) %>%
        BY::BY_area_source_projections(
          years = BY2011_YEARS,
          verbose = TRUE)
    }
  
}