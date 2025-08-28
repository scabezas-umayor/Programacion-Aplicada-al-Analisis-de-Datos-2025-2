#Valores Numericos y Caracter
#Supongamos que un negocio vende un producto "Servo motor"
#El precio del producto es 59.900
#Se venden 3 productos.
#Queremos saber:
#Nombre y precio unitario del producto, cantidad y total
#ejemplo de la salida:
#PRODUCTO    | CANTIDAD | PRECIO UNITARIO | TOTAL
#Servo Motor |    3     |      59900      | 179700








# Solución

print("PRODUCTO    | CANTIDAD | PRECIO UNITARIO | TOTAL")
print("Servo Motor |    3     |      59900      | 179700")











# Asignar los valores a variables
nombre_producto <- "Servo motor"
precio_unitario <- 49900
cantidad <- 5

# Calcular el total
total <- precio_unitario * cantidad

# Salida Principal
print(nombre_producto)
print(precio_unitario)
print(cantidad)
print(total)









# Concatenar la salida
linea_salida <- paste(nombre_producto, " | ", cantidad, " | ", precio_unitario, " | ", total)

# Imprimir el encabezado y la línea de datos
print("PRODUCTO    | CANTIDAD | PRECIO UNITARIO | TOTAL")
print(linea_salida)










# Crear un data frame para la salida
datos_producto <- data.frame(
    PRODUCTO = nombre_producto,
    CANTIDAD = cantidad,
    `PRECIO UNITARIO` = precio_unitario,
    TOTAL = total,
    check.names = FALSE # Evitar que R cambie los nombres de las columnas
)
# Imprimir el data frame
print(datos_producto)
