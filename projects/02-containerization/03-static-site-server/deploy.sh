#!/bin/bash

# --- Variáveis de Configuração ---
SERVER_IP="127.0.0.1" # IP do host Docker (para se conectar ao container via porta mapeada)
SSH_PORT="2222"       # Porta SSH mapeada para o container (será configurada no docker-compose.yml)
SSH_USER="root"       # Usuário SSH no container
SSH_KEY="/home/administrador/.ssh/id_rsa_static_server" # Caminho para a chave privada SSH local
SOURCE_DIR="./app/"        # Diretório local do site estático
DEST_DIR="/var/www/html/"  # Diretório de destino no container Docker

# --- Verificações Iniciais ---
if [ ! -f "${SSH_KEY}" ]; then
    echo "Erro: Chave SSH privada não encontrada em ${SSH_KEY}"
    echo "Certifique-se de que a chave foi gerada e que o caminho está correto."
    exit 1
fi

echo "Iniciando o deployment do site estático..."
echo "Sincronizando de ${SOURCE_DIR} para ${SSH_USER}@${SERVER_IP}:${DEST_DIR} via porta ${SSH_PORT}..."

# --- Executa Rsync para sincronizar os arquivos ---
# -a: modo archive (preserva permissões, timestamps, etc.)
# -v: verbose (mostra o que está sendo transferido)
# -z: comprime os dados durante a transferência
# -e "ssh ...": especifica o shell remoto (ssh) e suas opções (porta, chave, desabilitar host key checking)
rsync -avz -e "ssh -p ${SSH_PORT} -i ${SSH_KEY} -o StrictHostKeyChecking=no" \
      "${SOURCE_DIR}" \
      "${SSH_USER}@${SERVER_IP}:${DEST_DIR}"

if [ $? -eq 0 ]; then
    echo "Sincronização Rsync concluída com sucesso!"

    # --- Recarrega a configuração do Nginx no servidor remoto ---
    echo "Recarregando Nginx no servidor remoto..."
    ssh -p "${SSH_PORT}" -i "${SSH_KEY}" -o StrictHostKeyChecking=no "${SSH_USER}@${SERVER_IP}" "nginx -s reload"

    if [ $? -eq 0 ]; then
        echo "Nginx recarregado com sucesso no servidor remoto."
        echo "Deployment concluído!"
    else
        echo "Erro ao recarregar Nginx no servidor remoto."
        exit 1
    fi
else
    echo "Erro durante a sincronização Rsync."
    exit 1
fi
