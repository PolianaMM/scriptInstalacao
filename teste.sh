#!/bin/bash

echo "Olá usuário, vamos instalar nossa nova aplicação!"
sleep 1
echo "Atualizando e baixando pacotes!"
sudo apt update && sudo apt upgrade
sleep 2
echo "Pacotes atualizados!"

echo "Verificando se você possui o Java instalado na sua máquina!"
sleep 2

if which java > /dev/null 2>&1; then
  java_version=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')

  if [ "$(echo -e "17\n$java_version" | sort -V | head -n 1)" == "17" ]; then
    echo "A versão do JDK é igual ou superior a 17."
sleep 3

        echo "Agora será baixado o arquivo .JAR"
        cd /home/$USER/Desktop
        wget https://github.com/Noct-U/Noct.u/tree/main/java/target/noctu-looca-1.0-SNAPSHOT.jar
        sleep 3

        echo "Arquivo baixado, agora será executado"
        java -jar noctu-looca-1.0-SNAPSHOT.jar
        sleep 3

        echo "Aquivo executando..."
        sleep 4
  else
    echo "A versão do JDK é inferior a 17."
    echo "Deseja atualizar? [s/n]"
    read get

    if [ "$get" == "s" ]; then
      sudo apt install openjdk-17-jre -y
      sleep 5

      echo "Agora será baixado o arquivo .JAR"
      #cd /home/$USER/Desktop
      wget https://github.com/Noct-U/Noct.u/tree/main/java/target/noctu-looca-1.0-SNAPSHOT.jar
      sleep 6

      echo "Arquivo baixado, agora será executado"
      java -jar noctu-looca-1.0-SNAPSHOT.jar
      sleep 7

      echo "Aquivo executando..."
      ./noctu-looca-1.0-SNAPSHOT.jar
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
  else
    echo "Você escolheu não prosseguir."
  fi
fi


