# Estatística Básica;

# Parte 1 - Medidas de Posição;

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

#   Resumo do DataSet;
  View(vendas)
  str(vendas)
  summary(vendas$Valor_Venda)
  summary(vendas$Preço_Custo)
  
#   MÃ©dia
  ?mean
  mean(vendas$Valor_Venda)
  mean(vendas$Preço_Custo)
  
#   MÃ©dia Ponderada
  ?weighted.mean
  weighted.mean(vendas$Valor_Venda, w = vendas$Preço_Custo)
  
#   Mediana
  ?median
  median(vendas$Valor_Venda)
  median(vendas$Preço_Custo)

#   Moda
  moda <- function(v) {
    valor_unico <- unique(v)
    valor_unico[which.max(tabulate(match(v, valor_unico)))]
  }
  
#   Obtendo a moda
  resultado <- moda(vendas$Valor_Venda)
  print(resultado)
  
  resultado_custo <- moda(vendas$Preço_Custo)
  print(resultado_custo)

#   Criando um gráfico de Média de Valor por Estado com ggplot2;
  install.packages("ggplot2")
  
#   Carregamento o pacote nessa sessão. Deve ser feito SEMPRE;
  library(ggplot2)  
  
#   Criando o gráfico
  ggplot(vendas) +
    stat_summary(aes(x=Estado,y=Valor_Venda),
                 fun = mean,
                 geom = "bar",
                 fill = "lightgreen",
                 col = "grey50") +
    labs(title="Média de Valor por Estado")
  