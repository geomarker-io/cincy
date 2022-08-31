test_that("test county groupings", {
  expect_snapshot(get_county_grouping("healthvine"))
  expect_snapshot(get_county_grouping())
  expect_error(get_county_grouping("x"))
})
