#Antes de executar o script baixar o git (sudo apt install git)
#Fazer git clone do repositório do script (git clone *link_repositório*)
#Entra na pasta onde estão os arquivos utilizando cd nomeDaPasta
#Dar permissão ao script e ao sql para executa-lo (chmod +x install.sh / chmod +x confBanco.sh)
#Executar script (./install.sh)

#!/bin/bash

PURPLE='0;35'
NC='\033[0m' 
VERSAO=11

#Sudo instalando e atualizando pacotes iniciais da VM
echo "..."
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Olá usuário! Bem -vindo a Noct.u! Vamos iniciar nossa instalação!!"
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Vamos iniciar nossa instalação!!"
echo "..."
sleep 5
echo "..." 
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Atualizando e baixando pacotes do programa!" 
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Aguarde um momento"
echo "..." 
if sudo apt update -y && sudo apt upgrade -y; then
   echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Pacotes atualizados!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao instalar o Docker."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe Noct.u e informe o comando = update e upgrade "
    echo "..."
    exit 1
fi

# Sudo com criação do Docker
sleep 5
echo "..."
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Instalando Docker..."
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."
if sudo apt install docker.io -y; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Docker instalado com sucesso!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao instalar o Docker."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe Noct.u e informe o comando = install docker.io"
    echo "..."
    exit 1
fi

# Sudo iniciando o Docker
sleep 5
echo "..."
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Iniciando Docker"
echo "..."
if sudo systemctl start docker; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Docker iniciado com sucesso!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao iniciar o Docker."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe Noct.u e informe o comando = start docker"
    echo "..."
    exit 1
fi

# Sudo habilitando o Docker
sleep 5
echo "..."
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7)  Habilitando Docker"
echo "..."
if sudo systemctl enable docker; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Docker habilitado com sucesso!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao habilitar o Docker."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe Noct.u e informe o comando = enable docker"
    echo "..."
    exit 1
fi

#baixando imagem mysql com pull
sleep 5
echo "..."  
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Instalando Mysql" 
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Aguarde um instante enquanto fazemos as configurações..." 
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."  
if sudo docker pull mysql:latest; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Imagem carregada com sucesso!"
    echo "..."
else 
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao criar o container do Banco de dados."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe Noct.u e informe o comando = docker pull mysql:latest"
    echo "..."
    exit 1
fi

#Criando container do Banco de Dados
sleep 5
if sudo docker run -d -p 3306:3306 --name Noctu -e "MYSQL_DATABASE=noctuBD" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:latest; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Container do Banco de Dados criado com sucesso!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao criar o container do Banco de dados."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe Noct.u e informe o comando = docker run -d -p 3306:3306 --name Noctu -e "MYSQL_DATABASE=XX" -e "MYSQL_ROOT_PASSWORD=XX" mysql:latest"
    echo "..."
    exit 1
fi

#Atualizando VM
sleep 5
echo "..."
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Instalando aplicações complementares"
echo "..."
if sudo apt update -y; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Atualização realizada!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro fazer atualização."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = update"
    echo "..."
    exit 1
fi

#instalando mysql-server
# sleep 5
# if sudo apt install mysql-server -y; then
#     echo "..."
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) MySQL-Server instalado!"
#     echo "..."
# else
#     echo "..."
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro iniciar MySQL-Server."
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = install mysql-server"
#     echo "..."
#     exit 1
# fi

#Iniciando mysql
# sleep 5
# if sudo systemctl start mysql; then
#     echo "..."
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) MySQL iniciado!"
#     echo "..."
# else
#     echo "..."
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro iniciar MySQL."
#    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = start mysql"
#     echo "..."
#     exit 1
# fi

# habilitando mysql
# sleep 5
# if sudo systemctl enable mysql; then
#     echo "..."
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) MySQL Habilitado!"
#     echo "..."
# else
#     echo "..."
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro habilitar MySQL."
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = enable mysql"
#     echo "..."
#     exit 1
# fi
# sleep 5
# echo "..."
# echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Aplicações finalizadas!"
# echo "..."

#executando Docker
sleep 15
if sudo docker exec -i Noctu mysql -u root -paluno < /home/ubuntu/scriptInstalacao/confBanco.sql; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Docker Noct.u executado com sucesso!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao executar o docker."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = docker exec -it Noctu mysql -u aluno -paluno <caminhoScript"
    echo "..."
    exit 1
fi
 
# execução do script
#sleep 5
#if mysql -u root -paluno -h 127.0.0.1 -P 3306 < /home/ubuntu/scriptInstalacao/confBanco.sql; then
#    echo "..."
#    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Script SQL executado com sucesso!"
#    echo "..."
#else
#    echo "..."
#    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao executar o script SQL."
#    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = mysql -u XX -pXX -h host -P 3306 </caminhoScript"
#    echo "..."
#    exit 1
#fi

# Executando o Banco de Dados
# sleep 15
# echo "..."
# echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Iniciando Banco de Dados" 
# echo "..."
# if sudo docker exec Noctu service mysql start; then
#    echo "..."
#    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Banco de Dados Iniciado com sucesso!"
#    echo "..."
# else
#     echo "..."
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao iniciar Banco de dados"
#     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = docker exec noctuBD service mysql start"
#     echo "..."
# exit 1
# fi

chmod +x java.sh

./java.sh

