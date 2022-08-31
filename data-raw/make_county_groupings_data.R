library(tidyverse)
library(tigris)
library(sf)

codec_counties <- tigris::counties(state = "oh", year = 2019) |>
  filter(NAME %in% c("Hamilton", "Butler", "Clermont", "Warren",
                     "Adams", "Brown", "Clinton", "Highland")) |>
  bind_rows(tigris::counties(state = "ky", year = 2019) |>
              filter(NAME %in% c("Kenton", "Campbell", "Boone", "Grant"))) |>
  bind_rows(tigris::counties(state = "in", year = 2019) |>
              filter(NAME %in% c("Dearborn", "Ripley", "Franklin")))

codec_counties <- codec_counties |>
  mutate(state_name = c(rep("Ohio", 8), rep("Kentucky", 4), rep("Indiana", 3))) |>
  select(county_name = NAME,
         state_name,
         county_id = GEOID)

codec_counties <- st_transform(codec_counties, 5072)

usethis::use_data(codec_counties, overwrite = TRUE)
