# ARBOLES DE DECISION

# VER EN IMAGEN -> FireShot Capture 185 - Machine Learning para principiantes - Academia OW - openwebinars.net

# ALGORITMOS RANDOM FOREST Y GRADIENT BOSSTING (XGBOOST). Son combinaciones de arboles de decisión

# LO VEMOS EN EL CASO PRÁCTICO


# IMPORTANCIA DE VARIABLES UTILIZANDO MODELOS DE MACHINE LEARNING

data("mtcars")
data

install.packages("randomForest") # Para seleccionar las variables más representativas
library(randomForest)

model <- randomForest(mpg ~ ., data=mtcars, ntree = 100)

importance(model)
varImpPlot(model)


install.packages("Boruta") # Crea variable aleatorias y las compara con las verdaderas y determina cuel son mejores
library(Boruta)

mtcars$new <- runif(nrow(mtcars), 0, 1)

boruta_output <- Boruta(mpg ~ ., data=mtcars, doTrace=2, maxRuns = 50)  # Método Boruta

plot(boruta_output, las = 2, xlab="",main="Varible Importance")

boruta_signif<- names(boruta_output$finalDecision[boruta_output$finalDecision %in% c("Confirmed", "Tentative")])  

