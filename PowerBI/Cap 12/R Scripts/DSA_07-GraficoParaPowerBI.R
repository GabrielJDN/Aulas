# Estatística Básica

# Parte 6 - Gráficos com a linguagem R;

# Seleciono o diretório
setwd('C:/Users/User/Documents/DataSets')
getwd()

# Carregando o dataset
vendas <- read.csv("Vendas2.csv", fileEncoding="windows-1252")
View(vendas)

# Carregando a library necessária
library(ggplot2)

#Cria o Gráfico
?qplot
qplot(data = vendas, x=Valor, y=Custo) #Gráfico de dispersão