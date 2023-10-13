#' Spatially interpolate community-level data
#'
#' Weights at the census block-level are used to spatially interpolate different geographies.
#' Block-level total population, total number of homes, or total area from the 2020 Census
#' can be chosen to use for the weights.
#' All *numeric* variables in `from` are interpolated *non-extensively*,
#' except for any numeric variables that start with `n_`, which are interpolated
#' *extensively*.
#' @param from sf object with a neighborhood, census tract, census block group, census block,
#'  or zcta column and numeric values to be interpolated into target geographies. The `from`
#'  object should be CRS 5072. If not, it will be projected to 5072 for interpolation.
#' @param to sf object of target geography This function is designed to work with
#'  cincy:: geography objects, and `to` objects must be CRS 5072.
#' @param weights use one of "pop" (population), "homes", or "area" from the
#' 2020 census block estimates to interpolate the values
#' @details
#' Possible geography id column names include "neighborhood", "zcta",
#' "census_tract_id", "census_block_id", "census_block_group_id", and "district".
#' Optionally, the column names can be appended with the census decade vintage "_2000",
#' "_2010", or "_2000" ("district" vintages include "_2011" and "_2013").
#' @examples
#' # interpolate 2018 deprivation index to ZIP code level
#' interpolate(dep_index, cincy::zcta_tigris_2010, "pop")
#' # interpolate 2018 deprivation index to  2020 census tracts
#' interpolate(dep_index, cincy::tract_tigris_2020, "pop")
#' @export
interpolate <- function(from, to, weights = c("pop", "homes", "area")) {

  wt <- rlang::arg_match(weights)

  possible_ids <- c(
    paste("neighborhood", c("", "_2000", "_2010", "_2020"), sep = ""),
    paste("zcta", c("", "_2000", "_2010", "_2020"), sep = ""),
    paste("census_tract_id", c("", "_2000", "_2010", "_2020"), sep = ""),
    paste("census_block_id", c("", "_2000", "_2010", "_2020"), sep = ""),
    paste("census_block_group_id", c("", "_2000", "_2010", "_2020"), sep = ""),
    paste("district", c("", "_2011", "_2013"), sep = "")
  )

  # check for named geography id column
  if(all(! possible_ids %in% names(from))) {
    stop("from must have a properly named geography id column.
         See documentation for a list of possible ids.") }
  if(all(! possible_ids %in% names(to))) {
    stop("to must have a properly named geography id column.
         See documentation for a list of possible ids.") }

  # check for only 1 geography id column
  if (sum(possible_ids %in% names(from)) > 1) {
    stop("from cannot have more than one geography id column.") }
  if (sum(possible_ids %in% names(to)) > 1) {
    stop("to cannot have more than one geography id column.") }

  # pull out id column names
  from_id <- possible_ids[possible_ids %in% names(from)]
  to_id <- possible_ids[possible_ids %in% names(to)]

  # check that id columns have unique names
  if(from_id == to_id) {
    stop("geography columns in from and to must have distinct names") }

  if (sf::st_crs(weight_points) != sf::st_crs(to)) {
    stop(glue::glue("to must be projected to EPSG:5072, not {sf::st_crs(to)$input}"))
  }

  if (sf::st_crs(from) != sf::st_crs(to)) {
    message(glue::glue("from is being projected from {sf::st_crs(from)$input} to {sf::st_crs(to)$input}"))
    from <- sf::st_transform(from, sf::st_crs(to))
  }

  total_weights <-
    from |>
    sf::st_join(weight_points, left = FALSE) |>
    sf::st_drop_geometry() |>
    dplyr::group_by(!!rlang::sym(from_id)) |>
    dplyr::summarize(total = sum(!!rlang::sym(wt), na.rm = TRUE))

  from <- dplyr::left_join(from, total_weights, by = from_id)

  from_to_int <-
    sf::st_intersection(from, to) |>
    dplyr::filter(sf::st_is(.data$geometry, c("POLYGON", "MULTIPOLYGON", "GEOMETRYCOLLECTION"))) |>
    suppressWarnings() |>
    dplyr::mutate(.row = dplyr::row_number()) |>
    sf::st_join(weight_points, left = FALSE)

  intersections <-
    from_to_int |>
    sf::st_drop_geometry() |>
    dplyr::group_by(.row) |>
    dplyr::mutate(intersection_value = sum(!!rlang::sym(wt), na.rm = TRUE)) |>
    dplyr::ungroup() |>
    dplyr::distinct(.row, .keep_all = TRUE) |>
    dplyr::mutate(weight_coef = intersection_value / total) |>
    dplyr::select(-total, -.row, -pop, -homes, -area)

  to_non_extensive <-
    from |>
    sf::st_drop_geometry() |>
    tibble::as_tibble() |>
    dplyr::select(!!rlang::sym(from_id)) |>
    dplyr::left_join(intersections, by = from_id) |>
    dplyr::group_by(!!rlang::sym(to_id)) |>
    dplyr::summarize(
      dplyr::across(
        tidyselect::vars_select_helpers$where(is.numeric),
        .fns = ~weighted.mean(.x, w = intersection_value, na.rm = TRUE)
      )
    )

  to_non_extensive$intersection_value <- NULL
  to_non_extensive$weight_coef <- NULL
  to_non_extensive <- dplyr::select(to_non_extensive, -tidyselect::starts_with(c("n_")))

  to_extensive <-
    from |>
    sf::st_drop_geometry() |>
    tibble::as_tibble() |>
    dplyr::select(!!rlang::sym(from_id)) |>
    dplyr::left_join(intersections, by = from_id) |>
    dplyr::group_by(!!rlang::sym(to_id)) |>
    dplyr::mutate(
      dplyr::across(
        tidyselect::starts_with(c("n_")),
        .fns = ~(.x * weight_coef))) |>
    dplyr::select(-weight_coef) |>
    dplyr::group_by(!!rlang::sym(to_id)) |>
    dplyr::summarize(
      dplyr::across(
        tidyselect::starts_with(c("n_")),
        .fns = ~sum(.x, na.rm = TRUE)))

  out_data <- dplyr::left_join(to_non_extensive, to_extensive, by = to_id)
  out_data <- dplyr::left_join(to, out_data, by = to_id)

  return(out_data)
}

