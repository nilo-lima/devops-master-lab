#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
TERRAFORM_DIR="$PROJECT_DIR/terraform"
ANSIBLE_DIR="$PROJECT_DIR/ansible"

echo "🔍 Verificando pré-requisitos..."
command -v terraform >/dev/null 2>&1 || { echo "❌ Terraform não encontrado. Instale: https://developer.hashicorp.com/terraform/install"; exit 1; }
command -v ansible-playbook >/dev/null 2>&1 || { echo "❌ Ansible não encontrado. Instale: pip install ansible"; exit 1; }
command -v aws >/dev/null 2>&1 || { echo "❌ AWS CLI não encontrado."; exit 1; }
aws sts get-caller-identity >/dev/null 2>&1 || { echo "❌ Credenciais AWS não configuradas. Execute: aws configure"; exit 1; }

echo "🏗️   Inicializando Terraform..."
cd "$TERRAFORM_DIR"
terraform init

echo "🚀 Provisionando infraestrutura na AWS..."
terraform apply -auto-approve

echo "📋 Gerando inventário Ansible..."
INSTANCE_IP=$(terraform output -raw instance_ip)
PRIVATE_KEY_PATH=$(realpath "$(terraform output -raw private_key_path)")

printf '[web]\n%s ansible_user=ubuntu ansible_ssh_private_key_file=%s\n' \
  "$INSTANCE_IP" "$PRIVATE_KEY_PATH" > "$ANSIBLE_DIR/inventory.ini"

echo ""
echo "✅ Infraestrutura provisionada com sucesso!"
echo "   🌐 IP Público : $INSTANCE_IP"
echo "   🔑 Chave SSH  : $PRIVATE_KEY_PATH"
echo ""
echo "   Próximo passo: make configure"
