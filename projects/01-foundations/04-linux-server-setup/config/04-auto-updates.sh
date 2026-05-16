#!/usr/bin/env bash
# Instala e configura unattended-upgrades para patches de seguranca automaticos
set -euo pipefail

apt-get update -qq
apt-get install -y -qq unattended-upgrades apt-listchanges

# Habilita atualizacoes automaticas de seguranca
cat > /etc/apt/apt.conf.d/20auto-upgrades << 'CONF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
CONF
echo "[OK] Auto-upgrades configurado."

# Garante que apenas patches de seguranca sejam aplicados automaticamente
cat > /etc/apt/apt.conf.d/50unattended-upgrades << 'CONF'
Unattended-Upgrade::Allowed-Origins {
    "${distro_id}:${distro_codename}-security";
};
Unattended-Upgrade::AutoFixInterruptedDpkg "true";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "false";
CONF
echo "[OK] Politica de upgrade restrita a patches de seguranca."

systemctl enable unattended-upgrades
systemctl restart unattended-upgrades
echo "[OK] Servico unattended-upgrades ativo."
