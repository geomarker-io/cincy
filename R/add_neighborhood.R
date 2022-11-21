#' Add neighborhood based on census tract
#'
#' This function uses the internal data objects, `hamilton_tract_to_cincy_neighborhood_2010` and
#' `hamilton_tract_to_cincy_neighborhood_2020`, to add a neighborhood
#' from `cincy::neigh_cchmc_2010` and `cincy::neigh_cchmc_2020` for each
#' row of a data frame.
#'
#' The vintage of tracts is automatically inferred based on the
#' name of the found tract column (`census_tract_id_2010` or `census_tract_id_2020`), but
#' can be specified using the vintage argument. If just the column `census_tract_id`
#' exists, then a default of 2010 will be used.
#' @param .x a data frame containing a census tract column named
#' `census_tract_id`, `census_tract_id_2010`, or `census_tract_id_2020`
#' @param vintage a string specifying to use the `2010` or `2020` census tract to neighborhood lookup table;
#' if set will override any vintage found in census tract id column names
#' @examples
#' add_neighborhood(tract_tigris_2010)

#' @export
add_neighborhood <- function(.x, vintage = c("2010", "2020")) {

  # find census tract id column
  tract_id_names <- c("census_tract_id", "census_tract_id_2010", "census_tract_id_2020")
  tract_id_name <- tract_id_names[tract_id_names %in% names(.x)]
  if (length(tract_id_name) == 0) {
    stop("no census tract id column found", call. = FALSE)
  }

  # set vintage from argument or census tract id column name
  if (!identical(vintage, c("2010", "2020"))) {
    vintage <- rlang::arg_match(vintage)
  } else {
    vintage <- strsplit(tract_id_name, "_", fixed = TRUE)[[1]][4]
    if (is.na(vintage)) {
      warning("vintage unspecified and not found in census tract name; assuming 2010")
      vintage <- "2010"
    }
  }

  cw <-
    paste0("hamilton_tract_to_cincy_neighborhood_", vintage) |>
    rlang::parse_expr() |>
    rlang::eval_tidy()

  joiner <- "census_tract_id"
  names(joiner) <- tract_id_name

  dplyr::left_join(.x, cw, by = joiner)
}
