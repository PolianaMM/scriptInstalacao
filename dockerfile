
FROM mysql:latest

ENV MYSQL_USER=root
ENV MYSQL_DATABASE=aluno
ENV MYSQL_ROOT_PASSWORD=aluno

COPY confBanco.sql /docker-entrypoint-initdb.d/

EXPOSE 3306