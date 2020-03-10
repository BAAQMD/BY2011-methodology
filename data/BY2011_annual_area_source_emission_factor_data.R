require(DataBank)

if (!exists("BY2011_annual_area_source_emission_factor_data")) {
  
  BY2011_annual_area_source_emission_factor_data <-
    cacher::cached(
      "data",
      "BY2011_annual_area_source_emission_factor_data",
      verbose = TRUE) %or% 
    {
      BY(2011) %>%
        DB_area_source_emission_factors(
          verbose = TRUE) %>%
        annualize_DB_emission_factors(
          years = BY2011_YEARS,
          verbose = TRUE)
    }
  
}
