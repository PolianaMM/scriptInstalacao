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
echo "Habilitando Docker"
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

sleep 5

#Criando container do Banco de Dados
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

#Iniciando mysql
# sudo apt install mysql-server -y
if sudo systemctl start mysql; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) MySQL iniciado!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro iniciar MySQL."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = start mysql"
    echo "..."
    exit 1
fi

# habilitando mysql
if sudo systemctl enable mysql; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) MySQL Habilitado!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro habilitar MySQL."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = enable mysql"
    echo "..."
    exit 1
fi

echo "..."
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Instalando aplicações finalizadas!"
echo "..."

#executando Docker
if sudo docker exec -it Noctu mysql -u aluno -paluno </home/ubuntu/scriptInstalacao/confBanco.sql; then
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
if mysql -u aluno -paluno -h 127.0.0.1 -P 3306 </home/ubuntu/scriptInstalacao/confBanco.sql; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Script SQL executado com sucesso!"
    echo "..."
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao executar o script SQL."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = mysql -u XX -pXX -h host -P 3306 </caminhoScript"
    echo "..."
    exit 1
fi

# Executando o Banco de Dados
 sleep 5
 echo "..."
 echo "Iniciando Banco de Dados" 
 echo "..."
 if sudo docker exec noctuBD service mysql start; then
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Banco de Dados Iniciado com sucesso!"
    echo "..."
 else
     echo "..."
     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao iniciar Banco de dados"
     echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = docker exec noctuBD service mysql start"
     echo "..."
 exit 1
 fi

# verificando e instalando java 17
sleep 4
echo "..."
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Verificando se você possui o Java instalado na sua máquina!"
echo "..."
if which java > /dev/null 2>&1; then
  echo "..."
  echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Java não está instalado."
  echo "..."
  read -p "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Gostaria de instalar o Java versão 17? [s/n] " get
  if [ "$get" == "s" ]; then
    sudo apt install openjdk-17-jre -y
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Java Instalado com sucesso!"
    echo "..."
  else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Você escolheu não prosseguir. Por gentileza entre em contato com no equipe Noct.u."
    echo "..."
    exit 1
  fi
else
  echo "..."
  echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Java já Instalado!"
  echo "..."
fi

#instalação e instalação do .jar
sleep 5
echo "..."
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Instalando aplicação Noct.u"
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Logo inicializaremos a sua central de monitoramento"
echo "..." 
echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Estamos instalando a aplicação"
echo "..."
if curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar; then
    if [ -f "noctu-looca.jar" ]; then
        echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Arquivo noctu-looca.jar baixado e instalado com sucesso!"
        # Executando a aplicação somente se o download do arquivo der certo
        java -jar noctu-looca.jar
    else
        echo "..."
        echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) O arquivo noctu-looca.jar não foi encontrado."
        echo "..."
        exit 1
    fi
else
    echo "..."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Erro ao baixar o arquivo noctu-looca.jar."
    echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) Entre em contato com a equipe NOct.u e informe o comando = curl -LJO https://link.jar"
    echo "..."
    exit 1
fi

echo "$(tput setaf 10)[Noct.u]:$(tput setaf 7) BEM - VINDO A NOCT.U!"