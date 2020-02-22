add_BY2011_chart_guides <- function (
  chart_object,
  ...
) {
  
  BY2011_chart_guides <-
    guides(
      fill = guide_legend(
        title = ""),
      color = guide_legend(
        title = ""))
  
  return(chart_object + BY2011_chart_guides)
  
}
