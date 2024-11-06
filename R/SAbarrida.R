#' Calculates the Swept Area (SA) based on distance and the width of the fishing gear.
#'
#' @param distancia A vector representing distances in meters.
#' @param ancho A vector representing the width of the fishing gear in meters.
#'              It must be the same size as 'distancia' or a single value.
#'
#' @return A vector with the calculated swept area.
#' @export
#'
#' @examples
#' # Calculate the swept area with a width of 2.5 meters
#' distancia <- c(100, 200, 300)
#' swept_area <- SAbarrida(distancia, ancho = 2.5)
#' swept_area_pre <- SAbarrida(distancia, ancho = 2.5)
SAbarrida <- function(distancia, ancho) {
    if (length(ancho) == 1) {
    ancho <- rep(ancho, length(distancia))  # Expandir a largo de distancia
  }
  if (length(distancia) != length(ancho)) {
    stop("Los vectores 'distancia' y 'ancho' deben tener la misma longitud.")
  }
  # Calcular el área barrida
  SAbarrida <- distancia * ancho
  return(SAbarrida)
}
