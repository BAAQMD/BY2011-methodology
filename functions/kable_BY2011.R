kable_BY2011 <- function (
  kable_data,
  ...,
  caption = NULL,
  style = c("basic", "hover", "compact"),
  position = "center",
  totals = "none",
  verbose = getOption("verbose")
) {
  
  if (totals == "row") {
    
    kable_data <-
      kable_data %>%
      janitor::adorn_totals(
        where = "row",
        fill = "")
    
  } else if (totals %in% c("col", "column")) {
    
    num_data <-
      select_if(
        kable_data,
        ~ is.numeric(.))
    
    summed <-
      preduce(num_data, add)
    
    kable_data <-
      bind_cols(
        kable_data,
        tibble(Total = summed))
    
    class(kable_data$Total) <- 
      reduce(
        map(num_data, class),
        intersect)
    
  }
  
  kable_object <-
    kable(
      kable_data,
      ...,
      caption = caption) 
  
  styled_kable_object <-
    kable_object %>%
    kableExtra::kable_styling(
      style,
      position = position,
      full_width = FALSE) 
  
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