#' Process Artisanal Fishing Effort Data by Grid Cell
#'
#' This function processes artisanal fishing effort data by grid cell, including filtering data,
#' creating a spatial grid, and counting the number of times vessels pass through each cell.
#'
#' @param data A data frame containing artisanal fishing effort data.
#' @param lon_col Character. The name of the longitude column in `data` (default is `"N_LONGITUD"`).
#' @param lat_col Character. The name of the latitude column in `data` (default is `"N_LATITUD"`).
#' @param cell_size Numeric. The size of each cell in degrees for the grid (default is 0.02).
#' @return A spatial data frame (`sf`) with grid cells and the count of vessel passages per cell.
#' @export
#' @import dplyr sf
#' @examples
#' # Crear un conjunto de datos de ejemplo
#' data <- data.frame(
#'   N_LONGITUD = c(-71.3, -71.5, -71.4, -71.3),
#'   N_LATITUD = c(-33.5, -33.6, -33.5, -33.6)
#' )
#'
#' # Aplicar la función
#' processed_data <- count_art_trawl(
#'   data, lon_col = "N_LONGITUD", lat_col = "N_LATITUD", cell_size = 0.02
#' )
count_art_trawl <- function(data, lon_col = "N_LONGITUD", lat_col = "N_LATITUD", cell_size = 0.02) {

  # 1. Filter and validate data using the dynamic column names
  data_valid <- data %>%
    filter(!is.na(.data[[lon_col]]) & !is.na(.data[[lat_col]]))

  # 2. Define study area boundaries
  min_long <- min(data_valid[[lon_col]], na.rm = TRUE)
  max_long <- max(data_valid[[lon_col]], na.rm = TRUE)
  min_lat <- min(data_valid[[lat_col]], na.rm = TRUE)
  max_lat <- max(data_valid[[lat_col]], na.rm = TRUE)

  # 3. Create spatial grid based on the bounding box and specified cell size
  bbox <- st_as_sfc(st_bbox(c(xmin = min_long, xmax = max_long, ymin = min_lat, ymax = max_lat), crs = 4326))
  grid <- bbox %>%
    sf::st_make_grid(cellsize = c(cell_size, cell_size)) %>%
    sf::st_cast("MULTIPOLYGON") %>%
    sf::st_sf() %>%
    dplyr::mutate(cellid = row_number())

  # 4. Convert data to spatial points and join with grid cells
  data_sf <- st_as_sf(data_valid, coords = c(lon_col, lat_col), crs = 4326)

  # Re-check that both objects are `sf` for spatial join
  if (!inherits(data_sf, "sf") || !inherits(grid, "sf")) {
    stop("Both data_sf and grid must be spatial (sf) objects for spatial join.")
  }

  # 5. Count the number of vessel passages per cell
  passages_per_cell <- st_join(data_sf, grid) %>%
    group_by(.data$cellid) %>%
    summarize(count_passages = n(), .groups = "drop") %>%
    distinct(.data$cellid, .keep_all = TRUE) %>%
    st_as_sf()

  # 6. Check for missing data after join
  if (nrow(passages_per_cell) == 0) {
    stop("No data available for plotting. Verify data join.")
  }

  # 7. Join grid geometry with passages count
  grid <- grid %>%
    mutate(cellid = as.integer(.data$cellid)) %>%
    st_join(passages_per_cell)

  # 8. Return the processed spatial data frame with passage counts
  return(grid)
}
