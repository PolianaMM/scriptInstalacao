#!/bin/bash
PURPLE='0;35'
NC='\033[0m' 
VERSAO=11
#Sudo instalando e atualizando pacotes iniciais da VM
echo "..."
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Olá usuário! Bem -vindo a Noct.u! Vamos iniciar nossa instalação!!"
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Vamos iniciar nossa instalação!!"
echo "..."
sleep 5
echo "..." 
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Atualizando e baixando pacotes do programa!" 
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Aguarde um momento"
echo "..." 
if sudo apt update -y && sudo apt upgrade -y; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Pacotes atualizados!"
    echo "..."
else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro ao instalar o Docker."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Entre em contato com a equipe Noct.u e informe o comando = update e upgrade "
    echo "..."
    exit 1
fi

# Sudo com criação do Docker
sleep 5
echo "..."
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Instalando Docker..."
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."
if sudo apt install docker.io -y; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Docker instalado com sucesso!"
    echo "..."
else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro ao instalar o Docker."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Entre em contato com a equipe Noct.u e informe o comando = install docker.io"
    echo "..."
    exit 1
fi

# Sudo iniciando o Docker
sleep 5
echo "..."
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Iniciando Docker"
echo "..."
if sudo systemctl start docker; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Docker iniciado com sucesso!"
    echo "..."
else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro ao iniciar o Docker."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Entre em contato com a equipe Noct.u e informe o comando = start docker"
    echo "..."
    exit 1
fi

# Sudo habilitando o Docker
sleep 5
echo "..."
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Habilitando Docker"
echo "..."
if sudo systemctl enable docker; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Docker habilitado com sucesso!"
    echo "..."
else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro ao habilitar o Docker."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Entre em contato com a equipe Noct.u e informe o comando = enable docker"
    echo "..."
    exit 1
fi

#baixando imagem mysql com pull
sleep 5
echo "..."  
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Instalando Mysql" 
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Aguarde um instante enquanto fazemos as configurações..." 
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Não se preocupe, esse processo não afetará seus aplicativos atuais"
echo "..."  
if sudo docker pull mysql:latest; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Imagem carregada com sucesso!"
    echo "..."
else 
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro ao criar o container do Banco de dados."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Entre em contato com a equipe Noct.u e informe o comando = docker pull mysql:latest"
    echo "..."
    exit 1
fi

#Criando container do Banco de Dados
sleep 5
if sudo docker run -d -p 3306:3306 --name Noctu -e "MYSQL_DATABASE=noctuBD" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:latest; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Container do Banco de Dados criado com sucesso!"
    echo "..."
else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro ao criar o container do Banco de dados."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Entre em contato com a equipe Noct.u e informe o comando = docker run -d -p 3306:3306 --name Noctu -e "MYSQL_DATABASE=XX" -e "MYSQL_ROOT_PASSWORD=XX" mysql:latest"
    echo "..."
    exit 1
fi

#Atualizando VM
sleep 5
echo "..."
echo -e "\033[${PURPLE}m[Noct.u]:${NC} Instalando aplicações complementares"
echo "..."
if sudo apt update -y; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Atualização realizada!"
    echo "..."
else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro fazer atualização."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Entre em contato com a equipe NOct.u e informe o comando = update"
    echo "..."
    exit 1
fi

#executando Docker
sleep 15
if sudo docker exec -i Noctu mysql -u root -paluno < /home/ubuntu/scriptInstalacao/confBanco.sql; then
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Docker Noct.u executado com sucesso!"
    echo "..."
else
    echo "..."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Erro ao executar o docker."
    echo -e "\033[${PURPLE}m[Noct.u]:${NC} Entre em contato com a equipe NOct.u e informe o comando = docker exec -it Noctu mysql -u aluno -paluno <caminhoScript"
    echo "..."
    exit 1
fi

sudo chmod +x /home/ubuntu/scriptInstalacao/java.sh

./java.sh

