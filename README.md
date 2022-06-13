
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cincy

<!-- badges: start -->

[![R-CMD-check](https://github.com/geomarker-io/cincy/workflows/R-CMD-check/badge.svg)](https://github.com/geomarker-io/cincy/actions)
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

Objects are named by geography, source, and optionally vintage:

``` r
data(package = "cincy")$results[ , "Item"]
```

    ## [1] "neigh_ccc"         "neigh_cchmc"       "neigh_sna"        
    ## [4] "tract_tigris_2000" "tract_tigris_2010" "tract_tigris_2020"
    ## [7] "zcta_tigris_2000"  "zcta_tigris_2010"  "zcta_tigris_2020"

Use autocomplete functionality at the `R` prompt (e.g., typing `cincy::`
and pressing `TAB` twice) to find the needed `sf` object, narrowing
first based on geography (`tract`, `zcta`, `neigh`), source, and
optionally vintage.

Consult the help file for any object for more information on the data
within it:

``` r
?cincy::neigh_ccc
```

Or explore the dataset reference documentation online at
<https://geomarker.io/cincy/reference>

#### Examples

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

    ## Simple feature collection with 62 features and 1 field
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: 951927.2 ymin: 1825519 xmax: 1016173 ymax: 1893566
    ## Projected CRS: NAD83(NSRS2007) / Conus Albers
    ## First 10 features:
    ##     zcta                       geometry
    ## 1  45140 MULTIPOLYGON (((998848.1 18...
    ## 2  45216 MULTIPOLYGON (((983383.5 18...
    ## 3  45174 MULTIPOLYGON (((998460.2 18...
    ## 4  45229 MULTIPOLYGON (((982399.6 18...
    ## 5  45217 MULTIPOLYGON (((982958.8 18...
    ## 6  45252 MULTIPOLYGON (((968113 1866...
    ## 7  45040 MULTIPOLYGON (((992362.2 18...
    ## 8  45239 MULTIPOLYGON (((975836.3 18...
    ## 9  45243 MULTIPOLYGON (((998120.9 18...
    ## 10 45236 MULTIPOLYGON (((990543.7 18...
