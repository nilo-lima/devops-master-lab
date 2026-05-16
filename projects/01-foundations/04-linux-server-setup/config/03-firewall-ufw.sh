#!/usr/bin/env bash
# Configura UFW: bloqueia tudo, libera apenas SSH
set -euo pipefail

apt-get install -y -qq ufw

# Politica padrao: negar entrada, permitir saida
ufw default deny incoming
ufw default allow outgoing

# Libera SSH antes de ativar (evita lock-out)
ufw allow ssh
echo "[OK] SSH (porta 22) liberado."

# Ativa sem confirmacao interativa
ufw --force enable
echo "[OK] UFW ativado."

ufw status verbose
