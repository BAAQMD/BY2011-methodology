require(DataBank)

if (!exists("BY2011_annual_control_factor_data")) {
  
  BY2011_annual_control_factor_data <-
    cacher::cached(
      "data",
      "BY2011_annual_control_factor_data", 
      verbose = TRUE) %or% 
    {
      BY(2011) %>%
        DB_control_factors(
          verbose = TRUE) %>%
        annualize_DB_control_factors(
          years = BY2011_YEARS,
          verbose = TRUE)
    }
  
}
