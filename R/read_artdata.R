#' Reads and combines multiple data files, retaining the source of each file
#'
#' This function reads multiple text files located in a specific folder, adds a column
#' indicating the source file, and then combines them into a single data frame.
#'
#' @param archivos Un vector de nombres de archivos (por ejemplo, "archivo1.txt", "archivo2.txt", ...).
#' @param carpeta La ruta de la carpeta donde se encuentran los archivos.
#' @param sep El separador de los archivos (por ejemplo, `","` para coma, `";"` para punto y coma, o `" "` para espacio).
#'            Este separador se aplica a todos los archivos.
#' @param header Lógico, TRUE si los archivos tienen encabezado.
#'
#' @return Un data frame con todos los archivos combinados, incluyendo una columna "archivo_origen" que indica
#' el archivo de origen para cada fila.
#' @export
#' @importFrom utils read.table
#'
#' @examples
#' archivos <- c("Draga_01.txt", "Draga_02.txt", "Draga_03.txt")
#' carpeta <- "ruta/a/tu/carpeta"
#' # Verificar que todos los archivos existen antes de ejecutar la función
#' if (all(file.exists(file.path(carpeta, archivos)))) {
#'   datos_combinados <- read_artdata(archivos, carpeta, sep = ",")
#'   print(datos_combinados)
#' } else {
#'   warning("Uno o más archivos no se encuentran en la carpeta especificada.")
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

