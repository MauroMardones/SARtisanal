#' Calculates the Euclidean distance in meters using the Haversine formula
#'
#' Calculate Distance Between Consecutive Points of a Vessel
#'
#' This function calculates the distance between consecutive geographic points of the same vessel in a dataset,
#' using the Haversine formula to measure the distance in meters. It assigns `NA` when there is a change in date or vessel.
#'
#' @param data A data frame containing location and time data for the vessels.
#' @param lat_col Name of the latitude column (in decimal degrees).
#' @param lon_col Name of the longitude column (in decimal degrees).
#' @param fecha_col Name of the column containing the event date.
#' @param hora_col Name of the column containing the event time.
#' @param barco_col Name of the column identifying the vessel.
#'
#' @return A data frame that includes an additional column called `distance`, with the distance in meters between consecutive points of the same vessel on the same date. If there is a change of vessel or date, the value is `NA`.
#' @export
#'
#' @examples
#' # Example usage with a data frame named `artdata`
#' artdata_with_distances <- distart(
#'   data = artdata,
#'   lat_col = "N_LATITUD",
#'   lon_col = "N_LONGITUD",
#'   fecha_col = "FECHA",
#'   hora_col = "HORA",
#'   barco_col = "MATRICULA"
#' )
#' head(artdata_with_distances)
#'
distart <- function(data, lat_col, lon_col, fecha_col, hora_col, barco_col) {

  # Sub-función para calcular la distancia Haversine
  distart <- function(lat1, lon1, lat2, lon2) {
    R <- 6371000  # Radio de la Tierra en metros
    lat1_rad <- lat1 * pi / 180
    lon1_rad <- lon1 * pi / 180
    lat2_rad <- lat2 * pi / 180
    lon2_rad <- lon2 * pi / 180

    dlat <- lat2_rad - lat1_rad
    dlon <- lon2_rad - lon1_rad
    a <- sin(dlat / 2)^2 + cos(lat1_rad) * cos(lat2_rad) * sin(dlon / 2)^2
    c <- 2 * atan2(sqrt(a), sqrt(1 - a))
    return(R * c)  # distance mts
  }
   # Ordenar el data frame por embarcación, fecha y hora
  data <- data %>%
    arrange(!!sym(barco_col), !!sym(fecha_col), !!sym(hora_col))
  # Calcular la distancia usando mapply y asignar NA donde cambia la embarcación o la fecha
  data <- data %>%
    mutate(
      distancia = mapply(
        function(lat, lon, lat_lag, lon_lag, barco, barco_lag, fecha, fecha_lag) {
          if (is.na(barco_lag) || barco != barco_lag || fecha != fecha_lag) {
            return(NA)
          } else {
            return(distart(lat, lon, lat_lag, lon_lag))
          }
        },
        .[[lat_col]], .[[lon_col]],
        lag(.[[lat_col]]), lag(.[[lon_col]]),
        .[[barco_col]], lag(.[[barco_col]]),
        .[[fecha_col]], lag(.[[fecha_col]])
      )
    ) %>%
    mutate_if(is.numeric, round, 3)
  return(data)
}
