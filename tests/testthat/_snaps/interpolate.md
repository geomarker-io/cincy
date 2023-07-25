# interpolate

    Code
      dep_index_zcta
    Output
      Simple feature collection with 57 features and 8 fields
      Geometry type: MULTIPOLYGON
      Dimension:     XY
      Bounding box:  xmin: 953086.2 ymin: 1838813 xmax: 1010799 ymax: 1893846
      Projected CRS: NAD83(NSRS2007) / Conus Albers
      First 10 features:
         zcta_2010 fraction_assisted_income fraction_high_school_edu median_income
      1      45212               0.16410340                0.8421591      41301.12
      2      45204               0.40392778                0.7188268      25610.82
      3      45233               0.05260831                0.9309801      73058.66
      4      45216               0.27370364                0.7629741      33608.34
      5      45232               0.59374952                0.8475034      17231.43
      6      45251               0.14625964                0.8819390      57341.77
      7      45248               0.04986687                0.9435518      70346.04
      8      45215               0.15621395                0.8797299      58340.53
      9      45237               0.28496845                0.8737642      38110.11
      10     45240               0.14777140                0.9011510      52384.24
         fraction_no_health_ins fraction_poverty fraction_vacant_housing dep_index
      1              0.13237246       0.21703724              0.14662980 0.4261084
      2              0.18178607       0.42233918              0.25960964 0.6255437
      3              0.05037956       0.07854548              0.04275884 0.2599869
      4              0.16482487       0.24193363              0.16659043 0.5053800
      5              0.10067324       0.58286395              0.10035867 0.6427537
      6              0.11147235       0.11984921              0.07695121 0.3512824
      7              0.04933190       0.07368119              0.04908251 0.2578271
      8              0.09772376       0.15255358              0.10919115 0.3613932
      9              0.10532802       0.22753371              0.13103628 0.4436879
      10             0.10666545       0.15150728              0.08100371 0.3589110
                               geometry
      1  MULTIPOLYGON (((985627.7 18...
      2  MULTIPOLYGON (((977449.5 18...
      3  MULTIPOLYGON (((964704.8 18...
      4  MULTIPOLYGON (((983383.5 18...
      5  MULTIPOLYGON (((980269.4 18...
      6  MULTIPOLYGON (((970337.7 18...
      7  MULTIPOLYGON (((971363.4 18...
      8  MULTIPOLYGON (((983611.1 18...
      9  MULTIPOLYGON (((984422.1 18...
      10 MULTIPOLYGON (((976570 1863...

---

    Code
      dep_index_neigh
    Output
      Simple feature collection with 81 features and 9 fields
      Geometry type: GEOMETRY
      Dimension:     XY
      Bounding box:  xmin: 953086.2 ymin: 1838813 xmax: 1001233 ymax: 1869107
      Projected CRS: NAD83(NSRS2007) / Conus Albers
      # A tibble: 81 x 10
         neighborhood_2010                             geometry fraction_assisted_in~1
         <chr>                                   <GEOMETRY [m]>                  <dbl>
       1 Amberley              MULTIPOLYGON (((989336.8 185733~                 0.177 
       2 Anderson Twp.-Newtown POLYGON ((994438.7 1840694, 994~                 0.0726
       3 Avondale              POLYGON ((982445.4 1848615, 982~                 0.319 
       4 Blue Ash              POLYGON ((991931.8 1862204, 991~                 0.0462
       5 Bond Hill             POLYGON ((984462.6 1853544, 984~                 0.280 
       6 Camp Washington       MULTIPOLYGON (((979160 1850484,~                 0.551 
       7 Carthage              MULTIPOLYGON (((982527.5 185578~                 0.274 
       8 Cheviot               POLYGON ((972072.9 1849665, 972~                 0.227 
       9 Clifton               POLYGON ((980429.9 1849893, 980~                 0.113 
      10 Colerain Twp.         POLYGON ((972927.5 1855604, 972~                 0.123 
      # i 71 more rows
      # i abbreviated name: 1: fraction_assisted_income
      # i 7 more variables: fraction_high_school_edu <dbl>, median_income <dbl>,
      #   fraction_no_health_ins <dbl>, fraction_poverty <dbl>,
      #   fraction_vacant_housing <dbl>, dep_index <dbl>, n_things <dbl>

# interpolate keeps metadata

    Code
      codec::glimpse_tdr(hamilton_landcover_zcta)
    Output
      $attributes
      # A tibble: 6 x 2
        name     value                                                          
        <chr>    <chr>                                                          
      1 profile  tabular-data-resource                                          
      2 name     hamilton_landcover                                             
      3 path     hamilton_landcover.csv                                         
      4 version  0.1.0                                                          
      5 title    Hamilton County Landcover and Built Environment Characteristics
      6 homepage https://geomarker.io/hamilton_landcover                        
      
      $schema
      # A tibble: 6 x 4
        name                title                          description           type 
        <chr>               <chr>                          <chr>                 <chr>
      1 pct_green_2019      Percent Greenspace 2019        percent of pixels in~ numb~
      2 pct_impervious_2019 Percent Impervious 2019        average percent impe~ numb~
      3 pct_treecanopy_2016 Percent Treecanopy 2016        average percent tree~ numb~
      4 evi_2018            Enhanced Vegetation Index 2018 average enhanced veg~ numb~
      5 year                Year                           data year             inte~
      6 zcta_2010           Geography Identifier           <NA>                  stri~
      

