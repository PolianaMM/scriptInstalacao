#Utiliza a imagem do MySQL, pegando a ultima versão
FROM mysql:latest

#Configura o banco de dados, informando o usuário, database e senha
ENV MYSQL_USER=aluno
ENV MYSQL_DATABASE=noctuBD
ENV MYSQL_ROOT_PASSWORD=aluno

#Copia o arquivo de configuração do banco para pasta do docker para ser executado
COPY confBanco.sql /docker-entrypoint-initdb.d/

#Expõe a porta 3306 do MySQL
EXPOSE 3306