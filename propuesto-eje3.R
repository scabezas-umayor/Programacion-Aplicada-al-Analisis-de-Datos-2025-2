registros_bomba <- data.frame(
  id_bomba = c("B-01", "B-02", "B-03", "B-04", "B-05", "B-06", "B-07", "B-08"),
  tiempo_uso_hrs = c(150, 210, 85, 305, 120, 190, 250, 95),
  temperatura_max_c = c(78, 92, 70, 95, 80, 88, 102, 75),
  ubicacion = c("Norte", "Sur", "Norte", "Oeste", "Sur", "Oeste", "Norte", "Sur")
)
# Definir la temperatura crítica máxima
TEMP_CRITICA <- 90

print(registros_bomba)

salida <- registros_bomba %>%
  filter(ubicacion == "Norte", tiempo_uso_hrs > 100) %>%
  mutate(margen_temp = temperatura_max_c - TEMP_CRITICA) %>%
  select(id_bomba, margen_temp, tiempo_uso_hrs) %>%
  arrange(desc(margen_temp)) %>%
  filter(margen_temp > 0)
print(salida)
