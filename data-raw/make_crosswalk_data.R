library(sf)
library(dplyr)

make_weights <- function(poly1, poly2, key) {
  poly1$p1_area <- as.numeric(st_area(poly1))

  poly_intersections <-
    st_intersection(poly1, poly2) %>%
    mutate(area = as.numeric(st_area(.))) %>%
    filter(area > 0) %>%
    mutate(weight = area/p1_area) %>%
    st_drop_geometry() %>%
    arrange({{key}}) %>%
    select(-p1_area, -area) %>%

  return(poly_intersections)
}

zcta_to_tract_2000 <- make_weights(tract_tigris_2000, zcta_tigris_2000, key = tract_fips)
tract_to_zcta_2000 <- make_weights(zcta_tigris_2000, tract_tigris_2000, key = zcta)

zcta_to_tract_2010 <- make_weights(tract_tigris_2010, zcta_tigris_2010, key = tract_fips)
tract_to_zcta_2010 <- make_weights(zcta_tigris_2010, tract_tigris_2010, key = zcta)

zcta_to_tract_2020 <- make_weights(tract_tigris_2020, zcta_tigris_2020, key = tract_fips)
tract_to_zcta_2020 <- make_weights(zcta_tigris_2020, tract_tigris_2020, key = zcta)

# tract to tract
tracts_2000_to_2010 <- make_weights(tract_tigris_2010 %>%
                                      rename(tract_fips_2010 = tract_fips),
                                    tract_tigris_2000 %>%
                                      rename(tract_fips_2000 = tract_fips),
                                    key = tract_fips_2010)

tracts_2010_to_2000 <- make_weights(tract_tigris_2000 %>%
                                      rename(tract_fips_2000 = tract_fips),
                                    tract_tigris_2010 %>%
                                      rename(tract_fips_2010 = tract_fips),
                                    key = tract_fips_2000)

tracts_2010_to_2020 <- make_weights(tract_tigris_2020 %>%
                                      rename(tract_fips_2020 = tract_fips),
                                    tract_tigris_2010 %>%
                                      rename(tract_fips_2010 = tract_fips),
                                    key = tract_fips_2020)

tracts_2020_to_2010 <- make_weights(tract_tigris_2010 %>%
                                      rename(tract_fips_2010 = tract_fips),
                                    tract_tigris_2020 %>%
                                      rename(tract_fips_2020 = tract_fips),
                                    key = tract_fips_2010)

tracts_2000_to_2020 <- make_weights(tract_tigris_2020 %>%
                                      rename(tract_fips_2020 = tract_fips),
                                    tract_tigris_2000 %>%
                                      rename(tract_fips_2000 = tract_fips),
                                    key = tract_fips_2020)

tracts_2020_to_2000 <- make_weights(tract_tigris_2000 %>%
                                      rename(tract_fips_2000 = tract_fips),
                                    tract_tigris_2020 %>%
                                      rename(tract_fips_2020 = tract_fips),
                                    key = tract_fips_2000)

# zcta to zcta
zctas_2000_to_2010 <- make_weights(zcta_tigris_2010 %>%
                                      rename(zcta_2010 = zcta),
                                    zcta_tigris_2000 %>%
                                      rename(zcta_2000 = zcta),
                                    key = zcta_2010)

zctas_2010_to_2000 <- make_weights(zcta_tigris_2000 %>%
                                      rename(zcta_2000 = zcta),
                                    zcta_tigris_2010 %>%
                                      rename(zcta_2010 = zcta),
                                    key = zcta_2000)

zctas_2010_to_2020 <- make_weights(zcta_tigris_2020 %>%
                                      rename(zcta_2020 = zcta),
                                    zcta_tigris_2010 %>%
                                      rename(zcta_2010 = zcta),
                                    key = zcta_2020)

zctas_2020_to_2010 <- make_weights(zcta_tigris_2010 %>%
                                      rename(zcta_2010 = zcta),
                                    zcta_tigris_2020 %>%
                                      rename(zcta_2020 = zcta),
                                    key = zcta_2010)

zctas_2000_to_2020 <- make_weights(zcta_tigris_2020 %>%
                                      rename(zcta_2020 = zcta),
                                    zcta_tigris_2000 %>%
                                      rename(zcta_2000 = zcta),
                                    key = zcta_2020)

zctas_2020_to_2000 <- make_weights(zcta_tigris_2000 %>%
                                      rename(zcta_2000 = zcta),
                                    zcta_tigris_2020 %>%
                                      rename(zcta_2020 = zcta),
                                    key = zcta_2000)

# neighborhoods
hamilton_tract_to_cincy_neighborhood <-
  read_csv('data-raw/hamilton_tract_to_cincy_neighborhood.csv')

usethis::use_data(zcta_to_tract_2000, tract_to_zcta_2000,
                  zcta_to_tract_2010, tract_to_zcta_2010,
                  zcta_to_tract_2020, tract_to_zcta_2020,
                  tracts_2000_to_2010, tracts_2010_to_2000,
                  tracts_2010_to_2020, tracts_2020_to_2010,
                  tracts_2000_to_2020, tracts_2020_to_2000,
                  zctas_2000_to_2010, zctas_2010_to_2000,
                  zctas_2010_to_2020, zctas_2020_to_2010,
                  zctas_2000_to_2020, zctas_2020_to_2000,
                  hamilton_tract_to_cincy_neighborhood,
                  overwrite = TRUE, internal = TRUE)
