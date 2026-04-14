#!/bin/bash

# ==============================================================================
# Script: server-stats.sh
# Objetivo: Coletar e exibir métricas básicas de performance do servidor.
# ==============================================================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================================${NC}"
echo -e "${GREEN}             SERVER PERFORMANCE STATS                ${NC}"
echo -e "${BLUE}=====================================================${NC}"

# 1. Uso Total de CPU
echo -n "Total CPU Usage: "
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'

# 2. Uso de Memória (Livre vs Usada com porcentagem)
echo -e "\nMemory Usage:"
free -m | awk 'NR==2{printf "   Used: %sMB (%.2f%%) | Free: %sMB\n", $3, $3*100/$2, $4}'

# 3. Uso de Disco (Partição raiz)
echo -e "\nDisk Usage (Root /):"
df -h / | awk 'NR==2{printf "   Used: %s | Free: %s | Utilization: %s\n", $3, $4, $5}'

# 4. Top 5 processos por uso de CPU
echo -e "\n${GREEN}Top 5 Processes by CPU Usage:${NC}"
printf "%-10s %-10s %-25s %-10s %-10s\n" "PID" "USER" "COMMAND" "%MEM" "%CPU"
ps -eo pid,user,comm,%mem,%cpu --sort=-%cpu | head -n 6 | tail -n 5 | awk '{printf "%-10s %-10s %-25s %-10s %-10s\n", $1, $2, $3, $4, $5}'

# 5. Top 5 processos por uso de Memória
echo -e "\n${GREEN}Top 5 Processes by Memory Usage:${NC}"
printf "%-10s %-10s %-25s %-10s %-10s\n" "PID" "USER" "COMMAND" "%MEM" "%CPU"
ps -eo pid,user,comm,%mem,%cpu --sort=-%mem | head -n 6 | tail -n 5 | awk '{printf "%-10s %-10s %-25s %-10s %-10s\n", $1, $2, $3, $4, $5}'

echo -e "${BLUE}=====================================================${NC}"
