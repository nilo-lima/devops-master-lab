# 📑 Dashboard de Projetos

Navegue pelos projetos do laboratório através desta estrutura organizada pelos 5 Pilares da Engenharia DevOps.

---

<div align="center">
  <a href="#01-foundations"><img src="https://img.shields.io/badge/01--Foundations-326CE5?style=flat-square&logo=linux&logoColor=white"></a>
  <a href="#02-containerization"><img src="https://img.shields.io/badge/02--Containerization-623CE4?style=flat-square&logo=terraform&logoColor=white"></a>
  <a href="#03-infrastructure"><img src="https://img.shields.io/badge/03--Infrastructure-623CE4?style=flat-square&logo=terraform&logoColor=white"></a>
  <a href="#04-kubernetes"><img src="https://img.shields.io/badge/04--Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white"></a>
  <a href="#05-automation"><img src="https://img.shields.io/badge/05--Automation-2088FF?style=flat-square&logo=github-actions&logoColor=white"></a>
  <a href="#06-observability"><img src="https://img.shields.io/badge/06--Observability-E6522C?style=flat-square&logo=prometheus&logoColor=white"></a>
</div>

---

<details open>
<summary><h2 id="01-foundations" style="display: inline;">🛠️ 01. Foundations</h2></summary>
<br>
<blockquote>Foco em fundamentos de sistemas operacionais, conteinerização e automação de baixo nível.</blockquote>

| Projeto          | Descrição                                          | Status | Links                                                    |
| :--------------- | :------------------------------------------------- | :----: | :------------------------------------------------------- |
| **Server Stats** | Ferramenta de coleta de métricas em Bash e Docker. |   ✅   | [Visualizar](./projects/01-foundations/01-server-stats/) |
| **Nginx Log Analyser** | Script para analisar logs de acesso do Nginx. | ✅ | [Visualizar](./projects/01-foundations/01-nginx-log-analyser/) |
| **Serviço Systemd Fictício** | Exemplo prático de serviço systemd com Dockerização. | ✅ | [Visualizar](./projects/01-foundations/02-dummy-systemd-service/) |
| **Log Integrity Checker** | Ferramenta CLI para detectar adulterações em logs via SHA-256. | ✅ | [README](./projects/01-foundations/03-log-integrity-checker/README.md) |
| **Linux Server Setup** | Hardening completo de servidor Ubuntu: usuario, SSH, UFW, Fail2Ban e IaC Ansible. | ✅ | [README](./projects/01-foundations/04-linux-server-setup/README.md) |

<div align="right"><a href="#-dashboard-de-projetos">⬆️ Voltar ao Topo</a></div>
</details>

<hr>

<details>
<summary><h2 id="02-containerization" style="display: inline;">☁️ 02. Containerization</h2></summary>
<br>
<blockquote>Projetos focados em Docker, Docker Compose e conteinerização.</blockquote>

| Projeto              | Descrição                            | Status | Links                                                                  |
| :------------------- | :----------------------------------- | :----: | :--------------------------------------------------------------------- |
| **Basic Dockerfile** | Implementação inicial de Dockerfiles. |   ✅   | [Visualizar](./projects/02-containerization/01-basic-dockerfile/)      |
| **Servidor SSH com Fail2Ban** | Configuração de SSH seguro com Fail2Ban em Docker. | ✅ | [README](./projects/02-containerization/02-ssh-server-docker/README.md) |
| **Servidor de Site Estático** | Nginx, Docker e Rsync para hospedar e implantar sites estáticos. | ✅ | [README](./projects/02-containerization/03-static-site-server/README.md) |
| **Dockerfile Básico e Avançado** | Implementação de Dockerfile com personalização. | ✅ | [Visualizar](./projects/02-containerization/04-dockerfile-hello-captain/) |
| **Pomodoro Timer** | SPA React dockerizada com multi-stage build e deploy automatizado no GitHub Pages. | ✅ | [README](./projects/02-containerization/05-pomodoro-timer/README.md) |

<div align="right"><a href="#-dashboard-de-projetos">⬆️ Voltar ao Topo</a></div>
</details>

<hr>

<details>
<summary><h2 id="03-infrastructure" style="display: inline;">☁️ 03. Infrastructure</h2></summary>
<br>
<blockquote>Projetos focados em Infraestrutura como Código (IaC) e arquitetura em Cloud.</blockquote>

| Projeto                       | Descrição                                                     | Status | Links                                                                                                      |
| :---------------------------- | :------------------------------------------------------------ | :----: | :--------------------------------------------------------------------------------------------------------- |
| **AWS EC2 Static Site**       | Provisionamento de EC2 com site estático dockerizado via Terraform e SSM. |   ✅   | [Visualizar](./projects/03-infrastructure/01-aws-ec2-static-site/README.md) |
| **Ansible Configuration Management** | 4 roles Ansible modulares (base, nginx, app, ssh) com ambiente Docker reprodutível. | ✅ | [README](./projects/03-infrastructure/02-ansible-config-management/README.md) |
| **IaC AWS EC2** | Provisionamento e configuração de EC2 100% automatizados via Terraform + Ansible, sem etapas manuais. | ✅ | [README](./projects/03-infrastructure/03-iac-aws-ec2/README.md) |

<div align="right"><a href="#-dashboard-de-projetos">⬆️ Voltar ao Topo</a></div>
</details>

<hr>

<details>
<summary><h2 id="04-kubernetes" style="display: inline;">☸️ 04. Kubernetes</h2></summary>
<br>
<blockquote>Orquestração de microserviços, segurança de cluster e escalabilidade.</blockquote>

| Projeto       | Descrição               | Status | Links |
| :------------ | :---------------------- | :----: | :---- |
| _Coming Soon_ | Desafios de K8s e Helm. |   🗓️   | -     |

<div align="right"><a href="#-dashboard-de-projetos">⬆️ Voltar ao Topo</a></div>
</details>

<hr>

<details>
<summary><h2 id="05-automation" style="display: inline;">🤖 05. Automation (CI/CD)</h2></summary>
<br>
<blockquote>Entrega contínua, pipelines e automação de configuração.</blockquote>

| Projeto                  | Descrição                                        | Status | Links                                                            |
| :----------------------- | :----------------------------------------------- | :----: | :--------------------------------------------------------------- |
| **GH Deployment Workflow** | Implantação de site estático via GitHub Actions. |   ✅   | [Repositório](https://github.com/nilo-lima/gh-deployment-workflow) |
| **Node.js Service Deployment** | Pipeline CI/CD completo: testes Jest → Ansible → deploy automatizado em AWS EC2. | ✅ | [README](./projects/05-automation/01-nodejs-service-deployment/README.md) |
| **Dockerized Service Deployment** | Pipeline CI/CD com GHCR: build de imagem Docker → push para registry → deploy via `docker pull` em AWS EC2. | ✅ | [README](./projects/05-automation/02-dockerized-service-deployment/README.md) |

<div align="right"><a href="#-dashboard-de-projetos">⬆️ Voltar ao Topo</a></div>
</details>

<hr>

<details>
<summary><h2 id="06-observability" style="display: inline;">📊 06. Observability</h2></summary>
<br>
<blockquote>Monitoramento proativo, logs centralizados e gestão de incidentes.</blockquote>

| Projeto          | Descrição                                        | Status | Links                                                                  |
| :--------------- | :----------------------------------------------- | :----: | :--------------------------------------------------------------------- |
| **Netdata Monitoring** | Dashboard de monitoramento em tempo real com Docker. |   ✅   | [Visualizar](./projects/06-observability/01-netdata-monitoring/)       |

<div align="right"><a href="#-dashboard-de-projetos">⬆️ Voltar ao Topo</a></div>
</details>

---

<div align="center">
  <a href="./README.md"><img src="https://img.shields.io/badge/🏠-Página_Inicial-blue?style=flat-square"></a>
  &nbsp;&nbsp;
  <a href="#-dashboard-de-projetos"><img src="https://img.shields.io/badge/⬆️-Voltar_ao_Topo-blue?style=flat-square"></a>
</div>
