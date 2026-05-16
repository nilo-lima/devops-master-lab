#!/usr/bin/env bash
# Cria um usuario nao-root com privilegios sudo
set -euo pipefail

USERNAME="${1:-devops}"

if id "$USERNAME" &>/dev/null; then
  echo "[INFO] Usuario '$USERNAME' ja existe. Pulando criacao."
else
  useradd -m -s /bin/bash "$USERNAME"
  echo "[OK] Usuario '$USERNAME' criado."
fi

# Adiciona ao grupo sudo
usermod -aG sudo "$USERNAME"
echo "[OK] Usuario '$USERNAME' adicionado ao grupo sudo."

# Forca troca de senha no primeiro login (boa pratica de seguranca)
passwd -e "$USERNAME"
echo "[OK] Senha expirada. Usuario devera definir nova senha no proximo login."

echo ""
echo "==> Execute como root: passwd $USERNAME  (para definir a senha inicial)"
