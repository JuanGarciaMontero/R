# Data Frame II
data("ChickWeight")
ChickWeight

ChickWeight$weightperday <- chickWeight$weight / (ChickWeight$Time+1)
ChickWeight$weightperday <- ChickWeight$weight/(ChickWeight$Time+1) # Creo un columna con determinadas condiciones peso entere tiempo más uno
ChickWeight$weightperday <- NULL # Elimino columna

#Eliminar filas, la última fila la 578
df2 <- ChickWeight[-c(578),]

#Combinacion de data frames
#merge(). Combinar primer data.frame con el segundo
df1<-data.frame(Ciudad=c("Madrid","Bilbao","Sevilla"),
                Habitantes=c(150,200,40),
                Precipitaciones=c(25,13,2))
df2<-data.frame(Ciudad=c("Bilbao","Sevilla"), Temperatura=c(10,20))

dfT <- merge(df1, df2, by="Ciudad")

dfT <- merge(df1, df2, by="Ciudad", all=TRUE) # Muestra todas incluso las no mezcladas

#cbind() añado columnas a data.frame primero
df3 <- data.frame(PIB=c(97,33,44), Paro=c(10,12,15))

cbind(df1,df3)

#rbind() añado filas a data.frame primero
df4 <- data.frame(Ciudad="Valencia",Habitantes=100,Precipitaciones=5)
rbind(df1, df4)

# Agregar datos <- conocer el peso medio en funcion a la dieta de todos los data.frames ~=en funcion de
aggregate(weight ~ Diet, ChickWeight, mean)
aggregate(.~Diet,ChickWeight, mean) # . indica todas las variables
aggregate(weight ~Diet+Chick, ChickWeight, max)
aggregate(cbind(weight,Time)~Diet, ChickWeight, min)


