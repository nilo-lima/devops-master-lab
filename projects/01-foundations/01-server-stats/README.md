# 📊 Server Stats Tool

Ferramenta de monitoramento leve desenvolvida em Shell Script para extração de métricas vitais de servidores Linux. Este projeto faz parte do pilar **01-Foundations**.

**Link do Desafio Original:** Para mais detalhes sobre o desafio: [Server Stats Tool - roadmap.sh](https://roadmap.sh/projects/server-stats)

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

## 🚀 Próximos Passos (Backlog / Evolução Técnica)
- [ ] **Exportação para JSON:** Implementar flag `--json` para facilitar integração com pipelines de observabilidade.
- [ ] **Alertas via Webhook:** Integrar notificações via Discord/Slack para métricas que excedam limites de segurança (ex: CPU > 90%).
- [ ] **Interface Web:** Criar um microserviço em Python ou Go para expor essas métricas via dashboard.

## 🧠 Lições Aprendidas
- **Processamento de Strings:** A manipulação de saídas do sistema com `awk` e `sed` provou ser eficiente para scripts leves e portáveis.
- **Resiliência em Containers:** A instalação do pacote `procps` no Alpine foi crucial para garantir que o formato de saída dos comandos de monitoramento fosse consistente com distribuições Linux robustas.

---

## 💖 Apoie este Projeto Open Source

Se você gosta dos meus projetos, considere:
- 🏆 Me indicar para o GitHub Stars [Indicar Aqui](https://stars.github.com/nominate/)
- ⭐ Dar uma estrela nos repositórios
- 🐛 Reportar bugs ou melhorias
- 🤝 Contribuir com código

---

## ⚖️ Licença

Distribuído sob a licença **Apache 2.0**. Esta licença oferece permissão para uso, modificação e distribuição, além de garantir proteção contra disputas de patentes para colaboradores e usuários. Veja o arquivo [LICENSE](LICENSE) para mais informações.

---

This project is part of [roadmap.sh](https://roadmap.sh/projects/server-stats) DevOps projects.
