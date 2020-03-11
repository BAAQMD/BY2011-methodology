kable_BY2011_county_fractions <- function (
  input_data,
  ...,
  digits = 1,
  caption = "County fractions."
) {
  
  kable_data <- 
    input_data %>%
    mutate_at(
      vars(cnty_frac),
      ~ replace(., . == 0, NA_real_)) %>%
    select(
      category, 
      cnty_abbr,
      cnty_frac) %>%
    spread(
      cnty_abbr,
      cnty_frac) %>%
    mutate_at(
      vars(one_of(names(DST_COUNTY_CODES))),
      ~ formattable::percent(., digits = digits))
  
  kable_data %>%
    kable_BY2011(
      ...,
      caption = caption)
  
}