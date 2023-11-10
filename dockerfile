
FROM mysql:8

ENV MYSQL_DATABASE aluno
ENV MYSQL_ROOT_PASSWORD aluno

COPY ./dockerfile/ /docker-entrypoint-initdb.d/

EXPOSE 3306

CMD ["mysqld"]
