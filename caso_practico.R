# CASO PRÁCTICO
set.seed(500) # Utilizamos este comando para que los resultados aleatorios sean siempre los mismos

# Carga de datos
library(MASS)
data <- Boston
# CRIM: tasa de criminalidad
# ZN - proporcion de terrenos residenciales divididos en zonas para lotes de mas de 25,000 pies cuadrados.
# INDUS - proporcion de acres comerciales no comerciales por ciudad.
# CHAS - (1 si el tramo limita al ro; de lo contrario)
# NOX: concentracion de oxidos ntricos (partes por 10 millones)
# RM: numero promedio de habitaciones por vivienda
# AGE: proporcion de unidades ocupadas por el propietario construidas antes de 1940
# DIS - distancias ponderadas a cinco centros de empleo de Boston
# RAD - Indice de accesibilidad a las carreteras radiales
# IMPUESTO - tasa de impuesto a la propiedad
# PTRATIO - proporcion alumno-maestro por ciudad
# BLACK - proporcion de negros por barrio
# LSTAT -% estado mas bajo de la poblacion
# MEDV - Valor mediano de las casas (variable de salida)

# División train-test. divido el 80% para el entrenamiento y 20% test
index <- sample(1:nrow(data),round(0.80*nrow(data)))
train <- data[index,]
test <- data[-index,]

# Comprobación valores NA. Valores perdidos. En este caso no hay
miss <- colSums(is.na(train))
miss

miss_test <- colSums(is.na(test))
miss_test

# Importancia de variables
library(Boruta)
boruta_output <- Boruta(medv ~ ., data=train, doTrace=2, maxRuns = 50)  # perform Boruta search
# boruta_signif<- names(boruta_output$finalDecision[boruta_output$finalDecision %in% c("Confirmed", "Tentative")])  # collect Confirmed and Tentative variables
plot(boruta_output, las=2, xlab="", main="Variable Importance")  # plot variable importance


# Modelo de regresión Lineal
lm.fit <- lm(medv~., data=train)
summary(lm.fit)
# Predicción
pr.lm <- predict(lm.fit,test)
# Error MSE
MSE.lm <- sum((pr.lm - test$medv)^2)/nrow(test)
print(MSE.lm) # 24.77
# Error en porcentaje
error_porcentaje.lm = 100*mean((pr.lm-test$medv)/test$medv)
print(error_porcentaje.lm) # 4.52
# Scatter plot predicción y realidad
plot(test$medv,pr.lm)
abline(0,1,col="red")
cor(test$medv,pr.lm)^2 # coeficiente R^2 = 0.66


# Modelo de redes neuronales

# Normalizo los datos de entrenamiento
train_norm <- train
for (k in 1:14){
  train_norm[,k]=(train[,k]-mean(train[,k]))/(max(train[,k])-min(train[,k]))
}

library(neuralnet)
# Aplico el modelo
nn <- neuralnet(medv ~ crim + zn + indus + chas 
                + nox + rm + age + dis + rad + tax + ptratio +
                  black + lstat
                ,data=train_norm,
                hidden=c(13), # 13 neuronas en la capa oculta
                act.fct = "tanh", # Función de activación de tipo tanh
                linear.output=T)
# Plot de la red neuronal
plot(nn)

# Normalizo los datos de test
test_norm <- test
for (k in 1:14){
  test_norm[,k]=(test[,k]-mean(train[,k]))/(max(train[,k])-min(train[,k]))
}

# Predicción con el conjunto de test
pr.nn <- compute(nn,test_norm[,1:13])
# Des-normalización de las predicciones
pred.nn = pr.nn$net.result*(max(train[,14])-min(train[,14]))+mean(train[,14])
# Error MSE
MSE.nn <- sum((test$medv - pred.nn)^2)/nrow(test)
print(MSE.nn) # 13.61
error_porcentaje.nn = 100*mean((pred.nn-test$medv)/test$medv)
print(error_porcentaje.nn) # 0.97
# Comparo la predicción y los valores reales en un scatter plot
plot(test$medv,pred.nn)
abline(0,1,col="red")
cor(test$medv,pred.nn)^2 # Coeficiente R^2 = 0.82



# RANDOM FOREST
library(randomForest)
rf <- randomForest(medv~., data=train,ntree=500)
pr.rf <- predict(rf,test)
MSE.rf <- sum((pr.rf - test$medv)^2)/nrow(test)
print(MSE.rf) # 11.72 
error_porcentaje.rf = 100*mean((pr.rf-test$medv)/test$medv)
print(error_porcentaje.rf) # 7.39
plot(test$medv,pr.rf)
abline(0,1,col="red")
cor(test$medv,pr.rf)^2 # R^2 = 0.85

# GBM
install.packages("caret")
library(caret)
# CrossValidation. Validación cruzada importante a la hora de crear modelos
ctrl <- trainControl(method = "repeatedcv", 
                     number = 10, repeats = 3, 
                     allowParallel= T)

modelGBM <- train(medv~., data=train, method="gbm", trControl=ctrl,verbose=F)

modelGBM
# El siguiente plot indica los mejores hiperparámetros del modelo
plot(modelGBM)
# Predicción
pr.gb <- predict(modelGBM,test)
MSE.gb <- sum((pr.gb - test$medv)^2)/nrow(test)
print(MSE.gb) # 11.79
error_porcentaje.gb = 100*mean((pr.gb-test$medv)/test$medv)
print(error_porcentaje.gb) # 3.74
plot(test$medv,pr.gb)
abline(0,1,col="red")
cor(test$medv,pr.gb)^2 # R^2 = 0.84

