#'
#' A customized variant of `ggtools::chart_annual_emissions_by()`.
#'
chart_BY2011_annual_emissions_by <- function (
  chart_data,
  ...,
  facet_rows = "pollutant"
) {
  
  chart_object <-
    chart_data %>%
    filter_pollutants(
      BY2011_POLLUTANTS) %>%
    ggtools::chart_annual_emissions_by(
      ...,
      year_limits = BY2011_YEAR_LIMITS,
      year_expand = BY2011_YEAR_EXPAND,
      facet_rows = facet_rows) %>%
    add_BY2011_chart_theme() %>%
    add_BY2011_chart_guides()
  
  #
  # In the case where we're plotting emissions, let's put the
  # legend on top, and restrict the number of rows (in the legend)
  # to two. We were haveing some trouble with the legend
  # "overflowing" to the left and right --- this is a hack to 
  # fix that problem.
  #
  chart_object <- 
    chart_object + 
    theme(
      legend.position = "top",
      legend.direction = "horizontal") +
    guides(
      fill = guide_legend(
        title = "",
        ncol = 2))
  
  return(chart_object)
  
}
