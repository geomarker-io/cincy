library(dplyr)
library(tigris)
library(sf)
library(purrr)

counties <-
  map(c(39, 21, 18), ~ counties(state = ., year = 2019)) |>
  bind_rows() |>
  st_transform(5072)

county_group_lookup <-
  list(
    "swoh" = c(39017, 39061, 39025, 39165),
    "hlthv" = c(
      39017, 39015, 39001, 39071, 39027, 39061, 39025,
      39165, 21117, 21081, 21015, 21037, 18137, 18047, 18029
    ),
    "hlthvoh" = c(39017, 39015, 39001, 39071, 39027, 39061, 39025, 39165),
    "7cc" = c(39017, 39061, 39025, 39165, 21117, 21015, 21037),
    "8cc" = c(39017, 39061, 39025, 39165, 21117, 21015, 21037, 18029)
  )

county_groupings <-
  map(county_group_lookup, ~ filter(counties, GEOID %in% .x)) |>
  modify(
    ~ transmute(
      .,
      county_name = NAME,
      county_id = COUNTYFP,
      state_name = c("39" = "OH", "21" = "KY", "18" = "IN")[STATEFP],
      state_id = STATEFP,
      geoid = GEOID
    )
  )

names(county_groupings) <- glue::glue("county_{names(county_groupings)}_2010")

iwalk(
  county_groupings,
  ~ {
    assign(.y, .x)
    do.call(usethis::use_data, list(as.name(.y), overwrite = TRUE))
  }
)
