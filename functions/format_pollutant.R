format_pollutant <- function (x, as_html = TRUE) {
  
  dplyr::recode(
    x,
    "CO2" = "CO<sub>2</sub>",
    "CH4" = "CH<sub>4</sub>",
    "PM10" = "PM<sub>10</sub>",
    "PM25" = "PM<sub>2.5</sub>",
    "PM2.5" = "PM<sub>2.5</sub>",
    "NOx" = "NO<sub>x</sub>",
    "NOX" = "NO<sub>x</sub>",
    "N2O" = "N<sub>2</sub>O",
    "SOx" = "SO<sub>x</sub>",
    "SOX" = "SO<sub>x</sub>",
    "SO2" = "SO<sub>2</sub>",
    "CO2_bio" = "CO<sub>2</sub>bio")
  
}
