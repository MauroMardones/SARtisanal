#' Calcula la distancia euclideana en metros con información de los cuatro registros de latitud peor con diferentes tiempos
#'
#' @param lat1 point 1 Latitud
#' @param lon1 point 1 Longitud
#' @param lat2 point 2 Latitud
#' @param lon2 point 2 Longitud
#'
#' @return distancia calculada
#' @export
#'
#' @examples
#' # Ejemplo de uso:
#' # Distancia entre dos puntos: (lat1, lon1) y (lat2, lon2)
#' distancia <- distart(
#'   40.7128, -74.0060,
#'   34.0522, -118.2437
#' )  # Distancia entre Nueva York y Los Ángeles
#' print(distancia)
distart <- function(lat1, lon1, lat2, lon2) {
  lat1_rad <- lat1 * pi / 180
  lon1_rad <- lon1 * pi / 180
  lat2_rad <- lat2 * pi / 180
  lon2_rad <- lon2 * pi / 180
  radio_tierra <- 6371000
  dlat <- lat2_rad - lat1_rad
  dlon <- lon2_rad - lon1_rad
  a <- sin(dlat / 2)^2 + cos(lat1_rad) * cos(lat2_rad) * sin(dlon / 2)^2
  c <- 2 * atan2(sqrt(a), sqrt(1 - a))
  return(radio_tierra * c)
}
