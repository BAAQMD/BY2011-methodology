require(DataBank)

if (!exists("DB_annual_point_source_emission_data")) {
  
  DB_annual_point_source_emission_data <-
    cacher::cached(
      "data",
      "DB_annual_point_source_emission_data",
      verbose = TRUE) %or% 
    {
      
      DB_point_source_process_data <-
        map_df(
          list(RY = RY(1990:2011), PY = PY(1990:2011)),
          DB_point_source_PONSCO_emissions,
          .id = "inventory")
      
      DB_point_source_process_data %>%
        sum_annual_emissions_by(
          inventory,
          pol_abbr,
          cat_id)
      
    }
  
}