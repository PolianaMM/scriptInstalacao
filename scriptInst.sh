#Fazer um usuário com permissões de root (sudo adduser noctu) -> (sudo usermod -a -G sudo noctu) -> (sudo passwd noctu)
#Logar no usuário (su noctu)
#Antes de executar o script baixar o git 
#Fazer git clone do repositório
#Dar permissão ao script para executa-lo (chmod +x)
#executar script ./

#!/bin/bash

#baixando pacotes iniciais

echo "Olá usuário, vamos instalar nossa nova aplicação!"
sleep 1
echo "Atualizando e baixando pacotes!"
sudo apt update -y && sudo apt upgrade -y
sleep 2
echo "Pacotes atualizados!"

#Baixando interface gráfica
sleep 3
echo "Instalando Interface Gráfica"
sudo apt install xrdp lxde-core lxde tigervnc-standalone-server -y

#Instalando e iniciando docker
sleep 4
echo "Docker.io"
sudo apt install docker.io -y
docker --version
sudo systemctl start docker
sudo systemctl enable docker

#Container e instalação java
sleep 5
echo "Instalando o Java"
sudo docker run -d --name containerJava openjdk:17
sudo docker exec -it containerJava apt update -y
sudo docker exec -it containerJava apt install openjdk-17-jre -y

#Instalação do .jar no container do java
sudo docker exec -it containerJava sh -c 'curl -o /usr/src/app/noctu-looca.jar https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar'


#Criação do container BD (instalação)
sleep 6
echo "Instalando Mysql"
sudo docker pull mysql:5.7
sudo docker images
sudo docker run -d -p 3306:3306 --name noctuBD -e "MYSQL_DATABASE=root" -e "MYSQL_ROOT_PASSWORD=#Gf42848080876" mysql:5.7

#verificando se está ativo
sleep 7
echo "Confirmação"
sudo docker ps -a

echo "Instalação concluida com sucesso!"

