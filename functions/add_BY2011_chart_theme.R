add_BY2011_chart_theme <- function (
  chart_object,
  ...
) {
  
  BY2011_chart_theme <- 
    theme_simple() +
    theme(
      #legend.key.width = unit(0.2, "pt"),
      #legend.key.height = unit(0.2, "pt"),
      #legend.margin = margin(1, 1, 1, 1, unit = "cm"),
      #legend.box.margin = margin(1, 1, 1, 1, unit = "cm"),
      #legend.position = "top",
      legend.text = element_text(size = rel(0.9)))
  
  return(chart_object + BY2011_chart_theme)
  
}
