# Sesión 2: Variables y Estructura de Datos, Estructuras de Control y Flujo

## 2.1 Estructuras de Datos Compuestas (Homogéneas)

### 💡 Explicación del Concepto

En la sesión anterior vimos **vectores**, la estructura 1D (una dimensión) y homogénea (todos del mismo tipo). Ahora vemos estructuras 2D.

**Matrices (`matrix`)**
Una matriz es un vector que ha sido "doblado" en un formato de dos dimensiones (filas y columnas). Al igual que los vectores, las matrices son **homogéneas**: todos los elementos deben ser del mismo tipo (ej. todo `numeric` o todo `character`).

Se crean con la función `matrix(datos, nrow, ncol)`, donde `nrow` es el número de filas y `ncol` el número de columnas. R llena la matriz *por columna* por defecto.

**Indexación de Matrices:** Para acceder a un elemento, ahora necesitamos dos coordenadas: `[fila, columna]`.
* `mi_matriz[1, 2]`: Elemento en la fila 1, columna 2.
* `mi_matriz[1, ]`: Fila 1 completa (deja la columna en blanco).
* `mi_matriz[, 2]`: Columna 2 completa (deja la fila en blanco).

**Factores (`factor`)**
Un factor es un tipo especial de vector que R usa para almacenar **variables categóricas** (variables que solo pueden tomar un número limitado de valores, como "Hombre"/"Mujer", "Bajo"/"Medio"/"Alto").

Internamente, R almacena esto de forma eficiente como números enteros (`1`, `2`, `3`) y guarda una "etiqueta" (los "Niveles" o `Levels`) para saber qué significa cada número. Son cruciales para los modelos estadísticos.

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Crear un factor (variable categórica)
genero <- factor(c("M", "F", "M", "M", "F"))
print(genero)
# Output: [1] M F M M F
#         Levels: F M (R los ordena alfabéticamente por defecto)
```

```r
# Ejemplo 2: Crear una matriz
# 6 elementos, 2 filas, 3 columnas. R llena por columna.
m <- matrix(1:6, nrow = 2, ncol = 3)
print(m)
#      [,1] [,2] [,3]
# [1,]    1    3    5
# [2,]    2    4    6
```

```r
# Ejemplo 3: Indexación de la matriz 'm'
# Elemento en la fila 1, columna 3
elemento_1_3 <- m[1, 3] # Contiene el 5

# Fila 2 completa
fila_2 <- m[2, ] # Contiene el vector [2, 4, 6]
```

### ✏️ Ejercicios Propuestos

1. **Práctica**: Crear un vector llamado colores con 10 elementos que contenga una mezcla de "rojo", "azul" y "verde". Convertirlo a un factor (f_colores) y mostrar sus niveles (levels(f_colores)).

#### ✅ Solución
```r
v_colores <- c("rojo", "azul", "verde", "rojo", "azul", "azul", "verde", "rojo", "verde", "azul")

# Convertir a factor
f_colores <- factor(v_colores)

print(f_colores)
# [1] rojo  azul  verde rojo  azul  azul  verde rojo  verde azul 
# Levels: azul verde rojo

# Mostrar solo los niveles
levels(f_colores)
# [1] "azul"  "verde" "rojo"
```

2. **Laboratorio**: Crear una matriz de 4 filas y 2 columnas que contenga los números del 1 al 8.

#### ✅ Solución
```r
# R llenará por columna:
# Col 1: 1, 2, 3, 4
# Col 2: 5, 6, 7, 8
mi_matriz <- matrix(1:8, nrow = 4, ncol = 2)

print(mi_matriz)
#      [,1] [,2]
# [1,]    1    5
# [2,]    2    6
# [3,]    3    7
# [4,]    4    8
```

3. **Clase**: Usando la matriz del ejercicio anterior, extraer el elemento que se encuentra en la última fila y la primera columna.

#### ✅ Solución
```r
# La última fila es la 4, la primera columna es la 1
mi_matriz[4, 1]
# Output: [1] 4
```

## 2.2 Estructuras de Datos Compuestas (Heterogéneas)
### 💡 Explicación del Concepto
Las estructuras homogéneas (vector, matriz) son restrictivas. ¿Qué pasa si queremos una columna de texto, una de números y una lógica en la misma "tabla"?

Data Frames (`data.frame`) Esta es la estructura de datos más importante para la ciencia de datos en R. Es el equivalente de R a una hoja de cálculo de Excel o una tabla de SQL.

Un Data Frame es una estructura 2D (filas y columnas) que es heterogénea: cada columna debe ser un vector de un solo tipo, pero diferentes columnas pueden tener diferentes tipos.

Listas (`list`) Las listas son los "contenedores" más flexibles de R. Una lista es un vector de objetos donde cada elemento puede ser cualquier cosa: un vector, una matriz, un data frame, otra lista, una función, etc. Son útiles para agrupar resultados complejos.

*Acceso a Elementos:*

**Data Frames**: `df$NombreDeColumna` (la forma más común), o `df[, "NombreDeColumna"]`.

**Listas**: `mi_lista[[1]]` (para extraer el objeto dentro de la posición 1), o `mi_lista$nombre_elemento` (si los elementos tienen nombre).


### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Crear un Data Frame
# Note que todos los vectores (columnas) deben tener la misma longitud
df <- data.frame(
  id = 1:2,
  nombre = c("Ana", "Juan"),
  edad = c(25, 30),
  es_estudiante = c(TRUE, FALSE)
)
print(df)
```

```r
# Ejemplo 2: Crear una Lista
# Note que los elementos tienen diferentes tipos y longitudes
lista_mixta <- list(
  titulo = "Mi Lista",
  numeros = 1:5,
  una_matriz = matrix(1:4, 2)
)
print(lista_mixta)
```

```r
# Ejemplo 3: Acceso a elementos
# Acceder a la columna 'edad' del Data Frame 'df'
edades_df <- df$edad # [1] 25 30

# Acceder al elemento 'numeros' de la Lista 'lista_mixta'
numeros_lista <- lista_mixta$numeros # [1] 1 2 3 4 5
# O (menos legible):
numeros_lista_alt <- lista_mixta[[2]]
```

### ✏️ Ejercicios Propuestos
1. **Práctica**: Crear un Data Frame llamado df_alumnos con 3 columnas (Nombre, Puntaje, Ciudad) y 4 filas (para 4 alumnos).

#### ✅ Solución
```r
df_alumnos <- data.frame(
  Nombre = c("Luis", "Ana", "Leo", "Mia"),
  Puntaje = c(85, 92, 78, 88),
  Ciudad = c("A", "B", "A", "C")
)
print(df_alumnos)
#   Nombre Puntaje Ciudad
# 1   Luis      85      A
# 2    Ana      92      B
# 3    Leo      78      A
# 4    Mia      88      C
```

2. **Laboratorio**: Crear una lista_compilado que contenga:

* El Data Frame df_alumnos (del ejercicio anterior) en un elemento llamado datos_alumnos.

* La matriz mi_matriz (de la diapositiva anterior) en un elemento llamado matriz_numeros.

#### ✅ Solución
```r
# Asumiendo que df_alumnos y mi_matriz (de la sección 2.1) existen
lista_compilado <- list(
  datos_alumnos = df_alumnos,
  matriz_numeros = mi_matriz
)
print(lista_compilado)
```

3. **Evaluación**: ¿Cuál es la principal diferencia entre df[1, ] y df[[1]] cuando se aplica a un Data Frame df? (Pista: pruebe ambos en el df_alumnos y mire el class() del resultado).

#### ✅ Solución
```r
# Probando en el df_alumnos
resultado_A <- df_alumnos[1, ]
resultado_B <- df_alumnos[[1]]

class(resultado_A) # Output: [1] "data.frame"
class(resultado_B) # Output: [1] "factor" (o "character" si los factores están desactivados)
```
**Explicación**:

df[1, ] (con un corchete [] y una coma) significa "Subconjunto": Pide la Fila 1 y todas las columnas. El resultado sigue siendo un Data Frame (una tabla con 1 fila).

df[[1]] (con doble corchete [[ ]]) significa "Extraer": Pide el primer objeto (la primera columna) fuera de la estructura del Data Frame. El resultado es el Vector original (la columna Nombre).

## 2.3 Estructuras de Control Condicional

### 💡 Explicación del Concepto

El control condicional nos permite ejecutar bloques de código solo si se cumple una cierta condición.

`if-else` Es la estructura básica. La sintaxis es: `if (condicion_logica) { ... bloque de código si es TRUE ... } else { ... bloque de código si es FALSE ... }`

* La `condicion_logica` debe evaluar a un único `TRUE` o `FALSE`.

* El bloque `else` es opcional.

**Operadores Lógicos**: Para crear condiciones complejas:

* `&` (Y lógico): `condicion1 & condicion2` (Ambas deben ser `TRUE`).

* `|` (O lógico): `condicion1 | condicion2` (Al menos una debe ser `TRUE`).

* `!` (NO lógico): `!condicion1` (Invierte el resultado).

`ifelse()` (Función Vectorizada) El `if-else` normal solo funciona con una condición a la vez. ¿Qué pasa si queremos aplicarlo a un vector entero (una columna de un Data Frame)? Usamos `ifelse()`.

La sintaxis es: `ifelse(vector_de_condiciones, valor_si_TRUE, valor_si_FALSE)` Devolverá un vector de la misma longitud que el `vector_de_condiciones`.

```r
# Ejemplo 1: if-else básico
x <- 10
if (x > 5) {
  print("x es mayor que 5")
} else {
  print("x es menor o igual a 5")
}
```

```r
# Ejemplo 2: if-else con operadores lógicos
# (El 'else if' se usa para anidar condiciones)
nota <- 85
if (nota >= 90) {
  print("A")
} else if (nota >= 80 & nota < 90) {
  print("B")
} else {
  print("C o inferior")
}
```

```r
# Ejemplo 3: ifelse() vectorizado
calificaciones <- c(6.5, 8.0, 4.2, 5.5)

# Crear un vector que diga "Aprobado" o "Reprobado"
# (Asumiendo que se aprueba con 5.0)
resultado <- ifelse(calificaciones >= 5.0, "Aprobado", "Reprobado")
print(resultado)
# Output: [1] "Aprobado" "Aprobado" "Reprobado" "Aprobado"
```

### ✏️ Ejercicios Propuestos

1. **Práctica**: Crear una variable mes <- 8. Escribir un bloque if-else que imprima "Vacaciones" si el mes es 12, 1 o 2, y que imprima "Clases" en cualquier otro caso.

#### ✅ Solución
```r
mes <- 8

# Usamos el operador 'O' lógico (|)
if (mes == 12 | mes == 1 | mes == 2) {
  print("Vacaciones")
} else {
  print("Clases")
}
```

2. **Laboratorio**: Escribir un código que evalúe si un año es bisiesto. Un año es bisiesto si es divisible por 4, excepto si es divisible por 100 (a menos que también sea divisible por 400). (Pista: use el operador módulo %%. x %% y da el resto de x/y. Ej. 10 %% 3 es 1).

#### ✅ Solución
```r
ano <- 2024

# Condición 1: Divisible por 4 Y (NO divisible por 100)
cond_1 <- (ano %% 4 == 0) & (ano %% 100 != 0)

# Condición 2: Divisible por 400
cond_2 <- (ano %% 400 == 0)

if (cond_1 | cond_2) {
  print(paste(ano, "es bisiesto"))
} else {
  print(paste(ano, "no es bisiesto"))
}
```

3. **Evaluación**: Usar la función ifelse() en el df_alumnos (creado en la sección 2.2) para crear una nueva columna llamada ESTADO que diga "Aprobado" si el Puntaje es 80 o más, y "Reprobado" si es menor.

#### ✅ Solución
```r
# Asumiendo que 'df_alumnos' existe

# Usamos ifelse() para la condición vectorizada
# y $ para asignar el resultado a una nueva columna
df_alumnos$ESTADO <- ifelse(df_alumnos$Puntaje >= 80, "Aprobado", "Reprobado")

print(df_alumnos)
#   Nombre Puntaje Ciudad    ESTADO
# 1   Luis      85      A  Aprobado
# 2    Ana      92      B  Aprobado
# 3    Leo      78      A Reprobado
# 4    Mia      88      C  Aprobado
```