library(sf)

cincy <- readRDS("cincy.rds")

library(mapview)
mapviewOptions(platform = "leaflet")
mapviewOptions(fgb = FALSE)
## mapviewOptions(platform = "mapdeck")

leafsync::sync(mapview(cincy$tract_tigris_2010),
               mapview(cincy$tract_tigris_2020),
               mapview(cincy$zcta_tigris_2010),
               mapview(cincy$zcta_tigris_2020)
               )

old_tracts <- cincy$tract_tigris_2010[! cincy$tract_tigris_2010$tract_fips %in% cincy$tract_tigris_2020$tract_fips, ]
new_tracts <- cincy$tract_tigris_2020[! cincy$tract_tigris_2020$tract_fips %in% cincy$tract_tigris_2010$tract_fips, ]

mapview::mapview(old_tracts, color = "blue", alpha.regions = 0, lwd = 2, alpha = 0.5) +
mapview::mapview(new_tracts, color = "green", alpha.regions = 0, lwd = 2, alpha = 0.5)

mapview::mapview(cincy$neigh_besl_2021)

# TODO random C stack usage error on these two next commands ??
mapview::mapview(cincy$neigh_sna_2021)
mapview::mapview(cincy$neigh_ccc_2021)

# but this works:
plot(cincy$neigh_sna_2021)
plot(cincy$neigh_ccc_2021)
