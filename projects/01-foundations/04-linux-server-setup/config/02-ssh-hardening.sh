#!/usr/bin/env bash
# Hardeniza o servidor SSH: desabilita senha, habilita autenticacao por chave
set -euo pipefail

SSHD_CONFIG="/etc/ssh/sshd_config"
BACKUP="${SSHD_CONFIG}.bak.$(date +%Y%m%d%H%M%S)"

# Backup antes de qualquer alteracao
cp "$SSHD_CONFIG" "$BACKUP"
echo "[OK] Backup criado em $BACKUP"

# Aplica configuracoes de seguranca
declare -A SSH_SETTINGS=(
  ["PermitRootLogin"]="no"
  ["PasswordAuthentication"]="no"
  ["PubkeyAuthentication"]="yes"
  ["AuthorizedKeysFile"]=".ssh/authorized_keys"
  ["MaxAuthTries"]="3"
  ["LoginGraceTime"]="30"
  ["X11Forwarding"]="no"
  ["AllowAgentForwarding"]="no"
  ["ClientAliveInterval"]="300"
  ["ClientAliveCountMax"]="2"
)

for KEY in "${!SSH_SETTINGS[@]}"; do
  VALUE="${SSH_SETTINGS[$KEY]}"
  if grep -q "^${KEY}" "$SSHD_CONFIG"; then
    sed -i "s|^${KEY}.*|${KEY} ${VALUE}|" "$SSHD_CONFIG"
  else
    echo "${KEY} ${VALUE}" >> "$SSHD_CONFIG"
  fi
  echo "[OK] $KEY = $VALUE"
done

# Valida sintaxe antes de reiniciar
sshd -t && echo "[OK] Sintaxe do sshd_config valida."

systemctl restart ssh
echo "[OK] SSH reiniciado com configuracoes de seguranca aplicadas."
