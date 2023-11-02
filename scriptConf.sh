#!/bin/bash

echo "Iniciando configurações"

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
