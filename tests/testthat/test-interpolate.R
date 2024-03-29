test_that("interpolate", {
  dep_index_zcta <- interpolate(dep_index, cincy::zcta_tigris_2010, "pop")
  expect_snapshot(dep_index_zcta)
  dep_index_zcta$n_things <- 1:nrow(dep_index_zcta)
  dep_index_neigh <- interpolate(dep_index_zcta, cincy::neigh_cchmc_2010, "homes")
  expect_snapshot(dep_index_neigh)
})

test_that("using interpolate on non-TDR doesn't cause problems", {
  cincy::tract_tigris_2010 |>
    dplyr::mutate(n_things = dplyr::row_number()) |>
    interpolate(cincy::zcta_tigris_2010, "pop") |>
    expect_silent()
  })


test_that("ids checks", {
  # from must have a properly named geography id column
  expect_error(
    interpolate(dep_index |> dplyr::rename(id = census_tract_id_2010), cincy::zcta_tigris_2010))

  # to must have a properly named geography id column
  expect_error(
    interpolate(dep_index,cincy::zcta_tigris_2010 |> dplyr::rename(id = zcta_2010)))

  # from cannot have more than one geography id column
  expect_error(
    interpolate(dep_index |> dplyr::rename(zcta = fraction_poverty), cincy::zcta_tigris_2010))

  # to cannot have more than one geography id column
  expect_error(
    interpolate(dep_index, cincy::zcta_tigris_2010 |> dplyr::mutate(neighborhood = 1)))

  # geography columns in from and to must have distinct names
  expect_error(
    interpolate(dep_index, cincy::zcta_tigris_2010 |> dplyr::rename(census_tract_id_2010 = zcta_2010)))

  # to must be projected to EPSG:5072, not EPSG:3537
  expect_error(
    interpolate(dep_index, cincy::zcta_tigris_2010 |> sf::st_transform(3537)))

  # from is being projected from EPSG:3537 to EPSG:5072
  expect_message(
    interpolate(dep_index |> sf::st_transform(3537), cincy::zcta_tigris_2010))
})
