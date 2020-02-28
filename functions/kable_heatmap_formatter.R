kable_heatmap_formatter <- function (
  x, 
  rng = c("white" = 0, "darkorange" = NA),
  digits = Inf,
  color = "black",
  verbose = getOption("verbose")
) {
  
  # Treat NA as "max(x)"
  rng[is.na(rng)] <- 
    max(x, na.rm = TRUE)
  
  color_values <- 
    csscolor(
      gradient(
        as.numeric(
          c(unname(rng), x)), 
        names(rng[1]), 
        names(rng[2])))
  
  color_values <- 
    color_values[-(1:2)] ## remove colors for min/max
  
  formatter(
    "span", 
    function (x) { format(x, big.mark = ",", digits = digits) },
    style = function (x) {
      style(
        color = color,
        display = "block",
        `text-align` = "right",
        `font-variant-numeric` = "tabular-nums oldstyle-nums",
        padding = "0 4px",
        `border-radius` = "4px",
        `background-color` = color_values)
    })
  
}
