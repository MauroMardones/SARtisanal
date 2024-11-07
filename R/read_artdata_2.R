#' Reads and combines multiple .csv files, retaining the source of each file
#'
#' This function reads multiple .csv files located in a specific folder, adds a column
#' indicating the source file, and then combines them into a single data frame.
#'
#' @param archivos A vector of .csv file names (e.g., "archivo1.csv", "archivo2.csv", ...).
#' @param carpeta The folder path where the files are located.
#' @param sep The separator for .csv files (e.g., `","` for comma, `";"` for semicolon).
#' @param header Logical, TRUE if the files have a header.
#'
#' @return A data frame with all files combined, including a column "archivo_origen" that indicates
#' the source file for each row.
#' @export
#' @importFrom utils read.csv
#'
#' @examples
#' # Example for reading multiple .csv files
#' archivos_csv <- c("archivo1.csv", "archivo2.csv", "archivo3.csv")
#' carpeta <- "ruta/a/tu/carpeta"
#' if (all(file.exists(file.path(carpeta, archivos_csv)))) {
#'   datos_csv <- read_artdata_csv_2(archivos_csv, carpeta, sep = ",", header = TRUE)
#'   print(datos_csv)
#' } else {
#'   warning("One or more .csv files are not found in the specified folder.")
#' }
read_artdata_2 <- function(archivos, carpeta, sep = ",", header = TRUE) {
  lista_datos <- list()

  for (archivo in archivos) {
    ruta <- file.path(carpeta, archivo)
    datos <- read.csv(ruta, sep = sep, header = header)
    datos$archivo_origen <- archivo
    lista_datos[[archivo]] <- datos
  }

  datos_combinados <- do.call(rbind, lista_datos)
  return(datos_combinados)
}
