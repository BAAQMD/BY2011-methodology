kable_BY2011_emission_factors <- function (
  ef_data,
  pollutants = BY2011_POLLUTANTS,
  ...,
  digits = Inf,
  caption = NULL,
  verbose = getOption("verbose")
) {
  
  msg <- function (...) if(isTRUE(verbose)) message("[tabulate_BY2011_emission_factors] ", ...)
  
  #
  # TODO: (possibly) handle named integers, list, etc.
  #
  stopifnot(
    is.character(pollutants)) 
  
  #
  # Prevent accidental problems with "duplicated factor levels".
  #
  pollutants <- 
    unique(pollutants)
  
  kable_data <-
    ef_data %>%
    filter_pollutants(
      pollutants) %>%
    distinct(
      category,
      pollutant,
      ef_qty) %>% 
    mutate_at(
      vars(ef_qty),
      ~ round(., digits = digits))
  
  pollutant_levels <-
    intersect(
      pollutants,
      pull_distinct(kable_data, pollutant))
  
  msg("pollutant_levels is: ", pollutant_levels)
  
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
      escape = FALSE,
      caption = caption) %>%
    kableExtra::kable_styling(
      full_width = FALSE,
      bootstrap_options = c(
        #"striped", 
        "condensed")) %>%
    # kableExtra::footnote(
    #   general = "Emission factors (pounds per unit throughput).",
    #   general_title = "\n") %>%
    kableExtra::column_spec(
      1,
      color = "black")
  
  return(kable_object)
  
}