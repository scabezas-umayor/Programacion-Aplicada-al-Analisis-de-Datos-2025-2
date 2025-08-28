# Asignando valores a las variables, realice lo siguiente:
# Ingrese 4 notas, calcule el promedio e indique la nota mas alta
# Salida: "El promedio es: 5,0 y la nota más alta fue: 6,0"
# linea_salida <- paste(variable, " texto ")

# Asignar las 4 notas a un vector
notas <- c(4.5, 6.0, 5.5, 3.8, 5.5, 4.7, 6.8, 4.1)

# Calcular el promedio usando la función mean()
promedio <- mean(notas)

# Encontrar la nota más alta usando la función max()
nota_mas_alta <- max(notas)

# Crear la línea de salida combinando texto y variables
linea_salida <- paste("El promedio es:", round(promedio, 1), "y la nota más alta fue:", nota_mas_alta)

# Imprimir el resultado
print(linea_salida)
