# Estatística Básica

# Parte 5 - Tabela de Frequência

# Seleciono o diretório
setwd('C:/Users/User/Documents/DataSets')
getwd()

# Leitura do dataframe
dados <- read.table('Usuarios.csv',
                     dec = '.',
                     sep = ",",
                     h = T, #h = Header, T = True;
                     fileEncoding = 'windows-1252')

# Visualização dos dados;
names(dados) #Nome das colunas;
str(dados) #Informações sobre os dados;
summary(dados) #Sumário estatístico;

# Tabela de frequência;
freq <- table(dados$grau_instrucao)
View(freq)

# Tabela de frequência relativa;
freq_rel <- prop.table(freq)
View(freq_rel)

# Frequência relativa em formato de porcentagem;
p_freq_rel <- 100*freq_rel
View(p_freq_rel)

# Adicionando linhas na tabela;
View(freq)
freq <- c(freq, sum(freq))
View(freq)
names(freq)[4] <- 'Total'
View(freq)

# Tabela final com todos os valores;
#  Cálculo da frequência relativa normal e proporcional;
freq_rel <- c(freq_rel, sum(freq_rel))
p_freq_rel <- c(p_freq_rel, sum(p_freq_rel))
View(freq_rel)

# Tabela final com todos os vetores;
tabela_final <- cbind(freq, 
                      freq_rel = round(freq_rel,digits=2),
                      p_freq_rel = round(p_freq_rel,digits=2))
#cbind -> Faça a ligação por colunas.
View(tabela_final)

