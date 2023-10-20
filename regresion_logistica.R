# REGRESION LOGISTICA
df <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")

table(df$admit) # Para saber si está muy desbalanceado, y no lo está 0->273, 1->127

modelo <- glm(admit ~ gre + gpa + rank, data = df, family = "binomial") # binomial expecifica que es una regresión logística 
summary(modelo)

# Predicción
x <- data.frame(gre=790, gpa=3.8,rank=1)
p <- predict(modelo,x,type="response") #respuesta tipo response
p # probabilidad del 0.68 alumno de ser adminido en la universidad

# Evaluar modelo
prediccion_prob <- predict(modelo, df, type="response")
summary(prediccion_prob)

df$prediccion_prob <- prediccion_prob # incorporo la columna prediccion_prob a mi data frame df

install.packages("InformationValue") # No esta en repo R busco en github
remotes::install_github("selva86/InformationValue")
library(InformationValue)

# Corte óptimo en las probabilidades. El valor en que un alumno es admitido o no
opt <- optimalCutoff(df$admit, prediccion_prob)
opt

df$predicted <- ifelse(df$prediccion_prob>=opt,1,0)
# Para comparar valor real con el del modelo

#Matriz de confusión
table(df$predicted, df$admit)
#otra forma de hacerlo
confusionMatrix(df$admit, prediccion_prob, threshold = opt)

# Accuracy
1 - misClassError(df$admit, prediccion_prob, threshold = opt)

# Precision
Precision <- precision(df$admit, prediccion_prob, threshold = opt)
# Añado Precision como variable para usarla en F1 score

# Recall
Recall <- sensitivity(df$admit, prediccion_prob, threshold = opt)
Recall

# Specificity
specificity(df$admit, prediccion_prob, threshold = opt)

# F1 score
(2*Precision*Recall)/(Precision+Recall)

# Curva ROC
plotROC(actuals=df$admit, predictedScores = df$prediccion_prob)



