# Mini-Projeto 3:

# Capítulo 15 - 

# Definindo o diretório de trabalho
setwd("D:/Github/Aulas/Aulas/PowerBI/Cap 15")

# Carregando bibliotecas
library(Amelia)
library(recipes)
library(caret)
library(ggplot2)
library(reshape)
library(dplyr)
library(e1071)
library(randomForest)

# Carregando dados
dados_clientes <- read.csv("dataset.csv")
#O dicionário desses dados pode ser encontrado em:
# https://archive.ics.uci.edu/ml/datasets/default+of+credit+card+clients

View(dados_clientes)
dim(dados_clientes)
str(dados_clientes) #Podemos ver que o R viu os dados de maneira errada
summary(dados_clientes)

######### Análise exploratória, Limpeza e Transformação dos dados 

# Removendo a primeira coluna ID
dados_clientes$ID <- NULL #Removendo a coluna
dim(dados_clientes)
View(dados_clientes)

# Renomeando a coluna de cada classe
colnames(dados_clientes)
colnames(dados_clientes)[24] <- "Inadimplente"
colnames(dados_clientes)
View(dados_clientes)

# Verificação e exclusão de valores ausentes
sapply(dados_clientes, function(x) sum(is.na(x)))
?missmap
missmap(dados_clientes, main="Valores Missing Observados")
dados_clientes <- na.omit(dados_clientes)

# Convertendo os atributos para fatores
#  Renomeando colunas categóricas
colnames(dados_clientes)
colnames(dados_clientes)[2] <- "Genero"
colnames(dados_clientes)[3] <- "Escolaridade"
colnames(dados_clientes)[4] <- "Estado_Civil"
colnames(dados_clientes)[5] <- "Idade"
colnames(dados_clientes)
View(dados_clientes)

#  Gênero
View(dados_clientes$Genero)
str(dados_clientes$Genero)
summary(dados_clientes$Genero)
?cut
dados_clientes$Genero <- cut(
  dados_clientes$Genero,
  c(0,1,2),
  labels = c("Masculino","Feminino")
)
View(dados_clientes$Genero)
str(dados_clientes$Genero)
summary(dados_clientes$Genero)

#   Escolaridade
str(dados_clientes$Escolaridade)
summary(dados_clientes$Escolaridade)    
dados_clientes$Escolaridade <- cut(
  dados_clientes$Escolaridade,
  c(0,1,2,3,4),
  labels=c("Pos Graduado", "Graduado", "Ensino Medio", "Outros")
)
View(dados_clientes$Escolaridade)    
str(dados_clientes$Escolaridade)    
summary(dados_clientes$Escolaridade) 
#Podemos ver que essa transformação gerou alguns valores NA.

#   Estado Civil
dados_clientes$Estado_Civil <- cut(
  dados_clientes$Estado_Civil,
  c(-1,0,1,2,3),
  labels = c("Desconhecido","Casado","Solteiro","Outro")
)
str(dados_clientes$Estado_Civil)  
View(dados_clientes$Estado_Civil)    
summary(dados_clientes$Estado_Civil)    
#Podemos ver que temos 54 dados Desconhecidos!

#   Convertendo a variável "Idade" para "Faixa Etária"
str(dados_clientes$Idade)
summary(dados_clientes$Idade)
hist(dados_clientes$Idade)    
dados_clientes$Idade <- cut(
  dados_clientes$Idade, #Variável a ser alterada
  c(0,30,50,100), #Valores a serem alterados
  labels = c("Jovem","Adulto","Idoso") #Novos valores
) 
View(dados_clientes$Idade)    
str(dados_clientes$Idade)    
summary(dados_clientes$Idade)    

#   Convertendo a variável que indica pagamentos para o tipo fator
dados_clientes$PAY_0 <- as.factor(dados_clientes$PAY_0)
dados_clientes$PAY_2 <- as.factor(dados_clientes$PAY_2)
dados_clientes$PAY_3 <- as.factor(dados_clientes$PAY_3)
dados_clientes$PAY_4 <- as.factor(dados_clientes$PAY_4)
dados_clientes$PAY_5 <- as.factor(dados_clientes$PAY_5)
dados_clientes$PAY_6 <- as.factor(dados_clientes$PAY_6)
View(dados_clientes)

# Observação: 
# Usamos a função CUT quando queremos transformar o tipo da variável e
#alterar o valor;
# Usamos a função as.factor quando queremos mudar apenas o tipo da 
#variável.

#  Dataset após as conversões
str(dados_clientes)
sapply(dados_clientes, function(x) sum(is.na(x)))
missmap(dados_clientes, #dados plotados
        main="Valores Missing Observados" #título 
)  
dados_clientes <- na.omit(dados_clientes) #Removo valores ausentes
dim(dados_clientes)  
View(dados_clientes)

#   Alterando a variável INADIMPLENTE para o tipo fator
str(dados_clientes$Inadimplente)
dados_clientes$Inadimplente <- as.factor(dados_clientes$Inadimplente)
str(dados_clientes$Inadimplente)

# Total Inadimplentes VS Total de Não Inadimplentes
?table
table(dados_clientes$Inadimplente)
# Podemos ver que a proporção de inadimplente VS não inadimplentes é problemática
#visto que há mais de um do que outro, isso pode causar um certo erro na hora de
#treinarmos a IA;
prop.table(table(dados_clientes$Inadimplente))

# Plotando a distribuição usando o ggplot2;  
qplot(data = dados_clientes, Inadimplente, geom="bar")

# Set seed
set.seed(12345)

# Amostragem Estratificada
# Seleciona as linhas de acordo com a variável inadimplente como strata
?createDataPartition
indice <- createDataPartition(
  dados_clientes$Inadimplente, #Dados a serem usados;
  p=0.75, #Porcentagem dos dados para treinamento;
  list=FALSE #O resultado é uma matriz;
)
dim(indice)  

# Definimos os dados de treinamento como subconjunto do conjunto de dados originais
#com números de indice de linha (conforme identificado acima) e todas as colunas
dados_treino <- dados_clientes[indice,]
table(dados_treino$Inadimplente)  
prop.table(table(dados_treino$Inadimplente))

# Comparamos as porcentagens entre as clases de treinamento e dados originais
compara_dados <- cbind(prop.table(table(dados_clientes$Inadimplente)),
                       prop.table(table(dados_treino$Inadimplente)))
colnames(compara_dados) <- c("Treinamento", "Original") #Altero nome de colunas 
compara_dados

# Melt Data - Converte colunas em linhas;
?reshape2::melt
melt_compara_dados <- melt(compara_dados)
melt_compara_dados  
# Plot dos dados "meltados"
ggplot(melt_compara_dados, #Dados usados
       aes(x=X1, y=value)
) +
  geom_bar(aes(fill=X2), stat="identity", position="dodge")

# Gerando dados de teste
dados_teste <- dados_clientes[-indice,] #Crio os dados de teste
dim(dados_treino)
dim(dados_teste)

######### Modelo de Machine Learning

# Construindo a primeira versão do modelo - Random Forest
?randomForest
modelo_v1 <- randomForest(Inadimplente ~ ., data = dados_treino)
modelo_v1

# Avaliando o modelo
plot(modelo_v1)

# Previsão com os dados de teste
previsoes_v1 <- predict(modelo_v1, dados_teste)

# Confusion Matrix
?caret::confusionMatrix
cm_v1 <- caret::confusionMatrix(previsoes_v1, dados_teste$Inadimplente, positive="1")
#Essa forma de fazer indica o pacote e a função que eu quero do pacote, útil quando a função
#existe em mais de um pacote.
cm_v1


# Calculando métricas de avaliação do modelo preditivo
y <- dados_teste$Inadimplente
y_pred_v1 <- previsoes_v1
precision <- posPredValue(y_pred_v1,y)
recall <- sensitivity(y_pred_v1,y)  
F1 <- (2*precision*recall)/(precision+recall)
precision
recall
F1

# Construindo a segunda versão do modelo - Classes balanceadas
# Pacots necessários
install.packages(c("zoo","xts","quantmod"))
install.packages(c("abind","ROCR"))
install.packages("https://cran.r-project.org/src/contrib/Archive/DMwR/DMwR_0.4.1.tar.gz", repos=NULL, type="source" )
library(DMwR)
?SMOTE

# Aplicando o SMOTE
# Artigo sobre o método: https://arxiv.org/pdf/1106.1813.pdf
table(dados_treino$Inadimplente)
prop.table(table(dados_treino$Inadimplente))
set.seed(9560)
dados_treino_bal <- SMOTE(Inadimplente ~ ., data = dados_treino)
table(dados_treino_bal$Inadimplente)
prop.table(table(dados_treino_bal$Inadimplente))

# Criando a segunda versão
modelo_v2 <- randomForest(Inadimplente ~ ., data=dados_treino_bal)
modelo_v2    
plot(modelo_v2)

# Previsões
previsoes_v2 <- predict(modelo_v2, dados_teste)

# Confusion Matrix
cm_v2 <- caret::confusionMatrix(previsoes_v2, dados_teste$Inadimplente, positive="1")
cm_v2 
cm_v1

# Avaliando a segunda versão
y_pred_v2 <- previsoes_v2
precision <- posPredValue(y_pred_v2,y)
recall <- sensitivity(y_pred_v2,y)  
F1 <- (2*precision*recall)/(precision+recall)
precision
recall
F1

# Construindo a terceira versão do modelo: Utilizando apenas algumas variáveis de relevância

# Observando as variáveis importantes
varImpPlot(modelo_v2)

# Obtendo as variáveis mais importantes
imp_var <- importance(modelo_v2)
varImportance <- data.frame(variables = row.names(imp_var),
                            Importance=round(imp_var[, 'MeanDecreaseGini'],2))

# Criando um rank de variáveis baseado na importância
rankImportance <- varImportance %>%
  mutate(Rank = paste0('#', dense_rank(desc(Importance))))

# Usando o ggplot2 para visualizar a importância relativa das variáveis
ggplot(rankImportance,
       aes(
         x=reorder(variables, Importance),
         y=Importance,
         fill=Importance
       )
) + 
  geom_bar(stat='Identity') + 
  geom_text(aes(
    x=variables,
    y=0.5,
    label=Rank
  ),
  hjust=0,
  vjust=0.55,
  size=4,
  colour="red"
  ) +
  labs(x='Variables') +
  coord_flip()

# Construindo a terceira versão (finalmente)
modelo_v3 <- randomForest(Inadimplente ~ PAY_0 + PAY_2 + PAY_3 + PAY_AMT1
                          + PAY_AMT2 + PAY_5 + BILL_AMT1, data = dados_treino_bal)
modelo_v3 

# Previsões
previsoes_v3 <- predict(modelo_v3, dados_teste)

# Confusion Matrix
cm_v3 <- caret::confusionMatrix(previsoes_v3, dados_teste$Inadimplente, positive="1")
cm_v3 

# Avaliando a segunda versão
y_pred_v3 <- previsoes_v3
precision <- posPredValue(y_pred_v3,y)
recall <- sensitivity(y_pred_v3,y)  
F1 <- (2*precision*recall)/(precision+recall)
precision
recall
F1

# Salvando o modelo final
saveRDS(modelo_v3, file = "modelo_v3.rds")

# Carregando o modelo
modelo_final <- readRDS("modelo_v3.rds")


