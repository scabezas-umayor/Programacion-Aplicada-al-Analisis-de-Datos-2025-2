# Programacion-Aplicada-al-Analisis-de-Datos-2025-2
2025 Segundo Semestre | Programación Aplicada al Análisis de Datos

## Habilitación de R de Google Colab

1. Ir a: https://colab.research.google.com/
2. El primer código debe ser:
```R
%load_ext rpy2.ipython
```
3. Todos los códigos que continúen deben tener en la primera línea ***%%R***.
```R
%%R
```

### Prueba en Google Colab

```R
%load_ext rpy2.ipython
```
Insertar nuevo código
```R
%%R
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
```