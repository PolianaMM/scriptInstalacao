#!/bin/bash

echo "Olá usuário, vamos instalar nossa nova aplicação!"
sleep 1

echo "Vamos fazer seu usário"
sudo adduser Noctu
sudo usermod -a -G sudo Noctu
su Noctu

echo "Atualizando e baixando pacotes!"
sudo apt update && sudo apt upgrade
sleep 2

echo "Pacotes atualizados!"
echo "Instalando interface gráfica"
sudo  apt install xrdp lxde-core lxde tigervnc-standalone-server -y

echo instalando mySql
sudo apt install mysql-server

echo "Verificando se você possui o Java instalado na sua máquina!"
sleep 2

if which java > /dev/null 2>&1; then
  java_version=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')

  if [ "$(echo -e "17\n$java_version" | sort -V | head -n 1)" == "17" ]; then
    echo "A versão do JDK é igual ou superior a 17."
sleep 3

        echo "Estamos instalando a aplicação"
             curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar

if [ $? -eq 0 ]; then
    # Verificando se o arquivo baixado é um arquivo .jar válido
    if [ -f noctu-looca.jar ]; then
        echo ""
        echo "Iniciando o software"
        sleep 1
        echo "Bem-Vindo a Noct.u"
        echo ""
        java -jar noctu-looca.jar
    else
        echo "Erro ao rodar o .jar"
        exit 1
    fi
else
    echo "Erro ao executar o curl"
    exit 1
fi
        sleep 4
  else
    echo "A versão do JDK é inferior a 17."
    echo "Deseja atualizar? [s/n]"
    read get

    if [ "$get" == "s" ]; then
      sudo apt install openjdk-17-jre -y
      sleep 5

      curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar

if [ $? -eq 0 ]; then
    # Verificando se o arquivo baixado é um arquivo .jar válido
    if [ -f noctu-looca.jar ]; then
        echo ""
        echo "Iniciando o software"
        sleep 1
        echo "Bem-Vindo a Noct.u"
        echo ""
        java -jar noctu-looca.jar
    else
        echo "Erro ao rodar o .jar"
        exit 1
    fi
else
    echo "Erro ao executar o curl"
    exit 1
fi
      sleep 8
    else
      echo "Você escolheu não prosseguir. Não poderemos continuar com instalação da aplicação."
    fi
  fi
else
  echo "Java não está instalado."
  echo "Gostaria de instalar o OpenJDK-17? [s/n]"
  read get

  if [ "$get" == "s" ]; then
    sudo apt install openjdk-17-jre -y

          curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar

if [ $? -eq 0 ]; then
    # Verificando se o arquivo baixado é um arquivo .jar válido
    if [ -f noctu-looca.jar ]; then
        echo ""
        echo "Iniciando o software"
        sleep 1
        echo "Bem-Vindo a Noct.u"
        echo ""
        java -jar noctu-looca.jar
    else
        echo "Erro ao rodar o .jar"
        exit 1
    fi
else
    echo "Erro ao executar o curl"
    exit 1
fi

  else
    echo "Você escolheu não prosseguir."
  fi
fi


