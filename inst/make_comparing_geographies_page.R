library(cincy)
library(tmap)
library(sf)

tm <- # add fill colors
  tm_shape(county_7cc_2010, 
           name = "county_7cc_2010") +
  tm_polygons(alpha = 0.5,
              col = "#a6cee3") +
  tm_shape(county_8cc_2010, 
           name = "county_8cc_2010") +
  tm_polygons(alpha = 0.5,
              col = "#1f78b4") +
  tm_shape(county_hlthv_2010, 
           name = "county_hlthv_2010") +
  tm_polygons(alpha = 0.5,
              col = "#b2df8a") +
  tm_shape(county_hlthvoh_2010, 
           name = "county_hlthvoh_2010") +
  tm_polygons(alpha = 0.5,
              col = "#33a02c") +
  tm_shape(county_swoh_2010, 
           name = "county_swoh_2010") +
  tm_polygons(alpha = 0.5,
              col = "#fb9a99") +
  tm_shape(neigh_ccc, 
           name = "neigh_ccc") +
  tm_polygons(alpha = 0.5,
              col = "#e31a1c") +
  tm_shape(neigh_cchmc_2010, 
           name = "neigh_cchmc_2010") +
  tm_polygons(alpha = 0.5,
              col = "#fdbf6f") +
  tm_shape(neigh_cchmc_2020, 
           name = "neigh_cchmc_2020") +
  tm_polygons(alpha = 0.5,
              col = "#ff7f00") +
  tm_shape(neigh_sna, 
           name = "neigh_sna") +
  tm_polygons(alpha = 0.5,
              col = "#cab2d6") +
  tm_shape(tract_tigris_2000, 
           name = "tract_tigris_2000") +
  tm_polygons(alpha = 0.5,
              col = "#6a3d9a") +
  tm_shape(tract_tigris_2010, 
           name = "tract_tigris_2010") +
  tm_polygons(alpha = 0.5,
              col = "#ffff99") +
  tm_shape(tract_tigris_2020, 
           name = "tract_tigris_2020") +
  tm_polygons(alpha = 0.5,
              col = "#b15928") +
  tm_shape(zcta_tigris_2000, 
           name = "zcta_tigris_2000") +
  tm_polygons(alpha = 0.5,
              col = "gray30") +
  tm_shape(zcta_tigris_2010, 
           name = "zcta_tigris_2010") +
  tm_polygons(alpha = 0.5,
              col = "gray80") +
  tm_shape(zcta_tigris_2020, 
           name = "zcta_tigris_2020") +
  tm_polygons(alpha = 0.5,
              col = "goldenrod") +
  tm_facets(as.layers = TRUE, 
            free.scales.fill = TRUE, 
            sync = TRUE) 

tm1 <- tm |>
  tmap_leaflet() |>
  leaflet::hideGroup(c("county_7cc_2010", 
                       "county_8cc_2010", 
                       "county_hlthv_2010", 
                       "county_hlthvoh_2010", 
                       "county_swoh_2010", 
                       "neigh_ccc", 
                       "neigh_sna", 
                       "neigh_cchmc_2010", 
                       "neigh_cchmc_2020",
                       "tract_tigris_2000", 
                       "tract_tigris_2020",
                       "zcta_tigris_2000", 
                       "zcta_tigris_2010", 
                       "zcta_tigris_2020")) |>
  leaflet.extras::addFullscreenControl()

tm2 <- tm |>
  tmap_leaflet() |>
  leaflet::hideGroup(c("county_7cc_2010", 
                       "county_8cc_2010", 
                       "county_hlthv_2010", 
                       "county_hlthvoh_2010", 
                       "county_swoh_2010", 
                       "neigh_ccc", 
                       "neigh_sna",  
                       "neigh_cchmc_2020", 
                       "tract_tigris_2000", 
                       "tract_tigris_2010", 
                       "tract_tigris_2020",
                       "zcta_tigris_2000", 
                       "zcta_tigris_2010", 
                       "zcta_tigris_2020")) |>
  leaflet.extras::addFullscreenControl() |>
  leaflet::addLegend("bottomright", 
                     values = dates, 
                     colors = c(
                       "#a6cee3", 
                       "#1f78b4",
                       "#b2df8a",
                       "#33a02c",
                       "#fb9a99",
                       "#e31a1c",
                       "#fdbf6f",
                       "#ff7f00",
                       "#cab2d6",
                       "#6a3d9a",
                       "#ffff99",
                       "#b15928",
                       "gray30",
                       "gray80",
                       "goldenrod"),
                     labels = c(
                       "county_7cc_2010", 
                       "county_8cc_2010", 
                       "county_hlthv_2010", 
                       "county_hlthvoh_2010", 
                       "county_swoh_2010", 
                       "neigh_ccc", 
                       "neigh_sna",  
                       "neigh_cchmc_2010", 
                       "neigh_cchmc_2020", 
                       "tract_tigris_2000", 
                       "tract_tigris_2010", 
                       "tract_tigris_2020",
                       "zcta_tigris_2000", 
                       "zcta_tigris_2010", 
                       "zcta_tigris_2020"
                       ),
                     title = "",
                     opacity = 1) 

leafsync::latticeView(tm1, tm2, ncol = 1, 
                      sync = list(c(1, 2)), 
                      sync.cursor = TRUE, 
                      no.initial.sync = TRUE) 
# |>
#   mapview::mapshot(
#     file = fs::path(fs::path_package("cincy"), "comparing_geographies.html"),
#     remove_controls = NULL)

# mapview::mapshot doesn't work with sync maps: https://github.com/r-spatial/leafsync/issues/4

# a work around would be to save it from rstudio after running code above and then saving
