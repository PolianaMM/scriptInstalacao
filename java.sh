#!/bin/bash

#cor:
PURPLE='0;35'
#redefine formatação do texto:
NC='\033[0m'
#especifica número da versão 
VERSAO=11

# URL do arquivo JAR no GitHub
jar_url="https://github.com/PolianaMM/jarPoliana/raw/main/out/artifacts/jar_individual_jar/jar-individual.jar"

# Nome do arquivo JAR após o download
jar_nome="jar-individual.jar"

# verificando e instalando java 17
sleep 5
echo "..."
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Verificando se você possui o Java instalado na sua máquina!"
echo "..."

#validação do java: 
if which java > /dev/null 2>&1; then
  java_version=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')

  if [ "$(echo -e "17\n$java_version" | sort -V | head -n 1)" == "17" ]; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} A versão do JDK é igual ou superior a 17."
    echo "..."
    sleep 5
  else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} A versão do JDK é inferior a 17."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Deseja atualizar o java? [s/n]"
    echo "..."
    read get
    if [ "$get" == "s" ]; then
      sudo apt install openjdk-17-jre -y
      sleep 5
    else
      echo "..."
      echo -e "\033[${PURPLE}m[Noct.u]:${NC} Você escolheu não prosseguir. Não poderemos continuar com instalação da aplicação."
      echo "..."
    fi
  fi
else
  echo "..."
  echo -e "\033[${PURPLE}m[Noct.u]:${NC} Java não está instalado."
  echo -e "\033[${PURPLE}m[Noct.u]:${NC} Gostaria de instalar o OpenJDK-17? [s/n]"
  echo "..."
  read get
  if [ "$get" == "s" ]; then
    sudo apt install openjdk-17-jre -y
  else
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Você escolheu não prosseguir. Não poderemos continuar com instalação da aplicação"
  fi
fi
sleep 5

sudo apt update && sudo apt upgrade -y

#instalação do .jar
sleep 5
echo "..."
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Instalando aplicação Noct.u"
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Logo inicializaremos a sua central de monitoramento"
echo "..." 
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Estamos instalando a aplicação"
echo "..."
if [ ! -f "$jar_nome" ]; then
  echo "..." 
  echo -e "\033[${PURPLE}m[Noct.u]:${NC} Baixando a aplicação JAR..."
  echo "..." 
  sudo apt install wget -y
  sleep 5
  sudo wget "$jar_url" -O "$jar_nome"
# Verificar se o download foi bem-sucedido
    if [ $? -eq 0 ]; then
      echo "..."
      echo -e "\033[${PURPLE}m[Noct.u]:${NC} Download do arquivo concluído com sucesso!"
      echo "..."
    else
      echo "..."
      echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro ao baixar o arquivo JAR."
      echo -e "\033[${PURPLE}m[Noct.u]:${NC} Entre em contato com a equipe Noctu e informe o comando = wget "" -O ""."
      echo "..."
      exit 1
    fi
else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Arquivo JAR já existe. Vamos inicializar..."
    echo "..."
fi

# Executar o arquivo JAR
java -jar "$jar_nome"

# Verificar se a execução foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Execução do arquivo JAR bem-sucedida."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} BEM - VINDO A NOCT.U!"
    echo "..."
else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro ao executar o arquivo JAR."
    echo "..."
fi

