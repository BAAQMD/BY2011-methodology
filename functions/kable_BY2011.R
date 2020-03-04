kable_BY2011 <- function (
  kable_data,
  ...,
  caption = NULL,
  position = "center",
  totals = "none",
  verbose = getOption("verbose")
) {
  
  if (totals == "row") {
    
    # Do the math
    kable_data <-
      kable_data %>%
      janitor::adorn_totals(
        where = "row",
        fill = "")
    
  }
  
  kable_object <-
    kable(
      kable_data,
      ...,
      caption = caption) 
  
  styled_kable_object <-
    kable_object %>%
    kableExtra::kable_styling(
      c("basic", "hover"),
      position = position,
      full_width = FALSE) %>%
    kableExtra::column_spec(
      1,
      color = "black")
  
  if (is_grouped_df(kable_data)) {
    
    group_var <- 
      dplyr::group_vars(
        kable_data)
    
    if (length(group_var) > 1) {
      stop("[kable_BY2011] 2+ groups not yet supported, sorry.")
    }
      
    styled_kable_object <- 
      styled_kable_object %>%
      kableExtra::pack_rows(
        index = table(
          pull(kable_data, !!group_var)))
    
  }
  
  if (totals == "row") {
    
    # Having done the math, now add the formatting
    styled_kable_object <-
      styled_kable_object %>%
      kableExtra::row_spec(
        nrow(kable_data),
        bold = TRUE)
    
  }
  
  return(styled_kable_object)
  
}