humanize_ids <- function (ids) {
  packed <- pack_integers(ids)
  stripped <- packed %>% str_remove_all("^c\\(") %>% str_remove_all("\\)$")
  stripped %>% str_replace_all(":", "-") %>% str_c("#", .)
}
