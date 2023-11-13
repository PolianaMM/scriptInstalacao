sudo apt install mysql-server -y

if sudo docker exec -i Noctu mysql -u aluno -paluno </home/ubuntu/scriptInstalacao/confBanco.sql; then
    echo "..."
    echo "Docker Noct.u executado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao executar o docker."
    echo "1º linha de execução com caminho do script."
    echo "Entre em contato com a equipe NOct.u"
    echo "..."
    exit 1
fi
 
 if mysql -u aluno -paluno -h 127.0.0.1 -P 3306 </home/ubuntu/scriptInstalacao/confBanco.sql; then
    echo "..."
    echo "mysql-client instalado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao executar o script SQL."
    echo "2º linha de execução com caminho do script."
    echo "Entre em contato com a equipe NOct.u"
    echo "..."
    exit 1
fi