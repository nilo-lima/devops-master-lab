`monitoring` `netdata` `linux` `devops`
# 📊 Netdata Monitoring com Docker Compose

Este projeto demonstra a configuração básica de um painel de monitoramento em tempo real utilizando o [Netdata](https://www.netdata.cloud/) em um ambiente Dockerizado. O objetivo é familiarizar o usuário com os conceitos fundamentais de observabilidade, coleta de métricas de sistema (CPU, memória, I/O de disco) e configuração de alertas.

## 🎯 Objetivos de Aprendizagem

Ao final deste projeto, você terá aprendido a:

*   Instalar e executar o Netdata em um contêiner Docker.
*   Monitorar métricas essenciais do sistema operacional em tempo real.
*   Acessar e navegar pelo dashboard web do Netdata.
*   Personalizar configurações do Netdata através de arquivos.
*   Configurar alertas de saúde (Health Alarms) para métricas específicas, como o uso da CPU.
*   Automatizar o ciclo de vida do ambiente (setup, teste de carga, cleanup) com scripts shell.

## 🚀 Tecnologias Utilizadas

*   **Netdata:** Coletor de métricas de desempenho e integridade em tempo real.
*   **Docker:** Plataforma de containerização.
*   **Docker Compose:** Ferramenta para definir e executar aplicações Docker multi-contêiner.
*   **Bash:** Linguagem de script para automação.

## ✨ Principais Funcionalidades

*   **Monitoramento em Tempo Real:** Dashboard interativo para visualizar métricas de sistema (CPU, memória, disco, rede) de forma instantânea.
*   **Contêiner Isolado:** Execução do Netdata em um ambiente Docker, garantindo portabilidade e fácil gerenciamento.
*   **Alertas Configuráveis:** Configuração de alertas de saúde para notificar sobre anomalias no uso de recursos, como alta utilização de CPU.
*   **Automação do Ciclo de Vida:** Scripts shell para configurar, testar e limpar o ambiente de monitoramento de forma automatizada.
*   **Pronto para o Portfólio:** Projeto estruturado e documentado para demonstrar proficiência em observabilidade e Docker.

## 🏗️ Arquitetura

O projeto utiliza o Docker Compose para orquestrar o contêiner do Netdata, que por sua vez monitora o sistema operacional (o host, que neste caso é uma VM Vagrant ou seu ambiente local). Os scripts de automação interagem com o Docker Compose para gerenciar o ciclo de vida do ambiente.

```mermaid
graph TD
    A[Usuário] --> B(Navegador Web)
    B --> C(Netdata Dashboard)
    C --> D[Contêiner Docker Netdata]
    D --> E[Host Linux (VM Vagrant ou Sistema Local)]
    E --> F[Métricas do Sistema: CPU, Memória, Disco I/O]

    subgraph Scripts de Automação
        G[setup_netdata.sh] --> D
        H[test_dashboard.sh] --> E
        I[cleanup.sh] --> D
    end

    G --> E
    H --> E
    I --> E
```

## 🛠️ Como Usar

### Pré-requisitos

Certifique-se de ter o [Docker](https://docs.docker.com/get-docker/) e o [Docker Compose](https://docs.docker.com/compose/install/) instalados em seu sistema. Se você estiver utilizando o ambiente [DevOps Master Lab com Vagrant](https://github.com/nilo-lima/DevOps_Master_Lab), o Docker e o Docker Compose já estarão pré-configurados dentro da VM.

### 1. Clonar o Repositório

```bash
# Se você ainda não clonou o repositório principal
git clone https://github.com/nilo-lima/DevOps_Master_Lab
cd DevOps_Master_Lab/projects/06-observability/01-netdata-monitoring
```

### 2. Configuração Inicial e Início do Netdata

Navegue até o diretório do projeto e execute o script de `setup_netdata.sh`:

```bash
cd projects/06-observability/01-netdata-monitoring/
./setup_netdata.sh
```

Este script irá:
*   Verificar a instalação do Docker e Docker Compose.
*   Construir a imagem Docker do Netdata (baseada no `Dockerfile`).
*   Iniciar o contêiner Netdata em segundo plano usando `docker compose up -d`.

### 3. Acessar o Dashboard do Netdata

Após a execução bem-sucedida do `setup_netdata.sh`, abra seu navegador e acesse:

```
http://localhost:19999
```

*Se você estiver usando uma VM Vagrant, substitua `localhost` pelo IP da sua VM (ex: `http://192.168.56.101:19999`).*

Explore o dashboard para ver as métricas de CPU, memória, disco, rede, etc., em tempo real.

### 4. Testar a Configuração de Alerta (Simular Carga na CPU)

Para testar o alerta de uso de CPU que configuramos, execute o script `test_dashboard.sh`. Este script irá gerar uma carga artificial na CPU por um período para simular um cenário de alto uso.

```bash
cd projects/06-observability/01-netdata-monitoring/
./test_dashboard.sh <NUM_PROCESSOS>
```
*Substitua `<NUM_PROCESSOS>` por um número que você queira forçar. Recomenda-se um número maior que o de núcleos da sua CPU (ex: `8` para a maioria dos sistemas de teste) e uma duração de pelo menos 90 segundos para garantir que o alerta seja acionado.

Enquanto o script estiver em execução, observe o dashboard do Netdata na seção de "Alarms" ou no ícone de sino. O alerta `cpu_high_usage` deverá mudar de `CLEAR` para `WARNING` (laranja) e, possivelmente, para `CRITICAL` (vermelho) se a utilização média da CPU nos últimos 1 minuto exceder 80% e 95%, respectivamente.

### 5. Limpeza do Ambiente

Para parar e remover o contêiner Netdata e seus volumes, execute o script `cleanup.sh`:

```bash
cd projects/06-observability/01-netdata-monitoring/
./cleanup.sh
```

Este script perguntará se você deseja remover os volumes persistidos e a imagem Docker para uma limpeza completa.

## 📄 Conteúdo do Projeto

*   `Dockerfile`: Define a imagem Docker do Netdata.
*   `docker-compose.yml`: Orquestra o contêiner Netdata com volumes e capacidades necessárias.
*   `setup_netdata.sh`: Script para construir a imagem e iniciar o serviço Netdata.
*   `test_dashboard.sh`: Script para simular carga de CPU e testar o sistema de alertas.
*   `cleanup.sh`: Script para parar e remover o ambiente Netdata.
*   `.gitignore`: Regras para ignorar arquivos e diretórios desnecessários no controle de versão.
*   `README.md`: Este arquivo, detalhando o projeto.

## 🔮 Próximos Passos / Melhorias Futuras

*   **Persistência de Dados do Netdata:** Configurar volumes para persistir os dados históricos do Netdata, mesmo após a recriação dos contêineres.
*   **Configuração de Mais Alertas:** Adicionar e personalizar mais alertas para métricas diversas (uso de disco, tráfego de rede, processos específicos).
*   **Integração com Notificações:** Configurar o Netdata para enviar alertas para ferramentas como Slack, E-mail ou PagerDuty.
*   **Monitoramento de Aplicações:** Estender o monitoramento para incluir métricas de aplicações rodando em outros contêineres ou no próprio host.
*   **Dashboards Personalizados:** Explorar a criação de dashboards personalizados no Netdata ou integrar com Grafana para visualizações avançadas.

## 🧠 Lições Aprendidas

*   **Fundamentos de Observabilidade:** Compreensão da importância de coletar e visualizar métricas para a saúde e desempenho de sistemas.
*   **Docker e Docker Compose:** Aprofundamento na orquestração de contêineres e gerenciamento de serviços com Docker Compose.
*   **Automação com Shell Script:** Habilidade de automatizar tarefas complexas do ciclo de vida de um ambiente.
*   **Netdata como Ferramenta de Monitoramento:** Experiência prática com uma ferramenta poderosa para monitoramento em tempo real e configuração de alertas.
*   **Impacto da Carga de Trabalho:** Visualização direta do impacto de cargas de trabalho na utilização de recursos do sistema e como os alertas respondem a essas mudanças.

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

This project is part of [roadmap.sh](https://roadmap.sh/projects/simple-monitoring-dashboard) DevOps projects.
