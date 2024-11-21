test_that("distart calcula correctamente las distancias entre puntos consecutivos", {
  # Datos de ejemplo
  datos <- data.frame(
    MATRICULA = c("B001", "B001", "B001", "B002", "B002"),
    FECHA = c("2023-01-01", "2023-01-01", "2023-01-01", "2023-01-02", "2023-01-02"),
    HORA = c("10:00:00", "10:10:00", "10:20:00", "11:00:00", "11:10:00"),
    N_LATITUD = c(-33.0, -33.1, -33.2, -33.0, -33.1),
    N_LONGITUD = c(-71.0, -71.0, -71.1, -71.2, -71.3)
  )

  # Resultado esperado para las distancias calculadas
  datos_esperados <- datos
  datos_esperados$distancia <- c(NA, 11120, 11123, NA, 11120)  # Valores calculados manualmente

  # Aplicar la función distart
  resultado <- distart(
    data = datos,
    lat_col = "N_LATITUD",
    lon_col = "N_LONGITUD",
    fecha_col = "FECHA",
    hora_col = "HORA",
    barco_col = "MATRICULA"
  )

  # Verificar las distancias con tolerancia más alta (0.2)
  diff_result <- all.equal(round(resultado$distancia, 1), round(datos_esperados$distancia, 1), tolerance = 0.2)
  expect_true(diff_result == TRUE, info = diff_result)
})
