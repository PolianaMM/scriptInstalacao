#!/bin/bash

#Sudo instalando e atualizando pacotes iniciais da VM
echo "..."
echo "Olá usuário! Bem -vindo a Noct.u! Vamos iniciar nossa instalação!!"
echo " Vamos iniciar nossa instalação!!"
echo "..."
sleep 5
echo "..." 
echo "Atualizando e baixando pacotes do programa!" 
echo "Aguarde um momento"
echo "..." 
if sudo apt update -y && sudo apt upgrade -y; then
   echo "..."
    echo "Pacotes atualizados!"
    echo "..."
else
    echo "..."
    echo "Erro ao instalar o Docker."
    echo "Entre em contato com a equipe Noct.u e informe o comando = update e upgrade "
    echo "..."
    exit 1
fi

# Sudo com criação do Docker
sleep 5
echo "..."
echo "Instalando Docker..."
echo "Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."
if sudo apt install docker.io -y; then
    echo "..."
    echo "Docker instalado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao instalar o Docker."
    echo "Entre em contato com a equipe Noct.u e informe o comando = install docker.io"
    echo "..."
    exit 1
fi

# Sudo iniciando o Docker
sleep 5
echo "..."
echo "Iniciando Docker"
echo "..."
if sudo systemctl start docker; then
    echo "..."
    echo "Docker iniciado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao iniciar o Docker."
    echo "Entre em contato com a equipe Noct.u e informe o comando = start docker"
    echo "..."
    exit 1
fi

# Sudo habilitando o Docker
sleep 5
echo "..."
echo " Habilitando Docker"
echo "..."
if sudo systemctl enable docker; then
    echo "..."
    echo "Docker habilitado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao habilitar o Docker."
    echo "Entre em contato com a equipe Noct.u e informe o comando = enable docker"
    echo "..."
    exit 1
fi

#baixando imagem mysql com pull
sleep 5
echo "..."  
echo "Instalando Mysql" 
echo "Aguarde um instante enquanto fazemos as configurações..." 
echo "Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."  
if sudo docker pull mysql:latest; then
    echo "..."
    echo "Imagem carregada com sucesso!"
    echo "..."
else 
    echo "..."
    echo "Erro ao criar o container do Banco de dados."
    echo "Entre em contato com a equipe Noct.u e informe o comando = docker pull mysql:latest"
    echo "..."
    exit 1
fi

#Criando container do Banco de Dados
sleep 5
if sudo docker run -d -p 3306:3306 --name Noctu -e "MYSQL_DATABASE=noctuBD" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:latest; then
    echo "..."
    echo "Container do Banco de Dados criado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao criar o container do Banco de dados."
    echo "Entre em contato com a equipe Noct.u e informe o comando = docker run -d -p 3306:3306 --name Noctu -e "MYSQL_DATABASE=XX" -e "MYSQL_ROOT_PASSWORD=XX" mysql:latest"
    echo "..."
    exit 1
fi

#Atualizando VM
sleep 5
echo "..."
echo "Instalando aplicações complementares"
echo "..."
if sudo apt update -y; then
    echo "..."
    echo "Atualização realizada!"
    echo "..."
else
    echo "..."
    echo "Erro fazer atualização."
    echo "Entre em contato com a equipe NOct.u e informe o comando = update"
    echo "..."
    exit 1
fi

#executando Docker
sleep 15
if sudo docker exec -i Noctu mysql -u root -paluno < /home/ubuntu/scriptInstalacao/confBanco.sql; then
    echo "..."
    echo "Docker Noct.u executado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao executar o docker."
    echo "Entre em contato com a equipe NOct.u e informe o comando = docker exec -it Noctu mysql -u aluno -paluno <caminhoScript"
    echo "..."
    exit 1
fi

sudo chmod +x /home/ubuntu/noctu/script/java.sh

./java.sh

