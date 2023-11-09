#Antes de executar o script baixar o git (sudo apt install git)
#Fazer git clone do repositório do script (git clone *link_repositório*)
#Dar permissão ao script para executa-lo (chmod +x scriptInst.sh)
#Executar script (./scriptInst.sh)

#!/bin/bash

#Baixando pacotes iniciais
echo "..."
echo "Olá usuário! Bem -vindo a Noct.u! Vamos iniciar nossa instalação!!"
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

#Instalação do .jar
sleep 4
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
    java -jar noctu-looca.jar
else
    echo "Erro ao rodar o .jar. Entre em contato com nossa equipe!"
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

#Criação do container Banco de Dados e instalação
sleep 6
echo "..."  
echo "Instalando Mysql"  
echo "..."  
sudo docker pull mysql:8
sudo docker images
sudo docker run -d -p 3306:3306 --name noctuBD -e "MYSQL_DATABASE=aluno" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:8
sudo service mysql start

sudo docker ps -a

sleep 8
echo "..."
echo "Acessando Banco de Dados"  

echo "..."
sudo docker exec -i noctuBD mysql -u aluno -p aluno aluno < scriptConf.sql

# Verificando e executando o BD

sleep 9
echo "..."
echo "Iniciando Banco de Dados" 

echo "..." 
sudo docker exec -it noctuBD bash -c "mysql -u aluno -paluno -e 'SHOW DATABASES;'"  
sudo docker mysql -u root -p -h localhost

# Verificando se o banco foi criado corretamente 
if [ $? -eq 0 ]; then
    echo "Banco de dados criado com sucesso!"
    echo "Iniciando a aplicação Noct.u..."
    #executando aplicação
    java -jar noctu-looca.jar
    # Conexão com Banco local
    # mysql -h 127.0.0.1 -P 3306 -u aluno -p aluno -D aluno  

else
    echo "Erro ao criar o banco de dados 'aluno'."
    exit 1
fi

echo "BEM - VINDO A NOCT.U!"