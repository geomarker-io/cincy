#' @importFrom sf st_as_sf
NULL

#' ZCTAs
#'
#' [ZIP Code Tabulation Areas (ZCTAs)](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/zctas.html)
#' for Ohio that (at least partially) intersect with Hamilton County from 2000, 2010, and 2020.
#' @source ZCTAs were downloaded directly from the Census Bureau using the [tigris](https://github.com/walkerke/tigris) package

#' ZCTA (2000 TIGER/Line)
#' @rdname ZCTAs
"zcta_tigris_2000"

#' ZCTA (2010 TIGER/Line)
#' @rdname ZCTAs
"zcta_tigris_2010"

#' ZCTA (2020 TIGER/Line)
#' @rdname ZCTAs
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

#' Neighborhood: Cincinnati Community Council (CCC)
#' @source [CAGIS](http://cagismaps.hamilton-co.org/cagisportal)
#' [Open Data](http://cagis.org/Opendata/?) Community Council (CCC) Neighborhoods
"neigh_ccc"

#' Neighborhood: Statistical Neighborhood Approximations (SNA)
#' @source [CAGIS](http://cagismaps.hamilton-co.org/cagisportal)
#' [Open Data](http://cagis.org/Opendata/?) Community Council (CCC) Neighborhoods
"neigh_sna"

#' Neighborhood: CCHMC
#' @source See `data-raw/hamilton_tract_to_cincy_neighborhood.csv` for tract to neighborhood lookup table
"neigh_cchmc_2010"

#' Deprivation Index
#' 
#' An example census tract-level dataset.  A simple features object of all census tracts in
#' Hamilton County, OH with values for the 2018 deprivation index and its six components.
#' @source The [2018 deprivation_index](https://geomarker.io/dep_index/2018_dep_index/). See `data-raw/make_dep_index_data.R`.
"dep_index"

#' Counties: Southwest Ohio
#'
#' County groupings are derived from CCHMC operational definitions
#' @source see data-raw/data.R for county FIPS listed for each grouping
#' @format
#' A simple features data frame with 4 rows and 6 columns:
#' \describe{
#'   \item{county_name}{County Name}
#'   \item{county_id}{County ID}
#'   \item{state_name}
#'   \item{state_id}
#'   \item{geoid}{GEOID (state_id + county_id)}
#'   \item{geometry} simple features geometry column
#' }
#' @examples
#' plot(county_swoh_2010["county_name"], key.pos = 1)
"county_swoh_2010"

#' Counties: Healthvine
#'
#' County groupings are derived from CCHMC operational definitions
#' @source see data-raw/data.R for county FIPS listed for each grouping
#' @format
#' A simple features data frame with 15 rows and 6 columns:
#' \describe{
#'   \item{county_name}{County Name}
#'   \item{county_id}{County ID}
#'   \item{state_name}
#'   \item{state_id}
#'   \item{geoid}{GEOID (state_id + county_id)}
#'   \item{geometry} simple features geometry column
#' }
#' @examples
#' plot(county_hlthv_2010["county_name"], key.pos = 1)
"county_hlthv_2010"

#' Counties: Healthvine (in Ohio)
#'
#' County groupings are derived from CCHMC operational definitions
#' @source see data-raw/data.R for county FIPS listed for each grouping
#' @format
#' A simple features data frame with 8 rows and 6 columns:
#' \describe{
#'   \item{county_name}{County Name}
#'   \item{county_id}{County ID}
#'   \item{state_name}
#'   \item{state_id}
#'   \item{geoid}{GEOID (state_id + county_id)}
#'   \item{geometry} simple features geometry column
#' }
#' @examples
#' plot(county_hlthvoh_2010["county_name"], key.pos = 1)
"county_hlthvoh_2010"

#' Counties: 7 County Region
#'
#' County groupings are derived from CCHMC operational definitions
#' @source see data-raw/data.R for county FIPS listed for each grouping
#' @format
#' A simple features data frame with 7 rows and 6 columns:
#' \describe{
#'   \item{county_name}{County Name}
#'   \item{county_id}{County ID}
#'   \item{state_name}
#'   \item{state_id}
#'   \item{geoid}{GEOID (state_id + county_id)}
#'   \item{geometry} simple features geometry column
#' }
#' @examples
#' plot(county_7cc_2010["county_name"], key.pos = 1)
"county_7cc_2010"

#' Counties: 8 County Region
#'
#' County groupings are derived from CCHMC operational definitions
#' @source see data-raw/data.R for county FIPS listed for each grouping
#' @format
#' A simple features data frame with 8 rows and 6 columns:
#' \describe{
#'   \item{county_name}{County Name}
#'   \item{county_id}{County ID}
#'   \item{state_name}
#'   \item{state_id}
#'   \item{geoid}{GEOID (state_id + county_id)}
#'   \item{geometry} simple features geometry column
#' }
#' @examples
#' plot(county_8cc_2010["county_name"], key.pos = 1)
"county_8cc_2010"
