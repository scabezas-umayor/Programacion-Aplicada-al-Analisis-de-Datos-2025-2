# Sesión 5: Recolección, Exploración y Limpieza de Datos

## 5.1 Recolección e Importación de Datos

### 💡 Explicación del Concepto

Hasta ahora, hemos creado datos dentro de R. En el mundo real, los datos provienen de **archivos externos**. El primer paso de cualquier análisis es importar esos datos.

**Directorios de Trabajo (Working Directory)**
R necesita saber *dónde* buscar los archivos. El directorio de trabajo es la carpeta en su computador donde R está "parado" actualmente.
* `getwd()`: (Get Working Directory) Muestra la carpeta actual.
* `setwd("ruta/a/mi/carpeta")`: (Set Working Directory) Cambia la carpeta.
> **Mejor Práctica:** ¡No usar `setwd()`! En su lugar, usar **Proyectos de RStudio**. Cuando abre un Proyecto (`.Rproj`), RStudio automáticamente define el directorio de trabajo a la carpeta que contiene el proyecto. Todos sus scripts y archivos de datos deben vivir dentro de esa carpeta.

**Archivos CSV (Comma-Separated Values)**
Es el formato de archivo plano más común. Es un archivo de texto donde las columnas están separadas por comas (`,`) y las filas por saltos de línea.
* `read.csv("archivo.csv")`: Función base de R.
* `read_csv("archivo.csv")`: Función del paquete `readr` (parte del Tidyverse). Es **mucho más rápida y recomendada**.

**Archivos Excel (`.xlsx`)**
Para leer archivos de Excel, necesitamos un paquete especializado. El más común es `readxl`.
* `library(readxl)`: Cargar el paquete.
* `read_excel("archivo.xlsx")`: Lee la primera hoja.
* `read_excel("archivo.xlsx", sheet = "NombreDeLaHoja")`: Lee una hoja específica.

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Importar un CSV con la función base
# (Asumiendo que "datos.csv" está en su carpeta de Proyecto)
df_csv <- read.csv("datos.csv")
````

```r
# Ejemplo 2: Importar un CSV con 'readr' (Recomendado)
# 1. Instalar (solo una vez)
# install.packages("readr")
# 2. Cargar
library(readr)
df_readr <- read_csv("datos.csv")
# 'readr' también muestra los tipos de columna que detectó
```

```r
# Ejemplo 3: Importar un archivo Excel
# 1. Instalar (solo una vez)
# install.packages("readxl")
# 2. Cargar
library(readxl)
df_excel <- read_excel("mi_archivo_excel.xlsx", sheet = "Ventas_Q1")
```

### ✏️ Ejercicios Propuestos

*Nota: Para estos ejercicios, los estudiantes necesitarían archivos de ejemplo. Puede crear un `datos_punto_coma.csv` y un `datos_excel.xlsx` para la clase.*

1.  **Práctica:** Muchos CSV en español no usan coma (`,`) como separador, sino punto y coma (`;`). La función base para esto es `read.csv2()`. Importar un archivo que utilice punto y coma (`;`) como separador.
2.  **Laboratorio:** Importar datos de la **segunda hoja** (usando el índice `sheet = 2`) de un archivo Excel de ejemplo.
3.  **Teórico:** ¿Por qué es mejor usar `read_csv()` (de `readr`) que `read.csv()` (base)? (Mencione 2 razones).

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    # Asumiendo que 'datos_punto_coma.csv' existe

    # Opción 1: Función base de R (hecha para esto)
    datos_csv_es <- read.csv2("datos_punto_coma.csv")

    # Opción 2: Con 'readr' (más explícito)
    library(readr)
    datos_csv_es_readr <- read_csv("datos_punto_coma.csv", delim = ";")
    ```
2.  **Laboratorio:**
    ```r
    library(readxl)

    # Asumiendo que 'datos_excel.xlsx' existe
    # R cuenta las hojas desde 1
    datos_hoja2 <- read_excel("datos_excel.xlsx", sheet = 2)
    ```
3.  **Teórico:**
    1.  **Velocidad:** `read_csv` es significativamente más rápida (a veces 10x o 100x) en archivos grandes porque está escrita en C++.
    2.  **Consistencia:** `read_csv` es más "inteligente" al adivinar los tipos de columna, pero es más predecible. **Crucialmente**, `read_csv` **NO** convierte las cadenas de texto a factores por defecto, un comportamiento antiguo de `read.csv` que causa muchos problemas (`stringsAsFactors = TRUE`).

-----

## 5.2 Exploración Inicial de Datos

### 💡 Explicación del Concepto

Los datos se han importado. ¡No podemos analizarlos sin "mirarlos" primero\! Este paso (Análisis Exploratorio de Datos o EDA) es crucial para entender qué tenemos.

Funciones clave para "echar un vistazo" a un Data Frame (ej. `mi_df`):

  * `str(mi_df)`: (Structure) ¡La más importante\! Muestra la estructura del data frame: número de filas (observations) y columnas (variables), el nombre de cada columna, su tipo de dato (`int`, `num`, `chr`, `Factor`) y las primeras filas de datos.
  * `summary(mi_df)`: (Summary) Genera un resumen estadístico para *cada* columna.
      * Para columnas **numéricas**: Muestra Mínimo, 1er Cuartil, Mediana, Media, 3er Cuartil y Máximo.
      * Para columnas **categóricas (factores)**: Muestra el conteo de las categorías más frecuentes.
  * `head(mi_df)`: Muestra las primeras 6 filas.
  * `tail(mi_df)`: Muestra las últimas 6 filas.
  * `dim(mi_df)`: Muestra las dimensiones (ej. `[150, 5]` -\> 150 filas, 5 columnas).
  * `names(mi_df)`: Muestra los nombres de las columnas.
  * `table(mi_df$columna_categorica)`: Cuenta la frecuencia de cada categoría en una columna.

### 💻 Ejemplos de Código en R

```r
# Usaremos el dataset 'iris' que viene incluido en R

# Ejemplo 1: str() (Estructura)
# Vemos 150 obs, 5 variables. 4 numéricas, 1 Factor.
str(iris)
```

```r
# Ejemplo 2: summary() (Resumen)
# Nos da los cuartiles para las 4 columnas numéricas
# y el conteo para la columna categórica 'Species'
summary(iris)
```

```r
# Ejemplo 3: head() y table()
# Ver las primeras 3 filas
head(iris, n = 3)

# Contar cuántas flores hay de cada especie
table(iris$Species)
#     setosa versicolor  virginica 
#         50         50         50 
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Cargar el Data Frame `mtcars` (viene en R, `data(mtcars)`). Usar `str()` y `summary()` para inspeccionarlo.
2.  **Laboratorio:** Usando el Data Frame `iris`, calcular la media, mediana y desviación estándar (`sd`) *solo* de la columna `Sepal.Length`. (Pista: `iris$Sepal.Length`).
3.  **Clase:** Generar una tabla de frecuencias (un conteo) para la variable `cyl` (número de cilindros) del Data Frame `mtcars`. ¿Cuántos autos tienen 4 cilindros?

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    # Cargar el dataset (aunque usualmente ya está disponible)
    data(mtcars)

    # Inspeccionar estructura
    str(mtcars)
    # 'data.frame': 32 obs. of  11 variables:
    # $ mpg : num  21 21 22.8 21.4 18.7 ...
    # $ cyl : num  6 6 4 6 8 ...
    # ... (Todas son 'num' (numéricas))

    # Inspeccionar resumen
    summary(mtcars)
    #      mpg             cyl             disp             hp       ...
    # Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0  ...
    # 1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5  ...
    # ...
    ```
2.  **Laboratorio:**
    ```r
    data(iris)

    # Extraemos la columna como un vector numérico
    largo_sepalo <- iris$Sepal.Length

    # Calculamos las estadísticas
    media_ls <- mean(largo_sepalo)
    mediana_ls <- median(largo_sepalo)
    desv_est_ls <- sd(largo_sepalo)

    print(paste("Media:", media_ls))     # 5.843333
    print(paste("Mediana:", mediana_ls)) # 5.8
    print(paste("Desv. Estándar:", desv_est_ls)) # 0.8280661
    ```
3.  **Clase:**
    ```r
    data(mtcars)

    # Usamos table() en la columna 'cyl'
    table(mtcars$cyl)

    # Output:
    # 4  6  8 
    # 11  7 14 
    ```
    **Respuesta:** 11 autos tienen 4 cilindros.

-----

## 5.3 Limpieza de Datos (Data Wrangling)

### 💡 Explicación del Concepto

Rara vez los datos del mundo real vienen "limpios". La limpieza (o *wrangling*) es el proceso de tomar datos "sucios" y prepararlos para el análisis. A menudo es el 80% del trabajo.

**Valores Faltantes (NA)**
Es el problema más común.

  * `is.na(mi_df)`: Devuelve una matriz de TRUE/FALSE indicando dónde hay NAs.
  * `sum(is.na(mi_df$columna))`: Cuenta cuántos NAs hay en una columna.
  * `na.omit(mi_df)`: **Elimina** cualquier fila que contenga *al menos un NA*. Es una solución rápida pero peligrosa (¡podemos perder muchos datos\!).
  * **Imputación:** Es el proceso de "adivinar" el valor faltante. Una imputación simple es reemplazar el NA por la media o la mediana de la columna.

**Introducción a `dplyr` (El Verbo del Tidyverse)**
`dplyr` es un paquete que cambia la forma de manipular datos en R. Se basa en "verbos" (funciones) que son fáciles de leer y entender.

  * `library(dplyr)`: Cargar el paquete.
  * **El operador "Pipe" `%>%`**: Este operador (Ctrl+Shift+M en RStudio) es la clave. Se lee como "y luego...". Toma el resultado de la izquierda y lo "entuba" (pipe) como el primer argumento de la función de la derecha.
      * `datos %>% funcion()` es lo mismo que `funcion(datos)`.

**Verbos Clave de `dplyr`:**

  * `filter(condicion)`: Filtra **filas** (ej. `filter(Edad > 25)`).
  * `select(col1, col2)`: Selecciona **columnas**.
  * `mutate(nueva_col = ...)`: Crea o modifica columnas.
  * `arrange(columna)`: Ordena las filas.
  * `group_by(col_categorica)` y `summarise(media = mean(col_num))` (los veremos más adelante).

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Manejo básico de NA
df_sucio <- data.frame(a = c(1, 2, NA), b = c("X", NA, "Y"))

# Eliminar filas con NA
df_limpio <- na.omit(df_sucio) 
# 'df_limpio' solo tiene la fila 1
```

```r
# Ejemplo 2: Imputación simple (reemplazar NA con la media)
datos_con_na <- c(10, 20, NA, 40)
media_sin_na <- mean(datos_con_na, na.rm = TRUE) # 23.33
datos_imputados <- ifelse(is.na(datos_con_na), media_sin_na, datos_con_na)
# [1] 10.0 20.0 23.3 40.0
```

```r
# Ejemplo 3: dplyr y el pipe (%>%)
# install.packages("dplyr")
library(dplyr)
data(mtcars)

# Flujo de trabajo:
# 1. Tomar 'mtcars'
# 2. Y LUEGO... filtrar por filas donde 'mpg' > 20
# 3. Y LUEGO... seleccionar solo las columnas 'mpg' y 'cyl'
resultado_dplyr <- mtcars %>%
  filter(mpg > 20) %>%
  select(mpg, cyl)
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Crear un Data Frame que tenga una columna con NAs. Usar `is.na()` y `sum()` para contar cuántos NAs totales hay.
2.  **Laboratorio:** Crear un Data Frame con una columna numérica (`valor`) que tenga 5 NAs. Remplazar esos NA por la **mediana** de la columna (use `median(..., na.rm = TRUE)`).
3.  **Evaluación:** Usando `dplyr` y el dataset `iris`:
    1.  Tome `iris`.
    2.  `filter()` para quedarse solo con la especie "setosa".
    3.  `select()` para quedarse solo con las columnas `Sepal.Length` y `Petal.Length`.
    4.  `arrange()` para ordenar el resultado de mayor a menor `Petal.Length`.

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    df_prueba_na <- data.frame(
      a = c(1, 2, NA, 4),
      b = c(NA, "X", "Y", "Z")
    )

    # 1. Ver dónde están
    is.na(df_prueba_na)
    #         a     b
    # [1,] FALSE  TRUE
    # [2,] FALSE FALSE
    # [3,]  TRUE FALSE
    # [4,] FALSE FALSE

    # 2. Contar el total
    sum(is.na(df_prueba_na))
    # [1] 2
    ```
2.  **Laboratorio:**
    ```r
    # 1. Creamos un df con 5 NAs (y otros datos)
    datos_sucios <- data.frame(valor = c(10, 15, 12, NA, 5, NA, NA, 8, NA, NA))

    # 2. Calculamos la mediana (ignorando los NA existentes)
    mediana_valor <- median(datos_sucios$valor, na.rm = TRUE)
    # (La mediana de 10, 15, 12, 5, 8 es 10)

    # 3. Imputamos (usando ifelse)
    datos_sucios$valor_imputado <- ifelse(
      is.na(datos_sucios$valor), # Condición
      mediana_valor,             # Si es VERDADERO (es NA)
      datos_sucios$valor         # Si es FALSO (no es NA)
    )

    print(datos_sucios)
    ```
3.  **Evaluación:**
    ```r
    library(dplyr)
    data(iris)

    # El código se lee casi como inglés:
    resultado_setosa <- iris %>%
      filter(Species == "setosa") %>%
      select(Sepal.Length, Petal.Length) %>%
      arrange(desc(Petal.Length)) # desc() es para ordenar descendente

    # Ver el resultado
    head(resultado_setosa)
    #   Sepal.Length Petal.Length
    # 1          5.4          1.9
    # 2          5.0          1.9
    # 3          5.1          1.9
    # ...
    ```
