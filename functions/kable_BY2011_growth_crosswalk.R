kable_BY2011_growth_crosswalk <- function (
  input_data,
  caption = "Growth profile configuration (DataBank, {DataBank:::DB_activity_tbl(BY(2011))})."
) {
  
  kable_data <-
    input_data %>%
    transmute(
      category,
      backcast,
      forecast,
      profile = glue::glue(
        "#{gpf_id} {gpf_name}")) %>%
    distinct()
  
  kable_data %>%
    kable_BY2011(
      caption = glue::glue(caption))
  
}