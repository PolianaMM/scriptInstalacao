if sudo docker build -t bancodedados .; then
    echo "..."
    echo "Imagem do MySQL construída com sucesso!"
    echo "..."
else
    echo "..."
    echo "Erro ao construir a imagem do MySQL. Entre em contato com a equipe Noct.u."
    echo "..."
    exit 1
fi

# Verificar a existência da imagem baixada
sleep 5
if sudo docker images | grep -q "bancodedados"; then
    echo "..."
    echo "Imagem do MySQL encontrada."
    echo "..."
else
    echo "..."
    echo "Imagem do MySQL não encontrada. Encerrando o script. Entre em contato com a equipe Noct.u."
    echo "..."
    exit 1
fi