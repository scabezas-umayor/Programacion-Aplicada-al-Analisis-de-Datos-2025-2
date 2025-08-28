# IF-ELSE

# Indicar si alguien es mayor o menor de edad
edad <- 16
if (edad >= 18){
    print("Es mayor de edad");
}else{
    print("Es menor de edad");
}
# Asignando valores a las variables, realice lo siguiente:
# Ingrese 4 notas, calcule el promedio e indique la nota mas alta
# Salida: "El promedio es: 5,0 y la nota más alta fue: 6,0"
# linea_salida <- paste(variable, " texto ")

nota1 <- 1.0
nota2 <- 7.0
nota3 <- 3.0
nota4 <- 6.0

promedio <- (nota1 + nota2 + nota3 + nota4) / 4;

notaMasAlta <- nota1;

if (nota2 > notaMasAlta){
    notaMasAlta <- nota2;
}
if (nota3 > notaMasAlta){
    notaMasAlta <- nota3;
}
if (nota4 > notaMasAlta){
    notaMasAlta <- nota4;
}
out <- paste("El promedio es: ", promedio ," y la nota más alta fue: ", notaMasAlta);
print(out);
