#'
#' A customized variant of `ggtools::chart_annual_growth_by()`.
#' 
chart_BY2011_annual_growth_factors_by <- function (
  chart_data,
  ...,
  facet_rows = "category",
  facet_scales = "free_y",
  flag_years = CY(2030),
  base_year = CY(2011)
) {
  
  if ("pol_abbr" %in% names(chart_data)) {
    chart_data <-
      filter_pollutants(
        chart_data,
        BY2011_POLLUTANTS)
  }
  
  chart_object <-
    chart_data %>%
    mutate(
      facet_label = glue::glue(
        str_c(
          "{", facet_rows, "}, via #{gpf_id} {gpf_name}"))) %>%
    ggtools::chart_annual_growth_by(
      ...,
      facet_rows = "facet_label",
      facet_scales = facet_scales,
      flag_years = flag_years,
      year_limits = BY2011_YEAR_LIMITS,
      base_year = base_year) %>%
    add_BY2011_chart_theme() %>%
    add_BY2011_chart_guides()
  
  # gpf_label_data <-
  #   chart_data %>%
  #   distinct(
  #     category,
  #     gpf_id,
  #     gpf_name) %>%
  #   mutate(
  #     year = CY(1990),
  #     gf_qty = 0)
  # 
  # chart_object <-
  #   chart_object +
  #   geom_text(
  #     aes(label = gpf_name),
  #     year = CY(1990),
  #     gf_qty = 0,
  #     nudge_y = 0,
  #     data = gpf_label_data)
  
  return(chart_object)
  
}

