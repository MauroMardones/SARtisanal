#' Calculates the Euclidean distance in meters using the Haversine formula
#'
#' This function computes the distance between two geographical points specified by
#' their latitude and longitude coordinates using the Haversine formula, which accounts
#' for the curvature of the Earth.
#'
#' @param lat1 Latitude of point 1 (in degrees).
#' @param lon1 Longitude of point 1 (in degrees).
#' @param lat2 Latitude of point 2 (in degrees).
#' @param lon2 Longitude of point 2 (in degrees).
#'
#' @return The calculated distance in meters.
#' @export
#'
#' @examples
#' # Example usage:
#' # Distance between two points: (lat1, lon1) and (lat2, lon2)
#' distancia <- distart(
#'   40.7128, -74.0060,  # New York coordinates
#'   34.0522, -118.2437  # Los Angeles coordinates
#' )
#' print(distancia)  # Distance between New York and Los Angeles
distart <- function(lat1, lon1, lat2, lon2) {
  # Haversine formula
  R <- 6371000  # Radius of the Earth in meters
  lat1_rad <- lat1 * pi / 180
  lon1_rad <- lon1 * pi / 180
  lat2_rad <- lat2 * pi / 180
  lon2_rad <- lon2 * pi / 180

  dlat <- lat2_rad - lat1_rad
  dlon <- lon2_rad - lon1_rad
  a <- sin(dlat / 2)^2 + cos(lat1_rad) * cos(lat2_rad) * sin(dlon / 2)^2
  c <- 2 * atan2(sqrt(a), sqrt(1 - a))

  DISTANCIA <- R * c  # Distance in meters
  return(DISTANCIA)
}



