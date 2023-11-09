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

sleep 3
echo "..."  
echo "Criando Docker" 
echo "Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."
if sudo apt install docker.io -y && sudo systemctl start docker && sudo systemctl enable docker; then
echo "Docker instalado e iniciado com sucesso!"
else
echo "Erro ao instalar o Docker."
exit 1
fi

#Criação do container Banco de Dados e instalação
sleep 4

echo "..."  
echo "Instalando Mysql" 
echo "Aguarde um instante enquanto fazemos as configurações..." 
echo "Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."  

if sudo docker pull mysql:8; then
    echo "Docker image do MySQL 8 baixada com sucesso!"
else
    echo "Erro ao baixar a imagem do MySQL. Entre em contato com a equipe Noct.u."
    exit 1
fi

# Verificar a existência da imagem baixada
if sudo docker images | grep -q "mysql"; then
    echo "Imagem do MySQL 8 encontrada."
else
    echo "Imagem do MySQL 8 não encontrada. Encerrando o script. Entre em contato com a equipe Noct.u."
    exit 1
fi

if sudo docker run -d -p 3306:3306 --name noctuBD -e "MYSQL_DATABASE=aluno" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:8; then
    echo "Container do Banco de Dados criado com sucesso!"
else
    echo "Erro ao criar o container do Banco de dados. Entre em contato com a equipe Noct.u."
    exit 1
fi

# Verificando se o container está em execução
if sudo docker ps -a | grep -q "noctuBD"; then
    echo "Container do Banco de Dados está em execução."
else
    echo "Erro ao iniciar o container do Banco de dados. Entre em contato com a equipe Noct.u."
    exit 1
fi

# Iniciando o serviço do MySQL no container
if sudo service mysql start; then
    echo "Banco de dados iniciado com sucesso!"
else
    echo "Erro ao iniciar o Banco de dados. Entre em contato com a equipe Noct.u."
    exit 1
fi

#Lista de containers assossiados
echo "..." 
echo "Verificando se a instalação está funcionando"
echo "..." 
sudo docker ps -a

#Importando o script .sql para container do banco
sleep 6
echo "..."
echo "Configurando Banco de Dados"  
echo "..."
if sudo docker exec -i noctuBD mysql -u aluno -p < confBanco.sql; then
echo "Script SQL executado com sucesso no banco de dados!"
else
echo "Erro ao executar o script SQL."
exit 1
fi
# Conexão com Banco local
# mysql -h 127.0.0.1 -P 3306 -u aluno -p aluno -D aluno  

# Verificando e executando o Banco de Dados
sleep 7
echo "..."
echo "Iniciando Banco de Dados" 
echo "..."
if sudo docker exec noctuBD service mysql start; then
echo "Banco de Dados Iniciado com sucesso!"
else
echo "Erro ao iniciar Banco de dados"
exit 1
fi

sleep 8
echo "..."  
echo "Instalando Java 17"  
echo "Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."  

if docker build -t java_17_image .; then
    echo "Construção da imagem do Java 17 bem-sucedida!"
else
    echo "Erro durante a construção da imagem do Java 17. Entre em contato com a equipe Noct.u"
    exit 1
fi

if sudo docker run -it --name containerJava java_17_image /bin/bash; then
    echo "Container Java 17 iniciado com sucesso!"
else
    echo "Erro ao iniciar o container do Java 17. Entre em contato com a equipe Noct.u."
    exit 1
fi

#Instalação do .jar
sleep 9
echo "..."
echo "Instalando aplicação Noct.u"
echo "Logo inicializaremos a sua central de monitoramento"
echo "..." 
echo "Estamos instalando a aplicação"

if curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar; then
    if [ -f "noctu-looca.jar" ]; then
        echo "Arquivo noctu-looca.jar baixado e instalado com sucesso!"
        # Executando a aplicação somente se o download do arquivo foi bem-sucedido
        java -jar noctu-looca.jar
    else
        echo "O arquivo noctu-looca.jar não foi encontrado."
        exit 1
    fi
else
    echo "Erro ao baixar o arquivo noctu-looca.jar. Entre em contato com a equipe Noct.u"
    exit 1
fi

echo "BEM - VINDO A NOCT.U!"