#!/bin/bash

PURPLE='0;35'
NC='\033[0m' 
VERSAO=11

# verificando e instalando java 17
sleep 5
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