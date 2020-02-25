#'
#' A customized variant of `ggtools::chart_annual_control_factors_by()`.
#'
chart_BY2011_annual_control_factors_by <- function (
  chart_data,
  ...,
  flag_labels = "{format_percentage(1 - cf_qty, digits = 1)} controlled",
  facet_rows = "category"
) {
  
  chart_object <-
    chart_data %>%
    filter_pollutants(
      BY2011_POLLUTANTS) %>%
    ggtools::chart_annual_control_factors_by(
      ...,
      flag_labels = flag_labels,
      facet_rows = facet_rows,
      year_limits = BY2011_YEAR_LIMITS,
      flag_years = CY(2011)) %>%
    add_BY2011_chart_theme()%>%
    add_BY2011_chart_guides()
  
  return(chart_object)
  
}
