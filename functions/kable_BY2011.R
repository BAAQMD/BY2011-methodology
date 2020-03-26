kable_BY2011 <- function (
  kable_data,
  ...,
  caption = NULL,
  style = c("basic", "hover", "condensed"),
  font_size = 14,
  position = "center",
  full_width = FALSE,
  totals = "none",
  verbose = getOption("verbose")
) {
  
  msg <- function (...) if(isTRUE(verbose)) message("[kable_BY2011] ", ...)
  
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
  
  if (is_grouped_df(kable_data)) {
    
    group_var <- 
      dplyr::group_vars(
        kable_data)
    
    msg("grouping by: ", str_csv(group_var))
    
    if (length(group_var) > 1) {
      stop("[kable_BY2011] 2+ groups not yet supported, sorry.")
    }
    
    group_index <-
      kable_data %>%
      pull(
        !!group_var) %>%
      table()
      
    kable_data <-
      kable_data %>%
      ungroup() %>%
      drop_vars(
        !!group_var)
    
  } else {
    
    group_index <- NULL
    
  }
  
  kable_object <-
    kable(
      kable_data,
      ...,
      caption = caption) 
  
  styled_kable_object <-
    kable_object %>%
    kableExtra::kable_styling(
      bootstrap_options = style,
      font_size = font_size,
      full_width = full_width,
      position = position) 
  
  if (!is.null(group_index)) {
    
  styled_kable_object <- 
    styled_kable_object %>%
    kableExtra::pack_rows(
      index = group_index)
  
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
