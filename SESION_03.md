# Sesión 3: Estructuras de Control de Ciclo, Funciones y Biblioteca

## 3.1 Estructuras de Control de Ciclo

### 💡 Explicación del Concepto

A veces necesitamos repetir una tarea múltiples veces. En lugar de copiar y pegar código, usamos **ciclos** (o bucles).

**Ciclo `for` (Para)**
Se usa cuando sabemos *exactamente cuántas veces* queremos iterar (repetir) algo. Iteramos sobre una secuencia (ej. un vector, una lista, o una secuencia de números como `1:10`).

Sintaxis: `for (variable_iteradora in secuencia) { ...código a repetir... }`
La `variable_iteradora` (comúnmente llamada `i`) tomará el valor de cada elemento de la `secuencia` en cada "vuelta" del ciclo.

**Ciclo `while` (Mientras)**
Se usa cuando *no sabemos cuántas veces* iteraremos, pero sí sabemos cuándo debemos *detenernos*. El ciclo se repite *mientras* una condición lógica sea `TRUE`.

Sintaxis: `while (condicion_logica) { ...código a repetir... }`
**¡Cuidado!** Es fundamental que algo *dentro* del ciclo `while` eventualmente haga que la `condicion_logica` se vuelva `FALSE`, o creará un **ciclo infinito**.

**Control de Ciclos:**
* `break`: Interrumpe el ciclo y se sale de él inmediatamente.
* `next`: Omite la iteración actual y salta a la siguiente.

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Ciclo 'for'
# Iterar sobre la secuencia de números del 1 al 5
suma <- 0
for (i in 1:5) {
  # En cada vuelta, i toma el valor 1, luego 2, 3, 4, 5
  suma <- suma + i
  print(paste("Iteración:", i, "- Suma actual:", suma))
}
# 'suma' al final es 15
````

```r
# Ejemplo 2: Ciclo 'while'
# Simular un contador que se detiene en 5
contador <- 1
while (contador <= 5) {
  print(paste("Contador:", contador))
  # ¡Crucial! Modificamos la variable de la condición
  contador <- contador + 1 
}
# Si olvidamos 'contador <- contador + 1', esto corre para siempre.
```

```r
# Ejemplo 3: Uso de 'break'
# Buscar el primer número divisible por 7
for (i in 1:100) {
  if (i %% 7 == 0) {
    print(paste("El primer número divisible por 7 es:", i))
    break # ¡Encontrado! Salir del ciclo.
  }
}
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Usar un ciclo `for` para iterar sobre los números del 1 al 10. Imprimir el cuadrado de cada número *solo* si el número es par. (Pista: usar `if` y el operador módulo `%%`).
2.  **Laboratorio:** Usar un ciclo `while` para simular el lanzamiento de una moneda (`sample(c("cara", "sello"), 1)`) hasta que salga "cara". Contar cuántos intentos se necesitaron.
3.  **Evaluación:** Escribir un ciclo `for` que itere del 1 al 10, pero que omita (salte) la impresión del número 7 usando `next`.

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    for (i in 1:10) {
      # Chequear si i es par (resto de la división por 2 es 0)
      if (i %% 2 == 0) {
        print(paste("El cuadrado de", i, "es", i^2))
      }
    }
    ```
2.  **Laboratorio:**
    ```r
    # (Opcional) set.seed(42) # Para que todos tengan el mismo resultado

    intentos <- 0
    moneda <- "sello" # Inicializar con 'sello' para que el ciclo comience

    while (moneda != "cara") {
      moneda <- sample(c("cara", "sello"), 1) # Lanzar moneda
      intentos <- intentos + 1                # Incrementar contador
      print(paste("Intento", intentos, ":", moneda))
    }

    print(paste("¡Se obtuvo 'cara' después de", intentos, "intentos!"))
    ```
3.  **Evaluación:**
    ```r
    for (i in 1:10) {
      if (i == 7) {
        next # Salta esta iteración y continúa con i = 8
      }
      print(i)
    }
    # Output: 1, 2, 3, 4, 5, 6, 8, 9, 10
    ```

-----

## 3.2 Programación con Funciones Propias

### 💡 Explicación del Concepto

Una **función** es un bloque de código reutilizable que realiza una tarea específica. Las hemos usado todo el tiempo (`mean()`, `print()`, `c()`). Ahora, crearemos las nuestras.

Las funciones son la base de la programación "limpia": evitan que repitamos código (principio **DRY**: Don't Repeat Yourself).

**Sintaxis:**
`nombre_de_la_funcion <- function(argumento1, argumento2) {`
`...cuerpo de la función (código)...`
`return(valor_a_devolver)`
`}`

  * **Argumentos (o parámetros):** Son las "entradas" que la función necesita para trabajar (ej. `peso_kg` y `altura_m`).
  * **Cuerpo:** Las instrucciones que la función debe ejecutar.
  * **`return()`:** Especifica cuál es el "resultado" o "salida" de la función. Si no se especifica, R devuelve la última línea evaluada.

**Ámbito (Scope):** Las variables creadas *dentro* de la función (como `imc` en el ejemplo de IMC) son **locales**: existen solo dentro de la función y desaparecen cuando esta termina. No afectan a las variables *globales* (las que vemos en el *Environment*).

**Argumentos por Defecto:** Podemos dar un valor predeterminado a un argumento, haciéndolo opcional.

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Función simple, sin argumentos
saludar <- function() {
  print("Hola, mundo!")
}
# Uso:
saludar()
```

```r
# Ejemplo 2: Función con argumentos y retorno
cuadrado <- function(x) {
  resultado <- x^2
  return(resultado)
}
# Uso:
valor <- cuadrado(5) # 'valor' ahora contiene 25
```

```r
# Ejemplo 3: Función con argumento por defecto
# 'nombre' es obligatorio, 'saludo' es opcional
saludar_personalizado <- function(nombre, saludo = "Hola") {
  mensaje <- paste(saludo, ",", nombre, "!")
  return(mensaje)
}
# Uso:
saludar_personalizado("Maria") # Output: "Hola , Maria !"
saludar_personalizado("Juan", saludo = "Adiós") # Output: "Adiós , Juan !"
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Crear una función llamada `calcular_imc` que reciba dos argumentos: `peso_kg` y `altura_m`. La función debe calcular y devolver el Índice de Masa Corporal (IMC), cuya fórmula es $peso / (altura^2)$.
2.  **Laboratorio:** Modificar la función `calcular_imc` del ejercicio anterior para que, además de *calcular* el IMC, *clasifique* el resultado. Debe devolver un texto: "Bajo Peso" (IMC \< 18.5), "Normal" (18.5-24.9), "Sobrepeso" (25-29.9) u "Obesidad" (\>= 30). (Pista: usar `if-else` anidados).
3.  **Clase:** Crear una función que reciba un vector de números y un argumento opcional `alfa` con un valor por defecto de 0.05. (La función no necesita hacer nada con `alfa` todavía, solo recibirlo).

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    calcular_imc <- function(peso_kg, altura_m) {
      # Fórmula IMC: peso / (altura * altura)
      imc <- peso_kg / (altura_m^2)
      return(imc)
    }

    # Uso:
    mi_imc <- calcular_imc(70, 1.75)
    print(mi_imc) # Output: 22.85714
    ```
2.  **Laboratorio:**
    ```r
    clasificar_imc <- function(peso_kg, altura_m) {
      imc <- peso_kg / (altura_m^2)
      
      # Usamos if-else anidados para la clasificación
      if (imc < 18.5) {
        clasificacion <- "Bajo Peso"
      } else if (imc < 25) {
        clasificacion <- "Normal"
      } else if (imc < 30) {
        clasificacion <- "Sobrepeso"
      } else {
        clasificacion <- "Obesidad"
      }
      
      # Devolvemos un texto (character)
      return(clasificacion)
    }

    # Uso:
    diagnostico <- clasificar_imc(85, 1.70)
    print(diagnostico) # Output: "Sobrepeso"
    ```
3.  **Clase:**
    ```r
    # Esta función recibe un vector 'datos'
    # y un argumento 'alfa' que por defecto es 0.05
    mi_funcion_estadistica <- function(datos, alfa = 0.05) {
      
      # Por ahora, solo mostramos los argumentos recibidos
      print(paste("Vector de datos recibido con longitud:", length(datos)))
      print(paste("Nivel alfa seleccionado:", alfa))
      
      # (Aquí iría el cálculo de un intervalo de confianza, etc.)
    }

    # Uso:
    mi_funcion_estadistica(c(1,2,3,4,5)) # Usa alfa = 0.05
    mi_funcion_estadistica(c(1,2,3), alfa = 0.10) # Usa alfa = 0.10
    ```

-----

## 3.3 Familias `apply` y Paquetes

### 💡 Explicación del Concepto

**Familias `apply` (Programación Funcional)**
En R, los ciclos `for` son útiles, pero a veces son lentos o engorrosos. R promueve un estilo de "programación funcional". En lugar de *iterar* sobre un objeto, *aplicamos* una función a ese objeto.

Las funciones `apply` hacen esto por nosotros, y a menudo son más rápidas y limpias que un ciclo `for`.

  * `lapply(X, FUN)`: (List Apply). Toma una lista o vector `X` y aplica la función `FUN` a *cada elemento* de `X`. **Siempre devuelve una lista.**
  * `sapply(X, FUN)`: (Simplify Apply). Igual que `lapply`, pero *intenta simplificar* el resultado. Si `lapply` devuelve una lista de vectores de longitud 1, `sapply` lo simplifica a un solo vector. Es más conveniente, pero menos predecible.
  * `apply(X, MARGIN, FUN)`: Se usa en **Matrices** o Data Frames. Aplica `FUN` a las filas (`MARGIN = 1`) o a las columnas (`MARGIN = 2`).

**Paquetes (Packages)**
Ningún lenguaje puede hacer todo por sí solo. El poder de R reside en su comunidad y en los más de 18,000 **paquetes** (bibliotecas) disponibles en CRAN.

Un paquete es una colección de funciones, datos y documentación que extienden las capacidades de R.

  * `install.packages("nombre_paquete")`: Descarga e instala el paquete. Solo se hace una vez.
  * `library(nombre_paquete)`: Carga el paquete en la memoria para la sesión actual. Debe hacerse *cada vez* que se inicia R (o al inicio del script).

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: 'lapply'
# Tenemos una lista de vectores
lista_datos <- list(a = 1:5, b = 10:20)

# Queremos calcular la media de CADA elemento de la lista
medias_lista <- lapply(lista_datos, mean)
# 'medias_lista' es una LISTA: list(a = 3, b = 15)
```

```r
# Ejemplo 2: 'sapply' (Simplificado)
# Usando la misma lista
medias_vector <- sapply(lista_datos, mean)
# 'medias_vector' es un VECTOR: c(a = 3, b = 15)
```

```r
# Ejemplo 3: Instalación y carga de un paquete
# (ggplot2 es el paquete de visualización más famoso)

# 1. Instalar (solo una vez)
install.packages("ggplot2")

# 2. Cargar (al inicio de cada script/sesión)
library(ggplot2)

# Ahora podemos usar las funciones de ggplot2, como:
?ggplot
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Usar `sapply()` y el Data Frame `mtcars` (que ya viene en R) para calcular la desviación estándar (`sd`) de cada columna numérica (ej. las primeras 7 columnas: `mtcars[, 1:7]`).
2.  **Laboratorio:** Instalar el paquete `readr`. Cargar el paquete (`library(readr)`). Luego, usar la ayuda (`?readr`) para averiguar para qué tipo de archivos se utiliza este paquete.
3.  **Evaluación:** Explicar con sus palabras la principal diferencia entre `lapply()` y `sapply()`. ¿Cuándo preferiría usar `lapply` aunque `sapply` parezca más fácil?

### ✅ Solución a los Ejercicios

1.  **Práctica:**

    ```r
    # El Data Frame mtcars ya viene cargado

    # Seleccionamos solo las primeras 7 columnas (todas numéricas)
    columnas_numericas_mtcars <- mtcars[, 1:7]

    # Aplicamos la función 'sd' (desviación estándar) a cada
    # columna de ese subconjunto de datos.
    # sapply simplifica el resultado en un vector con nombres.
    desviaciones_std <- sapply(columnas_numericas_mtcars, sd)

    print(desviaciones_std)
    #       mpg       cyl      disp        hp      drat        wt      qsec 
    # 6.026948  1.785922 123.93869  68.56286   0.534679  0.978457  1.786943 
    ```

2.  **Laboratorio:**

    ```r
    # 1. Instalar
    install.packages("readr")

    # 2. Cargar
    library(readr)

    # 3. Ayuda
    ?readr
    ```

    *Respuesta (leyendo la ayuda):* El paquete `readr` (parte del Tidyverse) se utiliza para **leer archivos de datos planos** (como `.csv`, `.tsv`, `.fwf`). Sus funciones (`read_csv`, `read_tsv`) son alternativas mucho más rápidas y consistentes que las funciones base de R (como `read.csv`).

3.  **Evaluación:**

      * **Diferencia:** `lapply` (List Apply) **siempre** devuelve una **lista**. `sapply` (Simplify Apply) intenta "simplificar" el resultado; si el resultado de `lapply` era una lista de elementos simples (ej. números), `sapply` los convierte en un **vector** o **matriz**.
      * **Cuándo preferir `lapply`:** Se debe preferir `lapply` cuando se escribe código *robusto* (como dentro de una función o un paquete) donde la **predictibilidad** es clave. `sapply` puede fallar o dar un resultado inesperado (ej. una lista en lugar de un vector) si uno de los elementos de entrada es nulo o tiene un formato extraño. `lapply` *siempre* da una lista, por lo que el resto del código puede confiar en ese formato de salida.
