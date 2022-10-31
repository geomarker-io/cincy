library(sf)
library(dplyr)
library(readr)

hamilton_tract_to_cincy_neighborhood_2010 <-
  read_csv('data-raw/hamilton_tract_to_cincy_neighborhood_2010.csv',
           col_types = list(col_character(), col_character(), col_character()))

usethis::use_data(hamilton_tract_to_cincy_neighborhood_2010, overwrite = TRUE, internal = TRUE)


