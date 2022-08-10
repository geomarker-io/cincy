library(readr)

hamilton_tract_to_cincy_neighborhood <-
  read_csv('data-raw/hamilton_tract_to_cincy_neighborhood.csv')

usethis::use_data(hamilton_tract_to_cincy_neighborhood,
                  overwrite = TRUE)
