#Fazer um usuário com permissões de root (sudo adduser noctu) -> (sudo usermod -a -G sudo noctu) -> (sudo passwd noctu)
#Logar no usuário (su noctu)
#Antes de executar o script baixar o git 
#Fazer git clone do repositório
#Dar permissão ao script para executa-lo (chmod +x)
#executar script ./

#!/bin/bash

#baixando pacotes iniciais
#echo "..."
#echo "Olá usuário, vamos instalar nossa nova aplicação!"
#echo "..."
#sleep 1
#echo "..."
#echo "Atualizando e baixando pacotes!"
#echo "..."
#sudo apt update -y && sudo apt upgrade -y
#sleep 2
#echo "..."
#echo "Pacotes atualizados!"
#echo "..."

#instalação java
#sleep 5
#echo "..."
#echo "Instalando o Java"
#echo "..."
#sudo apt install openjdk-17-jre -y
#echo "..."
#echo "Java Instalado com sucesso!"
#echo "..."

#Instalando e iniciando docker
sleep 4
echo "..."
echo "Criando Docker.io"
echo "..."
sudo apt install docker.io -y
docker --version
sudo systemctl start docker
sudo systemctl enable docker

#Container e instalação java
#sleep 5
#echo "..."
#echo "Instalando o Java"
#echo "..."
#sudo docker pull openjdk:17(-alpine)
#não está reconhecendo a imagem, print do erro no word "validar com professor"
#sudo docker run -d --name containerJava openjdk:17(-alpine)
#echo "..."
#echo "Java Instalado com sucesso!"
#echo "..."

#Instalação do .jar no container
echo "..."
echo "Instalando o Java"
echo "..."
sudo docker run -d --name containerJava openjdk:17-alpine sleep infinity
sudo docker start containerJava

sudo wget -O noctu-looca.jar https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar

# Copiar o arquivo .jar para o contêiner
sudo docker cp noctu-looca.jar containerJava:/usr/src/noctu/noctu-looca.jar

#Criação do container BD (instalação)
#sleep 6
#echo "..."
#echo "Instalando Mysql"
#echo "..."
#sudo docker pull mysql:8
#sudo docker images
#sudo docker run -d -p 3306:3306 --name noctuBD -e "MYSQL_DATABASE=root" -e "MYSQL_ROOT_PASSWORD=#Gf42848080876" mysql:8

#verificando se está ativo
#sleep 7
#echo "..."
#echo "Confirmação"
#echo "..."
sudo docker ps -a

echo "Instalação concluida com sucesso!"

