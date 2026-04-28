`docker` `dockerfile` `Linux` `devops`

# 🐳 Dockerfile Básico e Avançado: Olá, Capitão!

Este projeto demonstra a criação de imagens Docker a partir de Dockerfiles, começando com uma versão básica e evoluindo para uma que aceita argumentos de construção para personalização.

## 🎯 Objetivo

O objetivo deste projeto é familiarizar o usuário com a criação de Dockerfiles, a construção de imagens Docker e a execução de contêineres, explorando a personalização através de argumentos de build.

## 🚀 Funcionalidades

- **Dockerfile Básico**: Cria uma imagem Docker que imprime "Olá, Capitão!" no console ao ser executada.
- **Dockerfile Avançado**: Permite passar um nome como argumento durante a construção da imagem, resultando em uma saudação personalizada ("Olá, [Seu Nome]!").

## 🛠️ Tecnologias Utilizadas

- **Docker**: Plataforma de conteinerização.
- **Docker Compose**: Ferramenta para definir e executar aplicações Docker multi-contêiner.
- **Alpine Linux**: Imagem base leve para otimização do tamanho da imagem final.

## 🧠 Justificativa das Decisões Técnicas

1.  **Pilar `02-containerization`**: Este projeto se alinha perfeitamente com o pilar de `containerization`, pois foca diretamente na criação e gestão de imagens Docker, que são a base da conteinerização.
2.  **Imagem Base `alpine:latest`**:
    *   **Porquê**: `alpine` é uma distribuição Linux extremamente leve e segura. É ideal para imagens Docker que precisam ser pequenas e eficientes, minimizando a superfície de ataque e o tempo de download/upload.
    *   **Alternativas Consideradas**: `ubuntu:latest`, `debian:latest`. Rejeitadas por serem significativamente maiores e conterem muitos pacotes desnecessários para este caso de uso simples.
3.  **Instrução `CMD` no Dockerfile**:
    *   **Porquê**: A instrução `CMD` define o comando padrão a ser executado quando um contêiner é iniciado a partir da imagem. Usar a forma `exec` (`["executable", "param1", "param2"]`) combinada com `sh -c` é uma boa prática para garantir que o processo seja PID 1 e que variáveis de ambiente sejam corretamente expandidas.
    *   **Correção**: A necessidade de `sh -c` surgiu para permitir a expansão de variáveis de ambiente no comando `CMD`, que não ocorre automaticamente no formato `exec` sem um shell intermediário.
4.  **Instruções `ARG` e `ENV`**:
    *   **Porquê**:
        *   `ARG`: Permite passar variáveis de construção (`--build-arg`) durante o `docker build`, tornando o Dockerfile mais flexível e reutilizável.
        *   `ENV`: Define variáveis de ambiente dentro do contêiner, tornando o valor do `ARG` acessível para o comando `CMD` durante a execução.
5.  **`docker-compose.yml`**:
    *   **Porquê**: Para padronizar e simplificar a construção e execução do projeto. Mesmo para um único contêiner, o Docker Compose oferece uma interface consistente e a capacidade de passar argumentos de build de forma organizada, como visto na versão avançada.
    *   **`docker compose run --rm` vs `docker compose up -d`**: Para esta aplicação efêmera que executa um comando e encerra, `docker compose run --rm` é superior, pois exibe a saída diretamente no terminal e remove o contêiner automaticamente, mantendo o ambiente limpo. `up -d` seria mais apropriado para serviços de longa duração.

## ⚙️ Como Usar

### Pré-requisitos

Certifique-se de ter o Docker e o Docker Compose instalados em sua máquina.

### 1. Navegue até o Diretório do Projeto

```bash
cd projects/02-containerization/04-dockerfile-hello-captain/
```

### 2. Versão Básica: "Olá, Capitão!"

Para construir e executar a versão básica (o `Dockerfile` já está configurado por padrão para "Capitão" se nenhum `USER_NAME` for passado):

```bash
# Reconstrua a imagem (se o docker-compose.yml não tiver argumentos definidos,
# ou se os argumentos estiverem comentados, o padrão "Capitão" será usado)
docker compose build --no-cache

# Execute o contêiner
docker compose run --rm hello-captain-app
```
Você verá: `Olá, Capitão!`

### 3. Versão Avançada: "Olá, [Seu Nome]!"

Para construir e executar a versão personalizada, você precisa configurar o `USER_NAME` no seu `docker-compose.yml`.

1.  **Edite `docker-compose.yml`**:

    ```yaml
    # projects/02-containerization/04-dockerfile-hello-captain/docker-compose.yml
    version: '3.8'
    services:
      hello-captain-app:
        build:
          context: .
          args:
            USER_NAME: "DevOps Master" # <-- Altere este nome!
        image: hello-captain:latest
        container_name: hello-captain-container
    ```

2.  **Reconstrua a imagem com o novo argumento**:

    ```bash
    docker compose build --no-cache
    ```

3.  **Execute o contêiner**:

    ```bash
    docker compose run --rm hello-captain-app
    ```
Você verá: `Olá, DevOps Master!` (ou o nome que você definiu).

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

This project is part of [roadmap.sh](https://roadmap.sh/devops) DevOps projects.
