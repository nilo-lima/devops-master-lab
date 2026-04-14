# 📊 Server Stats Tool

Ferramenta de monitoramento leve desenvolvida em Shell Script para extração de métricas vitais de servidores Linux. Este projeto faz parte do pilar **01-Foundations**.

## 🎯 Objetivo
O objetivo deste projeto é fornecer uma visão rápida e clara da saúde do servidor (CPU, Memória, Disco e Processos), utilizando ferramentas nativas do sistema operacional para garantir máxima portabilidade e baixo consumo de recursos.

## 🚀 Como Executar

### Pré-requisitos
- Git instalado.
- Docker instalado (recomendado) ou ambiente Linux/macOS.

### 1. Clone o Repositório
```bash
git clone https://github.com/nilo-lima/DevOps_Master_Lab.git
cd DevOps_Master_Lab/projects/01-foundations/01-server-stats/
```

### 2. Execução via Docker (Recomendado)
Garante que a ferramenta rode em um ambiente isolado com todas as dependências pré-configuradas.
```bash
# Build da imagem
docker build -t server-stats-app .

# Execução do container
docker run --rm server-stats-app
```

### 3. Execução Local (Script Bash)
Ideal para verificações rápidas diretamente no host.
```bash
chmod +x server-stats.sh
./server-stats.sh
```

## 🧠 Aprendizados
- Manipulação de strings com `awk` e `sed`.
- Estruturação de containers para ferramentas de sistema com Alpine e `procps`.
