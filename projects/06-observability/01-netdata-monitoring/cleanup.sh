#!/bin/bash

echo "Iniciando a limpeza do ambiente Netdata Monitoring..."

# 1. Parar e remover o contêiner Netdata, volumes e imagens
echo "Parando, removendo o contêiner Netdata, seus volumes e imagens..."
docker compose down -v --rmi all

echo "Limpeza do ambiente Netdata Monitoring concluída."
