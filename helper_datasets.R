library(BY2011)
library(cacher)

BY2011_annual_control_factor_data <-
  cacher::cached("cache", "BY2011_annual_control_factor_data") %or% {
    BY(2011) %>%
      DB_control_factors(
        verbose = TRUE) %>%
      annualize_DB_control_factors(
        years = CY(1990:2030),
        verbose = TRUE)
  }

BY2011_annual_area_source_emission_factor_data <-
  cacher::cached("cache", "BY2011_annual_emission_factor_data") %or% {
    BY(2011) %>%
      DB_area_source_emission_factors(
        verbose = TRUE) %>%
      annualize_DB_emission_factors(
        years = CY(1990:2030),
        verbose = TRUE)
  }

BY2011_annual_growth_factor_data <-
  cacher::cached("cache", "BY2011_annual_growth_factor_data") %or% {
    BY(2011) %>%
      DB_growth_profiles(
        years = CY(1990:2030),
        verbose = TRUE)
  }

#
# Step 1: `BY_area_source_projections()` recreates an entire inventory. For
# each category, it assembles `tput_qty`, `ef_qty`, and `cf_qty`, and then
# calculates `ems_qty` from those.
#
# It can also do much more --- see `help("BY_area_source_projections")` to learn
# how you can "swap in" alternative throughputs, emission factors, etc.
#
# **NOTE:** For BY2011, in some cases, the calculated emission estimates may
# differ from the published emission estimates. See the Appendix for an
# explanation and a specific example.
# 
BY2011_area_source_projection_data <-
  cacher::cached("cache", "BY2011_area_source_projection_data") %or% {
    BY(2011) %>%
      BY_area_source_projections(
        verbose = TRUE)
  }

#
# We can use `distinct()` to de-duplicate throughputs.
# 
BY2011_area_source_throughput_data <-
  BY2011_area_source_projection_data %>%
  distinct(
    year, 
    cat_id,
    cnty_abbr,
    tput_qty,
    tput_unit)
