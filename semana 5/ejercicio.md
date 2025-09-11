# Alerta de Baja Ley en Lotes de Mineral

## Contexto:

En una operación minera, el mineral extraído se almacena en lotes antes de ser procesado. Cada lote tiene una "ley" (concentración) del mineral. Una ley baja puede hacer que el lote no sea rentable para procesar. Tu trabajo es revisar cada lote e identificar aquellos con una ley por debajo de un umbral específico.

## Datos de los Lotes:

Crea un vector con las leyes de los últimos lotes (la ley se mide en porcentaje).
leyes_lotes <- c(0.8, 1.2, 0.5, 1.5, 0.9, 0.6, 2.1, 1.0)

## Problema a Resolver:
Escribe un script en R para:
1. Establecer un umbral de ley mínima de 1.0% en una variable llamada umbral_ley.
2. Recorrer cada una de las leyes en el vector leyes_lotes usando un ciclo.
3. Comparar cada ley con el umbral_ley usando una condición if.
4. Si la ley es menor que el umbral, imprime un mensaje de alerta indicando el valor de la ley del lote y su posición (índice) en el vector.
## Sugerencia:
• Para obtener el índice dentro del bucle, puedes usar la función seq_along(), que genera una secuencia de números del 1 al largo del vector.
• El paste() puede ser muy útil para crear mensajes claros.