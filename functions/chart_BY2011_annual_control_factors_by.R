#'
#' A customized variant of `ggtools::chart_annual_control_factors_by()`.
#'
chart_BY2011_annual_control_factors_by <- function (
  chart_data,
  ...,
  facet_rows = "category",
  flag_labels = "{format_percentage(1 - cf_qty, digits = 1)} controlled",
  flag_years = CY(2011)
) {
  
  chart_object <-
    chart_data %>%
    filter_pollutants(
      BY2011_POLLUTANTS) %>%
    ggtools::chart_annual_control_factors_by(
      ...,
      facet_rows = facet_rows,
      year_limits = BY2011_YEAR_LIMITS,
      flag_labels = flag_labels,
      flag_years = flag_years) %>%
    add_BY2011_chart_theme()%>%
    add_BY2011_chart_guides()
  
  return(chart_object)
  
}
