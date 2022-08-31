# add documentation
get_county_grouping <- function(grouping = "7-county catchment") {
  grouping <- rlang::arg_match(grouping, c("healthvine",
                                           "healthvine OH-KY-IN",
                                           "8-county catchment",
                                           "7-county catchment",
                                           "southwestern ohio"))

  if(grouping == "7-county catchment") {
    codec_counties |> dplyr::filter(county_name %in% c("Hamilton", "Butler", "Clermont", "Warren",
                                                 "Kenton", "Campbell", "Boone"))
  } else if (grouping == "8-county catchment") {
    codec_counties |> dplyr::filter(county_name %in% c("Hamilton", "Butler", "Clermont", "Warren",
                                                 "Kenton", "Campbell", "Boone", "Dearborn"))
  } else if (grouping == "southwestern ohio") {
    codec_counties |> dplyr::filter(county_name %in% c("Hamilton", "Butler", "Clermont", "Warren"))
  } else if (grouping == "healthvine") {
    codec_counties |> dplyr::filter(county_name %in% c("Adams", "Brown", "Butler", "Clermont", "Clinton",
                                                 "Hamilton", "Highland", "Warren"))
  } else if (grouping == "healthvine OH-KY-IN") {
    codec_counties |> dplyr::filter(county_name %in% c("Adams", "Brown", "Butler", "Clermont", "Clinton",
                                                 "Hamilton", "Highland", "Warren",
                                                 "Dearborn", "Ripley", "Franklin",
                                                 "Boone", "Campbell", "Grant", "Kenton"))
  }
}
