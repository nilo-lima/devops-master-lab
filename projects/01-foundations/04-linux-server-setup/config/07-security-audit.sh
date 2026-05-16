#!/usr/bin/env bash
# Verifica se todas as configuracoes de seguranca foram aplicadas corretamente
set -uo pipefail

PASS=0
FAIL=0

check() {
  local DESC="$1"
  local CMD="$2"
  if eval "$CMD" &>/dev/null; then
    echo "  [PASS] $DESC"
    PASS=$((PASS + 1))
  else
    echo "  [FAIL] $DESC"
    FAIL=$((FAIL + 1))
  fi
}

echo "========================================"
echo " AUDITORIA DE SEGURANCA DO SERVIDOR"
echo "========================================"

echo ""
echo "--- Usuarios ---"
check "Usuario sudo nao-root existe" "getent group sudo | cut -d: -f4 | grep -q '.'"
check "Root nao tem login direto (PasswordAuthentication no)" "grep -q '^PermitRootLogin no' /etc/ssh/sshd_config"

echo ""
echo "--- SSH ---"
check "Autenticacao por senha desabilitada" "grep -q '^PasswordAuthentication no' /etc/ssh/sshd_config"
check "PubkeyAuthentication habilitada" "grep -q '^PubkeyAuthentication yes' /etc/ssh/sshd_config"
check "MaxAuthTries configurado" "grep -q '^MaxAuthTries' /etc/ssh/sshd_config"

echo ""
echo "--- Firewall ---"
check "UFW ativo" "ufw status | grep -q 'Status: active'"
check "SSH permitido no UFW" "ufw status | grep -q '22'"

echo ""
echo "--- Atualizacoes ---"
check "unattended-upgrades instalado" "dpkg -l unattended-upgrades | grep -q '^ii'"
check "unattended-upgrades ativo" "systemctl is-active unattended-upgrades"

echo ""
echo "--- Fail2Ban ---"
check "Fail2Ban instalado" "dpkg -l fail2ban | grep -q '^ii'"
check "Fail2Ban ativo" "systemctl is-active fail2ban"
check "Jail SSH configurado" "fail2ban-client status sshd"

echo ""
echo "--- Sistema ---"
check "Timezone configurado" "timedatectl | grep -q 'Time zone'"
check "Hostname nao e localhost" "hostname | grep -vq 'localhost'"

echo ""
echo "========================================"
echo " RESULTADO: $PASS verificacoes OK | $FAIL falhas"
echo "========================================"

[ "$FAIL" -eq 0 ] && exit 0 || exit 1
