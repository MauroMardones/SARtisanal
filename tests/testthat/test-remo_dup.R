test_that("remo_dup elimina duplicados correctamente", {
  # Datos de ejemplo
  datos <- data.frame(
    id = c(1, 2, 2, 3, 4, 4),
    valor = c("a", "b", "b", "c", "d", "d")
  )

  # Caso 1: mantener la primera ocurrencia (por defecto)
  resultado_primero <- remo_dup(datos)
  esperado_primero <- data.frame(
    id = c(1, 2, 3, 4),
    valor = c("a", "b", "c", "d")
  )
  # Ignorar los índices de fila al comparar
  row.names(resultado_primero) <- NULL
  row.names(esperado_primero) <- NULL
  expect_equal(resultado_primero, esperado_primero)

  # Caso 2: mantener la última ocurrencia
  resultado_ultimo <- remo_dup(datos, mantener_ultima = TRUE)
  esperado_ultimo <- data.frame(
    id = c(1, 2, 3, 4),
    valor = c("a", "b", "c", "d")
  )
  row.names(resultado_ultimo) <- NULL
  row.names(esperado_ultimo) <- NULL
  expect_equal(resultado_ultimo, esperado_ultimo)
})
