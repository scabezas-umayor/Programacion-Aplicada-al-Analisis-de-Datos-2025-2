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

**Archivos CSV (Formato Español/Latam)**
Muchos archivos en español usan punto y coma (`;`) como separador y coma (`,`) para los decimales.
* `read.csv2("archivo.csv")`: Función base de R para este formato.
* `read_csv2("archivo.csv")`: Función de `readr` para este formato.

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Importar un CSV estándar con 'readr' (Recomendado)
# 1. Instalar (solo una vez)
# install.packages("readr")
# 2. Cargar
library(readr)

# 3. Importar (Asumiendo que "datos_ventas.csv" está en su Proyecto)
df_ventas <- read_csv("datos_ventas.csv")

# 'readr' también muestra los tipos de columna que detectó
````

```r
# Ejemplo 2: Importar un CSV formato español con 'readr'
library(readr)
# read_csv2 sabe que el separador es ';' y el decimal es ','
df_notas <- read_csv2("datos_notas.csv")
```

```r
# Ejemplo 3: Importar un CSV con la función base (alternativa)
# R base es más lento, pero es bueno conocerlo.
# Para CSV estándar:
df_ventas_base <- read.csv("datos_ventas.csv")

# Para CSV español:
df_notas_base <- read.csv2("datos_notas.csv")
```

### ✏️ Ejercicios Propuestos

*(Nota: Todos los ejercicios asumen que los archivos `datos_ventas.csv`, `datos_notas.csv` y `datos_sucios.csv` están en la carpeta de su Proyecto RStudio).*

1.  **Práctica:** Usando la función `read_csv()` del paquete `readr`, importe el archivo `datos_ventas.csv` y guárdelo en un data frame llamado `ventas`.
2.  **Laboratorio:** Usando la función `read_csv2()` (o `read.csv2`), importe el archivo `datos_notas.csv` y guárdelo en un data frame llamado `notas`.
3.  **Evaluación:** Importe el archivo `datos_sucios.csv` (use `read_csv`) y guárdelo en un data frame llamado `sucios`.

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    # (Asegúrese de haber corrido 'library(readr)' primero)
    ventas <- read_csv("datos_ventas.csv")

    # Verificar las primeras filas
    head(ventas)
    ```
2.  **Laboratorio:**
    ```r
    # (Asegúrese de haber corrido 'library(readr)' primero)
    # read_csv2 maneja automáticamente el ';' y la ',' decimal
    notas <- read_csv2("datos_notas.csv")

    # Verificar las primeras filas y los tipos de datos
    head(notas)
    str(notas) # Debería mostrar Nota_1 y Nota_2 como 'double'
    ```
3.  **Evaluación:**
    ```r
    # (Asegúrese de haber corrido 'library(readr)' primero)
    sucios <- read_csv("datos_sucios.csv")

    # Verificar
    head(sucios)
    ```

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
  * `dim(mi_df)`: Muestra las dimensiones (ej. `[50, 3]` -\> 50 filas, 3 columnas).
  * `table(mi_df$columna_categorica)`: Cuenta la frecuencia de cada categoría en una columna.

### 💻 Ejemplos de Código en R

*(Usaremos los data frames `ventas`, `notas` y `sucios` cargados en la sección anterior)*

```r
# Ejemplo 1: str() (Estructura)
# Inspeccionar el data frame de ventas
str(ventas)
# Debería mostrar 50 obs., 3 variables
# Producto (chr), Precio (dbl), Stock (dbl)
```

```r
# Ejemplo 2: summary() (Resumen)
# Obtener un resumen estadístico de las ventas
summary(ventas)
# Nos dará los cuartiles/media de Precio y Stock
# y un resumen de la columna Producto (longitud, clase)
```

```r
# Ejemplo 3: head() y table()
# Ver las primeras 3 filas de 'notas'
head(notas, n = 3)

# Contar cuántas filas hay por 'Producto' en 'ventas'
table(ventas$Producto)
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Ejecute `str(ventas)` y `summary(ventas)` en el data frame `ventas` que importó. ¿Cuál es el precio promedio (`Mean`) de los productos?
2.  **Laboratorio:** Ejecute `summary(notas)` en el data frame `notas`. ¿Cuál es la mediana (`Median`) de `Nota_1` y la media (`Mean`) de `Nota_2`?
3.  **Evaluación:** Cargue el data frame `sucios`. Use la función `table()` para contar cuántas personas (filas) hay registradas por `Ciudad`.

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    # Asumiendo que 'ventas' fue cargado
    summary(ventas)

    # Output (buscar en la columna Precio):
    #   Precio      
    # Min.   :0.650  
    # 1st Qu.:1.200  
    # Median :1.875  
    # Mean   :2.158  
    # 3rd Qu.:2.950  
    # Max.   :4.700

    # Respuesta: El precio promedio (Mean) es 2.158
    ```
2.  **Laboratorio:**
    ```r
    # Asumiendo que 'notas' fue cargado
    summary(notas)

    # Output (buscar en las columnas correspondientes):
    #     Nota_1          Nota_2     
    # Min.   :2.800   Min.   :3.900  
    # 1st Qu.:4.175   1st Qu.:4.375  
    # Median :5.250   Median :5.650  
    # Mean   :5.228   Mean   :5.480  
    # 3rd Qu.:6.125   3rd Qu.:6.200  
    # Max.   :7.000   Max.   :7.000  

    # Respuesta: La Mediana de Nota_1 es 5.250. La Media de Nota_2 es 5.480.
    ```
3.  **Evaluación:**
    ```r
    # Asumiendo que 'sucios' fue cargado
    table(sucios$Ciudad)

    # Output:
    # Concepcion      Madrid    Santiago    Valencia  Valparaiso 
    #          5           8          13           7           7 
    # (Nota: table() por defecto ignora los NAs)

    # Para incluir los NAs (valores faltantes) en el conteo:
    table(sucios$Ciudad, useNA = "ifany")
    # Concepcion      Madrid    Santiago    Valencia  Valparaiso        <NA> 
    #          5           8          13           7           7          10
    ```

-----

## 5.3 Limpieza de Datos (Data Wrangling)

### 💡 Explicación del Concepto

Rara vez los datos del mundo real vienen "limpios". La limpieza (o *wrangling*) es el proceso de tomar datos "sucios" y prepararlos para el análisis. A menudo es el 80% del trabajo.

**Valores Faltantes (NA)**
Es el problema más común (visto en `datos_sucios.csv`).

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

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Contar NAs en 'datos_sucios.csv'
# (Asumiendo que 'sucios' está cargado)

# ¿Cuántas Edades faltan?
sum(is.na(sucios$Edad))

# ¿Cuántas Ciudades faltan?
sum(is.na(sucios$Ciudad))
```

```r
# Ejemplo 2: Imputación simple (reemplazar NA con la media)
# 1. Calcular la media de Edad (ignorando los NAs existentes)
media_edad <- mean(sucios$Edad, na.rm = TRUE) 
# na.rm = TRUE es VITAL

# 2. Usar ifelse para crear una nueva columna imputada
sucios$Edad_Imputada <- ifelse(
    is.na(sucios$Edad),  # Condición: Si la Edad es NA
    media_edad,          # Valor si es TRUE
    sucios$Edad          # Valor si es FALSE (dejar la edad original)
)
```

```r
# Ejemplo 3: dplyr y el pipe (%>%)
# install.packages("dplyr")
library(dplyr)

# Flujo de trabajo con 'ventas':
# 1. Tomar 'ventas'
# 2. Y LUEGO... filtrar por filas donde 'Stock' sea menor a 100
# 3. Y LUEGO... seleccionar solo las columnas 'Producto' y 'Precio'
resultado_dplyr <- ventas %>%
  filter(Stock < 100) %>%
  select(Producto, Precio)
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Cargue el data frame `sucios`. Use `sum(is.na(...))` para contar cuántos valores `NA` hay en la columna `Edad` y cuántos en la columna `Ciudad`.
2.  **Laboratorio:** Usando el data frame `sucios`, cree una nueva columna llamada `Edad_Imputada_Mediana` que reemplace los `NA` de la columna `Edad` por la **mediana** de la misma columna. (Pista: use `median(..., na.rm = TRUE)`).
3.  **Evaluación:** Usando `dplyr` y el data frame `ventas`:
    1.  Tome `ventas`.
    2.  `filter()` para quedarse solo con los productos que tengan un `Stock` **menor a 100**.
    3.  `select()` para quedarse solo con las columnas `Producto` y `Stock`.
    4.  `arrange()` para ordenar el resultado por `Stock` (de menor a mayor).

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    # Asumiendo que 'sucios' está cargado

    # Contar NAs en Edad
    n_na_edad <- sum(is.na(sucios$Edad))
    print(paste("NAs en Edad:", n_na_edad))
    # Output: [1] "NAs en Edad: 6"

    # Contar NAs en Ciudad
    n_na_ciudad <- sum(is.na(sucios$Ciudad))
    print(paste("NAs en Ciudad:", n_na_ciudad))
    # Output: [1] "NAs en Ciudad: 10"
    ```
2.  **Laboratorio:**
    ```r
    # Asumiendo que 'sucios' está cargado

    # 1. Calcular la mediana de Edad (ignorando los NAs)
    mediana_edad <- median(sucios$Edad, na.rm = TRUE)
    print(paste("La mediana de edad es:", mediana_edad)) # 35.5

    # 2. Usar mutate (de dplyr) o $ e ifelse (base R)

    # Opción Base R (con ifelse):
    sucios$Edad_Imputada_Mediana <- ifelse(
      is.na(sucios$Edad),  # Condición
      mediana_edad,        # Valor si TRUE
      sucios$Edad          # Valor si FALSE
    )

    # Opción con dplyr (más limpia):
    # library(dplyr)
    # sucios <- sucios %>%
    #   mutate(Edad_Imputada_Mediana = ifelse(is.na(Edad), mediana_edad, Edad))

    # Verificar (ej. filas 3 y 14 deberían tener 35.5)
    print(sucios)
    ```
3.  **Evaluación:**
    ```r
    library(dplyr)
    # Asumiendo que 'ventas' está cargado

    reporte_stock_bajo <- ventas %>%
      filter(Stock < 100) %>%
      select(Producto, Stock) %>%
      arrange(Stock) # arrange por defecto ordena ascendente

    # Mostrar el resultado
    print(reporte_stock_bajo)

    #    Producto Stock
    #  <chr>    <dbl>
    # 1 Sandia      30
    # 2 Sandia      35
    # 3 Sandia      38
    # 4 Melon       40
    # ... (etc.)
    ```
