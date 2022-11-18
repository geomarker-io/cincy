library(sf)
library(dplyr)
library(readr)

hamilton_tract_to_cincy_neighborhood_2010 <-
  read_csv('data-raw/hamilton_tract_to_cincy_neighborhood_2010.csv',
           col_types = list(col_character(), col_character()))

saveRDS(hamilton_tract_to_cincy_neighborhood_2010,
        "data-raw/hamilton_tract_to_cincy_neighborhood_2010.rds")

hamilton_tract_to_cincy_neighborhood_2020 <-
  read_csv('data-raw/hamilton_tract_to_cincy_neighborhood_2020.csv',
           col_types = list(col_character(), col_character()))

saveRDS(hamilton_tract_to_cincy_neighborhood_2020,
        "data-raw/hamilton_tract_to_cincy_neighborhood_2020.rds")

