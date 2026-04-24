#!/bin/bash
#
# nginx-log-analyser.sh
# Script para analisar logs de acesso do Nginx e extrair as principais informações.

# Limpa a tela para melhor visualização dos resultados.
clear

# --- Validação de Argumentos ---
# Verifica se o arquivo de log foi fornecido como argumento.
if [ -z "$1" ]; then
  echo "Uso: $0 <caminho_para_o_arquivo_de_log>"
  exit 1
fi

LOG_FILE="$1"

# Verifica se o arquivo de log existe e é legível.
if [ ! -f "$LOG_FILE" ]; then
  echo "Erro: O arquivo '$LOG_FILE' não foi encontrado."
  exit 1
fi

if [ ! -r "$LOG_FILE" ]; then
  echo "Erro: O arquivo '$LOG_FILE' não tem permissão de leitura."
  exit 1
fi

echo "Analisando o arquivo de log: $LOG_FILE"
echo "--------------------------------------------------"
echo ""

# --- Top 5 Endereços IP com mais Requisições ---
echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""

# --- Top 5 Caminhos mais Requisitados ---
echo "Top 5 most requested paths:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""

# --- Top 5 Códigos de Status de Resposta ---
echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""

# --- Top 5 User Agents ---
echo "Top 5 user agents:"
#awk -F'"' '{print $6}' "$LOG_FILE" | sed 's/^ //g' | sort | uniq -c | sort -nr | head -n 5 | awk '{count=$1; $1=""; print $0 " - " count " requests"}'
awk -F'"' '{print $6}' "$LOG_FILE" | sed 's/^ //g' | sort | uniq -c | sort -nr | head -n 5 | awk '{count=$1; $1=""; sub(/^ +/, ""); print $0 " - " count " requests"}'
echo ""

echo "--------------------------------------------------"
echo "Análise concluída."
echo ""
