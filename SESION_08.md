# Sesión 8: Regresión Lineal, Repaso para la Prueba

*(Pre-requisito: Asegúrese de tener los paquetes `readr`, `dplyr` y `ggplot2` instalados, y los archivos `datos_ventas.csv` y `datos_notas.csv` en su carpeta de proyecto).*

## 8.1 Introducción a la Regresión Lineal Simple (RLS)

### 💡 Explicación del Concepto

En la Sesión 7, la **Correlación** nos dijo *si* existía una relación entre dos variables y qué *tan fuerte* era (un número entre -1 y 1).

La **Regresión Lineal** va un paso más allá: nos da una **fórmula matemática (un modelo)** para *describir* y *predecir* esa relación.

**Regresión Lineal Simple (RLS):** Involucra solo dos variables numéricas:
* **Variable Independiente (X):** La variable que usamos para predecir (la *causa* supuesta, ej. `Precio`).
* **Variable Dependiente (Y):** La variable que queremos predecir (el *efecto* supuesto, ej. `Stock`).

El objetivo es encontrar la **línea recta** que mejor se ajusta a los datos (la misma que vimos con `geom_smooth(method="lm")`).

La ecuación de esa línea es:
$Y = \beta_0 + \beta_1 X + \epsilon$

* $Y$: El valor predicho de la variable dependiente.
* $X$: El valor de la variable independiente.
* $\beta_0$ (**Intercepto**): El valor de $Y$ cuando $X$ es 0. (El punto donde la línea cruza el eje Y).
* $\beta_1$ (**Pendiente** o Coeficiente): El "corazón" del modelo. Nos dice: "por cada **unidad** que aumenta $X$, ¿cuánto cambia $Y$?".
* $\epsilon$ (Épsilon, el **Error** o Residual): La diferencia entre el valor real y la predicción del modelo. El objetivo es minimizar este error.

En R, la función es `lm()` (Linear Model). La sintaxis se escribe con una fórmula: `lm(Y ~ X, data = mi_dataframe)`. La tilde (`~`) se lee "es explicada por".

### 💻 Ejemplos de Código en R

```r
# --- Preparación: Cargar paquetes y datos ---
library(readr)
library(dplyr)
ventas <- read_csv("datos_ventas.csv")
# ---------------------------------------------

# Ejemplo 1: Ecuación
# Queremos predecir el Stock (Y) usando el Precio (X).
# La fórmula es: Stock = B0 + (B1 * Precio) + error
````

```r
# Ejemplo 2: Ajuste del Modelo en R con lm()
# Leemos la fórmula: Stock ~ Precio (Stock es explicado por Precio)
modelo_ventas <- lm(Stock ~ Precio, data = ventas)

# 'modelo_ventas' es un objeto que contiene toda la info del modelo
print(modelo_ventas)
# Output:
# Call: lm(formula = Stock ~ Precio, data = ventas)
#
# Coefficients:
# (Intercept)       Precio  
#     291.135      -84.821 
```

```r
# Ejemplo 3: Interpretación de Coeficientes
# Intercepto (Beta_0) = 291.135
#   "Un producto con un Precio de $0 tendría (teóricamente) 291 unidades de stock."
#   (Este valor a menudo no tiene interpretación en el mundo real,
#   es solo el punto de partida matemático de la línea).
#
# Pendiente (Beta_1) = -84.821
#   "Por cada $1 de aumento en el 'Precio', se espera que el 
#   'Stock' *disminuya* en 84.821 unidades."
#   (Esto coincide con nuestra correlación negativa).
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Ajuste el modelo de regresión lineal *opuesto* al del ejemplo. Intente predecir el `Precio` (Y) en función del `Stock` (X). Guarde el modelo en un objeto llamado `modelo_precio`.
2.  **Laboratorio:** Usando el `modelo_ventas` (el del Ejemplo 2), extraiga y muestre los coeficientes exactos usando la función `coef(modelo_ventas)`.
3.  **Evaluación:** Escriba la ecuación de regresión lineal completa para el `modelo_ventas` (del Ejemplo 2) reemplazando $\beta_0$ y $\beta_1$ con los valores numéricos que encontró. (Ej. `Stock_Predicho = ...`).

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    modelo_precio <- lm(Precio ~ Stock, data = ventas)

    print(modelo_precio)
    # Call:
    # lm(formula = Precio ~ Stock, data = ventas)
    #
    # Coefficients:
    # (Intercept)        Stock  
    #     3.22019     -0.00492  
    ```
2.  **Laboratorio:**
    ```r
    # Asumiendo que 'modelo_ventas' existe
    coef(modelo_ventas)

    # Output:
    # (Intercept)      Precio 
    #   291.13511   -84.82136
    ```
3.  **Evaluación:**
    `Stock_Predicho = 291.135 - 84.821 * Precio`

-----

## 8.2 Evaluación del Modelo y Predicción

### 💡 Explicación del Concepto

Ajustar un modelo no es suficiente. ¿Es un *buen* modelo? Para saberlo, usamos la función `summary()`.

`summary(mi_modelo)` nos da una radiografía completa. Debemos fijarnos en dos cosas principales:

1.  **Significancia (p-valor):** ¿La variable `X` (Precio) es realmente un predictor útil para `Y` (Stock)?

      * Miramos la fila de nuestra variable (ej. `Precio`) y la columna `Pr(>|t|)`.
      * Si el **p-valor \< 0.05** (indicado por asteriscos `*`, `**`, `***`), significa que la variable es **estadísticamente significativa**. ¡Es un buen predictor\!
      * Si p-valor \> 0.05, la variable probablemente no sirve para predecir (es solo ruido).

2.  **Bondad de Ajuste ($R^2$):** ¿Qué *porcentaje* de la variación en `Y` es explicado por nuestro modelo (por `X`)?

      * Miramos el valor **"Multiple R-squared"** (va de 0 a 1).
      * `R-squared: 0.5335` significa: "Nuestro modelo (usando `Precio`) explica el **53.35%** de la variación que vemos en el `Stock`".
      * Un $R^2$ más alto es (generalmente) mejor, pero un $R^2$ "bueno" depende del contexto (en ciencias sociales 0.2 es bueno, en física 0.99 es esperado).

**Predicción:**
Una vez que tenemos un modelo, podemos usarlo para predecir valores nuevos con la función `predict()`.

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: El Resumen (Summary)
# Usamos el modelo de la sección anterior
resumen_modelo <- summary(modelo_ventas)
print(resumen_modelo)

# Output (extracto):
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 291.1351    19.1029   15.24   <2e-16 ***
# Precio      -84.8214     9.2486   -9.17   1.9e-12 ***
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#
# Multiple R-squared:  0.6366,	Adjusted R-squared:  0.629 
```

```r
# Ejemplo 2: Interpretación del Resumen
# 1. Significancia (p-valor):
#   La fila 'Precio' tiene un p-valor de '1.9e-12' (0.0000000000019)
#   y tres asteriscos (***). Esto es MUCHO menor que 0.05.
#   Conclusión: 'Precio' ES un predictor altamente significativo para 'Stock'.
#
# 2. R-cuadrado:
#   'Multiple R-squared:  0.6366'.
#   Conclusión: "El Precio explica el 63.66% de la variación en el Stock."
```

```r
# Ejemplo 3: Predicción
# ¿Cuál sería el stock predicho para productos con nuevos precios?
# 1. Creamos un data frame con los nuevos valores (la columna DEBE
#    llamarse igual que en el modelo: 'Precio')
nuevos_precios <- data.frame(
  Precio = c(1.50, 3.00, 5.00)
)

# 2. Usamos predict()
predicciones <- predict(modelo_ventas, newdata = nuevos_precios)
print(predicciones)
#        1        2        3 
# 163.9031   36.6711 -132.9717 
#
# Interpretación: El modelo predice 164 unidades para $1.50,
# 37 unidades para $3.00, y un stock negativo (-133) para $5.00
# (lo cual nos muestra los límites del modelo en el mundo real).
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Ejecute `summary()` sobre el `modelo_precio` (el que usted creó en el ejercicio 8.1.1, `Precio ~ Stock`).
2.  **Laboratorio:** Mirando el `summary()` del `modelo_precio` (del ejercicio anterior), responda:
    1.  ¿Es la variable `Stock` un predictor estadísticamente significativo para `Precio`? (Mire el p-valor).
    2.  ¿Qué porcentaje de la varianza del `Precio` es explicado por el `Stock`? (Mire el R-cuadrado).
3.  **Evaluación:** Usando el `modelo_ventas` (el del Ejemplo 2), prediga el stock (`Stock`) para un producto que cuesta **$2.50**.

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    # Asumiendo que 'modelo_precio' existe
    summary(modelo_precio)

    # Output (extracto):
    # Coefficients:
    #             Estimate Std. Error t value Pr(>|t|)    
    # (Intercept) 3.220190   0.126442  25.468   <2e-16 ***
    # Stock       -0.004920   0.000537   -9.167   1.9e-12 ***
    # ---
    # Multiple R-squared:  0.6366,	Adjusted R-squared:  0.629 
    ```
2.  **Laboratorio:**
      * **Respuesta 1 (Significancia):** Sí. La variable `Stock` tiene un p-valor de `1.9e-12` (y `***`), que es mucho menor que 0.05. `Stock` es un predictor muy significativo para `Precio`.
      * **Respuesta 2 (R-cuadrado):** El `Multiple R-squared` es `0.6366`. Esto significa que el `Stock` explica el **63.66%** de la variación en el `Precio`. (Note que el R-cuadrado es el mismo para `Y~X` que para `X~Y`, porque mide la fuerza de la relación lineal, que es simétrica).
3.  **Evaluación:**
    ```r
    # 1. Crear el nuevo data frame
    precio_2_50 <- data.frame(Precio = 2.50)

    # 2. Predecir
    stock_predicho <- predict(modelo_ventas, newdata = precio_2_50)

    print(stock_predicho)
    #        1 
    # 80.5817 

    # Respuesta: El modelo predice un stock de 80.58 unidades.
    ```

-----

## 8.3 Repaso Final (Diagnóstico y Ciclo Completo)

### 💡 Explicación del Concepto

Hemos completado el ciclo básico de la ciencia de datos en R.

**Diagnóstico de Residuales:**
Un modelo `lm` solo es válido si cumple 4 supuestos. Los dos más importantes son:

1.  **Homocedasticidad:** Los errores (residuales) deben ser aleatorios, sin patrones. (Se ve en el gráfico `Residuals vs Fitted`).
2.  **Normalidad de los Residuales:** Los errores deben seguir una distribución normal. (Se ve en el gráfico `Normal Q-Q`).

R nos da estos gráficos automáticamente al ejecutar `plot(mi_modelo)`.

  * **`Residuals vs Fitted` (Gráfico 1):** Buscamos "ruido" (puntos dispersos al azar alrededor de la línea 0). Si vemos un patrón (como un embudo o una curva), tenemos un problema (se llama *heterocedasticidad*).
  * **`Normal Q-Q` (Gráfico 2):** Igual que en la Sesión 7. Los puntos deben seguir la línea diagonal.

**El Ciclo Completo de Data Science (Repaso):**

1.  **Importar:** `read_csv()` (Sesión 5)
2.  **Limpiar (Wrangling):** `is.na()`, `na.omit()`, `dplyr::filter()`, `select()`, `mutate()` (Sesión 5)
3.  **Explorar (EDA):** `summary()`, `str()`, `table()` (Sesión 5)
4.  **Visualizar:** `ggplot()` (`geom_point`, `geom_histogram`, `geom_boxplot`) (Sesión 6)
5.  **Modelar:** `cor()`, `shapiro.test()` (Sesión 7), `lm()`, `summary()`, `predict()` (Sesión 8)
6.  **Comunicar:** (Exportar los gráficos y conclusiones).

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Diagnóstico de Residuales
# Configura RStudio para mostrar 4 gráficos (2x2)
par(mfrow = c(2, 2)) 

# Ejecuta los 4 gráficos de diagnóstico
plot(modelo_ventas)

# Resetea la ventana gráfica a 1 solo gráfico
par(mfrow = c(1, 1))

# Interpretación (Gráfico 1: Residuals vs Fitted):
# La línea roja está algo curvada, no es perfectamente plana.
# Los puntos forman un ligero "embudo" (más dispersión a la derecha).
# Esto sugiere que nuestro modelo tiene problemas de heterocedasticidad.
#
# Interpretación (Gráfico 2: Normal Q-Q):
# Los puntos se desvían de la línea diagonal en las colas.
# Esto sugiere que los residuales NO son normales.
#
# Conclusión: Nuestro modelo 'Stock ~ Precio' es significativo,
# pero no es muy confiable porque viola los supuestos de la RLS.
# (Esto se debe a que 'Stock' no era normal, como vimos en Sesión 7).
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Ejecute los 4 gráficos de diagnóstico para el `modelo_precio` (el que creó usted: `Precio ~ Stock`). (Recuerde usar `par(mfrow = c(2, 2))` antes). ¿Observa problemas similares?
2.  **Laboratorio:** En la Sesión 7, la variable `Precio` SÍ pasó el test de normalidad (p-valor 0.09), pero `Stock` NO (p-valor 8.13e-06). Sabiendo esto, ¿cuál de los dos modelos (`Stock ~ Precio` o `Precio ~ Stock`) cree que es *teóricamente* más apropiado para una Regresión Lineal? ¿Por qué?
3.  **Evaluación (Examen Final):**
    Usando el dataframe `notas` (cargado de `datos_notas.csv`):
    1.  Ajuste un modelo de regresión lineal para predecir `Nota_2` (Y) en función de `Nota_1` (X).
    2.  Ejecute `summary()` sobre este nuevo modelo.
    3.  Interprete: ¿Es `Nota_1` un predictor significativo para `Nota_2`? ¿Cuál es el R-cuadrado del modelo?

### ✅ Solución a los Ejercicios

1.  **Práctica:**

    ```r
    # Asumiendo que 'modelo_precio' existe
    par(mfrow = c(2, 2)) 
    plot(modelo_precio)
    par(mfrow = c(1, 1))
    ```

    *Respuesta:* Sí, se observan exactamente los mismos problemas (lo cual es normal, ya que los residuales están relacionados). La línea del Gráfico 1 no es plana y el Q-Q plot (Gráfico 2) muestra colas desviadas.

2.  **Laboratorio (Conceptual):**

      * *Respuesta:* La Regresión Lineal Clásica (OLS) asume que los *residuales* (errores) son normales, no necesariamente las variables en sí. Sin embargo, si la variable *dependiente (Y)* está muy sesgada o tiene outliers (como `Stock`), es casi seguro que los residuales también lo estarán (como vimos en los gráficos de `plot(modelo_ventas)`).
      * El modelo `Precio ~ Stock` es igualmente problemático.
      * **Conclusión:** Aunque ambos modelos fallan los supuestos, el problema de *outliers* y no-normalidad en la variable `Stock` (detectado en Sesión 7) nos advirtió que cualquier modelo `lm` que use `Stock` (como Y o como X) será problemático. (La solución avanzada sería transformar `Stock`, ej. `log(Stock)`, o usar un modelo diferente).

3.  **Evaluación (Examen Final):**

    ```r
    # 1. Cargar datos (si es necesario)
    library(readr)
    notas <- read_csv2("datos_notas.csv")

    # 2. Ajustar el modelo
    modelo_notas <- lm(Nota_2 ~ Nota_1, data = notas)

    # 3. Ejecutar summary
    summary(modelo_notas)

    # Output (extracto):
    # Coefficients:
    #             Estimate Std. Error t value Pr(>|t|)    
    # (Intercept)   3.3330     0.5284   6.308 1.12e-07 ***
    # Nota_1        0.4107     0.0991   4.144 0.000135 ***
    # ---
    # Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    #
    # Multiple R-squared:  0.2635,	Adjusted R-squared:  0.2481 
    ```

    *Interpretación (Respuesta):*

    1.  **Significancia:** Sí. La variable `Nota_1` tiene un p-valor de `0.000135` (y `***`), que es mucho menor que 0.05. `Nota_1` es un predictor estadísticamente significativo para `Nota_2`.
    2.  **R-cuadrado:** El `Multiple R-squared` es `0.2635`. Esto significa que la `Nota_1` explica solo el **26.35%** de la variación en la `Nota_2`. (Es un predictor significativo, pero no muy fuerte; otros factores explican el 74% restante de la nota).
