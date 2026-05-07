# 🍅 Pomodoro Timer

> Aplicativo web de produtividade baseado na Técnica Pomodoro — construído com React, containerizado com Docker multi-stage e publicado automaticamente no GitHub Pages via GitHub Actions.

<div align="center">

![React](https://img.shields.io/badge/React-19-61DAFB?style=flat-square&logo=react&logoColor=black)
![Vite](https://img.shields.io/badge/Vite-6-646CFF?style=flat-square&logo=vite&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Multi--Stage-2496ED?style=flat-square&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Alpine-009639?style=flat-square&logo=nginx&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?style=flat-square&logo=github-actions&logoColor=white)

</div>

---

## 📋 Sobre o Projeto

O **Pomodoro Timer** implementa a [Técnica Pomodoro](https://roadmap.sh/projects/pomodoro-timer) — um método de gerenciamento de tempo que divide o trabalho em blocos de 25 minutos separados por pausas curtas.

### Funcionalidades

| Feature | Detalhes |
|:--------|:---------|
| ⏱️ Timer configurável | Trabalho (25min), Pausa Curta (5min), Pausa Longa (15min) |
| 🔄 Ciclo automático | Após 4 sessões de trabalho → Pausa Longa automática |
| 🍅 Contador de sessões | Rastreamento visual por ciclo com total acumulado |
| 🔔 Notificações | Som (Web Audio API) + Notificação do browser |
| ⌨️ Atalhos de teclado | `Espaço` para pausar, `Esc` para resetar |
| 🌙 Tema adaptativo | Dark/light mode via `prefers-color-scheme` |
| ♿ Acessibilidade | `role="timer"`, `aria-live`, navegação por teclado |

---

## 🏗️ Arquitetura

```
projects/02-containerization/05-pomodoro-timer/
├── app/                          # SPA React (Vite)
│   └── src/
│       ├── context/              # Estado global (useReducer)
│       ├── hooks/                # useTimer + useSound (side effects)
│       └── components/           # ModeSelector, Timer, Controls, SessionCounter, Settings
├── config/nginx.conf             # Config Nginx otimizada para SPA
├── .github/workflows/deploy.yml  # Pipeline CI/CD → GitHub Pages
├── Dockerfile                    # Multi-stage: Node builder + Nginx runner
├── docker-compose.yml            # Ambiente local na porta 8080
└── Makefile                      # Automação: setup, dev, up, down, clean
```

### Fluxo de Estado (Máquina de Estados Finitos)

```
idle ──[START]──→ running ──[TICK@0]──→ completed ──[+1.5s]──→ idle (próximo modo)
  ↑                  │                                              │
  └──[RESET]─────────┘                                             │
  └──[SET_MODE]─────────────────────────────────────────────────────┘
```

---

## 🧠 Justificativa das Decisões Técnicas

### 1. React 19 + Vite (em vez de HTML/JS puro)
O enunciado permite qualquer framework. React foi escolhido por dominar o mercado (portfólio) e por sua arquitetura de componentes eliminar o gerenciamento manual de DOM — que em um timer com múltiplos estados interdependentes se tornaria rapidamente insustentável.

### 2. `useReducer` + Context (em vez de Redux/Zustand)
O timer é uma **máquina de estados finitos** com 4 estados possíveis. `useReducer` é a primitiva idiomática do React para esse padrão: centraliza todas as transições, elimina estados impossíveis e é facilmente testável. Bibliotecas externas adicionariam overhead sem benefício real nessa escala.

### 3. Web Audio API nativa (em vez de Howler.js)
Zero dependências externas. A API está disponível em todos os browsers modernos desde 2013. Sons são gerados programaticamente via `OscillatorNode` — elimina requisições de rede e mantém o bundle mínimo.

### 4. Docker Multi-Stage Build (Node → Nginx Alpine)
A imagem final contém apenas Nginx + assets estáticos (~25MB). O ambiente Node.js de build (~200MB) é descartado. Resultado: menor superfície de ataque, pull mais rápido e nenhuma dependência de desenvolvimento em produção.

### 5. CSS Modules (em vez de Tailwind/Styled Components)
Escopo automático por componente sem runtime CSS. Sem configuração extra, sem overhead de bundle scan. Boas práticas de encapsulamento que escalam para projetos maiores.

### 6. `process.env.VITE_BASE` no vite.config.js
Desacopla a configuração de base URL do ambiente. Em dev: `base: '/'`. Em CI: `VITE_BASE=/DevOps_Master_Lab/`. Um único código-fonte serve ambos os contextos sem ifdef.

---

## 🚀 Guia de Execução

### Pré-requisitos

| Ferramenta | Versão Mínima |
|:-----------|:-------------|
| Node.js    | 20+          |
| Docker     | 24+          |
| Docker Compose | v2+     |

### Opção 1 — Desenvolvimento Local

```bash
# Clone o repositório
git clone https://github.com/nilo-lima/DevOps_Master_Lab.git
cd DevOps_Master_Lab/projects/02-containerization/05-pomodoro-timer

# Instala dependências e inicia o servidor de desenvolvimento
make setup
make dev
# Acesse http://localhost:5173
```

### Opção 2 — Docker (Produção)

```bash
# Build e execução com um único comando
make up
# Acesse http://localhost:8080

# Para encerrar
make down
```

### Comandos Disponíveis

| Comando      | Ação                                      |
|:-------------|:------------------------------------------|
| `make setup` | Instala dependências do Node.js           |
| `make dev`   | Inicia servidor Vite em modo desenvolvimento |
| `make up`    | Build Docker e executa em background      |
| `make down`  | Para e remove containers                  |
| `make build` | Build de produção (`app/dist/`)           |
| `make clean` | Remove containers, imagens e build        |

---

## 🔄 Pipeline CI/CD

O workflow `.github/workflows/deploy.yml` é acionado a cada `push` na branch `main` que modifique arquivos do projeto:

```
push → main → build (npm ci + npm run build) → deploy → GitHub Pages
```

URL de produção: `https://<seu-usuario>.github.io/DevOps_Master_Lab/pomodoro/`

---

## 📈 Próximos Passos

- [ ] Testes unitários do reducer com Vitest
- [ ] Modo `autostart` — próxima sessão inicia automaticamente
- [ ] Histórico de sessões persistido em `localStorage`
- [ ] Integração com a Pomodoro API para sincronização em nuvem
- [ ] PWA com service worker para uso offline

---

## 🎓 Lições Aprendidas

- **Máquinas de estado são mais fáceis de raciocinar do que `useState` múltiplos:** ao modelar o timer como `idle → running → completed → idle`, eliminamos bugs de estado impossível (ex: timer "rodando" com tempo zerado).
- **Web Audio API resolve 80% dos casos de uso de áudio** sem bibliotecas externas. A limitação principal é que o `AudioContext` deve ser criado após uma interação do usuário (política do browser).
- **Multi-stage Docker build é essencial para frontends:** separa ambiente de build do runtime, reduzindo a imagem final em ~85%.
- **CSS Modules escalam melhor do que CSS global** em aplicações componentizadas: sem colisões de nomes, sem especificidade acidental.

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

<div align="center">
  <sub>
    Projeto desenvolvido como parte do
    <a href="https://github.com/nilo-lima/DevOps_Master_Lab">DevOps Master Lab</a>
    · Pilar <strong>02 — Containerization</strong>
    · Baseado no desafio <a href="https://roadmap.sh/projects/pomodoro-timer">roadmap.sh</a>
  </sub>
</div>
