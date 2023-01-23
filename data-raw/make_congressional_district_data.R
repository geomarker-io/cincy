options(tigris_use_cache = TRUE)
options(tigris_class = "sf")
options(timeout = 600)

library(purrr)
library(dplyr)
library(sf)
library(tigris)

hc <- tigris::counties(state = "ohio") |>
  filter(NAME == "Hamilton") |>
  st_transform(5072) |>
  select(county_name = NAME)

# districts can change on odd years. cincy region only changed from 2011 to 2013 ??
# not available prior to 2011
districts_tigris_2013 <- tigris::congressional_districts(state = "ohio", year = 2013) |>
  st_transform(5072) |>
  select(district_name = NAMELSAD)

districts_tigris_2011 <- tigris::congressional_districts(state = "ohio", year = 2011) |>
  st_transform(5072) |>
  select(district_name = NAMELSAD)

intersect_geo <- function(geo, crop_geo) {
  int <- st_intersects(geo, crop_geo, sparse = FALSE)
  return(geo[int,])
}

districts_tigris_2013 <- intersect_geo(districts_tigris_2013, hc) |>
  filter(district_name != "Congressional District 8")

districts_tigris_2011 <- intersect_geo(districts_tigris_2011, hc) |>
  filter(district_name != "Congressional District 8")

usethis::use_data(districts_tigris_2013, districts_tigris_2011, overwrite = TRUE)
