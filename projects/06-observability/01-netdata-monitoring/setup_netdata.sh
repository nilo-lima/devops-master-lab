#!/bin/bash

echo "Iniciando a configuração do Netdata Monitoring..."

# 1. Verificar se o Docker está instalado
if ! command -v docker &> /dev/null
then
    echo "Docker não encontrado. Por favor, instale o Docker e o Docker Compose antes de continuar."
    exit 1
fi

echo "Docker e Docker Compose detectados."

# 2. Construir e iniciar o contêiner Netdata via Docker Compose
echo "Construindo e iniciando o serviço Netdata com Docker Compose..."
docker compose up -d --build

# 3. Verificar se o serviço Netdata foi iniciado corretamente
if [ $? -eq 0 ]; then
    echo "Serviço Netdata iniciado com sucesso!"
    echo "Você pode acessar o painel do Netdata em http://localhost:19999 (ou o IP da sua VM Vagrant:19999)."
else
    echo "Erro ao iniciar o serviço Netdata. Verifique os logs."
    exit 1
fi

echo "Configuração do Netdata Monitoring concluída."
