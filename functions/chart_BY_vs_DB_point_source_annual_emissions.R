chart_BY_vs_DB_point_source_annual_emissions <- function (
  BY_data,
  ...,
  years = NULL,
  pollutants = BY2011_POLLUTANTS,
  verbose = getOption("verbose")
) {
  
  msg <- function (...) if(isTRUE(verbose)) message("[chart_BY_vs_DB_point_source_annual_emissions] ", ...)
  
  BY_layer_data <-
    BY_data %>%
    filter(
      cat_id %in% BY2011_sets[["Point sources"]]) %>%
    filter_pollutants(
      pollutants)
  
  if (is.null(years)) {
    years <- 
      BY_layer_data %>%
      pull_distinct(
        year)
  }
  
  msg("years is: ", years)
  
  categories <-
    BY_layer_data %>%
    distinct(
      category,
      cat_id) %>%
    deframe()
  
  DB_layer_data <- local({
    
    filtered_data <-
      DB_annual_point_source_emission_data %>%
      filter_categories(
        categories) %>%
      filter(
        elide_year(year) %in% elide_year(years))
    
    speciated_data <-
      filtered_data %>%
      speciate_PM(
        into = c("TSP", "PM10", "PM2.5"),
        using = t0324, # timeless
        via = t1325, # DataBank:::DB_activity_tbl(BY(2011)),
        verbose = TRUE) %>%
      speciate_TOG(
        into = c("TOG", "ROG"),
        using = here::here(
          "data",
          "FROG11BY11.csv")) %>%
      filter_pollutants(
        pollutants) 
    
    DB_layer_data <- 
      speciated_data %>%
      mutate_at(
        vars(year),
        ~ elide_year(.)) %>%
      mutate_at(
        vars(inventory),
        ~ factor(., levels = c("RY", "PY"))) 
    
  })  
  
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
