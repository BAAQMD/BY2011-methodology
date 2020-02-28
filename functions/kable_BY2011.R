kable_BY2011 <- function (
  ...,
  position = "center",
  verbose = getOption("verbose")
) {
  
  kable_object <-
    kable(...) 
  
  styled_kable_object <-
    kable_object %>%
    kableExtra::kable_styling(
      c("basic", "hover"),
      position = position,
      full_width = FALSE) %>%
    kableExtra::column_spec(
      1,
      color = "black")
  
  return(styled_kable_object)
  
}