#' Remove duplicates from a data frame
#'
#' This function identifies and removes duplicate rows in a data frame that commonly occur in this type of records.
#' You can choose to remove duplicates while keeping only the last occurrence of each duplicated row.
#'
#' @param datos A data frame in which duplicates will be searched (for example, `artdata`).
#' @param mantener_ultima Logical, `TRUE` to keep the last occurrence of each duplicated row.
#'                        Defaults to `FALSE`, which keeps the first occurrence.
#'
#' @return A data frame without duplicate rows.
#' @export
#'
#' @examples
#' artdata_without_duplicates <- remo_dup(artdata, mantener_ultima = TRUE)
remo_dup <- function(datos, mantener_ultima = FALSE) {
  # Identificar filas duplicadas
  filas_duplicadas <- duplicated(datos, fromLast = mantener_ultima)
  # Filtrar para mantener solo las filas no duplicadas
  datos_sin_dup <- datos[!filas_duplicadas, ]
  return(datos_sin_dup)
}
