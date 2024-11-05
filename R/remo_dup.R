#' Elimina duplicados de un data frame
#'
#' Esta función identifica y elimina filas duplicadas en un data frame que comunente aparecen en este tipo de registros. Se puede optar por eliminar
#' los duplicados manteniendo solo la última ocurrencia de cada fila duplicada.
#'
#' @param datos Un data frame en el que se buscarán duplicados (por ejemplo, `artdata`).
#' @param mantener_ultima Lógico, `TRUE` para mantener la última ocurrencia de cada fila duplicada.
#'                        Por defecto es `FALSE`, lo que mantiene la primera ocurrencia.
#'
#' @return Un data frame sin filas duplicadas.
#' @export
#'
#' @examples
#' artdata_sin_duplicados <- remo_dup(artdata, mantener_ultima = TRUE)
remo_dup <- function(datos, mantener_ultima = FALSE) {
  # Identificar filas duplicadas
  filas_duplicadas <- duplicated(datos, fromLast = mantener_ultima)
  # Filtrar para mantener solo las filas no duplicadas
  datos_sin_dup <- datos[!filas_duplicadas, ]
  return(datos_sin_dup)
}
