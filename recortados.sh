#!/bin/bash

# Definir as cores
PURPLE='\033[0;35m'
NC='\033[0m' # Para resetar a cor
VERSAO=17

# Função para exibir mensagens com formatação
show_message() {
    echo -e "${PURPLE}[Noct.u]:${NC} $1"
}

show_message "Olá usuário! Bem-vindo à Noct.u! Vamos iniciar nossa instalação!!"
show_message "Vamos iniciar verificando se você possui o Docker instalado..."
sleep 10

# Verifica se o Docker já está instalado
        # Instalação do Docker
        sudo apt update -y
        sudo apt install docker.io -y
        sudo systemctl start docker
        sudo systemctl enable docker
        show_message "Docker instalado com sucesso!"
        show_message "Agora iremos construir a imagem do MySQL e iniciar o container."
        sleep 7

        # Construir a imagem MySQL usando Dockerfile
        show_message "Construindo a imagem do MySQL..."
        docker build -t noctu/mysql .

        # Iniciando o container
        if [ -z "$(docker ps -q -f name=noctuBD)" ]; then
            show_message "Iniciando o container MySQL..."
            docker run -d -p 3306:3306 --name noctuBD noctu/mysql
            show_message "Container MySQL criado com sucesso!"

            show_message "Agora precisamos executar nosso script SQL para configurar o banco de dados."
            sleep 2

            # Certifique-se de que o arquivo "confBanco.sql" existe no diretório atual
            if [ -e "confBanco.sql" ]; then
                show_message "Executando script SQL..."
                docker exec -i noctuBD mysql -u aluno -paluno Noct.u < confBanco.sql
                show_message "Script SQL executado com sucesso!"
            else
                show_message "Arquivo 'confBanco.sql' não encontrado. O script SQL não pôde ser executado."
            fi
        else
            show_message "Você optou por não instalar o Docker neste momento. Até a próxima!"
        fi
fi

show_message "Agora iremos verificar se você já possui o Java instalado, aguarde um instante..."
sleep 5

if ! command -v java &> /dev/null; then
    show_message "Você ainda não possui o Java instalado."
    echo "Deseja instalar o Java (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        show_message "Ok! Você escolheu instalar o Java."
        show_message "Adicionando o repositório..."
        sleep 7
        sudo apt update -y

        if [ $VERSAO -eq 17 ]; then
            show_message "Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
            sudo apt install openjdk-17-jre -y
            show_message "Java instalado com sucesso!"
            show_message "Atualizando os pacotes..."
            sudo apt update && sudo apt upgrade -y
        fi
    else
        show_message "Você optou por não instalar o Java neste momento."
    fi
else
    show_message "Você já possui o Java instalado!"
fi

cd ~/Desktop
show_message "Diretório Desktop acessado!"

show_message "Baixando o arquivo JAR..."

sudo apt install wget -y

if curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar; then
show_message "Arquivo JAR baixado com sucesso!"

show_message "Executando o arquivo JAR..."

java -jar noctu-looca.jar
chmod +x noctu-looca.jar

show_message "Tudo configurado com sucesso, bem-vindo à Noct.u!"