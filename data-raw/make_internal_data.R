hamilton_tract_to_cincy_neighborhood_2010 <- readRDS("data-raw/hamilton_tract_to_cincy_neighborhood_2010.rds") |>
  dplyr::rename(census_tract_id_2010 = census_tract_id)

hamilton_tract_to_cincy_neighborhood_2020 <- readRDS("data-raw/hamilton_tract_to_cincy_neighborhood_2020.rds") |>
  dplyr::rename(census_tract_id_2020 = census_tract_id)

weight_points <- readRDS("data-raw/weight_points.rds")

usethis::use_data(hamilton_tract_to_cincy_neighborhood_2010,
                  hamilton_tract_to_cincy_neighborhood_2020,
                  weight_points,
                  internal = TRUE,
                  overwrite = TRUE)
