# TIPOS DE DATOS

# character
"hola"
"124"
"23mm"

# numeric
23
pi
3.5

# integer
23L
2L
1L

# logical
TRUE
FALSE
T
F

# Para conocer el tipo de dato que se utiliza función class()
x <- 3
class(x)

# También es posible hacer cambios entre tipos
x <- as.numeric("122")
x
class(x)
y <- as.logical(1)
y
as.logical(0)
as.numeric(TRUE)
as.numeric("225mm")
as.character.srcref("123")

x <- as.character("123")
class(x)

# Operadores comparativos y lógicos
7 < 5
8 >3
3 == 3
3 != 4
3 > 1 & 2 > 0
3>9|2>0

# Vector
x <- vector() # Vector vacio
x_numeric <- c(1.5, "2.3", 6.8)
x_character <- c("Manuel", "Antonio")
x_logical <- c(TRUE,TRUE,FALSE,TRUE)

as.character(x_numeric)

length(x_numeric) # Longuitud del vector

v <- c(1,3,5,7,9,11) # Indexación vectores
v
v[3]
v[2:5]
v[v>5 & v<11]

# Operaciones aritméticas
# Data Frame II
data("ChickWeight")
ChickWeight
