library(dplyr)
# DATOS DE LECTURAS DE SENSORES EN BOMBAS DE EXTRACCIÓN
registros_bomba <- data.frame(
  id_bomba = c("B-01", "B-02", "B-03", "B-04", "B-05", "B-06", "B-07", "B-08"),
  tiempo_uso_hrs = c(150, 210, 85, 305, 120, 190, 250, 95),
  temperatura_max_c = c(78, 92, 70, 95, 80, 88, 102, 75),
  ubicacion = c("Norte", "Sur", "Norte", "Oeste", "Sur", "Oeste", "Norte", "Sur")
);

# Definir la temperatura crítica máxima
TEMP_CRITICA <- 90;

print(registros_bomba);

# datos
bombas_criticas <- registros_bomba %>%
  # 1 Filtrar: por las bombas que tienen temperatura mayor al umbral
  filter(temperatura_max_c > TEMP_CRITICA) %>%
  # 2 Seleccionar: solo las columnas relevantes
  select(id_bomba, temperatura_max_c, ubicacion) %>%
  # 3 Nueva Columna: Alarma
  mutate(estado = "Alarma!") %>%
  # 4 Ordenar: atentiendo la más crítica primero
  arrange(desc(temperatura_max_c))
  
print(bombas_criticas);
