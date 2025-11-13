# Sesión 7: Verificación de Supuestos y Determinación de Correlaciones

*(Pre-requisito: Asegúrese de tener el paquete `readr` y `ggplot2` instalados, y el archivo `datos_ventas.csv` en su carpeta de proyecto).*

## 7.1 Verificación de Supuestos (Normalidad)

### 💡 Explicación del Concepto

Muchos modelos estadísticos (como la Regresión Lineal que veremos en la Sesión 8) *asumen* que los datos, o más precisamente los "residuos" (errores) del modelo, siguen una **distribución normal** (la "campana de Gauss").

Si los datos no son normales, el modelo puede dar resultados erróneos o poco fiables. Por lo tanto, debemos verificar este supuesto. Hay dos formas principales de hacerlo:

1.  **Inspección Visual (La más recomendada):**
    * **Histograma/Gráfico de Densidad:** (Visto en Sesión 6). ¿El gráfico parece una campana simétrica?
    * **Gráfico Q-Q (Cuantil-Cuantil):** Este es el mejor gráfico para esta tarea. Compara los cuantiles de nuestros datos (eje Y) contra los cuantiles de una distribución normal teórica perfecta (eje X).
        * **Interpretación:** Si los puntos de datos siguen *perfectamente* la línea diagonal, los datos son perfectamente normales. Pequeñas desviaciones en las "colas" (extremos) son comunes y aceptables. Grandes desviaciones (ej. una forma de "S" o "banana") indican que los datos no son normales.

2.  **Prueba Estadística (Test de Hipótesis):**
    * **Test de Shapiro-Wilk (`shapiro.test()`):** Es una prueba formal muy popular para muestras pequeñas (típicamente < 5000 registros).
    * **Hipótesis Nula ($H_0$):** "Los datos SÍ provienen de una distribución normal".
    * **Hipótesis Alternativa ($H_1$):** "Los datos NO provienen de una distribución normal".
    * **Interpretación (Valor *p*):**
        * Si **p-valor > 0.05**: *No podemos rechazar* $H_0$. Asumimos que los datos son "suficientemente normales". (¡Resultado deseado!)
        * Si **p-valor < 0.05**: *Rechazamos* $H_0$. Los datos **no** se distribuyen normalmente.
    * *Precaución:* En datasets muy grandes, esta prueba es demasiado "sensible" y casi siempre rechazará $H_0$ (p-valor < 0.05), incluso si los datos son visualmente "suficientemente normales". Por eso, la inspección visual (Q-Q Plot) suele ser más práctica.

### 💻 Ejemplos de Código en R

```r
# --- Preparación: Cargar paquetes y datos ---
library(readr)
library(ggplot2)

# Cargamos los datos de la sesión anterior
ventas <- read_csv("datos_ventas.csv")
# ---------------------------------------------

# Ejemplo 1: Histograma y Densidad (Visual)
# ¿Cómo se distribuyen los Precios?
ggplot(ventas, aes(x = Precio)) +
  geom_histogram(aes(y = ..density..), fill = "lightblue", bins = 10) +
  geom_density(color = "red", size = 1) +
  labs(title = "Distribución de Precios")
# Visualmente, parece sesgado a la derecha (no perfectamente normal)
````

```r
# Ejemplo 2: Gráfico Q-Q (Visual - Recomendado)
# La función base 'qqnorm' es excelente para esto.
qqnorm(ventas$Precio, main = "Q-Q Plot de Precios")
qqline(ventas$Precio, col = "red", lwd = 2) # Añade la línea de normalidad
# Interpretación: Los puntos se desvían de la línea roja
# en las colas (extremos), confirmando que no es normal.
```

```r
# Ejemplo 3: Test de Shapiro-Wilk (Estadístico)
shapiro.test(ventas$Precio)

# Output:
#   Shapiro-Wilk normality test
# data:  ventas$Precio
# W = 0.95754, p-value = 0.0932
```

*Interpretación del Ejemplo 3:* El **p-valor (0.0932)** es *mayor* que 0.05. Aunque visualmente vimos un sesgo, el test estadístico *no tiene evidencia suficiente* para rechazar la normalidad. Para propósitos prácticos, podríamos considerarlo "suficientemente normal".

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Genere un histograma y un gráfico de densidad (como en el Ejemplo 1) para la columna `Stock` del dataframe `ventas`. ¿Parece normal visualmente?
2.  **Laboratorio:** Genere un gráfico Q-Q (`qqnorm` y `qqline`) para la columna `Stock`. ¿Qué le dice este gráfico sobre la normalidad de los datos de Stock?
3.  **Evaluación:** Ejecute el test `shapiro.test()` sobre la columna `Stock`. Interprete el resultado del p-valor. ¿Qué concluye sobre la normalidad del Stock?

### ✅ Solución a los Ejercicios

1.  **Práctica:**

    ```r
    # Asumiendo 'ggplot2' y 'ventas' cargados
    ggplot(ventas, aes(x = Stock)) +
      geom_histogram(aes(y = ..density..), fill = "orange", bins = 10) +
      geom_density(color = "blue", size = 1) +
      labs(title = "Distribución de Stock")
    ```

    *Respuesta:* Visualmente, **no parece normal**. La mayoría de los datos se concentra a la izquierda (stocks bajos) y tiene una "cola larga" hacia la derecha (sesgo positivo).

2.  **Laboratorio:**

    ```r
    qqnorm(ventas$Stock, main = "Q-Q Plot de Stock")
    qqline(ventas$Stock, col = "blue", lwd = 2)
    ```

    *Respuesta:* El gráfico Q-Q lo confirma. Los puntos forman una clara curva (una "banana") que se desvía significativamente de la línea azul, especialmente en la cola superior (derecha). Esto es un signo claro de **no normalidad**.

3.  **Evaluación:**

    ```r
    shapiro.test(ventas$Stock)

    # Output:
    #   Shapiro-Wilk normality test
    # data:  ventas$Stock
    # W = 0.84132, p-value = 8.13e-06 
    # (El p-valor es 0.00000813)
    ```

    *Interpretación:* El **p-valor (8.13e-06)** es *extremadamente pequeño* y mucho menor que 0.05.
    *Conclusión:* Rechazamos la hipótesis nula ($H_0$). El test estadístico confirma fuertemente lo que vimos visualmente: la variable `Stock` **no sigue una distribución normal**.

-----

## 7.2 Correlación entre Variables

### 💡 Explicación del Concepto

La **Correlación** mide la **fuerza y dirección** de la **relación lineal** entre dos variables numéricas.
El resultado es el **coeficiente de correlación (r)**, un número entre -1 y 1.

  * **r = 1 (Correlación Positiva Perfecta):** Cuando A aumenta, B aumenta en proporción perfecta.
  * **r = 0.7 (Correlación Positiva Fuerte):** Cuando A aumenta, B tiende a aumentar.
  * **r = 0 (Sin Correlación Lineal):** No hay relación lineal aparente.
  * **r = -0.8 (Correlación Negativa Fuerte):** Cuando A aumenta, B tiende a disminuir.
  * **r = -1 (Correlación Negativa Perfecta):** Cuando A aumenta, B disminuye en proporción perfecta.

> **¡ADVERTENCIA FUNDAMENTAL: CORRELACIÓN NO IMPLICA CAUSALIDAD\!**
> El clásico ejemplo: las ventas de helados y los ataques de tiburones están altamente correlacionados (ambos aumentan juntos). Pero los helados no causan ataques de tiburón. Una tercera variable (la "temporada de verano") causa ambos.

**Tipos de Coeficientes:**

  * **Pearson (`method = "pearson"`):** El estándar. Mide la relación *lineal*. Es sensible a *outliers* (valores extremos). Requiere que los datos sean (más o menos) normales.
  * **Spearman (`method = "spearman"`):** No paramétrico. Mide la relación *monotónica* (si A aumenta, B nunca disminuye, aunque no sea en línea recta). Se basa en los "rangos" (orden) de los datos. Es robusto a *outliers* y no requiere normalidad. **(Recomendado para nuestros datos de `Stock`, que no son normales)**.

**Matriz de Correlación:**
Si tenemos muchas variables numéricas, podemos calcular la correlación entre todas ellas a la vez con `cor()`.

### 💻 Ejemplos de Código en R

```r
# Asumiendo que 'ventas' está cargado

# Ejemplo 1: Correlación Pearson (lineal)
# ¿Qué relación hay entre el Precio y el Stock?
cor(ventas$Precio, ventas$Stock, method = "pearson")

# Output: [1] -0.7303803
# Interpretación: Hay una correlación negativa FUERTE.
# A medida que el Precio sube, el Stock tiende a ser menor.
```

```r
# Ejemplo 2: Correlación Spearman (robusta)
# Como 'Stock' no es normal, Spearman es más apropiado.
cor(ventas$Precio, ventas$Stock, method = "spearman")

# Output: [1] -0.8354671
# Interpretación: La correlación negativa es aún más fuerte
# usando rangos. ¡La relación es muy robusta!
```

```r
# Ejemplo 3: Matriz de Correlación
# Solo tenemos 2 variables numéricas, pero la sintaxis es esta:
# (Seleccionamos solo las columnas numéricas)
columnas_num <- ventas[, c("Precio", "Stock")]
matriz_cor <- cor(columnas_num)

print(matriz_cor)
#           Precio     Stock
# Precio  1.000000 -0.730380
# Stock  -0.730380  1.000000
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Usando `dplyr`, cree una nueva columna en el dataframe `ventas` llamada `Valor_Total_Stock` (que sea `Precio * Stock`). (Pista: `ventas <- ventas %>% mutate(...)`).
2.  **Laboratorio:** Calcule la correlación **Pearson** entre `Precio` y su nueva columna `Valor_Total_Stock`. Interprete el resultado.
3.  **Evaluación:** Calcule la correlación **Spearman** entre `Stock` y su nueva columna `Valor_Total_Stock`. Interprete el resultado.

### ✅ Solución a los Ejercicios

1.  **Práctica:**

    ```r
    library(dplyr)
    # Asumiendo que 'ventas' está cargado

    ventas <- ventas %>%
      mutate(Valor_Total_Stock = Precio * Stock)
      
    # Verificar
    head(ventas)
    #   Producto Precio Stock Valor_Total_Stock
    #   <chr>     <dbl> <dbl>             <dbl>
    # 1 Manzana    1.25   155              193.75
    # 2 Naranja    0.89   210              186.9 
    # ...
    ```

2.  **Laboratorio:**

    ```r
    # Asumiendo que 'ventas' tiene la nueva columna
    cor(ventas$Precio, ventas$Valor_Total_Stock, method = "pearson")

    # Output: [1] 0.2852601
    ```

    *Interpretación:* Hay una correlación positiva **débil** (0.285). Sugiere que los productos más caros *tienden* a tener un valor total de stock ligeramente mayor, pero la relación no es fuerte.

3.  **Evaluación:**

    ```r
    # Asumiendo que 'ventas' tiene la nueva columna
    cor(ventas$Stock, ventas$Valor_Total_Stock, method = "spearman")

    # Output: [1] 0.6974151
    ```

    *Interpretación:* Hay una correlación positiva **fuerte** (0.697) usando Spearman. Esto indica una relación monotónica clara: a mayor cantidad de stock, mayor es el valor total de ese stock. (Esto tiene más sentido que la relación con el precio).

-----

## 7.3 Visualización de Correlación y Detección de *Outliers*

### 💡 Explicación del Concepto

Nunca confíe solo en el número de correlación. El **Cuarteto de Anscombe** es un famoso ejemplo de cuatro datasets que tienen *exactamente las mismas estadísticas* (media, varianza, correlación) pero que visualmente son radicalmente diferentes.

**¡Siempre debe visualizar sus datos\!**

**Visualización de Correlación:**
El mejor gráfico para ver una correlación es el **gráfico de dispersión** (`geom_point()`).

  * Podemos añadir una línea de tendencia (`geom_smooth(method = "lm")`) para ver la relación lineal más claramente (lm = Linear Model).

**Detección de Outliers (Valores Atípicos)**
Un *outlier* es un punto de datos que está anormalmente lejos del resto.

  * Los *outliers* pueden **distorsionar gravemente** el coeficiente de correlación de Pearson (porque "jalan" la línea de tendencia hacia ellos).
  * La mejor forma de detectarlos visualmente es con un **Boxplot** (`geom_boxplot()`). Los puntos que aparecen fuera de los "bigotes" (whiskers) del boxplot son candidatos a ser *outliers*.

### 💻 Ejemplos de Código en R

```r
# Asumiendo 'ggplot2' y 'ventas' cargados

# Ejemplo 1: Gráfico de dispersión con línea de tendencia
# Visualizamos la correlación negativa fuerte entre 'Precio' y 'Stock'
ggplot(ventas, aes(x = Precio, y = Stock)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) + # se=FALSE quita la sombra de error
  labs(title = "Relación Precio vs. Stock")
```

```r
# Ejemplo 2: Visualización de una Matriz de Correlación (Opcional)
# Si tenemos muchas variables, 'corrplot' es excelente
# install.packages("corrplot")
library(corrplot)

# Usamos la matriz calculada en la sección 7.2
columnas_num <- ventas[, c("Precio", "Stock", "Valor_Total_Stock")]
matriz_cor <- cor(columnas_num)
corrplot(matriz_cor, method = "number")
```

```r
# Ejemplo 3: Detección de Outliers con Boxplot
# ¿Hay outliers en los Precios?
ggplot(ventas, aes(y = Precio)) +
  geom_boxplot() +
  labs(title = "Boxplot de Precios")
# (No parece haber outliers significativos en Precio)
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Genere un **Boxplot** para la columna `Stock` (similar al Ejemplo 3). ¿Observa algún *outlier*?
2.  **Laboratorio:** Genere el gráfico de dispersión (como en el Ejemplo 1) para `Precio` (eje X) vs `Stock` (eje Y). Esta vez, añada `color = Producto` dentro del `aes()` para ver si la correlación se mantiene para todos los productos.
3.  **Evaluación (Conceptual):** Mirando el resultado del `shapiro.test()` para `Stock` (que no era normal) y la correlación de Spearman (que fue más fuerte que la de Pearson), ¿Por qué cree que `Spearman` fue una mejor elección que `Pearson` para analizar la relación entre `Precio` y `Stock`?

### ✅ Solución a los Ejercicios

1.  **Práctica:**

    ```r
    ggplot(ventas, aes(y = Stock)) +
      geom_boxplot(fill = "red") +
      labs(title = "Boxplot de Stock")
    ```

    *Respuesta:* Sí, se observa un *outlier* claro. Hay un punto (o varios muy juntos) muy por encima del "bigote" superior. Esto corresponde a los productos con mucho stock (ej. Plátano, con 350 unidades) que se alejan del resto de los datos.

2.  **Laboratorio:**

    ```r
    ggplot(ventas, aes(x = Precio, y = Stock, color = Producto)) +
      geom_point(size = 2) + # Puntos un poco más grandes
      geom_smooth(method = "lm", se = FALSE, aes(group = 1)) + # Una línea para todos
      labs(title = "Relación Precio vs. Stock (por Producto)") +
      theme_minimal()
    ```

    *Interpretación:* El gráfico muestra que la tendencia negativa (precio alto/stock bajo) se mantiene. Los productos caros (Fresa, Kiwi, Uva) están en la esquina inferior derecha, mientras que los productos baratos (Plátano, Naranja) están en la esquina superior izquierda.

3.  **Evaluación (Conceptual):**

      * **Pearson** mide relaciones *lineales* y es muy sensible a *outliers* y a la *no normalidad*.
      * **Spearman** mide relaciones *monotónicas* (si una sube, la otra baja, aunque no sea en línea recta) y se basa en *rangos* (orden), no en los valores absolutos.
      * **Respuesta:** Spearman fue una mejor elección porque (como vimos en el Ejercicio 1 de esta sección) la variable `Stock` tiene *outliers* y (como vimos en la Sección 7.1) **no es normal**. Los *outliers* (como el stock de 350) pueden "jalar" la línea de Pearson y distorsionar el resultado. Spearman ignora esta distancia extrema y solo ve que "Plátano" tiene el *rango* de stock más alto y uno of los *rangos* de precio más bajos, capturando la tendencia monotónica de forma más robusta.
