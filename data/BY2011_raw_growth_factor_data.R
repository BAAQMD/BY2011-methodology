require(DataBank)

if (!exists("BY2011_raw_growth_profile_data")) {
  
  BY2011_raw_growth_profile_data <-
    cacher::cached(
      "data",
      "BY2011_raw_growth_profile_data",
      verbose = TRUE) %or% 
    {
      BY(2011) %>%
        DB_raw_growth_profiles(
          years = BY2011_YEARS,
          nested = FALSE)
    }
  
}