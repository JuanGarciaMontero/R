# REDES NEURONALES
# El dataset Trigo.RData contiene datos pertenecientes a tres variedades de trigo. Se
# midieron siete parametros geometricos de los granos de trigo:
# 1. area A,
# 2. perimetro P,
# 3. compacidad C = 4 * pi * A/P^2,
# 4. longitud del nucleo,
# 5. ancho del nucleo,
# 6. coeciente de asimetra
# 7. longitud de la ranura del nucleo.
# La ultima columna contiene la etiqueta de cada una de las tres variedades (1,2,3)

table(Trigo$X8) #Conjunto balanceado hay 70 resultados de cada clase

# set.seed(1)
# load("Trigo.RData")

Datos <- Trigo

Datos$Tipo1 <- -1
Datos$Tipo2 <- -1
Datos$Tipo3 <- -1

Datos$Tipo1 <-  ifelse(Datos$X8 == 1, 1, Datos$Tipo1)
Datos$Tipo2 <-  ifelse(Datos$X8 == 2, 1, Datos$Tipo2)
Datos$Tipo3 <-  ifelse(Datos$X8 == 3, 1, Datos$Tipo3)

Datos$X8 <- NULL

# Normalizar los datos
for(k in 1:7){
  Datos[,k] <- (Datos[,k]-mean(Datos[,k]))/(max(Datos[,k]-min(Datos[,k])))
}


index <- sample(1:nrow(Datos), size=0.8 * nrow(Datos))
train <- Datos[index,]
test <- Datos[-index,]

install.packages("neuralnet")
library(neuralnet)

nn <- neuralnet((Tipo1+Tipo2+Tipo3) ~ X1+X2+X3+X4+X5+X6+X7,
                  data = train,
                  hidden = 5,
                  act.fct = "tanh",
                  linear.output = FALSE # Si quiero regresión en vez de clasificación cambiar False por True
                )
plot(nn)

pr.nn <- compute(nn, test[, 1:7])
pr.nn$net.result

pred = max.col(pr.nn$net.result)

pred

real <- Trigo$X8[-index]
print(mean(pred==real)*100)

table(pred, real)

