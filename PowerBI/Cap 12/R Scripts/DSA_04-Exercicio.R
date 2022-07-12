# Estatística Básica;

# Parte 4 - Exercício sobre Notas

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
notas <- read.csv('Notas.csv', fileEncoding='UTF-8')

# Q1 Apresente um resumo de dados e estatística do dataset.
summary(notas) #Resumo Estatístico das duas turmas.
str(notas) #Informações sobre os dados.

# Q2 Qual a média das notas de cada turma?
Med_TurmaA = mean(notas$TurmaA)
Med_TurmaB = mean(notas$TurmaB)
print(paste('Média turma A:', Med_TurmaA))
print(paste('Média turma B:', Med_TurmaB))

# Q3 Qual a turma que apresentou a maior variabilidade de notas? Justifique.
print(paste('O desvio padrão da média da turma A é:', sd(notas$TurmaA)))
print(paste('O desvio padrão da média da turma B é:', sd(notas$TurmaB)))
#Como podemos ver, o desvio padrão da turma B é menor, portanto é uma turma que
#apresenta menor variabilidade.

# Q4 Calcule o coeficiente de variação de cada turma.
variacao <- function(v) {
  (sd(v)/mean(v))*100
}
print(paste('Coef. de variação da Turma A:',variacao(notas$TurmaA),'%'))
print(paste('Coef. de variação da Turma B:',variacao(notas$TurmaB),'%'))

# Q5 Qual Nota apareceu mais vezes em cada turma?
moda <- function(v) {
  valor_unico <- unique(v)
  valor_unico[which.max(tabulate(match(v, valor_unico)))]
}

print(paste('Moda da Turma A:',moda(notas$TurmaA)))
print(paste('Moda da Turma B:',moda(notas$TurmaB)))
