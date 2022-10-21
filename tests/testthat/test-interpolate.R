test_that("interpolate", {
  dep_index_zcta <- interpolate(dep_index, cincy::zcta_tigris_2010, "pop")
  expect_snapshot(dep_index_zcta)
  dep_index_zcta$n_things <- 1:nrow(dep_index_zcta)
  dep_index_neigh <- interpolate(dep_index_zcta, cincy::neigh_cchmc, "homes")
  expect_snapshot(dep_index_neigh)
})
