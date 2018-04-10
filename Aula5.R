#Carregando a biblioteca plyr
library(plyr)

#Trocando o nome das observacoes
duracao <- rename(duracao,replace = c("user_id" = "aluno", "course_id" = "curso", "timeToFinish" = "dias"))

#Criando grafico de dias 
plot(duracao$dias)

#Salvando o histograma dentro do arquivos jpeg, encerrando a geracao do arquivo com o comando dev.off()
#Criando histograma, informando o numero de quebras que queremos, Titulo, alterando label do eixo Y, eixo X, ajustando limite do eixo y, ajutando a cor
#paramentros do hist(banco, numero de quebras, titulo, labelY, labelX, limiteY,cor)
jpeg(filename = "histograma.jpg")
hist(duracao$dias,
     breaks = 20,
     main = "Histograma do Tempo",
     ylab = "Quantidade",
     xlab = "Tempo",
     ylim = c(0,2000),
     col = "blue")
dev.off()

#Calculando a media, ignorando os casos onde haja dados faltantes
mean(duracao$dias,na.rm = TRUE)

#calculando mediana do dias, ignorando os casos onde haja dados faltantes
median(duracao$dias,na.rm = TRUE)

#resumo estatistico para a variavel de dias
summary(duracao$dias)

#calculando a proporcao
dim(duracao)[1] #pegue o banco de dados duracao e me de o tamanho em linhas desse banco de dados
length(unique(duracao$curso)) #cursos unicos
length(unique(duracao$aluno)) #alunos unicos

#Agregando informações
sumario_estatistico <- aggregate(duracao$dias,list(duracao$curso),mean, na.rm = T)

popularidade_e_duracao <- merge(sumario_estatistico,popularidade, by = 'curso')

#renomeando as variaveis de banco de dados
sumario_estatistico <- rename(sumario_estatistico,replace = c('Group.1' = 'curso','x'='dias'))
popularidade <- rename(popularidade, c('course_id'='curso','freq'='popularidade'))

#criando grafico normal
plot(popularidade_e_duracao$dias,popularidade_e_duracao$popularidade)
#criando grafico com modelo linear
modelo.linear <- lm(popularidade_e_duracao$popularidade~popularidade_e_duracao$dias)
abline(lm(popularidade_e_duracao$popularidade~popularidade_e_duracao$dias))
abline(modelo.linear)

#grafico modelo scatter
scatter.smooth(popularidade_e_duracao$dias, popularidade_e_duracao$popularidade, pch=21,col='blue')

library(ggplot2)

grafico <- ggplot(popularidade_e_duracao,aes(dias,popularidade))

grafico <- grafico + geom_point()

grafico <- grafico + geom_smooth()

grafico
