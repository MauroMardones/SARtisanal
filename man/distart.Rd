% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/distart.R
\name{distart}
\alias{distart}
\title{Calculates the Euclidean distance in meters using the Haversine formula}
\usage{
distart(data, lat_col, lon_col, fecha_col, hora_col, barco_col)
}
\arguments{
\item{data}{A data frame containing location and time data for the vessels.}

\item{lat_col}{Name of the latitude column (in decimal degrees).}

\item{lon_col}{Name of the longitude column (in decimal degrees).}

\item{fecha_col}{Name of the column containing the event date.}

\item{hora_col}{Name of the column containing the event time.}

\item{barco_col}{Name of the column identifying the vessel.}
}
\value{
A data frame that includes an additional column called \code{distance}, with the distance in meters between consecutive points of the same vessel on the same date. If there is a change of vessel or date, the value is \code{NA}.
}
\description{
Calculate Distance Between Consecutive Points of a Vessel
}
\details{
This function calculates the distance between consecutive geographic points of the same vessel in a dataset,
using the Haversine formula to measure the distance in meters. It assigns \code{NA} when there is a change in date or vessel.
}
\examples{
# Example usage with a data frame named `artdata`
artdata_with_distances <- distart(
  data = artdata,
  lat_col = "N_LATITUD",
  lon_col = "N_LONGITUD",
  fecha_col = "FECHA",
  hora_col = "HORA",
  barco_col = "MATRICULA"
)
head(artdata_with_distances)

}
