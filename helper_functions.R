library(inventory)

BY2011_CHART_POLLUTANTS <- c(
  "PM",
  "TSP",
  "PM10",
  "PM2.5",
  "TOG",
  "ROG",
  "NOx",
  "SO2",
  "CO")

#'----------------------------------------------------------------------

add_BY2011_chart_theme <- function (
  chart_object,
  ...
) {
  
  BY2011_chart_theme <- 
    theme_simple() +
    theme(
      #legend.key.width = unit(0.2, "pt"),
      #legend.key.height = unit(0.2, "pt"),
      #legend.margin = margin(1, 1, 1, 1, unit = "cm"),
      #legend.box.margin = margin(1, 1, 1, 1, unit = "cm"),
      #legend.position = "top",
      legend.text = element_text(size = rel(0.9)))
  
  return(chart_object + BY2011_chart_theme)
  
}

#'----------------------------------------------------------------------

add_BY2011_chart_guides <- function (
  chart_object,
  ...
) {
  
  BY2011_chart_guides <-
    guides(
      fill = guide_legend(
        title = ""),
      color = guide_legend(
        title = ""))
  
  return(chart_object + BY2011_chart_guides)
  
}

#'----------------------------------------------------------------------

BY2011_chart_annual_control_factors_by <- function (
  chart_data,
  ...,
  flag_labels = "{format_percentage(1 - cf_qty, digits = 1)} controlled",
  facet_rows = "category"
) {
  
  chart_object <-
    chart_data %>%
    filter_pollutants(
      BY2011_CHART_POLLUTANTS) %>%
    ggtools::chart_annual_control_factors_by(
      ...,
      flag_labels = flag_labels,
      facet_rows = facet_rows,
      flag_years = CY(2011)) %>%
    add_BY2011_chart_theme()%>%
    add_BY2011_chart_guides()
  
  return(chart_object)
  
}

#'----------------------------------------------------------------------

BY2011_chart_annual_emissions_by <- function (
  chart_data,
  ...,
  facet_rows = "pollutant"
) {
  
  chart_object <-
    chart_data %>%
    filter_pollutants(
      BY2011_CHART_POLLUTANTS) %>%
    ggtools::chart_annual_emissions_by(
      ...,
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

#'----------------------------------------------------------------------

BY2011_chart_annual_growth_by <- function (
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
        BY2011_CHART_POLLUTANTS)
  }
  
  chart_object <-
    chart_data %>%
    ggtools::chart_annual_growth_by(
      ...,
      facet_rows = facet_rows,
      facet_scales = facet_scales,
      flag_years = flag_years,
      base_year = base_year) %>%
    add_BY2011_chart_theme() %>%
    add_BY2011_chart_guides()
  
  return(chart_object)
  
}

