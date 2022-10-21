#' Spatially interpolate community-level data
#'
#' Weights at the census block level are used to spatially interpolate different geographies.
#' Block-level total population, total number of homes, or total area from the 2020 Census
#' can be chosen to use for the weights.
#' All *numeric* variables in `from` are interpolated *non-extensively*,
#' except for any numeric variables that start with `n_`, which are interpolated
#' *extensively*.
#' @param from sf object with a neighborhood, census tract, or zcta column and
#' numeric values to be interpolated into target geographies
#' @param to sf object of target geography (**must** be one of the cincy:: geography objects)
#' @param weights use one of "pop" (population), "homes", or "area" from the
#' 2020 census block estimates to interpolate the values
#' @examples
#' # interpolate 2018 deprivation index to ZIP code level
#' interpolate(dep_index, cincy::zcta_tigris_2010, "pop")
#' # interpolate 2018 deprivation index to  2020 census tracts
#' interpolate(dep_index, cincy::tract_tigris_2020, "pop")
#' @export
interpolate <- function(from, to, weights = c("pop", "homes", "area")) {

  wt <- rlang::arg_match(weights)

  possible_ids <- c(
    "neighborhood",
    "tract_fips",
    "zcta",
    paste("census_tract_id", c("", "_2000", "_2010", "_2020"), sep = "")
  )

  from_id <- possible_ids[possible_ids %in% names(from)]
  to_id <- possible_ids[possible_ids %in% names(to)]
  # TODO, stop if can't find *_id; stop if more than one match for *_id

  from <- sf::st_transform(from, sf::st_crs(to))

  # TODO to must be a cincy:: geography object; or,
  # at the very least:
  stopifnot(sf::st_crs(weight_points) == sf::st_crs(to))

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
  dplyr::left_join(to, out_data, by = to_id)
}

