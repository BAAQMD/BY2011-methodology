library(captioner)

if (exists("tbl_cap")) {
  #' Bump the top-level (Chapter) numbering.
  captioner::bump(tbl_cap, level = 1)
} else {
  tbl_captioner <<- captioner::captioner(prefix = "Table", level = 2)
  tbl_cap <- tbl_captioner
  tbl_ref <- partial(tbl_captioner, display = "cite")
}

if (exists("fig_cap")) {
  #' Bump the top-level (Chapter) numbering.
  captioner::bump(fig_cap, level = 1)
} else {
  fig_captioner <- captioner::captioner(prefix = "Figure", level = 2)
  fig_cap <- fig_captioner
  fig_ref <- partial(fig_captioner, display = "cite")
}
