#' Calcula el área barrida (SA) en función de la distancia y el ancho del arte de pesca.
#'
#' @param distancia Un vector que representa las distancias en metros.
#' @param ancho Un vector que representa el ancho del arte de pesca en metros.
#'              Debe ser del mismo tamaño que 'distancia' o un solo valor.
#'
#' @return Un vector con el área barrida calculada.
#' @export
#'
#' @examples
#' # Cálculo del área barrida con un ancho de 2.5 metros
#' distancias <- c(100, 200, 300)
#' area_barrida <- SAbarrida(distancias, ancho = 2.5)
#' area_barrida_pre <- SAbarrida(distancias, ancho = 2.5)
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
