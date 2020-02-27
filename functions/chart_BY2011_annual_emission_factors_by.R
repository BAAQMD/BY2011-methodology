#'
#' A customized variant of `ggtools::chart_annual_emission_factors_by()`.
#'
chart_BY2011_annual_emission_factors_by <- function (
  chart_data,
  ...,
  facet_rows = "category",
  flag_years = CY(2011)
) {
  
  chart_object <-
    chart_data %>%
    filter_pollutants(
      BY2011_POLLUTANTS) %>%
    ggtools::chart_annual_emission_factors_by(
      ...,
      facet_rows = facet_rows,
      year_limits = BY2011_YEAR_LIMITS,
      flag_years = flag_years) %>%
    add_BY2011_chart_theme() %>%
    add_BY2011_chart_guides() +
    theme(
      legend.position = "top",
      legend.direction = "vertical")
  
  return(chart_object)
  
}
