# Sesión 6: Generación de Datos, Gráficos (ggplot2)

## 6.1 Generación de Datos Determinísticos y Aleatorios

### 💡 Explicación del Concepto

A veces necesitamos crear datos "falsos" o de prueba, ya sea para probar una función o para simular un escenario (ej. simular 1000 clientes).

**Generación Determinística (Secuencias)**
Generamos secuencias predecibles.
* `1:10`: Crea el vector `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`.
* `seq(from, to, by)`: Crea una secuencia. (Ej. `seq(0, 10, by = 2)` -> `[0, 2, 4, 6, 8, 10]`).
* `rep(x, times)`: Repite `x` un número de `times`. (Ej. `rep("A", 3)` -> `["A", "A", "A"]`).

**Generación Aleatoria (Simulación)**
Generamos números basados en distribuciones de probabilidad.
* `runif(n, min, max)`: Muestra `n` números de una distribución **Uniforme** (todos los números tienen la misma probabilidad, ej. un dado).
* `rnorm(n, mean, sd)`: Muestra `n` números de una distribución **Normal** (la "campana de Gauss", ej. estaturas de personas). `mean` es la media, `sd` es la desviación estándar.
* `rbinom(n, size, prob)`: Muestra `n` números de una distribución **Binomial** (ej. lanzar una moneda `size` veces, con probabilidad `prob` de "cara").
* `sample(x, size, replace)`: Toma una muestra de tamaño `size` del vector `x`. (ej. sacar cartas de una baraja). `replace = TRUE` significa que podemos sacar el mismo elemento varias veces.

**Semilla (`set.seed()`)**
Los números "aleatorios" en computación son en realidad "pseudo-aleatorios" (siguen un algoritmo complejo pero predecible). Si queremos que nuestro script genere **exactamente los mismos números aleatorios** cada vez que se ejecuta (para que los resultados sean **reproducibles**), debemos fijar la "semilla" (el punto de inicio) del generador.
Se usa `set.seed(numero)` (ej. `set.seed(42)`) al inicio del script.

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Generación determinística (secuencia y repetición)
# Secuencia de números pares
secuencia_par <- seq(from = 0, to = 10, by = 2)
# [1] 0  2  4  6  8 10

# Repetir categorías
grupos <- rep(c("A", "B"), times = 3)
# [1] "A" "B" "A" "B" "A" "B"
````

```r
# Ejemplo 2: Generación aleatoria (Normal)
# Simular 50 estaturas con media 170cm y desv. estándar 10cm
estaturas <- rnorm(n = 50, mean = 170, sd = 10)
```

```r
# Ejemplo 3: 'set.seed()' para reproducibilidad
# Ejecute estas dos líneas.
set.seed(42)
rnorm(1) # [1] 1.370958

# Ejecútelas de nuevo. El resultado será EXACTAMENTE el mismo.
# Si no usa set.seed(42), el resultado cambiará cada vez.
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Generar una secuencia de años desde 2010 hasta 2025 (use `seq` o el operador `:`).
2.  **Laboratorio:** Generar 1000 lanzamientos de una moneda (0 = sello, 1 = cara) usando `rbinom`. ¿Es una moneda justa? (Pista: use `table()` para contar los resultados).
3.  **Clase:** Explique el concepto de "reproducibilidad" en Data Science y por qué `set.seed()` es fundamental para ello.

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    # Opción 1: (más corta)
    anios_1 <- 2010:2025

    # Opción 2: (más formal)
    anios_2 <- seq(from = 2010, to = 2025, by = 1)

    print(anios_1)
    ```
2.  **Laboratorio:**
    ```r
    # n = 1000 (queremos 1000 resultados)
    # size = 1 (cada resultado es 1 lanzamiento)
    # prob = 0.5 (moneda justa, 50% prob de "éxito" (cara=1))

    # Fijamos la semilla para que el profesor pueda verificar
    set.seed(123) 

    lanzamientos <- rbinom(n = 1000, size = 1, prob = 0.5)

    # Contamos los resultados
    table(lanzamientos)
    #   0   1 
    # 487 513 

    # Respuesta: Sí, parece una moneda justa. 
    # No esperamos 500/500 exacto, 487/513 es muy razonable.
    ```
3.  **Clase:**
    **Reproducibilidad** es la capacidad de un investigador (o un colega, o su "yo" del futuro) de tomar el mismo código y los mismos datos, y llegar *exactamente* al mismo resultado (el mismo gráfico, el mismo modelo, las mismas estadísticas).
    En análisis que involucran aleatoriedad (como simulaciones o ciertos algoritmos de Machine Learning), si no se usa `set.seed()`, cada ejecución dará un resultado ligeramente diferente. Esto hace imposible *verificar* los resultados o *depurar* el código. `set.seed()` "fija" la aleatoriedad, garantizando que el script siempre produzca el mismo resultado, lo que lo hace reproducible.

-----

## 6.2 Fundamentos de `ggplot2`

### 💡 Explicación del Concepto

`ggplot2` es el paquete de visualización de datos más popular y potente de R (es parte del `tidyverse`). Creado por Hadley Wickham, se basa en la **"Gramática de Gráficos"**.

Esta gramática divide un gráfico en sus componentes fundamentales:

1.  **Data (Datos):** El Data Frame que contiene la información (ej. nuestro dataframe `ventas`).
2.  **Aesthetics (Estética, `aes()`):** El "mapeo" de las variables (columnas) a propiedades visuales. Ej: *mapear* la columna `Stock` al eje **X**; *mapear* la columna `Precio` al eje **Y**; *mapear* la columna `Producto` al **Color**.
3.  **Geometries (Geometrías, `geom_...`):** La forma visual que toman los datos (los "verbos" del gráfico). Ej: `geom_point()` (gráfico de dispersión), `geom_line()` (gráfico de líneas), `geom_bar()` (gráfico de barras).

La sintaxis siempre sigue esta plantilla:
`ggplot(data = <DATOS>, mapping = aes(x = <COL_X>, y = <COL_Y>)) +`
`geom_...()`

  * `ggplot(...)` crea el lienzo (lienzo gris).
  * `+` (¡siempre al final de la línea\!) se usa para añadir capas (geometrías).

### 💻 Ejemplos de Código en R

```r
# 1. Cargar el paquete
library(ggplot2)
# 2. Asumimos que 'ventas' ya está cargado de la Sesión 5
# (Si no, corra: library(readr); ventas <- read_csv("datos_ventas.csv"))

# Ejemplo 1: El lienzo base
# Mapeamos 'Stock' al eje X, 'Precio' al eje Y
# Esto solo crea un lienzo gris con los ejes definidos.
ggplot(data = ventas, mapping = aes(x = Stock, y = Precio))
```

```r
# Ejemplo 2: Añadir una Geometría (Puntos)
# Tomamos el lienzo anterior y le añadimos la capa 'geom_point'
# ¡Ahora tenemos un gráfico de dispersión!
ggplot(data = ventas, mapping = aes(x = Stock, y = Precio)) +
  geom_point()
```

```r
# Ejemplo 3: Añadir una Estética (Color)
# Mapeamos 'Producto' al color.
# ggplot es lo suficientemente inteligente para asignar un color
# diferente a cada producto único.
ggplot(data = ventas, mapping = aes(x = Stock, y = Precio, color = Producto)) +
  geom_point()
```

### ✏️ Ejercicios Propuestos

*(Recuerde tener `library(ggplot2)` y el dataframe `ventas` cargados).*

1.  **Práctica:** Iniciar un gráfico (`ggplot`) usando el dataframe `ventas`. Mapee `Precio` al eje X y `Stock` al eje Y. (No añada un `geom` todavía, solo vea el lienzo gris).
2.  **Laboratorio:** Tomar el gráfico anterior y añadirle una capa `geom_point()` para crear el gráfico de dispersión.
3.  **Evaluación:** Tomar el gráfico del laboratorio (Precio vs Stock) y hacer que el **color** de los puntos dependa de la variable `Producto`.

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    library(ggplot2)
    # Asumiendo que 'ventas' está cargado

    # El lienzo gris con ejes
    ggplot(data = ventas, mapping = aes(x = Precio, y = Stock))
    ```
2.  **Laboratorio:**
    ```r
    ggplot(data = ventas, mapping = aes(x = Precio, y = Stock)) +
      geom_point() # Añadimos la capa de puntos
    ```
3.  **Evaluación:**
    ```r
    # Añadimos 'color = Producto' DENTRO del aes()
    ggplot(data = ventas, mapping = aes(x = Precio, y = Stock, color = Producto)) +
      geom_point(alpha = 0.7) # alpha=0.7 añade algo de transparencia
    ```

-----

## 6.3 Tipos de Gráficos y Personalización

### 💡 Explicación del Concepto

La "Estética" y la "Geometría" definen el tipo de gráfico.

**Gráficos Comunes (y sus `geom`):**

  * **Dispersión (Scatter plot):** `geom_point()`. Muestra la relación entre dos variables numéricas.
  * **Histograma (Histogram):** `geom_histogram()`. Muestra la distribución de *una* variable numérica (qué tan frecuentes son los valores). Solo necesita `aes(x = ...)`.
  * **Gráfico de Cajas (Boxplot):** `geom_boxplot()`. Muestra la distribución de una variable numérica (Y) dividida por una variable categórica (X). Excelente para ver medianas y *outliers*.
  * **Gráfico de Barras (Bar plot):** `geom_bar()` (para contar) o `geom_col()` (para valores pre-calculados).

**Personalización (Añadir capas):**
`ggplot2` es aditivo. Podemos seguir añadiendo capas con `+` para mejorar el gráfico:

  * `labs(title = "...", x = "...", y = "...")`: Añade títulos y etiquetas a los ejes.
  * `theme_...()`: Cambia el aspecto general. (Ej. `theme_minimal()`, `theme_bw()`).
  * `facet_wrap(~ variable_categorica)`: ¡Muy poderoso\! Divide el gráfico en múltiples "sub-gráficos", uno por cada categoría de la variable.

### 💻 Ejemplos de Código en R

*(Usaremos el dataframe `ventas`)*

```r
# Ejemplo 1: Histograma (1 variable numérica)
# ¿Cómo se distribuyen los Precios?
ggplot(data = ventas, mapping = aes(x = Precio)) +
  geom_histogram(bins = 10, fill = "steelblue", color = "black")
  # 'bins' controla cuántas barras. 'fill' es relleno, 'color' es borde.
```

```r
# Ejemplo 2: Boxplot (1 Numérica (Y) vs 1 Categórica (X))
# ¿Cómo varía el Precio (Y) según el Producto (X)?
ggplot(data = ventas, mapping = aes(x = Producto, y = Precio)) +
  geom_boxplot()
```

```r
# Ejemplo 3: Facetas (Sub-gráficos)
# Relación entre 'Stock' y 'Precio', PERO en gráficos separados
# para cada 'Producto'
ggplot(data = ventas, mapping = aes(x = Stock, y = Precio)) +
  geom_point() +
  facet_wrap(~ Producto) +
  labs(title = "Stock vs Precio por Producto") +
  theme_minimal()
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Usando `ventas`, crear un **histograma** (`geom_histogram`) que muestre la distribución de la columna `Stock`.
2.  **Laboratorio:** Usando `ventas`, crear un **gráfico de cajas** (`geom_boxplot`) que muestre la distribución del `Stock` (eje Y) agrupado por `Producto` (eje X).
3.  **Evaluación:** Tomar el gráfico de cajas (Boxplot) del Laboratorio y aplicarle:
    1.  Un tema (ej. `theme_bw()` o `theme_minimal()`).
    2.  Títulos y etiquetas con `labs(title = "Distribución de Stock por Producto", x = "Tipo de Producto", y = "Unidades en Stock")`.

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    library(ggplot2)
    # Asumiendo que 'ventas' está cargado

    ggplot(data = ventas, mapping = aes(x = Stock)) +
      geom_histogram(bins = 15, fill = "darkgreen", color = "white")
    ```
2.  **Laboratorio:**
    ```r
    library(ggplot2)

    ggplot(data = ventas, mapping = aes(x = Producto, y = Stock)) +
      geom_boxplot(fill = "lightblue")
    ```
3.  **Evaluación:**
    ```r
    library(ggplot2)

    ggplot(data = ventas, mapping = aes(x = Producto, y = Stock)) +
      geom_boxplot(fill = "lightblue") +
      theme_minimal() + # 1. Aplicamos el tema
      labs(               # 2. Añadimos títulos y etiquetas
        title = "Distribución de Stock por Producto",
        x = "Tipo de Producto",
        y = "Unidades en Stock"
      ) +
      coord_flip() # Opcional: un 'giro' para leer mejor los productos
    ```
