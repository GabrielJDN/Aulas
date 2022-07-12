# Estatística Básica;

# Parte 1 - Medidas de Dispersão;

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
vendas <- read.csv("Vendas.csv", fileEncoding="windows-1252")

#   Variância
var(vendas$Valor_Venda)

#   Desvio Padrão
sd(vendas$Valor_Venda)

