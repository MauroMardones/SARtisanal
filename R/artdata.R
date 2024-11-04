#' Fisheries Monitoring Data from "Green boxes"
#'
#' This dataset contains monitoring information from various fishing vessels,
#' including timestamps, geographic coordinates, and operational details.
#'
#' @format ## `artdata`
#' A data frame with 182,176 rows and 20 columns:
#' \describe{
#'   \item{FK_ERES}{Unique identifier for the fishing event}
#'   \item{FECHA}{Date of the fishing event (in character format)}
#'   \item{DIA}{Day of the week (in character format)}
#'   \item{HORA}{Time of the fishing event (in character format)}
#'   \item{FK_BUQUE}{Unique identifier for the fishing vessel}
#'   \item{MATRICULA}{Registration number of the fishing vessel}
#'   \item{PUERTO}{Port of departure or arrival (in character format)}
#'   \item{FK_TIPO_F}{Type of fishing activity (as a factor)}
#'   \item{F_LOCALIZA}{Locality identifier (in character format)}
#'   \item{N_LONGITUD}{Longitude of the vessel's position (in decimal degrees)}
#'   \item{N_LATITUD}{Latitude of the vessel's position (in decimal degrees)}
#'   \item{N_X}{X-coordinate in a projected coordinate system}
#'   \item{N_Y}{Y-coordinate in a projected coordinate system}
#'   \item{N_VELOCIDAD}{Speed of the vessel (in knots)}
#'   \item{N_RUMBO}{Heading of the vessel (in degrees)}
#'   \item{N_SATELITES}{Number of satellites used for position fixing}
#'   \item{N_EN_PUERTO}{Indicator if the vessel is in port (0 = No, 1 = Yes)}
#'   \item{L_BACKUP}{Backup indicator (0 or 1)}
#'   \item{FK_ACTIVI}{Activity type code}
#'   \item{FK_ESTADO}{Status code}
#'   \item{FK_MODAL}{Modal code of the fishing activity}
#' }
#' @source Internal monitoring system data
"artdata"
