
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