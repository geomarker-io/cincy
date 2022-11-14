weight_points <-
  tigris::blocks(39, 061, year = 2020) |>
  sf::st_transform(5072) |>
  sf::st_point_on_surface() |>
  suppressWarnings() |>
  dplyr::select(pop = POP20, homes = HOUSING20, area = ALAND20)

saveRDS(weight_points, "data-raw/weight_points.rds")
