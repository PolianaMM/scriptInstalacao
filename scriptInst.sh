#Fazer um usuário com permissões de root (sudo adduser noctu) -> (sudo usermod -aG sudo noctu) -> (sudo passwd noctu)
#Logar no usuário (su noctu)
#Antes de executar o script baixar o git (sudo apt install git)
#Fazer git clone do repositório
#Dar permissão ao script para executa-lo (chmod +x)
#executar script ./

#!/bin/bash

#baixando pacotes iniciais
echo "..."
echo "Olá usuário, vamos instalar nossa nova aplicação!"
echo "..."
sleep 1
echo "..."
echo "Atualizando e baixando pacotes!"
echo "..."
sudo apt update -y && sudo apt upgrade -y
sleep 2
echo "..."
echo "Pacotes atualizados!"
echo "..."

# Instalação java
sleep 3
echo "..."
echo "Instalando o Java"
echo "..."
sudo apt install openjdk-17-jre -y
echo "..."
echo "Java Instalado com sucesso!"
echo "..."

#Criação do .jar (instalação)
sleep 6
echo "..."
echo "Instalando aplicação Noct.u"
echo "..."

        echo "Estamos instalando a aplicação"
             curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar

    # Verificando se o arquivo baixado é um arquivo .jar válido
    if [ -f noctu-looca.jar ]; then
        echo ""
        echo "Iniciando o software"
        sleep 1
        echo "Bem-Vindo a Noct.u"
        echo ""
        java -jar noctu-looca.jar
    else
        echo "Erro ao rodar o .jar"
        exit 1
    fi

#Instalando e iniciando docker
sleep 4
echo "..."
echo "Criando Docker.io"
echo "..."
sudo apt install docker.io -y
docker --version
sudo systemctl start docker
sudo systemctl enable docker

#Criação do container BD (instalação)
sleep 6
echo "..."
echo "Instalando Mysql"
echo "..."
sudo docker pull mysql:8
sudo docker images
sudo docker run -d -p 3306:3306 --name noctuBD -e "MYSQL_DATABASE=aluno" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:8

sudo docker ps -a

sleep 8
echo "Acessando Banco de Dados"
sudo docker exec -i noctuBD mysql -u aluno -p'aluno' root < scriptConf.sql

# Verificando e executando o BD
sleep 9
echo "Iniciando Banco de Dados"
sudo docker exec -it noctuBD bash -c "mysql -u aluno -p'aluno' -e 'SHOW DATABASES;'"    

# Verificando se o banco foi criado corretamente
if [ $? -eq 0 ]; then
    echo "Banco de dados criado com sucesso!"
    echo "Iniciando a aplicação Noct.u..."
    java -jar noctu-looca.jar
    # Conexão com Banco local
    # mysql -h 127.0.0.1 -P 3306 -u aluno -p aluno -D aluno sleep 6
echo "..."
echo "Instalando Mysql"
echo "..."
sudo docker pull mysql:8
sudo docker images
sudo docker run -d -p 3306:3306 --name noctuBD -e "MYSQL_DATABASE=aluno" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:8

sudo docker ps -a

sleep 8
echo "Acessando Banco de Dados"
sudo docker exec -i noctuBD mysql -u aluno -p'aluno' aluno < scriptConf.sql

# Verificando e executando o BD
sleep 9
echo "Iniciando Banco de Dados"
sudo docker exec -it noctuBD bash -c "mysql -u aluno -p'aluno' -e 'SHOW DATABASES;'"    

# Verificando se o banco foi criado corretamente
if [ $? -eq 0 ]; then
    echo "Banco de dados criado com sucesso!"
    echo "Iniciando a aplicação Noct.u..."
    java -jar noctu-looca.jar
    # Conexão com Banco local
    mysql -h 127.0.0.1 -P 3306 -u aluno -p'aluno' -D aluno
else
    echo "Erro ao criar o banco de dados 'root'."
    exit 1
fi

echo "Instalação concluida com sucesso!"
else
    echo "Erro ao criar o banco de dados 'root'."
    exit 1
fi

echo "Instalação concluida com sucesso!"