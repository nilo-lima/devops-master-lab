# 📊 Server Stats Tool

Ferramenta de monitoramento leve desenvolvida em Shell Script para extração de métricas vitais de servidores Linux. Este projeto faz parte do pilar **01-Foundations**.

## 🎯 Objetivo
O objetivo deste projeto é fornecer uma visão rápida e clara da saúde do servidor (CPU, Memória, Disco e Processos), utilizando ferramentas nativas do sistema operacional para garantir máxima portabilidade e baixo consumo de recursos.

## 🚀 Como Executar

### Via Script Local
```bash
chmod +x server-stats.sh
./server-stats.sh
```

### Via Docker
```bash
docker build -t server-stats-app .
docker run --rm server-stats-app
```

## 🧠 Aprendizados
- Manipulação de strings com `awk` e `sed`.
- Estruturação de containers para ferramentas de sistema com Alpine e `procps`.
