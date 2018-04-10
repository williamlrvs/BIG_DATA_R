#Tentando acessar a variavel sectionId do banco de Dados aulas
section_id

#criando uma cópia na memoria do R. Anexando o banco de dados Aulas
attach(aulas)

#Acessando a variavel sectionId
section_id

#Alterando o max.print, para exibir todos os valores que há na variavel section_Id
options(max.print = 40000)

#Exibindo as primeiras observacoes que há na variavel sectionId
head(section_id)

#Ordenando as observacoes que ha na variavel sectionID
sort(section_id)

#alterando o conteudo da linha 33137 na coluna 3 inserindo o valor correto
aulas[33137,3] <- 3255

#ordenando o conteudo do sectionId no bando de dados aulas
sort(aulas$section_id)

#verificando os videos que sao unicos
unique(aulas$section_id)

#verificando o tamanho do vetor
length(unique(aulas$section_id))

#verificando quantas vezes os videos foram assistidos
table(aulas$section_id)

#ordenando a tabela de videos visualizados
sort(table(aulas$section_id))

#ordenando a tabela de cursos visualizados
sort(table(aulas$course_id))

#Instalando a biblioteca plyr, pois recisaremos utilizar a funcao de count da biblioteca
install.packages("plyr")

#Informando ao R que vou usar a biblioteca plyr
library(plyr)

#Criando um novo banco de dados
auxiliar <- count(aulas, vars = "course_id")

#Salvando em disco o novo bando de dados
write.csv(auxiliar,"popularidade.csv")
