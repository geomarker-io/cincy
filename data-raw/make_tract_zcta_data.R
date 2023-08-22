options(tigris_use_cache = TRUE)
options(tigris_class = "sf")
options(timeout = 600)

library(purrr)
library(dplyr)
library(sf)
library(tigris)

tract_tigris_2000 <-
  tracts(state = "39", county = "061", year = 2000) |>
  st_transform(5072) |>
  transmute(census_tract_id_2000 = CTIDFP00)

county_tigris_2000 <- st_union(tract_tigris_2000)

zcta_tigris_2000 <-
  zctas(year = 2000, state = "39") |>
  select(zcta_2000 = ZCTA5CE00) |>
  st_transform(5072)

zcta_tigris_2000 <-
  st_filter(zcta_tigris_2000, county_tigris_2000, .predicate = st_within) |>
  bind_rows(st_filter(zcta_tigris_2000,
                      county_tigris_2000,
                      .predicate = st_overlaps)) |>
  filter(!zcta_2000 %in% c(45140)) # manually remove

usethis::use_data(tract_tigris_2000, zcta_tigris_2000, overwrite = TRUE)

tract_tigris_2010 <-
  tracts(state = "39", county = "061", year = 2010) |>
  st_transform(5072) |>
  transmute(census_tract_id_2010 = GEOID10)

county_tigris_2010 <- st_union(tract_tigris_2010)

zcta_tigris_2010 <-
  zctas(year = 2010, state = "39") |>
  st_transform(5072) |>
  select(zcta_2010 = ZCTA5CE10)

zcta_tigris_2010 <-
  st_filter(zcta_tigris_2010, county_tigris_2010, .predicate = st_within) |>
  bind_rows(st_filter(zcta_tigris_2010,
                      county_tigris_2010,
                      .predicate = st_overlaps))  |>
  filter(!zcta_2010 %in% c(45013, 45140, 45150)) # manually remove

usethis::use_data(tract_tigris_2010, zcta_tigris_2010, overwrite = TRUE)

tract_tigris_2020 <-
  tracts(state = "39", county = "061", year = 2020) |>
  st_transform(5072) |>
  transmute(census_tract_id_2020 = GEOID)

county_tigris_2020 <- st_union(tract_tigris_2020)

zcta_tigris_2020 <-
  zctas(year = 2020) |>
  st_transform(5072) |>
  select(zcta_2020 = ZCTA5CE20)

zcta_tigris_2020 <-
  st_filter(zcta_tigris_2020, county_tigris_2020, .predicate = st_within) |>
  bind_rows(st_filter(zcta_tigris_2020,
                      county_tigris_2020,
                      .predicate = st_overlaps)) |>
  filter(!zcta_2020 %in% c(45053, 47060, 47025, 41017, 41074,
                      45157, 45014, 45013, 45069, 45040,
                      45140, 45150)) # manually remove

usethis::use_data(tract_tigris_2020, zcta_tigris_2020, overwrite = TRUE)
