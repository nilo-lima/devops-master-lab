#!/usr/bin/env bash
# Configura timezone e hostname do servidor
set -euo pipefail

TIMEZONE="${1:-America/Sao_Paulo}"
HOSTNAME="${2:-lab-server}"

# Timezone
timedatectl set-timezone "$TIMEZONE"
echo "[OK] Timezone configurado: $(timedatectl | grep 'Time zone')"

# Hostname
hostnamectl set-hostname "$HOSTNAME"
echo "[OK] Hostname configurado: $HOSTNAME"

# Atualiza /etc/hosts para evitar warnings de resolucao
if ! grep -q "$HOSTNAME" /etc/hosts; then
  echo "127.0.1.1   $HOSTNAME" >> /etc/hosts
  echo "[OK] /etc/hosts atualizado."
fi

echo ""
echo "Uso: $0 [timezone] [hostname]"
echo "Exemplo: $0 America/Sao_Paulo meu-servidor"
