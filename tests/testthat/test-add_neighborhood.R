test_that("add_neighborhood", {

  set.seed(111)
  some_2010_tract_data <-
    cincy::tract_tigris_2010 |>
    dplyr::sample_n(length(letters)) |>
    sf::st_drop_geometry() |>
    tibble::tibble() |>
    dplyr::mutate(id = letters)

  neigh_data <- add_neighborhood(some_2010_tract_data)
  expect_identical(names(neigh_data), c("census_tract_id_2010", "id", "neighborhood"))

  # error if no census tract id column found
  expect_error({
    some_2010_tract_data |>
      dplyr::rename(not_census_tract_id = census_tract_id_2010) |>
      add_neighborhood()
  })

  # when year is not specified in tract id name, use 2010 with a message
  expect_warning({
    some_2010_tract_data |>
      dplyr::rename(census_tract_id = census_tract_id_2010) |>
      add_neighborhood()
  })

  # use vintage argument
  some_2010_tract_data |>
    dplyr::rename(census_tract_id = census_tract_id_2010) |>
    dplyr::mutate(census_tract_vintage = "2010") |>
    add_neighborhood(vintage = "2010") |>
    names() |>
    expect_identical(c("census_tract_id", "id", "census_tract_vintage", "neighborhood"))

  # error if wrong vintage argument
  expect_error({
    add_neighborhood(some_2010_tract_data, vintage = "2000")
  })

})
