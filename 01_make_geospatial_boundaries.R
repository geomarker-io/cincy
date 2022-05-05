library(purrr)
library(dplyr)
library(sf)
library(tigris)

options(tigris_use_cache = TRUE)
options(tigris_class = "sf")

#### getting data ####

## TODO do we need to do st_make_valid on any of these??
## TODO should we also include NHGIS 'conflated' tract boundaries??
## TODO consider using cb = TRUE to reduce files sizes?  would this impact calculations?

cincy <- list()

cincy$tract_tigris_2000 <-
  tracts(state = "39", county = "061", year = 2000) |>
  transmute(tract_fips = CTIDFP00)

cincy$county_tigris_2000 <- st_union(cincy$tract_tigris_2000)

cincy$zcta_tigris_2000 <-
  zctas(year = 2000, state = "39") |>
  select(zcta = ZCTA5CE00) |>
  st_filter(cincy$county_tigris_2000, .predicate = st_intersects)
# TODO better predicate to avoid keeping zip codes that only touch on the boundaries

cincy$tract_tigris_2010 <-
  tracts(state = "39", county = "061", year = 2010) |>
  transmute(tract_fips = GEOID10)

cincy$county_tigris_2010 <- st_union(cincy$tract_tigris_2010)

cincy$zcta_tigris_2010 <-
  zctas(year = 2010, state = "39") |>
  select(zcta = ZCTA5CE10) |>
  st_filter(cincy$county_tigris_2010, .predicate = st_intersects)

## 2020

cincy$tract_tigris_2020 <-
  tracts(state = "39", county = "061", year = 2020) |>
  transmute(tract_fips = GEOID)

cincy$county_tigris_2020 <- st_union(cincy$tract_tigris_2020)

cincy$zcta_tigris_2020 <-
  zctas(year = 2020) |>
  select(zcta = ZCTA5CE20) |>
  st_filter(cincy$county_tigris_2020, .predicate = st_intersects)

## neighorhoods

cincy$neigh_besl_2021 <-
  left_join(cincy$tract_tigris_2010,
            readr::read_csv("hamilton_tract_to_cincy_neighborhood.csv",
                            col_types = "ccc"),
            by = c("tract_fips" = "fips_tract_id")) |>
  group_by(neighborhood) |>
  summarise(geometry = st_union(geometry)) |>
  ungroup()

# TODO automate this downlaod and extract:
## download and extract: http://cagis.org/Opendata/CAGISOpenDataWinter2021.gdb.zip
## info on layers in gdb: http://cagis.org/Opendata/File_Info.txt

cincy$neigh_ccc_2021 <-
  st_read(
    dsn = "OpenDataWinter2021.gdb",
    layer = "Cincinnati_Community_Council_Neighborhoods"
  ) |>
  select(neighborhood = NEIGH)

cincy$neigh_sna_2021 <-
  st_read(
    dsn = "OpenDataWinter2021.gdb",
    layer = "Cincinnati_Statistical_Neighborhood_Approximations"
  ) |>
  select(neighborhood = SNA_NAME)

# reproject all to epsg 4326
cincy <- purrr::map(cincy, st_transform, 4326)

## export all
# list names are {geography}_{source}_{vintage}
# query using autocomplete: `cincy$...` or `cincy$neigh_...`
saveRDS(cincy, "cincy.rds")
