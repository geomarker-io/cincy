test_that("interpolate", {
  dep_index_zcta <- interpolate(dep_index, cincy::zcta_tigris_2010, "pop")
  expect_snapshot(dep_index_zcta)
  dep_index_zcta$n_things <- 1:nrow(dep_index_zcta)
  dep_index_neigh <- interpolate(dep_index_zcta, cincy::neigh_cchmc_2010, "homes")
  expect_snapshot(dep_index_neigh)
})


test_that("ids checks", {
  expect_error(
    interpolate(dep_index |> dplyr::rename(id = census_tract_id), cincy::zcta_tigris_2010))
  expect_error(
    interpolate(dep_index,cincy::zcta_tigris_2010 |> dplyr::rename(id = zcta)))
  expect_error(
    interpolate(dep_index |> dplyr::rename(zcta = fraction_poverty), cincy::zcta_tigris_2010))
  expect_error(
    interpolate(dep_index, cincy::zcta_tigris_2010 |> dplyr::mutate(neighborhood = 1)))
  expect_error(
    interpolate(dep_index, cincy::zcta_tigris_2010 |> dplyr::rename(census_tract_id = zcta)))
  expect_error(
    interpolate(dep_index, cincy::zcta_tigris_2010 |> sf::st_transform(3537)))
  expect_message(
    interpolate(dep_index |> sf::st_transform(3537), cincy::zcta_tigris_2010))
})
