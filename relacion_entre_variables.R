datos <- as.table(matrix(c(5,1,3,10,8,3), ncol=3))
colnames(datos) <- c('Alta', 'Media', 'Baja')
rownames(datos) <- c('Hombre', 'Mujer')
datos
chisq.test(datos) # Si p-value es menor a 0.05 es significativa la relación

df <- read.csv("https://goo.gl/j6lRXD")
table(df$treatment, df$improvement)
chisq.test(table(df$treatment, df$improvement)) # Al 97% están relacionadas

# Relación entre variables numéricas y categóricas. ANOVA Comprueba la variaza en los grupos y entre los grupos. Entre filas y columnas.

insectos <- c(16,11,20,21,14,7,37,32,15,25,39,41,21,12,14,17,13,17,45,59,48,46,38,47)
colores <- as.factor(c(rep(c("azul", "verde", "blanco", "amarillo"), each=6)))
colores
fm = aov(insectos ~ colores)
summary(fm) # Existe mucha relación viendo Pr y las ***


data(iris)
iris
summary(aov(iris$Petal.Length ~ iris$Species))

# Relación ente variables numéricas. Correlación.
horas <- c(7,4,12,11,8,6,11,5)
peso <- c(74,50,89,84,65,60,70,52)
cor(horas,peso) # El número significa pero no total ya que depende también del número de datos
cor.test(horas,peso) # p-values bajo variables relacionadas.

install.packages("readr")
library(readr)
Ownership <- read_csv("https://wiki.q-researchsoftware.com/images/b/b9/Ownership.csv")
install.packages("corrplot")
library(corrplot)
corrplot(cor(Ownership), type = "upper") # La correlación no implica causalidad



