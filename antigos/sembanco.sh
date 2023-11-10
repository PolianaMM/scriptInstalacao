#Antes de executar o script baixar o git (sudo apt install git)
#Fazer git clone do repositório do script (git clone *link_repositório*)
#Dar permissão ao script e ao sql para executa-lo (chmod +x install.sh / chmod +x confBanco.sh)
#Executar script (./install.sh)

#!/bin/bash

#Baixando pacotes iniciais
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

# Mensagem sobre a criação do Docker
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

# Iniciando o Docker
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

# Habilita o Docker
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

# Instalando java
sleep 5
echo "..."  
echo "Instalando Java 17"  
echo "Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."  
if sudo docker build -t java_17_image .; then
    echo "..."
    echo "Construção da imagem do Java 17 concluida!"
    echo "..."
else
    echo "..."
    echo "Erro durante a construção da imagem do Java 17. Entre em contato com a equipe Noct.u"
    echo "..."
    exit 1
fi
if sudo docker run -it --name containerJava java_17_image ; then
    echo "..."
    echo "Container Java 17 iniciado com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao iniciar o container do Java 17. Entre em contato com a equipe Noct.u."
    echo "..."
    exit 1
fi

#Instalação do .jar
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