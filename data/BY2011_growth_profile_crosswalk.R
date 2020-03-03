require(DataBank)

if (!exists("BY2011_growth_profile_crosswalk")) {
  
  BY2011_growth_profile_crosswalk <-
    cacher::cached(
      "data",
      "BY2011_growth_profile_crosswalk",
      verbose = TRUE) %or% 
    {
      BY(2011) %>%
        DB_growth_profile_crosswalk(
          verbose = TRUE) %>%
        left_join(
          distinct(
            BY2011_raw_growth_profile_data, 
            gpf_id, 
            cnty_abbr, 
            gpf_name),
          by = "gpf_id")
    }
  
}