# Ejercicio Alerta de Baja Ley en Lotes de Mineral

leyes_lotes <- c(0.8, 1.2, 0.5, 1.5, 0.9, 0.6, 2.1, 1.0);
umbral_ley <- 1.0;
indice <- 1;
for(ley in leyes_lotes){
    if (ley < umbral_ley){
        print(paste("Alerta! El lote de la posicion ",indice," tiene una ley baja de ", ley));
    }
    indice <- indice + 1
}
# incluyendo la posicion
for (posicion in seq_along(leyes_lotes)){
    ley <- leyes_lotes[posicion];
    if (ley < umbral_ley){
        print(paste("Alerta! El lote de la posicion ",posicion," tiene una ley baja de ", ley));
    }
}
