# Sesión 4: Depuración de Scripts, Repaso Prueba

## 4.1 Manejo de Errores y Advertencias

### 💡 Explicación del Concepto

Cuando el código falla, R nos da mensajes para ayudarnos a encontrar el problema. Es crucial aprender a leerlos. Hay tres tipos principales:

1.  **Error (Error):** ¡Detención total! El código no puede continuar ejecutándose. Esto ocurre por errores de sintaxis (ej. falta un paréntesis `)`), o errores lógicos (ej. `sqrt("a")`, intentar sacar la raíz cuadrada de un texto). La ejecución se detiene.
2.  **Warning (Advertencia):** ¡Precaución! R ejecutó el código, pero sospecha que algo salió mal o que el resultado podría no ser el esperado. Un `Warning` *no detiene* la ejecución. (Ej. la "regla de reciclaje" de la Sesión 1, o convertir texto a número y generar un `NA`).
3.  **Message (Mensaje):** Informativo. El código se ejecuta bien. R (o un paquete) solo quiere informarle de algo. (Ej. `library(tidyverse)` genera mensajes sobre los paquetes que está cargando).

**Valores Especiales:**
* `NA` (Not Available): Significa que el dato "falta" o "no está disponible". Es un concepto clave en estadística.
* `NaN` (Not a Number): Es el resultado de una operación matemática indefinida, como `0/0` o `log(-1)`.
* `Inf` (Infinito): El resultado de `1/0`.

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Generar un ERROR
# R no puede calcular la raíz cuadrada de un texto.
# La ejecución se detiene aquí.
sqrt("a")
# Error in sqrt("a") : non-numeric argument to mathematical function
````

```r
# Ejemplo 2: Generar un WARNING
# Intentamos convertir un vector a numérico, pero "tres" no es un número.
# R lo convierte en NA (Not Available) y nos advierte.
vector_mixto <- c("1", "2", "tres", "4")
vector_numerico <- as.numeric(vector_mixto) 
# Warning message:
# NAs introduced by coercion 

print(vector_numerico)
# [1]  1  2 NA  4
```

```r
# Ejemplo 3: Operaciones con NA
# La mayoría de funciones fallan si hay un NA
vector_con_na <- c(10, 20, NA, 40)
mean(vector_con_na)
# Output: [1] NA
# R dice: "Si no sé un valor, no puedo calcular la media".

# La solución es usar el argumento 'na.rm' (NA remove)
mean(vector_con_na, na.rm = TRUE)
# Output: [1] 23.33333
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Escribir un código que intencionalmente genere un `Warning` al intentar convertir un factor con texto a tipo numérico.
2.  **Laboratorio:** Generar un vector que contenga `NA`, `NaN` (se genera con `0/0`) e `Inf` (se genera con `1/0`). Luego, usar las funciones `is.na()`, `is.nan()` y `is.infinite()` en ese vector. (Pista: `is.na()` es especial).
3.  **Clase:** Discutir el error `Error: object 'x' not found`. ¿Cuáles son las 3 causas más probables de este error?

### ✅ Solución a los Ejercicios

1.  **Práctica:**
    ```r
    # Creamos un factor con niveles de texto
    mis_niveles <- factor(c("Nivel 1", "Nivel 2", "Nivel 1"))

    # Al intentar convertirlo a numérico, R no sabe qué hacer
    # con "Nivel 1" y "Nivel 2", los convierte en NA y avisa.
    as.numeric(mis_niveles)
    # Output: [1] 1 2 1
    # (Dato curioso: si el factor se creó de números, R recuerda los números. 
    # ¡Pero si se creó de texto, as.numeric() da NA y un Warning!)

    # Un mejor ejemplo (el de la diapositiva):
    vector_mixto <- c("1", "2", "tres", "4")
    as.numeric(vector_mixto)
    # Warning message: NAs introduced by coercion
    ```
2.  **Laboratorio:**
    ```r
    # 1. Creamos el vector
    v_especial <- c(1, 100, NA, 0/0, 1/0)
    print(v_especial)
    # [1]   1 100  NA NaN Inf

    # 2. Probamos las funciones 'is.'
    is.nan(v_especial)
    # [1] FALSE FALSE FALSE  TRUE FALSE

    is.infinite(v_especial)
    # [1] FALSE FALSE FALSE FALSE  TRUE

    # Pista: is.na() también captura NaN
    is.na(v_especial)
    # [1] FALSE FALSE  TRUE  TRUE FALSE

    # Para encontrar solo NA (y no NaN):
    is.na(v_especial) & !is.nan(v_especial)
    # [1] FALSE FALSE  TRUE FALSE FALSE
    ```
3.  **Clase:**
    El error `Error: object 'x' not found` es el más común en R. Las 3 causas probables son:
    1.  **Error tipográfico:** Quería escribir `mi_variable` pero escribió `mi_varibale`.
    2.  **Ámbito (Scope):** La variable `x` fue creada *dentro* de una función y está intentando usarla *fuera* de ella (R ya la "olvidó").
    3.  **Orden de ejecución:** La línea donde se usa `x` se ejecutó *antes* de la línea donde se define `x` (ej. al correr líneas sueltas en el script).

-----

## 4.2 Herramientas de Depuración (Debugging)

### 💡 Explicación del Concepto

Depurar (Debugging) es el arte de encontrar y corregir errores (bugs) en el código. En lugar de solo usar `print()` por todas partes, RStudio nos da herramientas profesionales.

**Breakpoints (Puntos de Interrupción)**
Es la herramienta principal. Un Breakpoint es una "señal de pare" que ponemos en nuestro script.

  * **¿Cómo?** Haciendo clic a la izquierda del número de línea en el editor de RStudio (aparece un círculo rojo).
  * **¿Qué hace?** Cuando RStudio ejecuta el script (usando `Source`), la ejecución se *pausará* justo *antes* de ejecutar esa línea.
  * **¿Por qué?** En ese momento de pausa, la Consola se convierte en un "Navegador" (Browser). Podemos inspeccionar el valor de *todas* las variables en ese preciso instante (en la pestaña *Environment*), y podemos ejecutar código línea por línea (usando los botones `Next` o `Continue`).

**Función `browser()`**
Esta función es un "breakpoint de código". Si escribe `browser()` en cualquier parte de su script (ej. dentro de un `if` o un `for`), R pausará la ejecución en ese punto, exactamente como si hubiera un breakpoint. Es muy útil para depurar funciones complejas o ciclos.

**Función `traceback()`**
Si un script falla (da un `Error`), puede ejecutar `traceback()` *inmediatamente después* en la consola. Esta función le mostrará la "pila de llamadas" (call stack), es decir, la secuencia de funciones que se llamaron hasta que ocurrió el error. Es muy útil para saber *dónde* ocurrió el error cuando tiene funciones que llaman a otras funciones.

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Poner un Breakpoint
# 1. Escriba este código en su script.
# 2. Ponga un breakpoint (círculo rojo) en la línea 'z <- x + y'.
# 3. Corra el script con el botón 'Source'.
# 4. RStudio se pausará. Mire la pestaña Environment.
#    Verá 'x' (10) e 'y' (20), pero 'z' aún no existe.

x <- 10
y <- 20
z <- x + y
print(z)
```

```r
# Ejemplo 2: Usar browser() dentro de una función
# Queremos saber qué pasa dentro de esta función
mi_funcion_compleja <- function(a) {
  b <- a * 2
  
  # Pausamos la ejecución aquí
  browser() 
  
  # R se detendrá ANTES de ejecutar esta línea
  c <- b + 10
  return(c)
}

# Al ejecutar esto, RStudio se pausará
mi_funcion_compleja(5)
# En la consola (que dirá 'Browse[1]>'), puede escribir 'b'
# y R le dirá que b = 10.
```

```r
# Ejemplo 3: Usar traceback()
# Primero, ejecute este código que falla:
log("texto")
# Error in log("texto") : non-numeric argument to mathematical function

# Ahora, ejecute esto en la consola:
traceback()
# 1: log("texto")
# (Este es simple, pero si estuviera dentro de 3 funciones,
# mostraría las 3 llamadas anidadas)
```

### ✏️ Ejercicios Propuestos

1.  **Práctica:** Copiar el código del Ejemplo 1 (`x, y, z`) y usar los botones de depuración (Breakpoint) para ejecutar el script línea por línea (`Next`).
2.  **Laboratorio:** Crear una función que tenga un ciclo `for` de 1 a 5. Dentro del ciclo, insertar un `browser()` que se active *solo* si `i == 3`. Correr la función y verificar el valor de `i` cuando se pause.
3.  **Evaluación:** Explicar la utilidad de `traceback()` en un escenario donde una función A llama a una función B, y la función B llama a la función C, y es la función C la que falla.

### ✅ Solución a los Ejercicios

1.  **Práctica:** (La solución es la acción en RStudio. El estudiante debe observar cómo en la pausa (breakpoint) `x` e `y` tienen valor, pero `z` no. Al presionar `Next`, la línea `z <- x + y` se ejecuta y `z` aparece en el Environment con el valor 30).
2.  **Laboratorio:**
    ```r
    funcion_con_breakpoint_condicional <- function() {
      for (i in 1:5) {
        
        print(paste("Iteración:", i))
        
        # Breakpoint condicional:
        if (i == 3) {
          browser() # Se pausará solo en la tercera iteración
        }
        
        # ... más código del ciclo ...
      }
      print("Ciclo terminado")
    }

    # Ejecutar la función
    funcion_con_breakpoint_condicional()

    # (El código se pausa. El estudiante debe escribir 'i'
    # en la consola 'Browse[1]>' y ver que el resultado es 3)
    ```
3.  **Evaluación:**
    Si la Función A llama a B, y B llama a C (y C falla), el `Error` se mostrará en la consola, pero puede ser difícil saber *quién* llamó a C.
    Si se ejecuta `traceback()`:
      * Mostrará un rastro (la pila de llamadas) similar a este:
        ```
        3: C()
        2: B()
        1: A()
        ```
      * Esto nos permite "rastrear" el origen del error. Nos dice que el error ocurrió en la función `C`, la cual fue llamada por `B`, la cual a su vez fue llamada por `A`. Esto es indispensable para depurar programas complejos.

-----

## 4.3 Repaso General y Preparación de Prueba

### 💡 Explicación del Concepto

Esta sección es para consolidar el conocimiento de las sesiones 1, 2 y 3, preparándonos para una evaluación.

**Conceptos Clave a Repasar:**

  * **Tipos de Datos:** `numeric`, `character`, `logical`.
  * **Estructuras de Datos:**
      * **Vector:** 1D, homogéneo. Se crea con `c()`.
      * **Matriz:** 2D, homogénea. Se crea con `matrix()`.
      * **Data Frame:** 2D, heterogéneo. Se crea con `data.frame()`. (¡El más importante\!).
      * **Lista:** N-D, heterogénea. Se crea con `list()`.
  * **Control de Flujo:**
      * **Condicional:** `if-else` (para una condición) y `ifelse()` (para vectores).
      * **Ciclos:** `for` (iteraciones conocidas) y `while` (basado en condición).
  * **Funciones:**
      * **Sintaxis:** `nombre <- function(arg) { ... return() ... }`
      * **Funcional:** `lapply()` (devuelve lista), `sapply()` (intenta simplificar).
  * **Paquetes:** `install.packages()` y `library()`.

**Buenas Prácticas:**

  * **Comentarios:** Usar `#` para explicar el *por qué* de su código, no el *qué*.
  * **Nombres de Variables:** Usar `snake_case` (ej. `mi_variable_larga`) o `camelCase` (ej. `miVariableLarga`). Ser descriptivo.
  * **No Repetirse (DRY):** Si copia y pega código más de dos veces, probablemente debería estar en una **función**.

### 💻 Ejemplos de Código (Repaso)

```r
# Ejemplo 1: Ejercicio Integrado (Datos, Ciclo, Condición)
# Crear una función que reciba un vector de números y 
# devuelva la suma de los elementos que son mayores a la media.

sumar_sobre_la_media <- function(vector_numeros) {
  media <- mean(vector_numeros, na.rm = TRUE)
  suma_total <- 0
  
  for (numero in vector_numeros) {
    # Asegurarse de no sumar NAs
    if (!is.na(numero)) {
      if (numero > media) {
        suma_total <- suma_total + numero
      }
    }
  }
  return(suma_total)
}

# Uso:
datos <- c(1, 2, 10, 12, NA, 5) # Media es (1+2+10+12+5)/5 = 6
sumar_sobre_la_media(datos) # Suma 10 + 12 = 22
```

### ✏️ Ejercicios Propuestos

1.  **Práctica (Conceptual):** Responder rápido:

    1.  ¿Vector vs Data Frame? (R: 1D/Homogéneo vs 2D/Heterogéneo).
    2.  ¿`for` vs `sapply`? (R: Iteración vs Aplicación de función).
    3.  ¿`if` vs `ifelse`? (R: Una condición vs Vector de condiciones).

2.  **Laboratorio (Refactorización):** El siguiente código "funciona", pero es un mal código. Reescríbalo (refactorice) usando buenas prácticas (ej. una función).

    ```r
    # Código Malo
    datos1 <- c(5, 10, 15)
    media1 <- sum(datos1) / length(datos1)
    datos2 <- c(10, 20, 30, 40)
    media2 <- sum(datos2) / length(datos2)
    ```

3.  **Evaluación (Simulacro):** Escriba un Data Frame con 3 columnas (`Producto`, `Precio`, `Stock`) y 3 filas. Luego, use `ifelse()` para agregar una cuarta columna llamada `Prioridad` que diga "ALTA" si el `Stock` es menor a 10, y "BAJA" en caso contrario.

### ✅ Solución a los Ejercicios

1.  **Práctica:** (Las respuestas están en el mismo enunciado).

2.  **Laboratorio (Refactorización):** El código viola el principio DRY (se repite el cálculo de la media). La solución es una función.

    ```r
    # Código Bueno (Refactorizado)

    # 1. Definimos la función (mean ya existe, pero imaginemos que no)
    calcular_media <- function(vector_datos) {
      # (Podríamos añadir chequeos de NA, etc.)
      media <- sum(vector_datos) / length(vector_datos)
      return(media)
    }

    # 2. Usamos la función (código limpio y reutilizable)
    datos1 <- c(5, 10, 15)
    media1 <- calcular_media(datos1) # media1 = 10

    datos2 <- c(10, 20, 30, 40)
    media2 <- calcular_media(datos2) # media2 = 25
    ```

3.  **Evaluación (Simulacro):**

    ```r
    # 1. Crear el Data Frame
    df_inventario <- data.frame(
      Producto = c("Manzana", "Naranja", "Plátano"),
      Precio = c(1.2, 0.8, 0.5),
      Stock = c(15, 5, 20)
    )

    # 2. Usar ifelse() para crear la nueva columna
    df_inventario$Prioridad <- ifelse(df_inventario$Stock < 10, "ALTA", "BAJA")

    # 3. Mostrar resultado
    print(df_inventario)
    #   Producto Precio Stock Prioridad
    # 1  Manzana    1.2    15      BAJA
    # 2  Naranja    0.8     5      ALTA
    # 3  Plátano    0.5    20      BAJA
    ```
