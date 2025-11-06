# Sesión 1: Presentación - Fundamentos

## 1.1 Introducción a R y RStudio

### 💡 Explicación del Concepto

**¿Qué es R?**
R es un **lenguaje de programación** y un entorno de software enfocado en el **cálculo estadístico y la visualización de datos**. Nació en el ámbito académico y se ha convertido en el estándar de facto en disciplinas como la ciencia de datos (Data Science), la bioinformática y las finanzas.

**¿Qué es RStudio?**
Si R es el "motor" del auto, RStudio es el "tablero de control" (el volante, los pedales y el panel de instrumentos). RStudio es un **Entorno de Desarrollo Integrado (IDE)** que nos facilita enormemente el trabajo con R. Nos proporciona en una sola pantalla:

1.  **Editor (Script):** Arriba a la izquierda. Aquí escribimos nuestro código (el "guion" de la película).
2.  **Consola:** Abajo a la izquierda. Aquí es donde R realmente ejecuta el código y muestra los resultados (la "película").
3.  **Entorno (Environment):** Arriba a la derecha. Aquí vemos todos los "objetos" (datos, variables) que hemos creado en nuestra sesión.
4.  **Misceláneo:** Abajo a la derecha. Pestañas para ver Archivos, Gráficos (Plots), Paquetes (Packages) y Ayuda (Help).

**Flujo de Trabajo:** El flujo de trabajo ideal es escribir el código en el **Editor** (para poder guardarlo y reutilizarlo), y luego enviarlo a la **Consola** para que se ejecute (usando `Cmd+Enter` en macOS o `Ctrl+Enter` en Windows).

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Operaciones aritméticas directas en la Consola
# R respeta la precedencia de operadores (primero multiplica, luego suma)
10 + 5 * 2
```

```r
# Ejemplo 2: Asignación de variables
# Usamos '<-' para guardar el resultado en una "caja" o "variable"
# El nombre 'mi_valor' ahora contiene el número 42
mi_valor <- 42
print(mi_valor)
```

```r
# Ejemplo 3: Instalación de un paquete (una colección de funciones)
# 'tidyverse' es una colección esencial de paquetes para ciencia de datos
# Esto solo se hace UNA VEZ por computador.
install.packages("tidyverse")
```
---
### ✏️ Ejercicios Propuestos
**Laboratorio**: Configurar un nuevo proyecto de RStudio llamado "**Programacion_R**". (Hacer esto desde File > New Project...).

#### ✅ Solución

Laboratorio: (La solución es realizar la acción en RStudio. Esto crea una carpeta en el computador que contendrá todos los scripts y archivos del curso).

---

**Teórico**: Mencionar 3 áreas (además de la estadística) donde R es fundamental en la industria o la academia.

#### ✅ Solución

Teórico:

* Bioinformática: Para análisis de secuencias de ADN y genómica (ej. paquetes de Bioconductor).

* Finanzas Cuantitativas: Para modelar series de tiempo, riesgo de mercado y optimización de portafolios.

* Marketing (Marketing Analytics): Para analizar el comportamiento del consumidor, segmentación de clientes y modelos de atribución.

---

**Práctica**: Ejecutar el comando install.packages("tidyverse") y explicar con sus palabras qué cree que hizo R.

#### ✅ Solución

```r
# El estudiante debe ejecutar esto en su consola:
install.packages("tidyverse")
```
Explicación: Al ejecutar este comando, R se conecta a CRAN (el repositorio oficial de paquetes de R). Busca el paquete llamado "tidyverse", descarga los archivos (y todas sus "dependencias" o paquetes que necesita para funcionar) y los instala en el computador. Ahora, el paquete está disponible para ser cargado en futuras sesiones (con library(tidyverse)).

---

## 1.2 Tipos de Datos y Objetos Fundamentales
### 💡 Explicación del Concepto
En R, todo es un "objeto". El objeto más básico es el vector.

Un vector es una colección de elementos del mismo tipo. Piense en él como una sola columna en una hoja de cálculo. Si mezcla tipos, R forzará que todos sean del tipo más "flexible" (usualmente, texto).

Los tipos de datos atómicos (básicos) más comunes son:

* numeric (numérico): Números con decimales. Ej: 10.5, 3.14159.

* integer (entero): Números sin decimales. Se definen con una L al final. Ej: 10L, 50L. (En la práctica, R maneja bien los enteros sin la L, pero el tipo subyacente será numeric).

* character (texto): Texto, siempre debe ir entre comillas (simples o dobles). Ej: "Hola", 'R es genial'.

* logical (lógico): Valores de Verdadero o Falso. Solo pueden ser TRUE (o T) y FALSE (o F).

**Indexación**: Para acceder a un elemento dentro de un vector, usamos corchetes [] con la posición del elemento que queremos. Importante: ¡En R, el primer elemento está en la posición [1], no en la [0] como en otros lenguajes!

### 💻 Ejemplos de Código en R


```r
# Ejemplo 1: Creación de un vector numérico (con decimales)
pi_aprox <- 3.14159
# La función c() (de "combinar") crea vectores
edades <- c(25, 30, 22)
print(pi_aprox)
print(edades)
```

```r
# Ejemplo 2: Creación de un vector lógico
# ¿Están aprobados estos estudiantes?
aprobado <- c(TRUE, FALSE, TRUE, TRUE)
print(aprobado)
```

```r
# Ejemplo 3: Indexación de vectores
# Queremos ver el segundo elemento del vector 'aprobado'
segundo_aprobado <- aprobado[2]
# segundo_aprobado ahora contiene FALSE
print(segundo_aprobado)
```

### ✏️ Ejercicios Propuestos

1. **Práctica**: Crear una variable (vector) para cada uno de los 4 tipos de datos atómicos (numeric, integer, character, logical).

#### ✅ Solución

```r
v_numeric <- 10.5
v_integer <- 10L  # La L fuerza el tipo integer
v_character <- "Hola R"
v_logical <- TRUE # O T
print(v_numeric)
print(v_integer)
print(v_character)
print(v_logical)
```

2. **Clase**: Usar las funciones class() y typeof() en cada una de las variables creadas en el ejercicio anterior. Ej: class(mi_variable_numerica). ¿Nota alguna diferencia?

```r
# Para el vector numérico
class(v_numeric)   # Output: [1] "numeric"
typeof(v_numeric)  # Output: [1] "double" (Dato curioso: R almacena todos los numéricos como 'double')

# Para el vector entero
class(v_integer)   # Output: [1] "integer"
typeof(v_integer)  # Output: [1] "integer"

# Para el vector de texto
class(v_character)   # Output: [1] "character"
typeof(v_character)  # Output: [1] "character"

# Para el vector lógico
class(v_logical)   # Output: [1] "logical"
typeof(v_logical)  # Output: [1] "logical"
```
**Explicación**: class() nos dice el tipo de objeto "visible" para el usuario, mientras typeof() nos dice cómo R lo almacena internamente. La única diferencia notable es numeric (clase) vs double (tipo).

3. **Evaluación**: Crear un vector llamado nombres que contenga 5 nombres de compañeros. Luego, escribir el código para imprimir solo el tercer y el quinto nombre en una sola línea de comando.

```r
nombres <- c("Ana", "Juan", "Maria", "Pedro", "Luisa")

# Para seleccionar múltiples elementos, le pasamos un *vector* de posiciones
nombres[c(3, 5)] 
# Output: [1] "Maria" "Luisa"
```

## 1.3 Operaciones y Ayuda

### 💡 Explicación del Concepto

**Operaciones Vectorizadas**: Esta es la característica más importante y poderosa de R. La mayoría de lenguajes requeriría un ciclo (for) para sumar dos listas de números. En R, las operaciones se aplican elemento por elemento automáticamente.

Si ejecuta c(1, 2) + c(10, 20), R entiende que debe sumar 1+10 y 2+20, devolviendo c(11, 22). Esto hace que el código sea más limpio, rápido y fácil de leer.

Funciones Básicas: R viene con miles de funciones. Las más comunes para vectores son:

* sum(mi_vector): Suma todos los elementos.

* mean(mi_vector): Calcula el promedio (media aritmética).

* length(mi_vector): Devuelve cuántos elementos tiene el vector.

**Sistema de Ayuda**: ¡Nadie se sabe todas las funciones de memoria! El sistema de ayuda es fundamental.

* ?nombre_funcion (ej. ?mean): Abre la documentación oficial de la función en la pestaña de Ayuda de RStudio.

* help("termino"): Busca ayuda sobre un término (ej. help("vector")).

### 💻 Ejemplos de Código en R

```r
# Ejemplo 1: Suma vectorial (vectorizada)
ventas_enero <- c(100, 200, 50)
ventas_febrero <- c(110, 190, 60)

# R suma elemento por elemento
ventas_totales <- ventas_enero + ventas_febrero
# ventas_totales es [1] 210 390 110
```

```r
# Ejemplo 2: Uso de funciones básicas
notas <- c(7.0, 5.5, 6.0)

# Calcular el promedio de las notas
promedio_notas <- mean(notas)
# promedio_notas es 6.1666...
```

```r
# Ejemplo 3: Obtener ayuda
# ¿Qué hace la función 'sum'? ¿Qué argumentos tiene?
?sum
```

### ✏️ Ejercicios Propuestos

1. **Práctica**: Crear dos vectores numéricos de 4 elementos cada uno (ej. vector_a y vector_b). Escribir el código para multiplicarlos elemento por elemento.

#### ✅ Solución
```r
vector_a <- c(1, 2, 3, 4)
vector_b <- c(10, 20, 30, 40)

# R usa el '*' para multiplicación elemento por elemento
resultado_multiplicacion <- vector_a * vector_b

print(resultado_multiplicacion)
# Output: [1] 10 40 90 160
```

2. **Laboratorio**: Usar la función rnorm(100) para generar 100 números aleatorios con distribución normal. Luego, calcular la media (mean) y la desviación estándar (sd) de esos 100 números.

#### ✅ Solución
```r
# Generamos los 100 números aleatorios
# (Sus números serán diferentes, ¡porque es aleatorio!)
muestra_aleatoria <- rnorm(100)

# Calculamos la media
media_muestra <- mean(muestra_aleatoria)

# Calculamos la desviación estándar
desviacion_muestra <- sd(muestra_aleatoria)

print(paste("Media:", media_muestra))
print(paste("Desv. Estándar:", desviacion_muestra))
# (La media debería ser cercana a 0 y la desv. estándar cercana a 1)
```

3. **Teórico**: ¿Qué sucede si intenta sumar un vector de longitud 3 con un vector de longitud 5? (Ej. c(1, 2, 3) + c(1, 2, 3, 4, 5)). Pruebe el código y explique el Warning (advertencia) que aparece.

#### ✅ Solución
```r
c(1, 2, 3) + c(1, 2, 3, 4, 5)
```
Resultado en la consola:
```r
[1] 2 4 6 5 7
Warning message:
In c(1, 2, 3) + c(1, 2, 3, 4, 5) :
  longer object length is not a multiple of shorter object length
```

Explicación (Regla de Reciclaje): R aplica la "Regla de Reciclaje". Intenta "reciclar" el vector más corto para que coincida con la longitud del más largo.

* Suma 1+1 (ok), 2+2 (ok), 3+3 (ok).

* Se acaba el vector corto. R lo "recicla" (vuelve a empezar).

* Suma 1 (del reciclado) + 4 (ok), 2 (del reciclado) + 5 (ok).

* El Warning (advertencia) nos dice: "Oye, hice esto, pero el vector largo (5) no es un múltiplo exacto del corto (3), así que esto probablemente no es lo que querías hacer". Si el vector corto tuviera 2 elementos y el largo 4, R lo haría sin advertencia (ej. c(1, 2) + c(1, 2, 3, 4)).
