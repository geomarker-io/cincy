hamilton_tract_to_cincy_neighborhood_2010 <- readRDS("data-raw/hamilton_tract_to_cincy_neighborhood_2010.rds")
hamilton_tract_to_cincy_neighborhood_2020 <- readRDS("data-raw/hamilton_tract_to_cincy_neighborhood_2020.rds")
weight_points <- readRDS("data-raw/weight_points.rds")

usethis::use_data(hamilton_tract_to_cincy_neighborhood_2010,
                  hamilton_tract_to_cincy_neighborhood_2020,
                  weight_points,
                  internal = TRUE,
                  overwrite = TRUE)
