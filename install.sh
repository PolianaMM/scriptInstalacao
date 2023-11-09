#Antes de executar o script baixar o git (sudo apt install git)
#Fazer git clone do repositório do script (git clone *link_repositório*)
#Dar permissão ao script para executa-lo (chmod +x install.sh)
#Executar script (./install.sh)

#!/bin/bash

#Baixando pacotes iniciais
echo "..."
echo "Olá usuário! Bem -vindo a Noct.u! Vamos iniciar nossa instalação!!"
echo "..."
sleep 1
echo "..." 
echo "Atualizando e baixando pacotes do programa!" 
echo "Aguarde um momento"
echo "..." 
sudo apt update -y && sudo apt upgrade -y
sleep 2
echo "..."
echo "Pacotes atualizados!"
echo "..."

#Instalando e iniciando docker
sleep 4
echo "..."  
echo "Estamos criando o Docker" 
echo "Não se preocupe não fará alterações em seu computador!"
echo "..."  
sudo apt install docker.io -y
docker --version
sudo systemctl start docker
sudo systemctl enable docker

#Criação do container Banco de Dados e instalação
sleep 6
echo "..."  
echo "Instalando Mysql" 
echo "Aguarde um instante enquanto fazemos as configurações..." 
echo "..."  
sudo docker pull mysql:8
sudo docker images
sudo docker run -d -p 3306:3306 --name noctuBD -e "MYSQL_DATABASE=aluno" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:8
sudo service mysql start

#Lista de containers assossiados
echo "..." 
echo "Verificando se a instalação está funcionando"
echo "..." 
sudo docker ps -a

#Importando o script .sql para container do banco
sleep 8
echo "..."
echo "Acessando Banco de Dados"  
echo "..."
sudo docker exec -i noctuBD mysql -u aluno -p aluno root < confBanco.sql

# Verificando e executando o Banco de Dados
sleep 9
echo "..."
echo "Iniciando Banco de Dados" 
echo "..." 
sudo docker mysql -u root -p -h localhost

sleep 6
echo "..."  
echo "Instalando Java 17"  
echo "Não se preocupe não irá fazer modificações nas aplicações atuais!"
echo "..."  
docker build -t java_17_image .
sudo docker run -it --name java_container java_17_image /bin/bash

#Instalação do .jar
sleep 4
echo "..."
echo "Instalando aplicação Noct.u"
echo "Logo inicializaremos a sua central de monitoramento"
echo "..." 
echo "Estamos instalando a aplicação"
curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar