#'
#' Use `distinct()` to de-duplicate the unique values of `tput_qty` --- keyed by
#' `year`, `cat_id`, and `cnty_abbr` --- that are contained in
#' `BY2011_area_source_projection_data` (which we must have already built!).
#' 

if (!exists("BY2011_area_source_throughput_data")) {
  
  BY2011_area_source_throughput_data <-
    BY2011_area_source_projection_data %>%
    distinct(
      year, 
      cat_id,
      cnty_abbr,
      tput_qty,
      tput_unit)
  
}