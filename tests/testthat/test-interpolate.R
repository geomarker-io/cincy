test_that("interpolate", {
  to <- cincy::zcta_tigris_2010

  dep_index <-
    "https://github.com/geomarker-io/dep_index/raw/master/ACS_deprivation_index_by_census_tracts.rds" |>
    url() |>
    gzcon() |>
    readRDS() |>
    tibble::as_tibble()

  from <-
    dplyr::left_join(cincy::tract_tigris_2010, dep_index, by = c("tract_fips" = "census_tract_fips")) |>
    dplyr::arrange(tract_fips) |>
    sf::st_transform(sf::st_crs(to))

  dep_index_zcta <- interpolate(from, to, "pop")
  expect_snapshot(dep_index_zcta)
})
