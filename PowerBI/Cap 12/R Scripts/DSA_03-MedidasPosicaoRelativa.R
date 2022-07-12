# Estatística Básica;

# Parte 3 - Medidas de Posição Relativa;

# Definindo a pasta de trabalho;
#  Substituindo esse caminho abaixo pela pasta do arquivo no computador.

#  Setwd - Set Working Directory (Configure o Diretório de Trabalho);
setwd('C:/Users/User/Documents/DataSets')
#  Uma observação a ser feita: O R foi desenvolvido em ambiente UNIX, portanto
#  a separação de arquivos é dada pela BARRA (/) e não pela contra-barra (\) 
#  como ocorre no Windows.

#  Getwd - Get Working Diretory (Obtenha o Diretório de Trabalho);
getwd() 
#  Basicamente, esse comando me permite ver em qual diretório estou atualmente
#  trabalhando.

#   Carregando o DataSet;
vendas <- read.csv("Vendas2.csv", fileEncoding="windows-1252")

#   Resumo dos dados;
head(vendas)
tail(vendas)
View(vendas)

#   Medidas de Tendência Central;
summary(vendas$Valor)
summary(vendas[c('Valor','Custo')])

#   Explorando variáveis numéricas;
summary(vendas$Valor) #Sumário
mean(vendas$Valor) #Média
median(vendas$Valor) #Mediana
range(vendas$Valor) #Máximos e Mínimos
diff(range(vendas$Valor)) #Diferença entre os máximos e mínimos

quantile(vendas$Valor) #Quartis
quantile(vendas$Valor, probs=c(0.01,0.99)) #Percentis 0.01 e 0.99
quantile(vendas$Valor, seq(from = 0, to = 1, by=0.2)) #Percentis
IQR(vendas$Valor) #Interquartile Range, diferença entre Q3 e Q1
