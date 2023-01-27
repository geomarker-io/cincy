library(sf)
library(dplyr)

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
  select(neighborhood = NEIGH) |>
  st_cast("MULTIPOLYGON")

neigh_sna <-
  st_read(
    dsn = glue::glue("data-raw/OpenData{cagis_vintage}.gdb"),
    layer = "Cincinnati_Statistical_Neighborhood_Approximations"
  ) |>
  st_transform(5072) |>
  select(neighborhood = SNA_NAME) |>
  st_cast("MULTIPOLYGON") |>
  st_make_valid()

usethis::use_data(neigh_ccc, neigh_sna, overwrite = TRUE)

neigh_cchmc_2010 <-
  left_join(tract_tigris_2010,
    readr::read_csv("data-raw/hamilton_tract_to_cincy_neighborhood_2010.csv",
      col_types = "ccc"
    ),
    by = c("census_tract_id_2010" = "census_tract_id")
  ) |>
  group_by(neighborhood) |>
  summarise(geometry = sf::st_union(geometry)) |>
  ungroup() |>
  rename(neighborhood_2010 = neighborhood)

usethis::use_data(neigh_cchmc_2010, overwrite = TRUE)

neigh_cchmc_2020 <-
  left_join(tract_tigris_2020,
            hamilton_tract_to_cincy_neighborhood_2020,
            by = c("census_tract_id_2020" = "census_tract_id")
  ) |>
  group_by(neighborhood) |>
  summarise(geometry = sf::st_union(geometry)) |>
  ungroup() |>
  rename(neighborhood_2020 = neighborhood)

usethis::use_data(neigh_cchmc_2020, overwrite = TRUE)
