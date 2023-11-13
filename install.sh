#Antes de executar o script baixar o git (sudo apt install git)
#Fazer git clone do repositório do script (git clone *link_repositório*)
#Entra na pasta onde estão os arquivos utilizando cd nomeDaPasta
#Dar permissão ao script e ao sql para executa-lo (chmod +x install.sh / chmod +x confBanco.sh)
#Executar script (./install.sh)

#!/bin/bash

#Sudo instalando e atualizando pacotes iniciais da VM
echo "..."
echo "Olá usuário! Bem -vindo a Noct.u! Vamos iniciar nossa instalação!!"
echo "Vamos iniciar nossa instalação!!"
echo "..."
sleep 5
echo "..." 
echo "Atualizando e baixando pacotes do programa!" 
echo "Aguarde um momento"
echo "..." 
sudo apt update -y && sudo apt upgrade -y
sleep 5
echo "..."
echo "Pacotes atualizados!"
echo "..."

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
    echo "..."
    exit 1
fi

# Sudo niciando o Docker
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
    echo "Docker habilitado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao habilitar o Docker."
    echo "..."
    exit 1
fi

#Sudo com instalação do Mysql e Criação do container Banco de Dados
sleep 5
echo "..."  
echo "Instalando Mysql" 
echo "Aguarde um instante enquanto fazemos as configurações..." 
echo "Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."  
sudo docker pull mysql:latest
sleep 5
if sudo docker run -d -p 3306:3306 --name Noctu -e "MYSQL_DATABASE=noctuBD" -e "MYSQL_ROOT_PASSWORD=noctu" mysql:latest; then
    echo "..."
    echo "Container do Banco de Dados criado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao criar o container do Banco de dados. Entre em contato com a equipe Noct.u."
    echo "..."
    exit 1
fi

#Sudo fazendo instalação complementar do Banco de dados e instalando script do banco, e executando container banco de Dados com conexão local
sleep 5
echo "..."
echo "Instalando aplicações complementares"
echo "..."
sudo apt update -y
sudo apt install mysql-server -y
sudo systemctl start mysql
sudo systemctl enable mysql
echo "..."
echo "Instalando aplicações finalizadas!"
echo "..."
if sudo docker exec -i Noctu mysql -u root -pnoctu noctuBD < confBanco.sql &&
   sudo apt install mysql-client -y &&
   sudo mysql -u root -pnoctu -h 127.0.0.1 -P 3306 noctuBD < confBanco.sql; then
    echo "..."
    echo "Script SQL executado com sucesso no banco de dados!"
    echo "..."
else
    echo "..."
    echo "Erro ao executar o script SQL."
    echo "..."
    exit 1
fi

# Sudo verificando e executando o Banco de Dados
# sleep 5
# echo "..."
# echo "Iniciando Banco de Dados" 
# echo "..."
# if sudo docker exec noctuBD service mysql start; then
#     echo "..."
#     echo "Banco de Dados Iniciado com sucesso!"
#     echo "..."
# else
#     echo "..."
#     echo "Erro ao iniciar Banco de dados"
#     echo "..."
# exit 1
# fi

#Sudo verificando e instalando java 17
sleep 4
echo "..."
echo "Verificando se você possui o Java instalado na sua máquina!"
echo "..."
if which java > /dev/null 2>&1; then
  echo "..."
  echo "Java não está instalado."
  echo "..."
  read -p "Gostaria de instalar o Java versão 17? [s/n] " get
  if [ "$get" == "s" ]; then
    sudo apt install openjdk-17-jre -y
    echo "..."
    echo "Java Instalado com sucesso!"
    echo "..."
  else
    echo "..."
    echo "Você escolheu não prosseguir. Por gentileza entre em contato com no equipe Noct.u."
    echo "..."
    exit 1
  fi
else
  echo "..."
  echo "Java já Instalado!"
  echo "..."
fi

#Sudo com instalação e instalação do .jar
sleep 5
echo "..."
echo "Instalando aplicação Noct.u"
echo "Logo inicializaremos a sua central de monitoramento"
echo "..." 
echo "Estamos instalando a aplicação"
echo "..."
if curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar; then
    if [ -f "noctu-looca.jar" ]; then
        echo "Arquivo noctu-looca.jar baixado e instalado com sucesso!"
        # Executando a aplicação somente se o download do arquivo der certo
        java -jar noctu-looca.jar
    else
        echo "..."
        echo "O arquivo noctu-looca.jar não foi encontrado."
        echo "..."
        exit 1
    fi
else
    echo "..."
    echo "Erro ao baixar o arquivo noctu-looca.jar. Entre em contato com a equipe Noct.u"
    echo "..."
    exit 1
fi

echo "BEM - VINDO A NOCT.U!"