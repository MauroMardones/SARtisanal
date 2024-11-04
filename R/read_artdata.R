#' Lee y combina múltiples archivos de datos, manteniendo el origen de cada archivo
#'
#' Esta función lee múltiples archivos de texto ubicados en una carpeta específica, agrega una columna
#' indicando el archivo de origen y luego los combina en un único data frame.
#'
#' @param archivos Un vector de nombres de archivos (por ejemplo, "archivo1.txt", "archivo2.txt", ...).
#' @param carpeta La ruta de la carpeta donde se encuentran los archivos.
#' @param sep El separador utilizado en los archivos de texto (por defecto es ";").
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
#' if (all(file.exists(file.path(carpeta, archivos)))) {
#'   datos_combinados <- read_artdata(archivos, carpeta, sep = ",")
#' }
read_artdata <- function(archivos, carpeta, sep = ";", header = TRUE) {
  # Lista para almacenar los datos de cada archivo
  lista_datos <- list()
  # Ciclo para leer cada archivo y guardarlo en la lista con una columna adicional "archivo_origen"
  for (archivo in archivos) {
    # Construir la ruta completa del archivo
    ruta <- file.path(carpeta, archivo)
    # Leer el archivo
    datos <- read.table(ruta, sep = sep, header = header)
    # Agregar columna "archivo_origen" con el nombre del archivo
    datos$archivo_origen <- archivo
    # Agregar los datos a la lista
    lista_datos[[archivo]] <- datos
  }
  # Combinar todos los data frames en uno solo
  datos_combinados <- do.call(rbind, lista_datos)
  return(datos_combinados)
}

