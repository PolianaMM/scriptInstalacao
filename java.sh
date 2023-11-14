#!/bin/bash

# URL do arquivo JAR no GitHub
jar_url="https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar"

# Nome do arquivo JAR após o download
jar_nome="noctu-looca.jar"

# verificando e instalando java 17
sleep 5
echo "..."
echo "Verificando se você possui o Java instalado na sua máquina!"
echo "..."
if which java > /dev/null 2>&1; then
  java_version=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')

  if [ "$(echo -e "17\n$java_version" | sort -V | head -n 1)" == "17" ]; then
    echo "..."
    echo "A versão do JDK é igual ou superior a 17."
    echo "..."
    sleep 5
  else
    echo "..."
    echo "A versão do JDK é inferior a 17."
    echo "Deseja atualizar o java? [s/n]"
    echo "..."
    read get
    if [ "$get" == "s" ]; then
      sudo apt install openjdk-17-jre -y
      sleep 5
    else
      echo "..."
      echo "Você escolheu não prosseguir. Não poderemos continuar com instalação da aplicação."
      echo "..."
    fi
  fi
else
  echo "..."
  echo "Java não está instalado."
  echo "Gostaria de instalar o OpenJDK-17? [s/n]"
  echo "..."
  read get
  if [ "$get" == "s" ]; then
    sudo apt install openjdk-17-jre -y
  else
    echo "Você escolheu não prosseguir. Não poderemos continuar com instalação da aplicação"
  fi
fi
sleep 5

sudo apt update && sudo apt upgrade -y

#instalação do .jar
sleep 5
echo "..."
echo "Instalando aplicação Noct.u"
echo "Logo inicializaremos a sua central de monitoramento"
echo "..." 
echo "Estamos instalando a aplicação"
echo "..."
if [ ! -f "$jar_nome" ]; then
  echo "Baixando a aplicação JAR..."
  sudo apt install wget -y
  sleep 5
  sudo wget "$jar_url" -O "$jar_nome"
# Verificar se o download foi bem-sucedido
    if [ $? -eq 0 ]; then
      echo "..."
      echo "Download do arquivo concluído com sucesso!"
      echo "..."
    else
      echo "..."
      echo "Erro ao baixar o arquivo JAR."
      echo "Entre em contato com a equipe Noctu e informe o comando = wget "" -O ""."
      echo "..."
      exit 1
    fi
else
    echo "..."
    echo "Arquivo JAR já existe. Continuando a execução..."
    echo "..."
fi

# Executar o arquivo JAR
java -jar "$jar_nome"

# Verificar se a execução foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "..."
    echo "Execução do arquivo JAR bem-sucedida."
    echo "..."
else
    echo "..."
    echo "Erro ao executar o arquivo JAR."
    echo "..."
fi

echo "BEM - VINDO A NOCT.U!"