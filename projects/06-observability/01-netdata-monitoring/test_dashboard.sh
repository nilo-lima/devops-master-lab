#!/bin/bash

echo "Iniciando teste de carga para o dashboard Netdata..."
echo "Este script irá simular alto uso de CPU por um período."
echo "Gerar carga na CPU"
echo "O 'yes > /dev/null &' cria um processo que consome 100% de um núcleo da CPU."
echo "Usamos 'seq' para criar vários processos para simular carga em múltiplos núcleos."
# O número de processos pode ser ajustado conforme a necessidade e o número de núcleos disponíveis.
NUM_PROCESSES=${1:-$(nproc)} # Usa o número de núcleos do processador como padrão, ou o primeiro argumento

echo "Simulando carga em ${NUM_PROCESSES} núcleos de CPU por 90 segundos..."

for i in $(seq 1 $NUM_PROCESSES); do
  yes > /dev/null &
done

# Armazenar os PIDs dos processos em segundo plano
PIDS=$(jobs -p)

echo "Processos de carga iniciados. Monitorando por 90 segundos..."
sleep 90

echo "Parando processos de carga..."
kill $PIDS
wait $PIDS 2>/dev/null # Espera os processos terminarem, redireciona stderr para /dev/null para evitar mensagens de "No such process"

echo "Teste de carga concluído. Verifique o dashboard do Netdata."
