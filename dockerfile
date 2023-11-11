
FROM mysql:latest

ENV MYSQL_USER=root
ENV MYSQL_DATABASE=noctuBD
ENV MYSQL_ROOT_PASSWORD=noctu

COPY confBanco.sql /docker-entrypoint-initdb.d/

EXPOSE 3306