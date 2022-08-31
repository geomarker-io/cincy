#' @importFrom sf st_sf
NULL

#' ZCTAs
#'
#' [ZIP Code Tabulation Areas (ZCTAs)](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/zctas.html)
#' for Ohio that (at least partially) intersect with Hamilton County from 2000, 2010, and 2020.
#' @details ZCTAs were downloaded directly from the Census Bureau using the [tigris](https://github.com/walkerke/tigris) package

#' ZCTA (2000 TIGER/Line)
#' @rdname ZCTAs
#' @source [TIGER/Line Shapefile](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2000.html)
"zcta_tigris_2000"

#' ZCTA (2010 TIGER/Line)
#' @rdname ZCTAs
#' @source [TIGER/Line Shapefile](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2010.html)
"zcta_tigris_2010"

#' ZCTA (2020 TIGER/Line)
#' @rdname ZCTAs
#' @source [TIGER/Line Shapefile](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2020.html)
"zcta_tigris_2020"

#' Tracts
#'
#' Census Tracts for Hamilton County from 2000, 2010, and 2020.
#' @details Tracts were downloaded directly from the Census Bureau using the [tigris](https://github.com/walkerke/tigris) package

#' Census Tracts (2000 TIGER/Line)
#' @rdname Tracts
#' @source [TIGER/Line Shapefile](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2000.html)
"tract_tigris_2000"

#' Census Tracts (2010 TIGER/Line)
#' @rdname Tracts
#' @source [TIER/Line Shapefile](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2010.html)
"tract_tigris_2010"

#' Census Tracts (2020 TIGER/Line)
#' @rdname Tracts
#' @source [TIGER/Line Shapefile](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2020.html)
"tract_tigris_2020"

#' Neighborhoods
#'
#' Neighborhoods for Hamilton County defined in [CAGIS](http://cagismaps.hamilton-co.org/cagisportal) [Open Data](http://cagis.org/Opendata/?)

#' Cincinnati Community Council (CCC) Neighborhoods
#' @rdname Neighborhoods
"neigh_ccc"

#' Cincinnati Statistical Neighborhood Approximations (SNA)
#' @rdname Neighborhoods
"neigh_sna"

#' Neighborhoods (CCHMC)
#'
#' Neighborhood derived from CCHMC internally-used lookup table for
#' 2010 census tract identifier to neighborhood
#' @source See `data-raw/hamilton_tract_to_cincy_neighborhood.csv`
"neigh_cchmc"

#' CODEC Counties
#' @rdname Counties
"codec_counties"

