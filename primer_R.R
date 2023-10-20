# COMANDOS ÚTILES
print("Hola a todos")

# Conocer directorio
getwd()

# Cambiar directorio
setwd("C:/Users/jgmen/Desktop/R")

# Ejecutar todo el código
print("Ejecutar todo el código")

# Instalar paquetes y utilización
install.packages("plotly")
library(plotly)

# Ayuda
?print
help(print)

# Asignar valores a variables, tambien vale  "=" mejor acostumbrarse "<-"
x <- 5
y <- (4*x+5/2) - log(x) + cos(2*pi*x)
y
print(y)

# Eliminar una variable
rm(y)

# Borrar el contenido del workspace
rm(list=ls())


