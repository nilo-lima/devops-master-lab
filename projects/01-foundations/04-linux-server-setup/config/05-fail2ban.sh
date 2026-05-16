#!/usr/bin/env bash
# Instala e configura Fail2Ban com jail SSH customizado
set -euo pipefail

apt-get install -y -qq fail2ban

# Configuracao customizada (mais agressiva que o padrao)
cat > /etc/fail2ban/jail.local << 'CONF'
[DEFAULT]
bantime  = 3600
findtime = 600
maxretry = 3
backend  = systemd

[sshd]
enabled  = true
port     = ssh
logpath  = %(sshd_log)s
maxretry = 3
bantime  = 3600
CONF
echo "[OK] Jail SSH configurado: 3 tentativas, ban de 1 hora."

systemctl enable fail2ban
systemctl restart fail2ban
echo "[OK] Fail2Ban ativo."

fail2ban-client status
