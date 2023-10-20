# Aprendizaje no supervisado. Algoritmos de agrupación. Kmeans
data("USArrests") # Cargo datos
df <- USArrests

sum(is.na(df)) # Compruebo si hay valores perdidos, en este caso no hay 0

df2 <- (df-min(df))/(max(df)-min(df)) # Normalizao los datos entre 0 y 1

k2 <- kmeans(df2, centers = 2, nstart = 25)
k2$centers
table(k2$cluster)

install.packages("factoextra")
library(factoextra)
fviz_cluster(k2, data = df2)

set.seed(123)
# Gráfica para elegir el mejor número de clusters a través del método del codo
fviz_nbclust(df2, kmeans, method = "wss")


set.seed(123)
# Repetimos el algoritmo utilizando 3 clusters
final <- kmeans(df2, 3, nstart = 25)
final$centers
table(final$cluster)
fviz_cluster(final, data = df2)

# Predicción
datos_new <- data.frame(Murder=14,Assault=200,UrbanPop=51,Rape=20)
datos_new_norm <- (datos_new-min(df))/(max(df) - min(df))

install.packages("clue")
library(clue)
cl_predict(final,datos_new)
