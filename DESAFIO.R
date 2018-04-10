## Setando o diretório de trabalho 
setwd("E:\\CURSOS\\ALURA\\COMPUTAÇÃO\\BIG_DATA\\DESAFIO_OPCIONAL_I\\HMP_Dataset")

######################################## 1) Carrega dados
df_medidas <- data.frame()
arqs = list.files(pattern = ".txt$",recursive = TRUE)
for (a in 1:length(arqs)) {
  arquivo = arqs[a]
  # buscamos arquivos em subdiretórios
  if (!(length(i <- grep('/', arquivo))) == 0)
  {
    movimento = unlist(strsplit(arquivo, "/")[1][1])[1]
    genero = substr(unlist(strsplit(arquivo, "-"))[9],1,1)
    data <- read.table(arquivo)
    data$arquivo <- arquivo
    data$movimento <- movimento
    data$genereo <- genero
    df_medidas <- rbind(df_medidas,data)
  }
}
colnames(df_medidas) <- c("X","Y", "Z", "Arquivo", "Movimento", "Genero")

str(df_medidas)

table(df_medidas$Genero)

table(df_medidas$Movimento)

var(df_medidas[c("X","Y", "Z")], y = NULL, na.rm = FALSE, use)

cov(df_medidas[c("X","Y", "Z")],method = c("pearson", "kendall", "spearman"))

cor(df_medidas[c("X","Y", "Z")],method = c("pearson", "kendall", "spearman"))
    
hist(df_medidas$X, main = 'Histograma', xlab = 'X')

library(sqldf)
Medidas_por_Tipo = sqldf("select Movimento, count(*) Qtos  
                            from df_medidas group by Movimento
                            order by 2 desc")
library(ggplot2)
ggplot(Medidas_por_Tipo, aes(x = Movimento, y = Qtos)) +
  geom_col(aes(fill = Movimento))

#Eliminar observações do tipo MODEL:
df_medidas <- df_medidas[!grepl("MODEL", df_medidas$Arquivo), ]

#    Eliminar a variável contendo nome do arquivo:
df_medidas$Arquivo <- NULL

#Acrescentar nova variável representando a média das coordenadas
#install.packages("dplyr")
library(dplyr)
df_medidas <- df_medidas %>% mutate(media = (X+Y+Z)/3)

#Veja o grau de correlação da nova variável em relação às demais coordenadas
cor(df_medidas[c("X","Y","Z","media")])