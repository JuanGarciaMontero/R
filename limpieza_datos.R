# LIMPIEZA DE DATOS
x <- c(10, 20, NA, 30, NA, 40)
is.na(x) # Nos dice los valores NA que tiene la variable x, devuelve True en las posicione donde hay NA
x[!is.na(x)] # Dame los valores que no sean NA

mean(x, na.rm=TRUE) # No tien en cuenta los valores NA

data("airquality")
df <- airquality

# Cantidad de valores NA
sum(is.na(df)) # Suma los NA que hay en ese conjunto de datos
summary(df)
colSums(is.na(df))

# Computar por la mediana
df$Ozone[is.na(df$Ozone)] <- median(df$Ozone, na.rm=TRUE)
df$Solar.R[is.na(df$Solar.R)] <- median(df$Solar.R, na.rm=TRUE)

# Otra opcion
df2 <- na.omit(airquality)

# Corrección de Outliers, valores atípicos
boxplot(df) # Grafico de cajas

# Recojer ejemplos

# TRASFORMACIÓN DE VARIABLES CATEGÓRICAS
data("Titanic")
df <- as.data.frame(Titanic)

df$class_num <- ifelse(df$Class=="1st",1,
                       ifelse(df$Class=="2nd",2,
                             ifelse(df$Class=="3st",3,4)))
df$Sex_num <- ifelse(df$Sex=="Male",1,0)
df$Survived_num <- ifelse(df$Survived=="No",0,1)
df$Age_num <- ifelse(df$Age=="Child",1,0)

# One hot encoding, transformar las columnas categóricas a binarias
install.packages("dummies") #Deprecad
library(dummies)
df3 <- dummy.data.frame(df) # No va


# Alternativa
install(MASS)
install.packages("MASS")
library(MASS)
df3 <- data.frame(df)
variables_dummy <- model.matrix(~ Titanic - 1, df3)
variables_dummy




