# REGRESIONES LINEALES de una variable
data(cars)
data
plot(cars$speed,cars$dist)

modelo <- lm(dist ~ speed, data = cars)
summary(modelo)

abline(modelo$coefficients[1], modelo$coefficients[2], col="red")

# Predicción
predict(modelo, data.frame(speed=100))

# Error cometido RMSE
RMSE <- function(error){
  sqrt(mean(error^2))
}

# MAE
mae <- function(error){
  mean(abs(error))
}

pr = predict (modelo,cars)
error = pr-cars$dist
modelo$residuals

RMSE(error)
mae(error)

# Regersión Lineal de varias variables
install.packages("carData")
library(carData)
data("Salaries")
Salaries

modelo2 <- lm(salary~sex, data=Salaries) # cocatenar sex+rank
summary(modelo2)

modelo2 <- lm(salary~., data=Salaries)
summary(modelo2)

predict(modelo2, data.frame(rank="Prof", discipline="A",
                           yrs.since.phd=20, yrs.service=20,
                           sex="Female"))


