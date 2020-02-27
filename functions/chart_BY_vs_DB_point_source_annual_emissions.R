chart_BY_vs_DB_point_source_annual_emissions <- function (
  BY_data,
  ...,
  verbose = getOption("verbose")
) {
  
  BY_layer_data <-
    BY_data %>%
    filter(
      cat_id %in% BY2011_sets[["Point sources"]]) %>%
    filter_pollutants(
      BY2011_POLLUTANTS)
  
  categories <-
    BY_layer_data %>%
    distinct(
      category,
      cat_id) %>%
    deframe()
  
  DB_layer_data <-
    DB_annual_point_source_emission_data %>%
    filter_categories(
      categories) %>%
    filter_pollutants(
      BY2011_POLLUTANTS) %>%
    mutate_at(
      vars(year),
      ~ elide_year(.)) %>%
    mutate_at(
      vars(inventory),
      ~ factor(., levels = c("RY", "PY")))
  
  BY_layer_data %>%
    chart_BY2011_annual_emissions_by(
      color = category) +
    geom_point(
      aes(shape = inventory),
      data = DB_layer_data) +
    scale_shape_manual(
      values = c(RY = 20, PY = 5)) +
    guides(
      color = guide_legend(title = "", override.aes = list(shape = NA)),
      shape = guide_legend(title = "")) +
    theme(
      legend.direction = "vertical")
  
}
