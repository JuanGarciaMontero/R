# Visualización

# Función gráfica básica: plot()

x <- 1:100
y <- log(x)

plot(x,y,type="l")
plot(x,y,main="Función logaritmo", sub="subtitulo",
     xlab="eje x", ylab="log(x)", xlim=c(1,10), ylim=c(0,3),
     type="b")

# Scatter plot
x <- rnorm(100)
y <- rnorm(100)
plot(x,y)

# Histogramas
x <- rnorm(1000)
hist(x)

# Gráficos de barra
x <- c("Rojo","Verde","Rojo","Azul","Azul","Rojo")
barplot(table(x))

# Gráficos 3D
x <- seq(-10,10, length=30)
y <- x
f <- function(x,y){
  r <- sqrt(x^2+y^2)
  10*sin(r)/r
}
z <- outer(x,y,f)
persp(x,y,z,theta=30,phi=15,col="green")

# Plotly
install.packages("plotly")
libray(plotly)

trace_0 <- rnorm(100, mean = 5)
trace_1 <- rnorm(100, mean = 0)
trace_2 <- rnorm(100, mean = -5)
x <- c(1:100)

data <- data.frame(x, trace_0, trace_1, trace_2)

# sin tereminar ver, plot.ly/r/
