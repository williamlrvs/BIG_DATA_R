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
hist(duracao$dias,breaks = 20, main = "Histograma do Tempo", ylab = "Quantidade", xlab = "Tempo", ylim = c(0,2000), col = "blue")
dev.off()


