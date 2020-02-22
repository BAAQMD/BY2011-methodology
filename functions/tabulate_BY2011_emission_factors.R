tabulate_BY2011_emission_factors <- function (
  ef_data,
  pollutants = BY2011_POLLUTANTS,
  ...,
  verbose = getOption("verbose")
) {
  
  kable_data <-
    ef_data %>%
    filter_pollutants(
      pollutants) %>%
    distinct(
      category,
      pollutant,
      ef_qty)
  
  format_pollutant <- function (x, as_html = TRUE) {
    
    dplyr::recode(
      x,
      "CO2" = "CO<sub>2</sub>",
      "CH4" = "CH<sub>4</sub>",
      "PM10" = "PM<sub>10</sub>",
      "PM25" = "PM<sub>2.5</sub>",
      "PM2.5" = "PM<sub>2.5</sub>",
      "NOX" = "NO<sub>x</sub>",
      "NOx" = "NO<sub>x</sub>",
      "SOX" = "SO<sub>x</sub>",
      "SOx" = "SO<sub>x</sub>",
      "SO2" = "SO<sub>2</sub>",
      "CO2_bio" = "CO<sub>2</sub>bio")
    
  }
  
  pollutant_levels <-
    intersect(
      pollutants,
      pull_distinct(kable_data, pollutant))
  
  kable_object <- 
    kable_data %>%
    mutate_at(
      vars(pollutant),
      ~ factor(., levels = pollutant_levels)) %>%
    spread(
      pollutant,
      ef_qty) %>%
    set_names(
      format_pollutant(names(.))) %>%
    kable(
      escape = FALSE) %>%
    kableExtra::kable_styling(
      full_width = FALSE,
      bootstrap_options = c(
        #"striped", 
        "condensed")) %>%
    kableExtra::column_spec(
      1,
      bold = TRUE) %>%
    kableExtra::footnote(
      general = "Emission factors (pounds per unit throughput).",
      general_title = "\n")
    
  return(kable_object)
  
}