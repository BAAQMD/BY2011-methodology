kable_BY2011_quantities_by <- function (
  input_data,
  ...,
  caption = NULL,
  style = c("basic", "hover", "condensed"),
  font_size = 12,
  position = "center",
  full_width = FALSE,
  verbose = getOption("verbose")
) {

  kable_data <-
    input_data %>%
    tabulate_quantities_by(
      ...) %>%
    arrange(           # preserve ordering encoded by `THESE_CATEGORIES`
      category) %>%
    separate(          # split `category` into `cat_id` and `cat_name`
      category,
      into = c("cat_id", "cat_name"),
      sep = " ",
      extra = "merge") %>%
    separate(
      cat_name,
      into = c("cat_group", "cat_name"),
      sep = ", ",
      extra = "merge") %>%
    mutate_at(
      vars(cat_group),
      ~ fct_inorder(.)) %>%
    select(
      cat_group,
      cat_name,
      cat_id,
      matches("_abbr"),
      matches("_unit"),
      everything())

  #
  # 1. Strip the leading clauses (e.g. "Solvent Base, ") from the names.
  # 2. Apply `kable_heatmap_formatter()` to all columns beginning with "CY".
  # 3. Blank out the non-humanized column names (those with a "_").
  #
  kable_object <-
    kable_data %>%
    drop_vars(
      cat_group) %>%
    mutate_at(
      vars(starts_with("CY")),
      ~ kable_heatmap_formatter(., digits = 0)(.)) %>%
    kable(
      #col.names = c("", "", "", "", keep(names(kable_data), ~ str_begins(., "CY"))),
      col.names = names(kable_data) %>%
        setdiff("cat_group") %>%
        replace(
          str_detect(., "_"),
          ""),
      escape = FALSE,
      caption = caption)

  #
  # Add three top-level row groupings.
  # Put inside a scrollable (HTML) box.
  #
  styled_kable_object <-
    kable_object %>%
    kableExtra::pack_rows(
      index = table(kable_data[["cat_group"]])) %>%
    kableExtra::kable_styling(
      bootstrap_options = style,
      full_width = full_width,
      font_size = font_size,
      position = position) %>%
    kableExtra::column_spec(
      1,
      color = "black") %>%
    kableExtra::scroll_box(
      box_css = "",
      width = 700)

  return(styled_kable_object)

}
