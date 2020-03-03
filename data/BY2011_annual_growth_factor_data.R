require(DataBank)

if (!exists("BY2011_annual_growth_factor_data")) {
  
  BY2011_annual_growth_factor_data <-
    cacher::cached(
      "data",
      "BY2011_annual_growth_factor_data",
      verbose = TRUE) %or% 
    {
      
      BY2011_growth_profile_name_lookup <-
        BY2011_raw_growth_profile_data %>%
        distinct(
          gpf_id,
          cnty_abbr,
          gpf_name)
      
      BY(2011) %>%
        DB_growth_profiles(
          years = BY2011_YEARS,
          ref_year = CY(2011),
          verbose = TRUE) %>%
        left_join(
          BY2011_growth_profile_name_lookup,
          by = c("gpf_id", "cnty_abbr"))
      
    }
  
}