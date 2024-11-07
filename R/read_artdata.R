#' Reads and combines multiple .txt files, retaining the source of each file
#'
#' This function reads multiple .txt files located in a specific folder, adds a column
#' indicating the source file, and then combines them into a single data frame.
#'
#' @param archivos A vector of .txt file names (e.g., "archivo1.txt", "archivo2.txt", ...).
#' @param carpeta The folder path where the files are located.
#' @param sep The separator for .txt files (e.g., `","` for comma, `";"` for semicolon, or `" "` for space).
#' @param header Logical, TRUE if the files have a header.
#'
#' @return A data frame with all files combined, including a column "archivo_origen" that indicates
#' the source file for each row.
#' @export
#' @importFrom utils read.table
#'
#' @examples
#' # Example for reading multiple .txt files
#' archivos_txt <- c("archivo1.txt", "archivo2.txt", "archivo3.txt")
#' carpeta <- "ruta/a/tu/carpeta"
#' if (all(file.exists(file.path(carpeta, archivos_txt)))) {
#'   datos_txt <- read_artdata_txt(archivos_txt, carpeta, sep = "\t", header = TRUE)
#'   print(datos_txt)
#' } else {
#'   warning("One or more .txt files are not found in the specified folder.")
#' }
read_artdata <- function(archivos, carpeta, sep = ",", header = TRUE) {
  lista_datos <- list()
  for (archivo in archivos) {
    ruta <- file.path(carpeta, archivo)
    datos <- read.table(ruta, sep = sep, header = header)
    datos$archivo_origen <- archivo
    lista_datos[[archivo]] <- datos
  }
  datos_combinados <- do.call(rbind, lista_datos)
  return(datos_combinados)
}

