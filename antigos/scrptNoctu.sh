
#Fazer um usuário com permissões de root (sudo adduser noctu) -> (sudo usermod -a -G sudo noctu) -> (sudo passwd noctu)
#Logar no usuário (su noctu)
#Antes de executar o script baixar o git 
#Fazer git clone do repositório
#Dar permissão ao script para executa-lo (chmod +x)
#executar script ./

#!/bin/bash

#baixando pacotes iniciais

echo "Olá usuário, vamos instalar nossa nova aplicação!"
sleep 1
echo "Atualizando e baixando pacotes!"
sudo apt update && sudo apt upgrade -y
sleep 2
echo "Pacotes atualizados!"

#Baixando interface gráfica
sleep 3
echo "Instalando Interface Gráfica"
sudo apt install xrdp lxde-core lxde tigervnc-standalone-server -y

#verificando e instalando java
sleep 4
echo "Verificando se você possui o Java instalado na sua máquina!"
if ! command -v java &> /dev/null; then
  echo "Java não está instalado."
  read -p "Gostaria de instalar o OpenJDK-17? [s/n] " get
  if [ "$get" == "s" ]; then
    sudo apt install openjdk-17-jre -y
  else
    echo "Você escolheu não prosseguir. Por gentileza entre em contato com no equipe Noct.u."
    exit 1
  fi
else
  echo "Java Instalado com sucesso!"
fi

#Instalando e iniciando docker
sleep 5
echo "Docker.io"
sudo apt install docker.io -y
docker --version
sudo systemctl start docker
sudo systemctl enable docker

#Instalando e criando o banco da Noctu
sleep 6
echo "Instalando Mysql"
sudo docker pull mysql:5.7
sudo docker images
 

#verificando se está ativo
sleep 7
echo "Confirmação"
sudo docker ps -a

#Acessando banco e verificando tabelas existentes
sleep 8
echo "Acessando Banco de Dados"
sudo docker exec -it noctuBD bash -c "mysql -u root -p'#Gf42848080876' -e 'SHOW DATABASES;'"

# Verificando e executando o BD
sleep 9
echo "Iniciando Banco de Dados"
sudo docker exec -it noctuBD bash -c "mysql -u root -p'#Gf42848080876' -e 'USE root;'"

#Verificando se banco foi criado corretamente
if [ $? -eq 0 ]; then
    echo "Banco de dados 'root' criado com sucesso!"
else
    echo "Erro ao criar o banco de dados 'root'."
    exit 1
fi

# Criação das tabelas
#Verificar se é necessário criar todas as tabelas ou se ao executar o banco as tabelas são criadas automaticamente;
echo "Configurando banco de Dados"
sudo docker exec -i noctuBD mysql -u root -p'#Gf42848080876' -e "CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    telefoneFixo CHAR(12) NOT NULL,
    email VARCHAR(45) NOT NULL,
    senha VARCHAR(15) NOT NULL
);
CREATE TABLE endereco(
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
	cep CHAR(8) NOT NULL,
    uf CHAR(2) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    logradouro VARCHAR(45) NOT NULL
);
CREATE TABLE local(
	idLocal INT AUTO_INCREMENT,
    numero INT NOT NULL,
    complemento VARCHAR(45),
    andar INT,
    sala VARCHAR(45),
    fkEndereco INT NOT NULL,
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    PRIMARY KEY (idLocal, fkEndereco, fkEmpresa)
);
CREATE TABLE empresaLocataria (
	idEmpresaLocataria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cnpj CHAR(14),
    fkMatriz INT,
    fkEmpresa INT,
    FOREIGN KEY (fkMatriz) REFERENCES empresaLocataria(idEmpresaLocataria),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);
CREATE TABLE tipoUsuario(
	idTipoUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeTipo VARCHAR(45) NOT NULL
);
CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
	email VARCHAR(45) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    fkTipoUsuario INT NOT NULL,
    fkEmpresaAlocacao INT NOT NULL,
    FOREIGN KEY (fkEmpresaAlocacao) REFERENCES empresaLocataria(idEmpresaLocataria),
    FOREIGN KEY (fkTipoUsuario) REFERENCES tipoUsuario (idTipoUsuario)
);
CREATE TABLE modeloComputador(
	idModeloComputador INT PRIMARY KEY auto_increment,
    nome VARCHAR(45)
);
CREATE TABLE computador(
	idComputador INT PRIMARY KEY auto_increment,
    numeroSerie VARCHAR(45),
    fkEmpresa INT,
    fkModeloComputador INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkModeloComputador) REFERENCES modeloComputador(idModeloComputador)
);
CREATE TABLE tipoHardware(
	idTipoHardware INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);
CREATE TABLE hardware(
	idHardware INT PRIMARY KEY auto_increment,
    nome VARCHAR(100) NOT NULL,
    especificidade VARCHAR(45),
    capacidade FLOAT NOT NULL,
	fkTipoHardware INT,
    FOREIGN KEY (fkTipoHardware) REFERENCES tipoHardware(idTipoHardware)
);
CREATE TABLE componente(
	idComponente INT AUTO_INCREMENT,
    fkHardware INT,
    fkComputador INT,
    codigoSerial VARCHAR(45),
    FOREIGN KEY (fkHardware) REFERENCES hardware(idHardware),
    FOREIGN KEY (fkComputador) REFERENCES computador(idComputador),
    PRIMARY KEY (idComponente, fkHardware, fkComputador)
);
CREATE TABLE captura (
	idCaptura INT PRIMARY KEY AUTO_INCREMENT,
    valor FLOAT,
    descricao VARCHAR(45),
    dtCaptura DATETIME,
    fkComputador INT,
    fkHardware INT,
    fkComponente INT,
    FOREIGN KEY (fkComputador) REFERENCES componente(fkComputador),
    FOREIGN KEY (fkHardware) REFERENCES componente(fkHardware),
    FOREIGN KEY (fkComponente) REFERENCES componente(idComponente)
);"

if [ -z "$RESULT" ]; then
    echo "Tabelas criadas com sucesso!"
    sudo docker exec -it noctuBD bash -c "mysql -u root -p'#Gf42848080876' -e 'SHOW DATABASES;'"
else
    echo "Erro ao criar tabelas."
    echo "$RESULT"
    exit 1
fi

#Permissão e instalação do .jar
sleep 10
echo "Estamos instalando a aplicação"
curl -LJO https://github.com/Noct-U/Noct.u/raw/main/java/out/artifacts/noctu_looca_jar/noctu-looca.jar
if [ $? -eq 0 ]; then

    # Verificando se o arquivo baixado é um arquivo .jar válido
    if [ -f noctu-looca.jar ]; then
        echo "Iniciando o software"
        sleep 1
        echo "Bem-Vindo a Noct.u"
        chmod +x noctu-looca.jar
        java -jar noctu-looca.jar
    else
        echo "Erro ao rodar o .jar"
        exit 1
    fi
else
    echo "Erro ao executar o curl"
    exit 1
fi


