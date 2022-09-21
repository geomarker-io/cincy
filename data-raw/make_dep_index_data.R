dep_index <-
  "https://github.com/geomarker-io/dep_index/raw/master/ACS_deprivation_index_by_census_tracts.rds" |>
  url() |>
  gzcon() |>
  readRDS() |>
  tibble::as_tibble()

dep_index <- dplyr::left_join(cincy::tract_tigris_2010, dep_index, by = c("tract_fips" = "census_tract_fips"))

usethis::use_data(dep_index, overwrite = TRUE)
