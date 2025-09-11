# Ejemplo del uso de FOR
listaNumeros <- c(20,45,10,3,5,7);
suma_total <- 0;
for(numero in listaNumeros){
    suma_total <- suma_total + numero;
}
print(paste("La suma total es: ", suma_total))

# Ejemplo del uso de WHILE
# Mostrar números desde el 1 al 5
numero <- 1;
while(numero < 5){ # mientras sea verdadero
    # si la condicion no cambia, el ciclo no se termina
    print(numero)
    numero <- numero + 1; # variable incrementadora
}

# Ejemplo del uso del REPEAT (do-while)
# Mostrar números desde el 1 al 5
num <- 1;
repeat{
    print(num);
    num <- num + 1;
    if (num > 5){ # si la condición se cumple, se termina
        print("Se cumple el > 5");
        break; # el que rompe la condición
    }
}
