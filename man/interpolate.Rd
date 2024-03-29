% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/interpolate.R
\name{interpolate}
\alias{interpolate}
\title{Spatially interpolate community-level data}
\usage{
interpolate(from, to, weights = c("pop", "homes", "area"))
}
\arguments{
\item{from}{sf object with a neighborhood, census tract, census block group, census block,
or zcta column and numeric values to be interpolated into target geographies. The \code{from}
object should be CRS 5072. If not, it will be projected to 5072 for interpolation.}

\item{to}{sf object of target geography This function is designed to work with
cincy:: geography objects, and \code{to} objects must be CRS 5072.}

\item{weights}{use one of "pop" (population), "homes", or "area" from the
2020 census block estimates to interpolate the values}
}
\description{
Weights at the census block-level are used to spatially interpolate different geographies.
Block-level total population, total number of homes, or total area from the 2020 Census
can be chosen to use for the weights.
All \emph{numeric} variables in \code{from} are interpolated \emph{non-extensively},
except for any numeric variables that start with \code{n_}, which are interpolated
\emph{extensively}.
}
\details{
Possible geography id column names include "neighborhood", "zcta",
"census_tract_id", "census_block_id", "census_block_group_id", and "district".
Optionally, the column names can be appended with the census decade vintage "_2000",
"_2010", or "_2000" ("district" vintages include "_2011" and "_2013").
}
\examples{
# interpolate 2018 deprivation index to ZIP code level
interpolate(dep_index, cincy::zcta_tigris_2010, "pop")
# interpolate 2018 deprivation index to  2020 census tracts
interpolate(dep_index, cincy::tract_tigris_2020, "pop")
}
