# Estatística Básica

# Parte 6 - Gráficos com a linguagem R;

# Seleciono o diretório
setwd('C:/Users/User/Documents/DataSets')
getwd()

# É possível encontrar alguns gráficos em R no site:
# www.r-graph-gallery.com

vetor_total_resultados = c(3,12,5,18,45)
names(vetor_total_resultados) = c("A","B","C","D","E")
vetor_total_resultados

### Barplot ###
?barplot
barplot(vetor_total_resultados) #Plot normal;
barplot(vetor_total_resultados, #Vetor a ser plotado, 
        col = c(1,2,3,4,5) #Cores escolhidas para cada barra.
        ) #Plot com barras coloridas;
  ## Salvando o gráfico em disco

png("barplot.png", #Nome do arquivo. Ele será salvo no diretório de trabalho
    width=480, height = 480 #Dimensões da imagem
    )
barplot(vetor_total_resultados, #Arquivo plotado
        col = rgb(0.5,0.1,0.1,0.6), #Cores em RGB
        xlab = "Categorias", #Label do eixo X
        ylab = "Valores", #Label do eixo y
        main = "Barplot em R", #Título
        ylim = c(0,60) #Altura do eixo Y
        )
dev.off() #Salvo tudo isso em disco

# Trabalhando com o ggplot2
library(ggplot2) #Carregando o ggplot2 nessa seção
View(mtcars) #Esse é um dataset que vem com a linguagem R, é um dataset de prática

# Barplot via ggplot2
ggplot(mtcars, #Dados a serem plotados 
       aes(x = as.factor(cyl)) #Passo qual variável eu quero no eixo X e 
       #converto-a para o tipo fator. Essa é a primeira "camada" do gráfico, chamada
       #de camada de dados.
       ) + 
  geom_bar() #Faço uma concatenação com o gráfico de barras.

  ## Mesmo gráfico, mas com cores customizadas.
ggplot(mtcars, #Dados a serem plotados 
       aes(x = as.factor(cyl), #Escolho a variável no eixo X em forma de fator
           fill = as.factor(cyl)) #Customização das cores
       ) + 
  geom_bar() +
  scale_fill_manual(values = c("red","green","blue")) #Gero cores para o gráfico

# Criando dados fictícios
dados = data.frame(group = c("A","B","C","D"),
                   values =c(33,62,56,67))
 ## Barplot

 ggplot(dados, 
        aes(x=group, y=values, #Escolho o que vai em cada eixo
            fill = group) #Escolho pelo que irei colorir
        ) + 
   geom_bar(width=0.85, #Largura das barras
            stat = "identity")
 
### Pie Chart ### 
 
fatias <- c(4,12,14,16,8)
paises <- c("Brasil", "Estados Unidos", "Alemanha", "Reino Unido", "Espanha")
?pie
pie(fatias, #Dados a serem plotados
    labels = paises, #Label dos dados
    main = "Leitura de Livros Por Pessoa/Ano" #Título
    ) #Podemos ver que esse gráfico fica MUITO feio!

  ## Pie Chart 3D
install.packages("plotrix")
library(plotrix)

fatias <- c(4,12,14,16,8)
paises <- c("Brasil", "Estados Unidos", "Alemanha", "Reino Unido", "Espanha")
?pie3D 
pie3D(fatias, #Dados a serem plotados
      labels = paises, #Label dos dados
      main = "Leitura de Livros Por Pessoa/Ano", #Título
      explode = 0.1 #Distância/Separação entre as fatias
      )
 
### Gráfico de Linha ###
carros <- c(1,3,6,4,9)
caminhoes <- c(2,5,4,5,12)
plot(x = carros, #Dados a serem plotados
     type = "o", #Tipo do plot ("o","l","s","p","b","h")
     col = "blue", #Cor
     ylim = c(0,12) #Limite do eixo y
     )
#Criando uma outra linha em cima do plot
lines(x = caminhoes, #Dados a serem plotados
      type = "o", #Tipo do plot
      col = "red", #Cor do plot
      pch = 22,
      lty = 2
      )
title(main = "Produção de veículos", #Título
      col.main ="red", #Cor do título
      font.main = 4 #Tamanho da fonte
      )

### Boxplot ###
library(ggplot2)
View(mpg) #Iremos usar esse pacote de dados;
ggplot(mpg, #Dados a serem plotados
       aes(x=reorder(class,hwy), 
           y = hwy,
           fill=class)
       ) +
  geom_boxplot() +
  xlab("Class") + 
  theme(legend.position="none")

### ScatterPlot ###
library(ggplot2)
data = data.frame(cond = rep(c("condition 1", "condition 2"), each=10),
                  my_x = 1:100 + rnorm(100,sd=9), 
                  my_y = 1:100 + rnorm(100,sd=16)
                  )
# A função "rnorm" gera valores aleatórios utilizando uma distribuição normal
View(data)
ggplot(data, #Dados a serem plotados
       aes(x=my_x, y=my_y)) +
  geom_point(shape=1) #Escolho o tipo dos pontos

  ## Adicionando linhas de regressão
ggplot(data, #Dados a serem plotados
       aes(x=my_x, y=my_y)) +
  geom_point(shape=1) +
  geom_smooth(method = lm, #Método "Linear Model" AKA regressão linear
              col = "red", #Cor
              se=TRUE #Intervalo de confiança Sim(True)/Não(False)
              )

### TreeMap ###
install.packages("treemap")
library(treemap)

grupo = c(rep("grupo1",4), rep("grupo2",2), rep("grupo3",3))
subgrupo = paste("subgroup", c(1,2,3,4,1,2,1,2,3), sep="-")
valor = c(13,5,22,12,11,7,3,1,23)
dados = data.frame(grupo,subgrupo,valor)
View(dados)
 ## Labels
?treemap
treemap(dados, #Dados a serem carregados
        index = c("grupo","subgrupo"), #Indíces
        vSize = "valor", 
        type = "index",
        fontsize.labels = c(15,12),
        fontcolor.labels = c("white","orange"),
        fontface.labels = c(2,1),
        bg.labels = 220,
        align.labels = list(c("center", "center"), c("right","bottom")),
        overlap.labels = 0.5,
        inflate.labels = F
        )

### Histograma ###
x <- mtcars$mpg
h <- hist(x, #dados a serem usados
          breaks = 10,
          col = "red",
          xlab = "Milhas por galão",
          main = "Histograma com Curva de Distribuição")
 ## Customizando o histogrma
xfit <- seq(min(x), max(x), length = 40)
yfit <- dnorm(xfit, mean = mean(x), sd = sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

 ## Usando ggplot2
dados = data.frame(value = rnorm(10000))
ggplot(dados, aes(x=value)) +
  geom_histogram(binwidth=0.5) #Alterando apenas o tamanho das colunas

ggplot(dados, aes(x=value)) +
  geom_histogram(binwidth=0.2, color="white", fill=rgb(0.2,0.7,0.1,0.4))

ggplot(dados, aes(x=value)) +
  geom_histogram(binwidth=0.2, aes(fill=..count..))
