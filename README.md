
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cincy

<!-- badges: start -->

[![R-CMD-check](https://github.com/geomarker-io/cincy/workflows/R-CMD-check/badge.svg)](https://github.com/geomarker-io/cincy/actions)
[![R-CMD-check](https://github.com/geomarker-io/cincy/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/geomarker-io/cincy/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The `cincy` package contains simple feature geographic polygon files
(`sf` objects) that define Cincinnati Neighborhood, Tract, County, and
ZIP Code Geographies.

#### Installing

``` r
# install.packages("remotes")
remotes::install_github("geomarker-io/cincy")
```

#### Data

Data objects are `data.frame`s of class `sf` and are named by geography,
source, and optionally vintage:

| name                  | geography | source  | vintage |
|:----------------------|:---------:|:-------:|:-------:|
| `zcta_tigris_2020`    |   zcta    | tigris  |  2020   |
| `zcta_tigris_2010`    |   zcta    | tigris  |  2010   |
| `zcta_tigris_2000`    |   zcta    | tigris  |  2000   |
| `tract_tigris_2020`   |   tract   | tigris  |  2020   |
| `tract_tigris_2010`   |   tract   | tigris  |  2010   |
| `tract_tigris_2000`   |   tract   | tigris  |  2000   |
| `neigh_sna`           |   neigh   |   sna   |         |
| `neigh_cchmc`         |   neigh   |  cchmc  |         |
| `neigh_ccc`           |   neigh   |   ccc   |         |
| `county_swoh_2010`    |  county   |  swoh   |  2010   |
| `county_hlthvts_2010` |  county   | hlthvts |  2010   |
| `county_hlthvoh_2010` |  county   | hlthvoh |  2010   |
| `county_hlthv_2010`   |  county   |  hlthv  |  2010   |
| `county_8cc_2010`     |  county   |   8cc   |  2010   |
| `county_7cc_2010`     |  county   |   7cc   |  2010   |

Use autocomplete functionality at the `R` prompt (e.g., typing `cincy::`
and pressing `TAB` twice) to find the needed `sf` object, narrowing
first based on geography (`tract`, `zcta`, `neigh`, `county`), then by
source, and then optionally by vintage.

Consult the help file for any object for more information on the data
within it:

``` r
?cincy::neigh_ccc
```

Or explore the data documentation online at
<https://geomarker.io/cincy/reference>

#### Examples

Data are returned as simple features objects.

``` r
library(sf)
```

    ## Linking to GEOS 3.11.0, GDAL 3.5.0, PROJ 9.0.1; sf_use_s2() is TRUE

For example, to get Cincinnati neighborhoods, as defined by the most
recent version of community council boundaries from CAGIS:

``` r
cincy::neigh_ccc
```

    ## Simple feature collection with 75 features and 1 field
    ## Geometry type: GEOMETRY
    ## Dimension:     XY
    ## Bounding box:  xmin: 964487.7 ymin: 1841115 xmax: 994472.8 ymax: 1859227
    ## Projected CRS: NAD83(NSRS2007) / Conus Albers
    ## First 10 features:
    ##                    neighborhood                          SHAPE
    ## 1                 Paddock Hills MULTIPOLYGON (((983858.2 18...
    ## 2          Corryville - Heights MULTIPOLYGON (((981244.3 18...
    ## 3            South Cumminsville MULTIPOLYGON (((978487 1850...
    ## 4     Avondale - North Avondale MULTIPOLYGON (((982119.8 18...
    ## 5                    Corryville MULTIPOLYGON (((981595.5 18...
    ## 6          Spring Grove Village MULTIPOLYGON (((978574 1854...
    ## 7            CUF - Mount Auburn MULTIPOLYGON (((981415.8 18...
    ## 8  Columbia Tusculum - East End MULTIPOLYGON (((987788.1 18...
    ## 9                 Mount Lookout MULTIPOLYGON (((988777.9 18...
    ## 10      Riverside - Sayler Park MULTIPOLYGON (((967897.7 18...

Or to get Cincinnati ZIP Codes, as defined by the Census Bureau as ZIP
Code Tabulation Areas (ZCTAs), from 2000:

``` r
cincy::zcta_tigris_2000
```

    ## Simple feature collection with 54 features and 1 field
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: 953086.2 ymin: 1838982 xmax: 1009435 ymax: 1872501
    ## Projected CRS: NAD83(NSRS2007) / Conus Albers
    ## First 10 features:
    ##     zcta                       geometry
    ## 1  45216 MULTIPOLYGON (((983383.5 18...
    ## 2  45174 MULTIPOLYGON (((998460.2 18...
    ## 3  45229 MULTIPOLYGON (((982399.6 18...
    ## 4  45217 MULTIPOLYGON (((982958.8 18...
    ## 5  45252 MULTIPOLYGON (((968113 1866...
    ## 6  45239 MULTIPOLYGON (((975836.3 18...
    ## 7  45243 MULTIPOLYGON (((998120.9 18...
    ## 8  45236 MULTIPOLYGON (((990543.7 18...
    ## 9  45220 MULTIPOLYGON (((979633.8 18...
    ## 10 45204 MULTIPOLYGON (((976776.5 18...

Alternatively, get the 2010 Counties in Cincinnati’s 7-county catchment
area:

``` r
cincy::county_7cc_2010
```

    ## Simple feature collection with 7 features and 5 fields
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: 949713.7 ymin: 1808108 xmax: 1025618 ymax: 1903358
    ## Projected CRS: NAD83(NSRS2007) / Conus Albers
    ##   county_name county_id state_name state_id geoid
    ## 1      Butler       017         OH       39 39017
    ## 2    Hamilton       061         OH       39 39061
    ## 3    Clermont       025         OH       39 39025
    ## 4      Warren       165         OH       39 39165
    ## 5      Kenton       117         KY       21 21117
    ## 6       Boone       015         KY       21 21015
    ## 7    Campbell       037         KY       21 21037
    ##                         geometry
    ## 1 MULTIPOLYGON (((968901.4 18...
    ## 2 MULTIPOLYGON (((954168.6 18...
    ## 3 MULTIPOLYGON (((1002941 186...
    ## 4 MULTIPOLYGON (((991479.4 18...
    ## 5 MULTIPOLYGON (((974627.4 18...
    ## 6 MULTIPOLYGON (((953225.9 18...
    ## 7 MULTIPOLYGON (((990745 1832...
