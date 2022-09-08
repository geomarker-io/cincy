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
  transmute(tract_fips = CTIDFP00)

county_tigris_2000 <- st_union(tract_tigris_2000)

zcta_tigris_2000 <-
  zctas(year = 2000, state = "39") |>
  select(zcta = ZCTA5CE00) |>
  st_transform(5072)

zcta_tigris_2000 <-
  st_filter(zcta_tigris_2000, county_tigris_2000, .predicate = st_within) |>
  bind_rows(st_filter(zcta_tigris_2000,
                      county_tigris_2000,
                      .predicate = st_overlaps))

usethis::use_data(tract_tigris_2000, zcta_tigris_2000, overwrite = TRUE)

tract_tigris_2010 <-
  tracts(state = "39", county = "061", year = 2010) |>
  st_transform(5072) |>
  transmute(tract_fips = GEOID10)

county_tigris_2010 <- st_union(tract_tigris_2010)

zcta_tigris_2010 <-
  zctas(year = 2010, state = "39") |>
  st_transform(5072) |>
  select(zcta = ZCTA5CE10)

zcta_tigris_2010 <-
  st_filter(zcta_tigris_2010, county_tigris_2010, .predicate = st_within) |>
  bind_rows(st_filter(zcta_tigris_2010,
                      county_tigris_2010,
                      .predicate = st_overlaps))

usethis::use_data(tract_tigris_2010, zcta_tigris_2010, overwrite = TRUE)

tract_tigris_2020 <-
  tracts(state = "39", county = "061", year = 2020) |>
  st_transform(5072) |>
  transmute(tract_fips = GEOID)

county_tigris_2020 <- st_union(tract_tigris_2020)

zcta_tigris_2020 <-
  zctas(year = 2020) |>
  st_transform(5072) |>
  select(zcta = ZCTA5CE20)

zcta_tigris_2020 <-
  st_filter(zcta_tigris_2020, county_tigris_2020, .predicate = st_within) |>
  bind_rows(st_filter(zcta_tigris_2020,
                      county_tigris_2020,
                      .predicate = st_overlaps)) |>
  filter(!zcta %in% c(45053, 47060, 47025, 41017, 41074,
                      45157, 45014)) # manually remove

usethis::use_data(tract_tigris_2020, zcta_tigris_2020, overwrite = TRUE)

neigh_cchmc <-
  left_join(tract_tigris_2010,
    readr::read_csv("data-raw/hamilton_tract_to_cincy_neighborhood.csv",
      col_types = "ccc"
    ),
    by = c("tract_fips" = "fips_tract_id")
  ) |>
  group_by(neighborhood) |>
  summarise(geometry = st_union(geometry)) |>
  ungroup()

usethis::use_data(neigh_cchmc, overwrite = TRUE)

cagis_vintage <- "Summer2022"

if (!file.exists(glue::glue("data-raw/OpenData{cagis_vintage}.gdb"))) {
  tmp <- tempfile(fileext = ".zip")
  download.file(glue::glue("http://cagis.org/Opendata/CAGISOpenData{cagis_vintage}.gdb.zip"), tmp)
  unzip(tmp, exdir = "data-raw")
}

neigh_ccc <-
  st_read(
    dsn = glue::glue("data-raw/OpenData{cagis_vintage}.gdb"),
    layer = "Cincinnati_Community_Council_Neighborhoods"
  ) |>
  st_transform(5072) |>
  select(neighborhood = NEIGH)

neigh_sna <-
  st_read(
    dsn = glue::glue("data-raw/OpenData{cagis_vintage}.gdb"),
    layer = "Cincinnati_Statistical_Neighborhood_Approximations"
  ) |>
  st_transform(5072) |>
  select(neighborhood = SNA_NAME)

usethis::use_data(neigh_ccc, neigh_sna, overwrite = TRUE)
