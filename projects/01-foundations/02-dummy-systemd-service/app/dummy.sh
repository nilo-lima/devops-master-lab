#!/bin/bash
#
LOG_FILE="/var/log/dummy-service.log"
# Garante que o diretório de log exista
mkdir -p "$(dirname "$LOG_FILE")"
while true; do
  echo "$(date): Dummy service is running..." >> "$LOG_FILE"
  sleep 10
done
