#' Process Artisanal Fishing Effort Data by Grid Cell
#'
#' This function processes artisanal fishing effort data by grid cell, including filtering data,
#' creating a spatial grid, calculating the average swept area (SA) per grid cell, and determining
#' each cell's area.
#'
#'
#' @param data A data frame containing artisanal fishing effort data.
#' @param lon_col Character. The name of the longitude column in `data` (default is `"N_LONGITUD"`).
#' @param lat_col Character. The name of the latitude column in `data` (default is `"N_LATITUD"`).
#' @param sa_col Character. The name of the swept area (SA) column in `data` (default is `"SA"`).
#' @param cell_size Numeric. The size of each cell in degrees for the grid (default is 0.02).
#' @return A spatial data frame (`sf`) with grid cells, average SA values, cell area, and SAR levels.
#' @export
#' @import dplyr sf
#' @examples
#' # Crear un conjunto de datos de ejemplo
#' data <- data.frame(
#'   N_LONGITUD = c(-71.3, -71.5),
#'   N_LATITUD = c(-33.5, -33.6),
#'   SA = c(0.1, 0.3)
#' )
#'
#' # Aplicar la función
#' processed_data <- process_art_effort(
#'   data, lon_col = "N_LONGITUD", lat_col = "N_LATITUD", sa_col = "SA", cell_size = 0.02
#' )
process_art_effort <- function(data, lon_col = "N_LONGITUD", lat_col = "N_LATITUD", sa_col = "SA", cell_size = 0.02) {

  # 1. Filter and validate data using the dynamic column names
  data_valid <- data %>%
    filter(!is.na(.data[[lon_col]]) & !is.na(.data[[lat_col]]) & !is.na(.data[[sa_col]]))

  # 2. Define study area boundaries
  min_long <- min(data_valid[[lon_col]], na.rm = TRUE)
  max_long <- max(data_valid[[lon_col]], na.rm = TRUE)
  min_lat <- min(data_valid[[lat_col]], na.rm = TRUE)
  max_lat <- max(data_valid[[lat_col]], na.rm = TRUE)

  # 3. Create spatial grid based on the bounding box and specified cell size
  bbox <- st_as_sfc(st_bbox(c(xmin = min_long, xmax = max_long, ymin = min_lat, ymax = max_lat), crs = 4326))
  grid <- bbox %>%
    sf::st_make_grid(cellsize = c(0.02, 0.02)) %>%
    sf::st_cast("MULTIPOLYGON") %>%
    sf::st_sf() %>%
    dplyr::mutate(cellid = row_number())

  # 4. Convert data to spatial points and join with grid cells
  data_sf <- st_as_sf(data_valid, coords = c(lon_col, lat_col), crs = 4326)

  # Re-check that both objects are `sf` for spatial join
  if (!inherits(data_sf, "sf") || !inherits(grid, "sf")) {
    stop("Both data_sf and grid must be spatial (sf) objects for spatial join.")
  }

  avg_SA_per_cell <- st_join(data_sf, grid) %>%
    group_by(cellid) %>%
    summarize(promedio_SA = mean(.data[[sa_col]], na.rm = TRUE), .groups = "drop") %>%
    distinct(cellid, .keep_all = TRUE)  %>%
    st_as_sf()

  # 5. Check for missing data after join
  if (nrow(avg_SA_per_cell) == 0) {
    stop("No data available for plotting. Verify data join.")
  }

  # 6. Join grid geometry with average SA data, adding cell area and SAR levels
  grid <- grid %>%
    mutate(cellid = as.integer(cellid),
           area_celda = as.numeric(st_area(.)))  %>%
    st_join(avg_SA_per_cell) %>%
    mutate(SAR = (promedio_SA / area_celda) * 100)

  # 7. Return the processed spatial data frame
  return(grid)
}


