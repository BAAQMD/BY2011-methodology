require(BY2011)

if (!exists("BY2011_annual_point_source_emission_data")) {
  
  BY2011_annual_point_source_emission_data <-
    cacher::cached(
      "data",
      "BY2011_annual_point_source_emission_data",
      verbose = TRUE) %or% 
    {
      
      BY2011_annual_emission_data %>%
        filter_categories(
          BY2011_sets$`Point sources`)
      
    }
  
}
